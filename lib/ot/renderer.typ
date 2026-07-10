#import "../utils/fit-effect-text.typ": fit_effect_text_to_box
#import "../utils/jpeg-size.typ": jpeg_image_size
#import "../utils/scale-x-to-fit.typ": scale_x_to_fit
#import "layout.typ": ot_layout

#let ot_assets_root = "../../assets/ot/"
#let card_text_fonts = ("Yu-Gi-Oh! DFKaiW5-A", "YGO_Card_JP")

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

#let render_card_image(path, is_pendulum) = {
    let target_width = if is_pendulum {
        ot_layout.image.size.pendulum.width
    } else {
        ot_layout.image.size.normal.width
    }
    let target_height = if is_pendulum {
        let size = jpeg_image_size(path)
        if size.width == 712 and size.height == 908 {
            ot_layout.image.size.pendulum.tall_height
        } else {
            ot_layout.image.size.pendulum.short_height
        }
    } else {
        ot_layout.image.size.normal.height
    }

    image(path, width: target_width, height: target_height, fit: "stretch")
}

#let render_card(model) = {
    set page(
        width: ot_layout.page.width,
        height: ot_layout.page.height,
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
        dx: if model.is_pendulum { ot_layout.image.pos.pendulum.x } else { ot_layout.image.pos.normal.x },
        dy: if model.is_pendulum { ot_layout.image.pos.pendulum.y } else { ot_layout.image.pos.normal.y },
        render_card_image(model.image_path, model.is_pendulum),
    )
    place(dx: 0pt, dy: 0pt, image(ot_assets_root + "frame/" + model.frame_name + ".png"))
    place(dx: ot_layout.attribute_pos.x, dy: ot_layout.attribute_pos.y, image(
        ot_assets_root + "attribute/" + model.attribute_name + ".png",
    ))

    place(
        dx: ot_layout.name_area.start.x,
        dy: ot_layout.name_area.start.y,
        block(
            width: ot_layout.name_area.end.x - ot_layout.name_area.start.x,
            height: ot_layout.name_area.end.y - ot_layout.name_area.start.y,
            inset: (x: 1pt, y: 3pt),
            {
                set align(left + horizon)
                set text(
                    font: card_text_fonts,
                    size: 10pt,
                    fill: if model.is_xyz or model.is_spell or model.is_trap { white } else { black },
                )
                scale_x_to_fit(min_x_scale: 50%, model.name)
            },
        ),
    )

    if model.is_pendulum {
        for side in ("left", "right") {
            place(
                dx: ot_layout.scale_area.x.at(side),
                dy: ot_layout.scale_area.y,
                block(
                    width: 11pt,
                    height: 12pt,
                    inset: (x: 1pt, y: 3pt),
                    {
                        set align(center + horizon)
                        set text(font: "Yu-Gi-Oh! Matrix", size: 10pt, fill: black)
                        str(model.scale)
                    },
                ),
            )
        }

        place(
            dx: ot_layout.pendulum_description_area.start.x,
            dy: ot_layout.pendulum_description_area.start.y,
            block(
                width: ot_layout.pendulum_description_area.end.x - ot_layout.pendulum_description_area.start.x,
                height: ot_layout.pendulum_description_area.end.y - ot_layout.pendulum_description_area.start.y,
                inset: (x: 1pt, y: 1pt),
                {
                    set align(left)
                    set text(font: card_text_fonts, size: 5pt, fill: black)
                    fit_effect_text_to_box(4, model.pendulum_description, compress: model.compress_description)
                },
            ),
        )
    }

    place(
        dx: ot_layout.password_pos.x,
        dy: ot_layout.password_pos.y,
        block(
            width: 32pt,
            height: 10pt,
            {
                set align(left + horizon)
                set text(font: "Yu-Gi-Oh! ITC Stone Serif M", size: 4.71pt, fill: if model.is_xyz { white } else {
                    black
                })
                padded_number(model.id, 8)
            },
        ),
    )

    if model.is_spell or model.is_trap {
        let has_icon = model.spell_trap_icon_name != none
        place(
            dx: if has_icon { ot_layout.race_pos.x.with_icon } else { ot_layout.race_pos.x.without_icon },
            dy: ot_layout.race_pos.y,
            block(
                width: if has_icon { 50pt } else { 45pt },
                height: 12pt,
                inset: (x: 1pt, y: 2pt),
                {
                    set align(right + horizon)
                    set text(font: card_text_fonts, size: 10pt, fill: black)
                    if model.is_spell { "【魔法卡" } else { "【陷阱卡" }
                    if has_icon {
                        box(image(ot_assets_root + "icon/" + model.spell_trap_icon_name + ".png", scaling: "pixelated"))
                    }
                    "】"
                },
            ),
        )
    }

    if model.is_monster {
        if model.is_link {
            for marker in model.link_markers {
                let pos = ot_layout.link_marker_pos.at(marker)
                place(
                    dx: pos.x,
                    dy: pos.y,
                    image(ot_assets_root + "link/" + str(marker) + ".png"),
                )
            }
        } else {
            let star_path = if model.is_xyz { ot_assets_root + "rank/rank.png" } else {
                ot_assets_root + "level/level.png"
            }

            if model.level <= 12 {
                for pos in range(model.level) {
                    let slot = if model.is_xyz { pos } else { 11 - pos }
                    place(
                        dx: ot_layout.star_pos.x.up_to_twelve.at(slot),
                        dy: ot_layout.star_pos.y,
                        image(star_path),
                    )
                }
            } else {
                let width = ot_layout.star_pos.x.over_twelve.end - ot_layout.star_pos.x.over_twelve.start
                let step = width / (13 - 1) - 0.72pt

                for pos in range(13) {
                    place(
                        dx: ot_layout.star_pos.x.over_twelve.start + step * pos,
                        dy: ot_layout.star_pos.y,
                        image(star_path),
                    )
                }
            }
        }

        place(dx: ot_layout.bar_pos.x, dy: ot_layout.bar_pos.y, image(if model.is_link {
            ot_assets_root + "bar/atk-link.png"
        } else {
            ot_assets_root + "bar/atk-def.png"
        }))

        place(
            dx: ot_layout.atk_pos.x,
            dy: ot_layout.atk_pos.y,
            block(
                width: 15pt,
                height: 6pt,
                inset: (x: 1pt, y: 1pt),
                {
                    set align(right + horizon)
                    set text(font: "Yu-Gi-Oh! Matrix", size: 7pt, fill: black)
                    stat_text(model.atk)
                },
            ),
        )

        if model.is_link {
            place(
                dx: ot_layout.link_value_pos.x,
                dy: ot_layout.link_value_pos.y,
                block(
                    width: 6pt,
                    height: 6pt,
                    inset: (x: 1pt, y: 1pt),
                    {
                        set align(center + horizon)
                        set text(font: "Yu-Gi-Oh! Ro GSan Serif Std B", size: 5.2pt, fill: black)
                        str(model.link_value)
                    },
                ),
            )
        } else {
            place(
                dx: ot_layout.def_pos.x,
                dy: ot_layout.def_pos.y,
                block(
                    width: 15pt,
                    height: 6pt,
                    inset: (x: 1pt, y: 1pt),
                    {
                        set align(right + horizon)
                        set text(font: "Yu-Gi-Oh! Matrix", size: 7pt, fill: black)
                        stat_text(model.def)
                    },
                ),
            )
        }
    }

    place(
        dx: ot_layout.description_area.start.x,
        dy: ot_layout.description_area.start.y,
        block(
            width: ot_layout.description_area.end.x - ot_layout.description_area.start.x,
            height: ot_layout.description_area.end.y - ot_layout.description_area.start.y,
            inset: (x: 1pt, y: 1pt),
            {
                set align(left)
                set text(font: card_text_fonts, size: 5pt, fill: black)
                fit_effect_text_to_box(5, model.description, compress: model.compress_description)
            },
        ),
    )

    pagebreak(weak: true)
}
