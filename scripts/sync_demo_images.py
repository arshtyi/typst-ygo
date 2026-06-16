#!/usr/bin/env python3
"""Sync demo card images from the Typst template.

The script reads ``ot_demo_ids`` and ``rd_demo_ids`` from
``template/template.typ``, maps each card id to its ``image`` id through the
local JSON card data, downloads missing images from YGOPRODeck, and removes
unused JPG files from the matching demo image directories.
"""

from __future__ import annotations

import argparse
import json
import re
import shutil
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen


IMAGE_URL = "https://images.ygoprodeck.com/images/cards_cropped/{image_id}.jpg"
USER_AGENT = "typst-ygo-demo-image-sync/1.0"


@dataclass(frozen=True)
class ImageSet:
    name: str
    demo_ids_variable: str
    cards_json: Path
    images_dir: Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Download and clean OT/RD demo images used by template/template.typ.",
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
        help="Print planned downloads/deletions without changing files.",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Re-download images even when the target JPG already exists.",
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
        help="Network timeout in seconds per image download.",
    )
    return parser.parse_args()


def find_repo_root(start: Path) -> Path:
    for candidate in (start, *start.parents):
        if (candidate / "template" / "template.typ").is_file() and (candidate / "assets").is_dir():
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
    request = Request(url, headers={"User-Agent": USER_AGENT})

    temp = tempfile.NamedTemporaryFile(
        prefix=f".{destination.stem}.",
        suffix=".tmp",
        dir=destination.parent,
        delete=False,
    )
    temp_path = Path(temp.name)
    try:
        with temp:
            with urlopen(request, timeout=timeout) as response:
                shutil.copyfileobj(response, temp)

        if temp_path.stat().st_size == 0:
            print(f"  missing/empty image: {url}", file=sys.stderr)
            temp_path.unlink(missing_ok=True)
            return False

        with temp_path.open("rb") as temp_file:
            if temp_file.read(2) != b"\xff\xd8":
                print(f"  downloaded file is not a JPEG image: {url}", file=sys.stderr)
                temp_path.unlink(missing_ok=True)
                return False

        temp_path.replace(destination)
        print(f"  downloaded {destination}")
        return True
    except HTTPError as exc:
        if exc.code == 404:
            print(f"  image does not exist: {url}", file=sys.stderr)
        else:
            print(f"  HTTP {exc.code} while downloading {url}: {exc.reason}", file=sys.stderr)
        temp_path.unlink(missing_ok=True)
        return False
    except URLError as exc:
        print(f"  network error while downloading {url}: {exc.reason}", file=sys.stderr)
        temp_path.unlink(missing_ok=True)
        return False
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


def run() -> int:
    args = parse_args()
    root = resolve_root(args.root)
    template_path = resolve_under_root(root, args.template)
    template_text = read_text(template_path)

    image_sets = (
        ImageSet(
            name="OT",
            demo_ids_variable="ot_demo_ids",
            cards_json=resolve_under_root(root, Path("assets/ot/card/ot.json")),
            images_dir=resolve_under_root(root, Path("assets/ot/images")),
        ),
        ImageSet(
            name="RD",
            demo_ids_variable="rd_demo_ids",
            cards_json=resolve_under_root(root, Path("assets/rd/card/rd.json")),
            images_dir=resolve_under_root(root, Path("assets/rd/images")),
        ),
    )

    failures = 0
    for image_set in image_sets:
        failures += sync_image_set(
            image_set=image_set,
            template_text=template_text,
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
