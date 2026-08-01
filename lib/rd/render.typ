#import "../utils/text.typ": fit-text, fit-width
#import "layout.typ": layout

#let assets = "../../assets/rd/"
#let fonts = ("Yu-Gi-Oh! DFKaiW5-A", "YGO_Card_JP")

#let stat-text(value) = if value == -1 { "?" } else { str(value) }

#let card-image(id) = image(
    assets + "images/" + str(id) + ".jpg",
    width: layout.image.size.width,
    height: layout.image.size.height,
    fit: "stretch",
)

#let type-line(model) = {
    "【"
    for (index, part) in model.type-parts.enumerate() {
        if index > 0 {
            "/"
        }
        part
        let icon = model.type-icons.at(index, default: none)
        if icon != none {
            box(baseline: 10%, image(
                assets + "icon/" + icon + ".png",
                height: layout.type-icon-height,
            ))
        }
    }
    "】"
}

#let card(model) = block(
    width: layout.card-size.width,
    height: layout.card-size.height,
    clip: true,
    {
        set place(top + left)
        set text(
            lang: "zh",
            region: "cn",
            cjk-latin-spacing: auto,
            overhang: false,
        )
        set par(justify: true)
    
        place(dx: layout.image.pos.x, dy: layout.image.pos.y, card-image(model.image))
        image(assets + "frame/" + model.frame + ".png")
        place(dx: layout.attribute-pos.x, dy: layout.attribute-pos.y, image(
            assets + "attribute/" + model.attribute + ".png",
        ))
    
        place(
            dx: layout.name-area.start.x,
            dy: layout.name-area.start.y,
            block(
                width: layout.name-area.end.x - layout.name-area.start.x,
                height: layout.name-area.end.y - layout.name-area.start.y,
                inset: (x: 1pt, y: 3pt),
                {
                    set align(left + horizon)
                    set text(
                        font: fonts,
                        size: 12pt,
                        fill: black,
                    )
                    fit-width(min: 50%, model.name)
                },
            ),
        )
    
        if model.legend {
            place(dx: layout.legend-pos.x, dy: layout.legend-pos.y, image(assets + "legend/0.png"))
        }
    
        if model.monster {
            if model.maximum-atk != none {
                place(dx: layout.maximum-atk.bar-pos.x, dy: layout.maximum-atk.bar-pos.y, image(
                    assets + "bar/1.png",
                ))
                place(
                    dx: layout.maximum-atk.value-pos.x,
                    dy: layout.maximum-atk.value-pos.y,
                    block(
                        width: 50pt,
                        height: 12pt,
                        {
                            set align(right + horizon)
                            set text(font: "Yu-Gi-Oh! Ro GSan Serif Std B", size: 8pt, fill: white)
                            stat-text(model.maximum-atk)
                        },
                    ),
                )
            }
            place(dx: layout.bar-pos.x, dy: layout.bar-pos.y, image(assets + "bar/0.png"))
            place(
                dx: layout.atk-pos.x,
                dy: layout.atk-pos.y,
                block(
                    width: 48pt,
                    height: 12pt,
                    {
                        set align(right + horizon)
                        set text(font: "Yu-Gi-Oh! Ro GSan Serif Std B", size: 8pt, fill: white)
                        stat-text(model.atk)
                    },
                ),
            )
            place(
                dx: layout.def-pos.x,
                dy: layout.def-pos.y,
                block(
                    width: 48pt,
                    height: 12pt,
                    {
                        set align(right + horizon)
                        set text(font: "Yu-Gi-Oh! Ro GSan Serif Std B", size: 8pt, fill: white)
                        stat-text(model.def)
                    },
                ),
            )
            place(
                dx: layout.level.pos.x,
                dy: layout.level.pos.y,
                image(assets + "level/0.png"),
            )
            place(
                dx: layout.level.number-pos.x,
                dy: layout.level.number-pos.y,
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
    
        place(
            dx: layout.type-area.start.x,
            dy: layout.type-area.start.y,
            block(
                width: layout.type-area.end.x - layout.type-area.start.x,
                height: layout.type-area.end.y - layout.type-area.start.y,
                inset: (x: 1pt, y: 1pt),
                {
                    set align(left + horizon)
                    set text(font: fonts, size: 6pt, fill: black)
                    type-line(model)
                },
            ),
        )
    
        place(
            dx: layout.description-area.start.x,
            dy: layout.description-area.start.y,
            block(
                width: layout.description-area.end.x - layout.description-area.start.x,
                height: layout.description-area.end.y - layout.description-area.start.y,
                inset: (x: 1pt, y: 1pt),
                {
                    set align(left)
                    set text(font: fonts, size: 5pt, fill: black)
                    fit-text(model.description)
                },
            ),
        )
    
        if model.password {
            place(
                dx: layout.password-pos.x,
                dy: layout.password-pos.y,
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
        }
    
    },
)
