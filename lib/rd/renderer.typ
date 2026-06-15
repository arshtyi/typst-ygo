#import "../utils/fit-text.typ": fit_text_to_box
#import "../utils/scale-x-to-fit.typ": scale_x_to_fit
#import "layout.typ": rd_layout

#let rd_assets_root = "../../assets/rd/"
#let card_text_fonts = ("Yu-Gi-Oh! DFKaiW5-A", "YGO_Card_JP")

#let stat_text(value) = if value == -1 { "?" } else { str(value) }

#let render_card_image(path) = image(
    path,
    width: rd_layout.image.size.width,
    height: rd_layout.image.size.height,
    fit: "stretch",
)

#let render_typeline(model) = {
    "【"
    for (index, part) in model.typeline_parts.enumerate() {
        if index > 0 {
            "/"
        }
        part
        let icon_asset = model.typeline_icon_names.at(index, default: none)
        if icon_asset != none {
            box(baseline: 10%, image(
                rd_assets_root + "icon/" + icon_asset + ".png",
                height: rd_layout.typeline_icon_height,
            ))
        }
    }
    "】"
}

#let render_card(model) = {
    set page(
        width: rd_layout.page.width,
        height: rd_layout.page.height,
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

    place(dx: rd_layout.image.pos.x, dy: rd_layout.image.pos.y, render_card_image(model.image_path))
    place(dx: 0pt, dy: 0pt, image(rd_assets_root + "frame/" + model.frame_name + ".png"))
    place(dx: rd_layout.attribute_pos.x, dy: rd_layout.attribute_pos.y, image(
        rd_assets_root + "attribute/" + model.attribute_name + ".png",
    ))

    place(
        dx: rd_layout.name_area.start.x,
        dy: rd_layout.name_area.start.y,
        block(
            width: rd_layout.name_area.end.x - rd_layout.name_area.start.x,
            height: rd_layout.name_area.end.y - rd_layout.name_area.start.y,
            inset: (x: 1pt, y: 3pt),
            {
                set align(left + horizon)
                set text(
                    font: card_text_fonts,
                    size: 12pt,
                    fill: if model.is_spell or model.is_trap { white } else { black },
                )
                scale_x_to_fit(min_x_scale: 50%, model.name)
            },
        ),
    )

    if model.legend {
        place(dx: rd_layout.legend_pos.x, dy: rd_layout.legend_pos.y, image(rd_assets_root + "legend/legene.png"))
    }

    if model.is_monster {
        if model.maximum_atk != none {
            place(dx: rd_layout.maximum_atk.bar_pos.x, dy: rd_layout.maximum_atk.bar_pos.y, image(
                rd_assets_root + "bar/maximum-atk.png",
            ))
            place(
                dx: rd_layout.maximum_atk.value_pos.x,
                dy: rd_layout.maximum_atk.value_pos.y,
                block(
                    width: 50pt,
                    height: 12pt,
                    {
                        set align(right + horizon)
                        set text(font: "Yu-Gi-Oh! Ro GSan Serif Std B", size: 8pt, fill: white)
                        stat_text(model.maximum_atk)
                    },
                ),
            )
        }
        place(dx: rd_layout.bar_pos.x, dy: rd_layout.bar_pos.y, image(rd_assets_root + "bar/atk-def.png"))
        place(
            dx: rd_layout.atk_pos.x,
            dy: rd_layout.atk_pos.y,
            block(
                width: 48pt,
                height: 12pt,
                {
                    set align(right + horizon)
                    set text(font: "Yu-Gi-Oh! Ro GSan Serif Std B", size: 8pt, fill: white)
                    stat_text(model.atk)
                },
            ),
        )
        place(
            dx: rd_layout.def_pos.x,
            dy: rd_layout.def_pos.y,
            block(
                width: 48pt,
                height: 12pt,
                {
                    set align(right + horizon)
                    set text(font: "Yu-Gi-Oh! Ro GSan Serif Std B", size: 8pt, fill: white)
                    stat_text(model.def)
                },
            ),
        )
        place(
            dx: rd_layout.level.pos.x,
            dy: rd_layout.level.pos.y,
            image(rd_assets_root + "level/container.png"),
        )
        place(
            dx: rd_layout.level.number_pos.x,
            dy: rd_layout.level.number_pos.y,
            block(
                width: 24pt,
                height: 18pt,
                {
                    set align(center + horizon)
                    set text(
                        font: "Yu-Gi-Oh! Ro GSan Serif Std B",
                        size: 10pt,
                        fill: white,
                        tracking: -2pt,
                    )
                    str(model.level)
                },
            ),
        )
    }

    if model.maximum_part != none {
        place(
            dx: rd_layout.maximum_part_area.start.x,
            dy: rd_layout.maximum_part_area.start.y,
            block(
                width: rd_layout.maximum_part_area.end.x - rd_layout.maximum_part_area.start.x,
                height: rd_layout.maximum_part_area.end.y - rd_layout.maximum_part_area.start.y,
                inset: (x: 2pt, y: 2pt),
                {
                    set align(center + horizon)
                    set text(font: "Yu-Gi-Oh! Ro GSan Serif Std B", size: 8pt, fill: white)
                    "MAX " + model.maximum_part
                },
            ),
        )
    }

    place(
        dx: rd_layout.typeline_area.start.x,
        dy: rd_layout.typeline_area.start.y,
        block(
            width: rd_layout.typeline_area.end.x - rd_layout.typeline_area.start.x,
            height: rd_layout.typeline_area.end.y - rd_layout.typeline_area.start.y,
            inset: (x: 1pt, y: 1pt),
            {
                set align(left + horizon)
                set text(font: card_text_fonts, size: 6pt, fill: black)
                render_typeline(model)
            },
        ),
    )

    place(
        dx: rd_layout.description_area.start.x,
        dy: rd_layout.description_area.start.y,
        block(
            width: rd_layout.description_area.end.x - rd_layout.description_area.start.x,
            height: rd_layout.description_area.end.y - rd_layout.description_area.start.y,
            inset: (x: 1pt, y: 1pt),
            {
                set align(left)
                set text(font: card_text_fonts, size: 10pt, fill: black)
                fit_text_to_box(model.description)
            },
        ),
    )

    place(
        dx: rd_layout.password_pos.x,
        dy: rd_layout.password_pos.y,
        block(
            width: 70pt,
            height: 10pt,
            {
                set align(left + horizon)
                set text(font: "Yu-Gi-Oh! ITC Stone Serif M", size: 6pt, fill: white)
                str(model.id)
            },
        ),
    )

    pagebreak(weak: true)
}
