#!/usr/bin/env python3
"""Download typst-ygo assets and sync demo card images.

Run with ``python scripts/assets.py``.

Commands:

* no command: print help information.
* ``sync``: keep the current demo image synchronization behavior.
* ``download``: download card data and static resources into the ignored
  ``assets`` directory.
* ``all``: download resources first, then sync demo images.
"""

from __future__ import annotations

import argparse
import json
import re
import shutil
import sys
import tarfile
import tempfile
from dataclasses import dataclass
from pathlib import Path, PurePosixPath
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen


OT_DATA_URL = "https://github.com/arshtyi/ygo-cards/releases/download/latest/ot.json"
RD_DATA_URL = "https://github.com/arshtyi/ygo-cards/releases/download/latest/rd.json"
ASSETS_ARCHIVE_URL = "https://github.com/arshtyi/ygo-assets/releases/download/latest/assets.tar.xz"
IMAGE_URL = "https://images.ygoprodeck.com/images/cards_cropped/{image_id}.jpg"
USER_AGENT = "typst-ygo-assets/1.0"
ASSETS_ARCHIVE_ROOTS = frozenset(("ot", "rd", "readme.md"))


@dataclass(frozen=True)
class DataResource:
    name: str
    url: str
    destination: Path


@dataclass(frozen=True)
class ImageSet:
    name: str
    demo_ids_variable: str
    cards_json: Path
    images_dir: Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Download typst-ygo resources and sync demo card images.",
    )
    parser.add_argument(
        "--root",
        type=Path,
        default=None,
        help="Repository root. Defaults to auto-detection from this script location.",
    )
    parser.add_argument(
        "--template",
        type=Path,
        default=Path("template/template.typ"),
        help="Typst template path relative to the repository root.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print planned downloads/extractions/deletions without changing files.",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Re-download demo images even when the target JPG already exists.",
    )
    parser.add_argument(
        "--no-clean",
        action="store_true",
        help="Do not remove JPG files that are not needed by the demo ids.",
    )
    parser.add_argument(
        "--timeout",
        type=float,
        default=30.0,
        help="Network timeout in seconds per download.",
    )

    parser.add_argument(
        "command",
        nargs="?",
        choices=("download", "sync", "all"),
        help="Action to run: download resources, sync demo images, or all.",
    )
    args = parser.parse_args()
    if args.command is None:
        parser.print_help()
    return args


def find_repo_root(start: Path) -> Path:
    for candidate in (start, *start.parents):
        if (candidate / "template" / "template.typ").is_file() and (candidate / "lib" / "mod.typ").is_file():
            return candidate
    raise RuntimeError("could not auto-detect repository root")


def resolve_root(root_arg: Path | None) -> Path:
    if root_arg is not None:
        return root_arg.resolve()
    return find_repo_root(Path(__file__).resolve().parent)


def resolve_under_root(root: Path, relative_path: Path) -> Path:
    path = (root / relative_path).resolve()
    try:
        path.relative_to(root)
    except ValueError as exc:
        raise RuntimeError(f"path escapes repository root: {relative_path}") from exc
    return path


def read_text(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except FileNotFoundError as exc:
        raise RuntimeError(f"missing file: {path}") from exc


def download_to_temp(url: str, directory: Path, timeout: float) -> Path:
    directory.mkdir(parents=True, exist_ok=True)
    request = Request(url, headers={"User-Agent": USER_AGENT})
    temp = tempfile.NamedTemporaryFile(
        prefix=".download.",
        suffix=".tmp",
        dir=directory,
        delete=False,
    )
    temp_path = Path(temp.name)

    try:
        with temp:
            with urlopen(request, timeout=timeout) as response:
                shutil.copyfileobj(response, temp)
    except HTTPError as exc:
        temp_path.unlink(missing_ok=True)
        raise RuntimeError(f"HTTP {exc.code} while downloading {url}: {exc.reason}") from exc
    except URLError as exc:
        temp_path.unlink(missing_ok=True)
        raise RuntimeError(f"network error while downloading {url}: {exc.reason}") from exc
    except OSError as exc:
        temp_path.unlink(missing_ok=True)
        raise RuntimeError(f"file error while downloading {url}: {exc}") from exc

    if temp_path.stat().st_size == 0:
        temp_path.unlink(missing_ok=True)
        raise RuntimeError(f"downloaded file is empty: {url}")
    return temp_path


def download_json_resource(resource: DataResource, timeout: float, dry_run: bool) -> None:
    print(f"{resource.name}:")
    print(f"  download {resource.url} -> {resource.destination}")
    if dry_run:
        return

    temp_path = download_to_temp(resource.url, resource.destination.parent, timeout)
    try:
        with temp_path.open("r", encoding="utf-8") as file:
            json.load(file)
        temp_path.replace(resource.destination)
    except json.JSONDecodeError as exc:
        temp_path.unlink(missing_ok=True)
        raise RuntimeError(f"downloaded JSON is invalid for {resource.name}: {exc}") from exc
    except OSError as exc:
        temp_path.unlink(missing_ok=True)
        raise RuntimeError(f"file error while writing {resource.destination}: {exc}") from exc


def archive_target_path(assets_dir: Path, member_name: str) -> Path | None:
    normalized_name = member_name.replace("\\", "/")
    member_path = PurePosixPath(normalized_name)
    if member_path.is_absolute():
        raise RuntimeError(f"archive member uses absolute path: {member_name}")

    parts = [part for part in member_path.parts if part not in ("", ".")]
    if not parts:
        return None
    if any(part == ".." for part in parts):
        raise RuntimeError(f"archive member escapes assets directory: {member_name}")
    if any(":" in part for part in parts):
        raise RuntimeError(f"archive member contains invalid path segment: {member_name}")
    if parts[0] not in ASSETS_ARCHIVE_ROOTS:
        raise RuntimeError(f"archive member has unexpected root: {member_name}")
    if parts[0] == "readme.md" and len(parts) != 1:
        raise RuntimeError(f"archive member is nested under readme.md: {member_name}")

    target = assets_dir.joinpath(*parts).resolve()
    try:
        target.relative_to(assets_dir)
    except ValueError as exc:
        raise RuntimeError(f"archive member escapes assets directory: {member_name}") from exc
    return target


def extract_assets_archive(archive_path: Path, assets_dir: Path) -> int:
    extracted = 0
    try:
        archive = tarfile.open(archive_path, mode="r:xz")
    except tarfile.TarError as exc:
        raise RuntimeError(f"invalid assets archive: {exc}") from exc

    with archive:
        for member in archive:
            target = archive_target_path(assets_dir, member.name)
            if target is None:
                continue

            if member.isdir():
                target.mkdir(parents=True, exist_ok=True)
                continue
            if not member.isfile():
                raise RuntimeError(f"unsupported archive member type: {member.name}")

            target.parent.mkdir(parents=True, exist_ok=True)
            source = archive.extractfile(member)
            if source is None:
                raise RuntimeError(f"could not read archive member: {member.name}")

            temp = tempfile.NamedTemporaryFile(
                prefix=f".{target.name}.",
                suffix=".tmp",
                dir=target.parent,
                delete=False,
            )
            temp_path = Path(temp.name)
            try:
                with source, temp:
                    shutil.copyfileobj(source, temp)
                temp_path.replace(target)
            except OSError as exc:
                temp_path.unlink(missing_ok=True)
                raise RuntimeError(f"file error while extracting {target}: {exc}") from exc
            extracted += 1

    return extracted


def download_assets_archive(assets_dir: Path, timeout: float, dry_run: bool) -> None:
    print("assets archive:")
    print(f"  download {ASSETS_ARCHIVE_URL} -> {assets_dir}")
    if dry_run:
        print(f"  extract archive -> {assets_dir}")
        return

    temp_path = download_to_temp(ASSETS_ARCHIVE_URL, assets_dir, timeout)
    try:
        extracted = extract_assets_archive(temp_path, assets_dir)
    finally:
        temp_path.unlink(missing_ok=True)
    print(f"  extracted {extracted} file(s)")


def download_assets(root: Path, timeout: float, dry_run: bool) -> None:
    assets_dir = resolve_under_root(root, Path("assets"))
    data_resources = (
        DataResource(
            name="OT card data",
            url=OT_DATA_URL,
            destination=resolve_under_root(root, Path("assets/ot/card/ot.json")),
        ),
        DataResource(
            name="RD card data",
            url=RD_DATA_URL,
            destination=resolve_under_root(root, Path("assets/rd/card/rd.json")),
        ),
    )

    if not dry_run:
        assets_dir.mkdir(parents=True, exist_ok=True)

    download_assets_archive(assets_dir, timeout, dry_run)
    for resource in data_resources:
        if not dry_run:
            resource.destination.parent.mkdir(parents=True, exist_ok=True)
        download_json_resource(resource, timeout, dry_run)


def extract_demo_ids(template_text: str, variable_name: str) -> list[int]:
    pattern = re.compile(rf"#let\s+{re.escape(variable_name)}\s*=\s*\((?P<body>.*?)\)", re.DOTALL)
    match = pattern.search(template_text)
    if match is None:
        raise RuntimeError(f"could not find Typst tuple: {variable_name}")

    body_without_comments = re.sub(r"//.*", "", match.group("body"))
    ids = [int(value) for value in re.findall(r"\b\d+\b", body_without_comments)]
    if not ids:
        raise RuntimeError(f"Typst tuple is empty: {variable_name}")
    return ids


def load_cards(path: Path) -> dict[int, dict[str, object]]:
    try:
        with path.open("r", encoding="utf-8") as file:
            data = json.load(file)
    except FileNotFoundError as exc:
        raise RuntimeError(f"missing card data: {path}") from exc
    except json.JSONDecodeError as exc:
        raise RuntimeError(f"invalid JSON in {path}: {exc}") from exc

    if isinstance(data, dict) and isinstance(data.get("cards"), list):
        cards = data["cards"]
    elif isinstance(data, list):
        cards = data
    else:
        raise RuntimeError(f"unsupported card JSON shape: {path}")

    index: dict[int, dict[str, object]] = {}
    for card in cards:
        if not isinstance(card, dict):
            continue
        card_id = card.get("id")
        if isinstance(card_id, int):
            index[card_id] = card
    return index


def image_id_for(card: dict[str, object]) -> int | None:
    image_id = card.get("image")
    if isinstance(image_id, int):
        return image_id
    if isinstance(image_id, str) and image_id.isdecimal():
        return int(image_id)
    return None


def required_images(card_index: dict[int, dict[str, object]], demo_ids: list[int]) -> tuple[set[int], list[str]]:
    image_ids: set[int] = set()
    warnings: list[str] = []

    for card_id in demo_ids:
        card = card_index.get(card_id)
        if card is None:
            warnings.append(f"card id not found in JSON: {card_id}")
            continue

        image_id = image_id_for(card)
        if image_id is None:
            warnings.append(f"card id has no usable image id: {card_id}")
            continue

        image_ids.add(image_id)

    return image_ids, warnings


def download_image(image_id: int, destination: Path, timeout: float, dry_run: bool) -> bool:
    url = IMAGE_URL.format(image_id=image_id)
    if dry_run:
        print(f"  download {url} -> {destination}")
        return True

    destination.parent.mkdir(parents=True, exist_ok=True)
    try:
        temp_path = download_to_temp(url, destination.parent, timeout)
    except RuntimeError as exc:
        print(f"  {exc}", file=sys.stderr)
        return False

    try:
        with temp_path.open("rb") as temp_file:
            if temp_file.read(2) != b"\xff\xd8":
                print(f"  downloaded file is not a JPEG image: {url}", file=sys.stderr)
                temp_path.unlink(missing_ok=True)
                return False

        temp_path.replace(destination)
        print(f"  downloaded {destination}")
        return True
    except OSError as exc:
        print(f"  file error while writing {destination}: {exc}", file=sys.stderr)
        temp_path.unlink(missing_ok=True)
        return False


def clean_extra_jpgs(images_dir: Path, expected_names: set[str], dry_run: bool) -> int:
    removed = 0
    for path in sorted(images_dir.glob("*.jpg")):
        if path.name in expected_names:
            continue
        if dry_run:
            print(f"  remove extra {path}")
        else:
            path.unlink()
            print(f"  removed extra {path}")
        removed += 1
    return removed


def sync_image_set(image_set: ImageSet, template_text: str, dry_run: bool, force: bool, clean: bool, timeout: float) -> int:
    print(f"{image_set.name}:")

    demo_ids = extract_demo_ids(template_text, image_set.demo_ids_variable)
    card_index = load_cards(image_set.cards_json)
    image_ids, warnings = required_images(card_index, demo_ids)
    failures = len(warnings)

    for warning in warnings:
        print(f"  warning: {warning}", file=sys.stderr)

    expected_names = {f"{image_id}.jpg" for image_id in image_ids}

    if dry_run:
        print(f"  demo card ids: {len(demo_ids)}")
        print(f"  required image ids: {len(image_ids)}")
    else:
        image_set.images_dir.mkdir(parents=True, exist_ok=True)

    for image_id in sorted(image_ids):
        destination = image_set.images_dir / f"{image_id}.jpg"
        if destination.exists() and not force:
            continue
        if not download_image(image_id, destination, timeout, dry_run):
            failures += 1

    if clean and warnings:
        print("  skip cleanup because card/image mapping is incomplete", file=sys.stderr)
    elif clean:
        clean_extra_jpgs(image_set.images_dir, expected_names, dry_run)

    return failures


def sync_demo_images(root: Path, template: Path, dry_run: bool, force: bool, clean: bool, timeout: float) -> int:
    template_path = resolve_under_root(root, template)
    template_text = read_text(template_path)

    image_sets = (
        ImageSet(
            name="OT",
            demo_ids_variable="ot-demo-ids",
            cards_json=resolve_under_root(root, Path("assets/ot/card/ot.json")),
            images_dir=resolve_under_root(root, Path("assets/ot/images")),
        ),
        ImageSet(
            name="RD",
            demo_ids_variable="rd-demo-ids",
            cards_json=resolve_under_root(root, Path("assets/rd/card/rd.json")),
            images_dir=resolve_under_root(root, Path("assets/rd/images")),
        ),
    )

    failures = 0
    for image_set in image_sets:
        failures += sync_image_set(
            image_set=image_set,
            template_text=template_text,
            dry_run=dry_run,
            force=force,
            clean=clean,
            timeout=timeout,
        )
    return failures


def run() -> int:
    args = parse_args()
    if args.command is None:
        return 0

    root = resolve_root(args.root)

    if args.command in ("download", "all"):
        download_assets(root=root, timeout=args.timeout, dry_run=args.dry_run)

    failures = 0
    if args.command in ("sync", "all"):
        failures = sync_demo_images(
            root=root,
            template=args.template,
            dry_run=args.dry_run,
            force=args.force,
            clean=not args.no_clean,
            timeout=args.timeout,
        )

    if failures:
        print(f"done with {failures} warning/error(s)", file=sys.stderr)
        return 1

    print("done")
    return 0


def main() -> int:
    try:
        return run()
    except RuntimeError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
