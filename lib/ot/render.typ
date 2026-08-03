#import "../utils/draw.typ": area, canvas, layer
#import "../utils/jpeg.typ": jpeg-size
#import "../utils/text.typ": fit-effect, fit-width
#import "layout.typ": layout

#let assets = "../../assets/ot/"
#let fonts = ("Yu-Gi-Oh! DFKaiW5-A", "YGO_Card_JP")

#let pad-number(value, width) = {
    let text = str(value)
    if text.len() < width {
        "0" * (width - text.len()) + text
    } else {
        text
    }
}

#let stat-text(value) = {
    if value == -1 {
        "   ?"
    } else if str(value).len() < 4 {
        " " * (4 - str(value).len()) + str(value)
    } else {
        str(value)
    }
}

#let card-image(id, pendulum) = {
    let path = assets + "images/" + str(id) + ".jpg"
    let target-width = if pendulum {
        layout.image.size.pendulum.width
    } else {
        layout.image.size.normal.width
    }
    let target-height = if pendulum {
        let size = jpeg-size(path)
        if size.width == 712 and size.height == 908 {
            layout.image.size.pendulum.tall-height
        } else {
            layout.image.size.pendulum.short-height
        }
    } else {
        layout.image.size.normal.height
    }

    image(path, width: target-width, height: target-height, fit: "stretch")
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
        set par(
            justify: true,
            linebreaks: "optimized",
            justification-limits: (
                spacing: (min: 90%, max: 130%),
                tracking: (min: -0.01em, max: 0.02em),
            ),
        )

        layer(
            if model.pendulum { layout.image.pos.pendulum } else { layout.image.pos.normal },
            card-image(model.image, model.pendulum),
        )
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
                set text(
                    font: fonts,
                    size: 10pt,
                    fill: if model.xyz or model.spell or model.trap { white } else { black },
                )
                fit-width(min: 50%, model.name)
            },
        )

        if model.pendulum {
            for side in ("left", "right") {
                layer(
                    (x: layout.pendulum-scale-area.x.at(side), y: layout.pendulum-scale-area.y),
                    block(
                        width: 12pt,
                        height: 12pt,
                        {
                            set align(center + horizon)
                            set text(font: "Yu-Gi-Oh! Matrix", size: 10pt, fill: black)
                            str(model.scale)
                        },
                    ),
                )
            }

            area(
                layout.pendulum-description-area,
                inset: (x: 1pt, y: 1pt),
                {
                    set align(left)
                    set text(font: fonts, size: 5pt, fill: black)
                    fit-effect(4, model.pendulum-text, compact: model.compact)
                },
            )
        }

        if model.password {
            layer(
                layout.password-pos,
                block(
                    width: 32pt,
                    height: 10pt,
                    {
                        set align(left + horizon)
                        set text(
                            font: "Yu-Gi-Oh! ITC Stone Serif M",
                            size: 4.71pt,
                            fill: if model.xyz { white } else { black },
                        )
                        pad-number(model.id, 8)
                    },
                ),
            )
        }

        if model.spell or model.trap {
            let has-icon = model.icon != none
            layer(
                (
                    x: if has-icon { layout.race-pos.x.with-icon } else { layout.race-pos.x.without-icon },
                    y: layout.race-pos.y,
                ),
                block(
                    width: if has-icon { 50pt } else { 45pt },
                    height: 12pt,
                    inset: (right: 1pt),
                    {
                        set align(right + horizon)
                        set text(font: fonts, size: 10pt, fill: black)
                        if model.spell { "【魔法卡" } else { "【陷阱卡" }
                        if has-icon {
                            box(baseline: .8pt, scale(
                                image(assets + "icon/" + model.icon + ".png"),
                                x: 110%,
                                y: 110%,
                            ))
                        }
                        "】"
                    },
                ),
            )
        }

        if model.monster {
            if model.link {
                for marker in model.link-markers {
                    let pos = layout.link-marker-pos.at(marker)
                    layer(pos, image(assets + "link/" + str(marker) + ".png"))
                }
            } else {
                let star-path = if model.xyz { assets + "rank/0.png" } else {
                    assets + "level/0.png"
                }

                if model.level <= 12 {
                    for pos in range(model.level) {
                        let slot = if model.xyz { pos } else { 11 - pos }
                        layer(
                            (x: layout.star-pos.x.up-to-twelve.at(slot), y: layout.star-pos.y),
                            image(star-path),
                        )
                    }
                } else {
                    let width = layout.star-pos.x.over-twelve.end - layout.star-pos.x.over-twelve.start
                    let step = width / (13 - 1) - 0.72pt

                    for pos in range(13) {
                        layer(
                            (x: layout.star-pos.x.over-twelve.start + step * pos, y: layout.star-pos.y),
                            image(star-path),
                        )
                    }
                }
            }

            layer(layout.bar-pos, image(if model.link {
                assets + "bar/1.png"
            } else {
                assets + "bar/0.png"
            }))

            layer(
                layout.atk-pos,
                block(
                    width: 15pt,
                    height: 6pt,
                    {
                        set align(right + horizon)
                        set text(font: "Yu-Gi-Oh! Matrix", size: 7pt, fill: black)
                        stat-text(model.atk)
                    },
                ),
            )

            if model.link {
                layer(
                    layout.link-value-pos,
                    block(
                        width: 6pt,
                        height: 6pt,
                        {
                            set align(center + horizon)
                            set text(font: "Yu-Gi-Oh! Ro GSan Serif Std B", size: 5.2pt, fill: black)
                            str(model.link-value)
                        },
                    ),
                )
            } else {
                layer(
                    layout.def-pos,
                    block(
                        width: 15pt,
                        height: 6pt,
                        {
                            set align(right + horizon)
                            set text(font: "Yu-Gi-Oh! Matrix", size: 7pt, fill: black)
                            stat-text(model.def)
                        },
                    ),
                )
            }
        }

        area(
            if model.monster { layout.monster-description-area } else { layout.spell-or-trap-description-area },
            {
                set align(left)
                set text(font: fonts, size: 5pt, fill: black)
                fit-effect(5, model.description, compact: model.compact)
            },
        )
    },
)
