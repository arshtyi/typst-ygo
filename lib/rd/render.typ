#import "../utils/draw.typ": area, canvas, layer
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
    let slash = if model.fullwidth-slash { "／" } else { "/" }
    "【"
    for (index, part) in model.type-parts.enumerate() {
        if index > 0 {
            slash
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

#let card(model) = canvas(
    layout.card-size,
    {
        set text(
            lang: "zh",
            region: "cn",
            cjk-latin-spacing: auto,
            overhang: false,
        )
        set par(justify: true)

        layer(layout.image.pos, card-image(model.image))
        image(
            assets + "frame/" + model.frame + ".png",
            width: layout.card-size.width,
            height: layout.card-size.height,
            fit: "stretch",
        )
        layer(layout.attribute-pos, image(
            assets + "attribute/" + model.attribute + ".png",
        ))

        area(
            layout.name-area,
            {
                set align(left + horizon)
                set text(font: fonts, size: 14pt, fill: black)
                fit-width(min: 50%, model.name)
            },
        )

        if model.legend {
            layer(layout.legend-pos, image(assets + "legend/0.png"))
        }

        if model.monster {
            if model.maximum-atk != none {
                layer(layout.maximum-atk.bar-pos, image(
                    assets + "bar/1.png",
                ))
                layer(
                    layout.maximum-atk.value-pos,
                    block(
                        width: 30pt,
                        height: 12pt,
                        {
                            set align(right + horizon)
                            set text(font: "Yu-Gi-oh(RD)-Number", size: 12pt, fill: white, tracking: -1pt)
                            stat-text(model.maximum-atk)
                        },
                    ),
                )
            }
            layer(layout.bar-pos, image(assets + "bar/0.png"))
            layer(
                layout.atk-pos,
                block(
                    width: 30pt,
                    height: 12pt,
                    {
                        set align(right + horizon)
                        set text(font: "Yu-Gi-oh(RD)-Number", size: 12pt, fill: white, tracking: -1pt)
                        stat-text(model.atk)
                    },
                ),
            )
            layer(
                layout.def-pos,
                block(
                    width: 30pt,
                    height: 12pt,
                    {
                        set align(right + horizon)
                        set text(font: "Yu-Gi-oh(RD)-Number", size: 12pt, fill: white, tracking: -1pt)
                        stat-text(model.def)
                    },
                ),
            )
            layer(layout.level.pos, image(assets + "level/0.png"))
            layer(
                layout.level.number-pos,
                block(
                    width: 17pt,
                    {
                        set align(center + horizon)
                        image(assets + "level/" + str(model.level) + ".png")
                    },
                ),
            )
        }

        area(
            layout.type-area,
            inset: (x: 0pt, y: 1pt),
            {
                set align(left + horizon)
                set text(font: fonts, size: 6pt, fill: black)
                type-line(model)
            },
        )

        area(
            layout.description-area,
            {
                set align(left)
                set text(font: fonts, size: 5pt, fill: black)
                fit-text(model.description)
            },
        )

        if model.password {
            layer(
                layout.password-pos,
                block(
                    width: 50pt,
                    height: 6pt,
                    {
                        set align(left + horizon)
                        set text(font: "FOT-Rodin Pro M", size: 6pt, fill: white)
                        str(model.id)
                    },
                ),
            )
        }
    },
)
