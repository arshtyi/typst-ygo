#import "../utils/fit-text.typ": fit_text_to_box
#import "../utils/scale-x-to-fit.typ": scale_x_to_fit
#import "constants.typ": layout
#import "types.typ": (
    card_kind, frame_family, frame_name, is_link_frame, is_monster_frame, is_pendulum_frame, is_spell_frame,
    is_trap_frame, is_xyz_frame, link_marker_order, make_frame, spell_race, trap_race,
)

#let default_assets = (
    arrows: (
        bottom: none,
        bottom-left: none,
        bottom-right: none,
        left: none,
        right: none,
        top: none,
        top-left: none,
        top-right: none,
    ),
    attribute: none,
    card_frame: none,
    card_image: none,
    fonts: (
        atk_def_scale: none,
        link: none,
        password_no: none,
        sc: none,
    ),
    icon: none,
    indicators: (
        atk_def: none,
        atk_link: none,
        level: none,
        rank: none,
    ),
    path: none,
)

#let default_fonts = (
    sc: "Yu-Gi-Oh! DFKaiW5-A",
    atk_def_scale: "Yu-Gi-Oh! Matrix",
    link: "Yu-Gi-Oh! Ro GSan Serif Std B",
    password_no: "Yu-Gi-Oh! ITC Stone Serif M",
)

#let asset_or(override, fallback) = if override != none { override } else { fallback }

#let merge_assets(base, override) = {
    let override_arrows = override.at("arrows", default: (:))
    let override_fonts = override.at("fonts", default: (:))
    let override_indicators = override.at("indicators", default: (:))

    (
        arrows: (
            bottom: asset_or(override_arrows.at("bottom", default: none), base.arrows.bottom),
            bottom-left: asset_or(override_arrows.at("bottom-left", default: none), base.arrows.bottom-left),
            bottom-right: asset_or(override_arrows.at("bottom-right", default: none), base.arrows.bottom-right),
            left: asset_or(override_arrows.at("left", default: none), base.arrows.left),
            right: asset_or(override_arrows.at("right", default: none), base.arrows.right),
            top: asset_or(override_arrows.at("top", default: none), base.arrows.top),
            top-left: asset_or(override_arrows.at("top-left", default: none), base.arrows.top-left),
            top-right: asset_or(override_arrows.at("top-right", default: none), base.arrows.top-right),
        ),
        attribute: asset_or(override.at("attribute", default: none), base.attribute),
        card_frame: asset_or(override.at("card_frame", default: none), base.card_frame),
        card_image: asset_or(override.at("card_image", default: none), base.card_image),
        fonts: (
            atk_def_scale: asset_or(override_fonts.at("atk_def_scale", default: none), base.fonts.atk_def_scale),
            link: asset_or(override_fonts.at("link", default: none), base.fonts.link),
            password_no: asset_or(override_fonts.at("password_no", default: none), base.fonts.password_no),
            sc: asset_or(override_fonts.at("sc", default: none), base.fonts.sc),
        ),
        icon: asset_or(override.at("icon", default: none), base.icon),
        indicators: (
            atk_def: asset_or(override_indicators.at("atk_def", default: none), base.indicators.atk_def),
            atk_link: asset_or(override_indicators.at("atk_link", default: none), base.indicators.atk_link),
            level: asset_or(override_indicators.at("level", default: none), base.indicators.level),
            rank: asset_or(override_indicators.at("rank", default: none), base.indicators.rank),
        ),
        path: asset_or(override.at("path", default: none), base.path),
    )
}

#let default_frame = make_frame(card_kind.monster, "effect")

#let png_size(path) = {
    let data = read(path, encoding: none)
    let be32(data, index) = {
        (
            data.at(index) * 256 * 256 * 256
                + data.at(index + 1) * 256 * 256
                + data.at(index + 2) * 256
                + data.at(index + 3)
        )
    }

    (
        width: be32(data, 16),
        height: be32(data, 20),
    )
}

#let padded_number(value, width) = {
    let text = str(value)
    if text.len() < width {
        "0" * (width - text.len()) + text
    } else {
        text
    }
}

#let stat_text(value) = {
    if value == -1 {
        "   ?"
    } else if str(value).len() < 4 {
        " " * (4 - str(value).len()) + str(value)
    } else {
        str(value)
    }
}

#let card(
    assets: default_assets,
    atk: 5000,
    attribute: "earth",
    card_image: 23288411,
    def: 5000,
    description: "这张卡不能通常召唤。让这张卡以外的自己的手卡·墓地的「莫忘」怪兽5种类各1只回到卡组·额外卡组的场合才能从手卡·墓地特殊召唤。\n①：自己场上没有其他怪兽存在的场合，这张卡可以向对方怪兽全部各作1次攻击。②：1回合1次，对方把魔法·陷阱·怪兽的效果发动的场合才能发动。从自己的手卡·墓地把1只「莫忘」怪兽特殊召唤。",
    frame: default_frame,
    id: 23288411,
    level: 11,
    limit: (
        md: none,
        ocg: none,
        tcg: none,
    ),
    link_markers: (
        bottom: none,
        bottom-left: none,
        bottom-right: none,
        left: none,
        right: none,
        top: none,
        top-left: none,
        top-right: none,
    ),
    link_value: none,
    name: "冥骸合龙-莫忘冥地王灵",
    pendulum_description: none,
    race: none,
    scale: none,
    type_line: "【幻龙族/特殊召唤/效果】",
) = {
    let resolved_assets = merge_assets(default_assets, assets)
    let assets_path = asset_or(resolved_assets.path, "../../assets/")
    let fonts = (
        sc: asset_or(resolved_assets.fonts.sc, default_fonts.sc),
        atk_def_scale: asset_or(resolved_assets.fonts.atk_def_scale, default_fonts.atk_def_scale),
        link: asset_or(resolved_assets.fonts.link, default_fonts.link),
        password_no: asset_or(resolved_assets.fonts.password_no, default_fonts.password_no),
    )
    let frame_type = frame_name(frame)

    let is_monster = is_monster_frame(frame)
    let is_spell = is_spell_frame(frame)
    let is_trap = is_trap_frame(frame)
    let is_xyz = is_xyz_frame(frame)
    let is_link = is_link_frame(frame)
    let is_pendulum = is_pendulum_frame(frame)

    let render_card_image(path) = {
        let size = png_size(path)
        let target_width = if is_pendulum {
            layout.image.size.pendulum.width
        } else {
            layout.image.size.normal.width
        }
        let target_height = if is_pendulum {
            if size.width == 712 and size.height == 908 {
                layout.image.size.pendulum.tall_height
            } else {
                layout.image.size.pendulum.short_height
            }
        } else {
            layout.image.size.normal.height
        }

        image(path, width: target_width, height: target_height, fit: "stretch")
    }

    let card_image_path = asset_or(resolved_assets.card_image, assets_path + "images/" + str(card_image) + ".png")
    let frame_image_path = asset_or(
        resolved_assets.card_frame,
        assets_path + "figure/cards/card-" + frame_type + ".png",
    )
    let attribute_icon_path = asset_or(
        resolved_assets.attribute,
        assets_path + "figure/attributes/attribute-" + attribute + ".png",
    )

    set page(
        width: layout.page.width,
        height: layout.page.height,
        margin: 0pt,
    )
    set text(
        lang: "zh",
        region: "cn",
        cjk-latin-spacing: auto,
        overhang: false,
    )
    set par(
        justify: true,
        linebreaks: "optimized",
        justification-limits: (
            spacing: (min: 90%, max: 130%),
            tracking: (min: -0.01em, max: 0.02em),
        ),
    )

    place(
        dx: if is_pendulum { layout.image.pos.pendulum.x } else { layout.image.pos.normal.x },
        dy: if is_pendulum { layout.image.pos.pendulum.y } else { layout.image.pos.normal.y },
        render_card_image(card_image_path),
    )
    place(dx: 0pt, dy: 0pt, image(frame_image_path))
    place(dx: layout.attribute_pos.x, dy: layout.attribute_pos.y, image(attribute_icon_path))

    place(
        dx: layout.name_area.start.x,
        dy: layout.name_area.start.y,
        block(
            width: layout.name_area.end.x - layout.name_area.start.x,
            height: layout.name_area.end.y - layout.name_area.start.y,
            inset: (x: 1pt, y: 3pt),
            {
                set align(left + horizon)
                set text(font: fonts.sc, size: 10pt, fill: if is_xyz or is_spell or is_trap { white } else { black })
                scale_x_to_fit(min_x_scale: 50%, name)
            },
        ),
    )

    if is_pendulum {
        for side in ("left", "right") {
            place(
                dx: layout.scale_area.x.at(side),
                dy: layout.scale_area.y,
                block(
                    width: 11pt,
                    height: 12pt,
                    inset: (x: 1pt, y: 3pt),
                    {
                        set align(center + horizon)
                        set text(font: fonts.atk_def_scale, size: 10pt, fill: black)
                        str(scale)
                    },
                ),
            )
        }

        place(
            dx: layout.pendulum_description_area.start.x,
            dy: layout.pendulum_description_area.start.y,
            block(
                width: layout.pendulum_description_area.end.x - layout.pendulum_description_area.start.x,
                height: layout.pendulum_description_area.end.y - layout.pendulum_description_area.start.y,
                inset: (x: 1pt, y: 1pt),
                {
                    set align(left)
                    set text(font: fonts.sc, size: 10pt, fill: black)
                    fit_text_to_box(pendulum_description)
                },
            ),
        )
    }

    place(
        dx: layout.password_pos.x,
        dy: layout.password_pos.y,
        block(
            width: 32pt,
            height: 10pt,
            {
                set align(left + horizon)
                set text(font: fonts.password_no, size: 4.71pt, fill: if is_xyz { white } else { black })
                padded_number(id, 8)
            },
        ),
    )

    if is_spell or is_trap {
        let normalized_race = if race != none {
            race
        } else if is_spell {
            spell_race.normal
        } else {
            trap_race.normal
        }
        let has_icon = if is_spell {
            normalized_race != spell_race.normal
        } else {
            normalized_race != trap_race.normal
        }

        place(
            dx: if has_icon { layout.race_pos.x.with_icon } else { layout.race_pos.x.without_icon },
            dy: layout.race_pos.y,
            block(
                width: if has_icon { 50pt } else { 45pt },
                height: 12pt,
                inset: (x: 1pt, y: 2pt),
                {
                    set align(right + horizon)
                    set text(font: fonts.password_no, size: 10pt, fill: black)
                    if is_spell { "【魔法卡" } else { "【陷阱卡" }
                    if has_icon {
                        let icon_path = asset_or(
                            resolved_assets.icon,
                            assets_path + "figure/icons/icon-" + normalized_race + ".png",
                        )
                        box(image(icon_path, scaling: "pixelated"))
                    }
                    "】"
                },
            ),
        )
    }

    if is_monster {
        if is_link {
            for marker in link_marker_order {
                if link_markers.at(marker, default: none) != none {
                    let marker_path = asset_or(
                        resolved_assets.arrows.at(marker),
                        assets_path + "figure/arrows/arrow-" + marker + ".png",
                    )
                    place(
                        dx: layout.link_marker_pos.at(marker).x,
                        dy: layout.link_marker_pos.at(marker).y,
                        image(marker_path),
                    )
                }
            }
        } else {
            let star_path = if is_xyz {
                asset_or(resolved_assets.indicators.rank, assets_path + "figure/indicators/rank.png")
            } else {
                asset_or(resolved_assets.indicators.level, assets_path + "figure/indicators/level.png")
            }

            if level <= 12 {
                for pos in range(level) {
                    let slot = if is_xyz { pos } else { 11 - pos }
                    place(
                        dx: layout.star_pos.x.up_to_twelve.at(slot),
                        dy: layout.star_pos.y,
                        image(star_path),
                    )
                }
            } else {
                let width = layout.star_pos.x.over_twelve.end - layout.star_pos.x.over_twelve.start
                let step = width / (13 - 1) - 0.72pt

                for pos in range(13) {
                    place(
                        dx: layout.star_pos.x.over_twelve.start + step * pos,
                        dy: layout.star_pos.y,
                        image(star_path),
                    )
                }
            }
        }

        let bar_path = if is_link {
            asset_or(resolved_assets.indicators.atk_link, assets_path + "figure/indicators/atk-link.png")
        } else {
            asset_or(resolved_assets.indicators.atk_def, assets_path + "figure/indicators/atk-def.png")
        }

        place(dx: layout.bar_pos.x, dy: layout.bar_pos.y, image(bar_path))

        place(
            dx: layout.atk_pos.x,
            dy: layout.atk_pos.y,
            block(
                width: 15pt,
                height: 6pt,
                inset: (x: 1pt, y: 1pt),
                {
                    set align(right + horizon)
                    set text(font: fonts.atk_def_scale, size: 7pt, fill: black)
                    stat_text(atk)
                },
            ),
        )

        if is_link {
            place(
                dx: layout.link_value_pos.x,
                dy: layout.link_value_pos.y,
                block(
                    width: 6pt,
                    height: 6pt,
                    inset: (x: 1pt, y: 1pt),
                    {
                        set align(center + horizon)
                        set text(font: fonts.link, size: 5.2pt, fill: black)
                        str(link_value)
                    },
                ),
            )
        } else {
            place(
                dx: layout.def_pos.x,
                dy: layout.def_pos.y,
                block(
                    width: 15pt,
                    height: 6pt,
                    inset: (x: 1pt, y: 1pt),
                    {
                        set align(right + horizon)
                        set text(font: fonts.atk_def_scale, size: 7pt, fill: black)
                        stat_text(def)
                    },
                ),
            )
        }
    }

    place(
        dx: layout.description_area.start.x,
        dy: layout.description_area.start.y,
        block(
            width: layout.description_area.end.x - layout.description_area.start.x,
            height: layout.description_area.end.y - layout.description_area.start.y,
            inset: (x: 1pt, y: 1pt),
            {
                set align(left)
                set text(font: fonts.sc, size: 9pt, fill: black)
                fit_text_to_box(description)
            },
        ),
    )

    pagebreak(weak: true)
}
