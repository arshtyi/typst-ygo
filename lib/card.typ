#import "variable.typ": *
#import "one-line.typ": squeeze-to-width

#let card(
    name: "冥骸合龙-莫忘冥地王灵",
    id: 23288411,
    description: "这张卡不能通常召唤。让这张卡以外的自己的手卡·墓地的「莫忘」怪兽5种类各1只回到卡组·额外卡组的场合才能从手卡·墓地特殊召唤。\n①：自己场上没有其他怪兽存在的场合，这张卡可以向对方怪兽全部各作1次攻击。②：1回合1次，对方把魔法·陷阱·怪兽的效果发动的场合才能发动。从自己的手卡·墓地把1只「莫忘」怪兽特殊召唤。",
    pendulumDescription: none,
    scale: none,
    linkVal: none,
    linkMarkers: (
        top-left: none,
        top: none,
        top-right: none,
        left: none,
        right: none,
        bottom-left: none,
        bottom: none,
        bottom-right: none,
    ),
    cardType: "monster",
    attribute: "earth",
    race: none,
    atk: 5000,
    def: 5000,
    level: 11,
    frameType: "effect",
    typeline: "【幻龙族/特殊召唤/效果】",
    limit: (
        ocg: none,
        tcg: none,
        md: none,
    ),
    cardImage: 23288411,
    assets: (
        path: none,
        fonts: (
            SC: none,
            ATK-DEF-SCALE: none,
            LINK: none,
            PASSWD-NO: none,
        ),
        cardImage: none,
        arrows: (
            bottom-left: none,
            bottom: none,
            bottom-right: none,
            left: none,
            right: none,
            top-left: none,
            top: none,
            top-right: none,
        ),
        attribute: none,
        card: none,
        icon: none,
        indicators: (
            atk-def: none,
            atk-link: none,
            level: none,
            rank: none,
        ),
    ),
) = {
    let assetsPath = if assets.path != none { assets.path } else { "../assets/" }
    let fonts = (
        SC: if assets.fonts.SC != none { assets.fonts.SC } else { "Yu-Gi-Oh! DFKaiW5-A" },
        ATK-DEF-SCALE: if assets.fonts.ATK-DEF-SCALE != none { assets.fonts.ATK-DEF-SCALE } else { "Yu-Gi-Oh! Matrix" },
        LINK: if assets.fonts.LINK != none { assets.fonts.LINK } else { "Yu-Gi-Oh! Ro GSan Serif Std B" },
        PASSWD-NO: if assets.fonts.PASSWD-NO != none { assets.fonts.PASSWD-NO } else {
            "Yu-Gi-Oh! ITC Stone Serif M"
        },
    )

    // Divide the card types.
    let isMonster = cardType == _card_type.monster
    let isSpell = cardType == _card_type.spell
    let isTrap = cardType == _card_type.trap
    let isXyz = isMonster and frameType.contains(_card_hint.xyz)
    let isLink = isMonster and frameType.contains(_card_hint.link)
    let isPendulum = isMonster and frameType.contains(_card_hint.pendulum)

    // Image and frame.
    let png-size(path) = {
        let data = read(path, encoding: none)
        let be32(data, i) = {
            data.at(i) * 256 * 256 * 256 + data.at(i + 1) * 256 * 256 + data.at(i + 2) * 256 + data.at(i + 3)
        }
        (
            width: be32(data, 16),
            height: be32(data, 20),
        )
    }
    let card-image(path) = {
        let size = png-size(path)
        let target-width = if isPendulum { _image.size.pendulum.width } else { _image.size.normal.width }
        let target-height = if isPendulum {
            if size.width == 712 and size.height == 908 { _image.size.pendulum.height-1 } else {
                _image.size.pendulum.height-2
            }
        } else { _image.size.normal.height }
        image(
            path,
            width: target-width,
            height: target-height,
            fit: "stretch",
        )
    }
    let frame-image(path) = image(path)
    let cardImagePath = if (assets.cardImage != none) {
        assets.cardImage
    } else {
        assetsPath + "images/" + str(cardImage) + ".png"
    }
    let frameImagePath = if (assets.card != none) {
        assets.card
    } else {
        assetsPath + "figure/cards/card-" + frameType + ".png"
    }

    // Attributes.
    let attributeIconPath = if assets.attribute != none { assets.attribute } else {
        assetsPath + "figure/attributes/attribute-" + attribute + ".png"
    }
    set page(
        width: _card_width,
        height: _card_height,
        margin: 0pt,
    )
    set par(justify: true)
    place(
        dx: if isPendulum { _image.pos.pendulum.x } else { _image.pos.normal.x },
        dy: if isPendulum { _image.pos.pendulum.y } else { _image.pos.normal.y },
        card-image(cardImagePath),
    )
    place(
        dx: 0pt,
        dy: 0pt,
        frame-image(frameImagePath),
    )
    place(
        dx: _attribute_pos.x,
        dy: _attribute_pos.y,
        image(attributeIconPath),
    )
    place(
        dx: _name_area.st.x,
        dy: _name_area.st.y,
        block(
            width: _name_area.ed.x - _name_area.st.x,
            height: _name_area.ed.y - _name_area.st.y,
            // stroke: .1pt,
            inset: (x: 1pt, y: 3pt),
            {
                set align(left + horizon)
                set text(font: fonts.SC, size: 10pt, fill: if isXyz or isSpell or isTrap { white } else { black })
                squeeze-to-width(min-x-scale: 50%, name)
            },
        ),
    )
    if isPendulum {
        place(
            dx: _scale_area.x.left,
            dy: _scale_area.y,
            block(
                width: 11pt,
                height: 12pt,
                // stroke: .1pt,
                inset: (x: 1pt, y: 3pt),
                {
                    set align(center + horizon)
                    set text(font: fonts.ATK-DEF-SCALE, size: 10pt, fill: black)
                    str(scale)
                },
            ),
        )
        place(
            dx: _scale_area.x.right,
            dy: _scale_area.y,
            block(
                width: 11pt,
                height: 12pt,
                // stroke: .1pt,
                inset: (x: 1pt, y: 3pt),
                {
                    set align(center + horizon)
                    set text(font: fonts.ATK-DEF-SCALE, size: 10pt, fill: black)
                    str(scale)
                },
            ),
        )
    }
    place(
        dx: _passwd_pos.x,
        dy: _passwd_pos.y,
        block(
            width: 32pt,
            height: 10pt,
            // stroke: .1pt,
            {
                set align(left + horizon)
                set text(font: fonts.PASSWD-NO, size: 6pt, fill: black)
                if str(id).len() < 8 {
                    "0" * (8 - str(id).len()) + str(id)
                } else {
                    str(id)
                }
            },
        ),
    )
    if isSpell or isTrap {
        let hasIcon = not (race == _frame_type.spell.normal or race == _frame_type.trap.normal)
        place(
            dx: if hasIcon { _race_pos.x.hasIcon } else { _race_pos.x.noIcon },
            dy: _race_pos.y,
            block(
                width: if hasIcon { 50pt } else { 45pt },
                height: 12pt,
                inset: (x: 1pt, y: 2pt),
                // stroke: .1pt,
                {
                    set align(right + horizon)
                    set text(font: fonts.PASSWD-NO, size: 10pt, fill: black)
                    if isSpell {
                        "【魔法卡"
                    } else {
                        "【陷阱卡"
                    }
                    if hasIcon {
                        let iconPath = if assets.icon != none {
                            assets.icon
                        } else {
                            assetsPath + "figure/icons/icon-" + race + ".png"
                        }
                        box(image(iconPath, scaling: "pixelated"))
                    }
                    str("】")
                },
            ),
        )
    }
    if isMonster {
        if isLink {
            let linkMarkerPos = (
                "top-left",
                "top",
                "top-right",
                "left",
                "right",
                "bottom-left",
                "bottom",
                "bottom-right",
            )
            for marker in linkMarkerPos {
                if linkMarkers.at(marker, default: none) != none {
                    let markerPath = if assets.arrows.at(marker) != none {
                        assets.arrows.at(marker)
                    } else {
                        assetsPath + "figure/arrows/arrow-" + marker + ".png"
                    }
                    place(
                        dx: _link_markers_pos.at(marker).x,
                        dy: _link_markers_pos.at(marker).y,
                        image(markerPath),
                    )
                }
            }
        } else {
            let starPath = if { if isXyz { assets.indicators.rank } else { assets.indicators.level } } != none {
                if isXyz {
                    assets.indicators.rank
                } else {
                    assets.indicators.level
                }
            } else {
                assetsPath + "figure/indicators/" + if isXyz { "rank" } else { "level" } + ".png"
            }
            if level <= 12 {
                if isXyz {
                    for pos in range(level) {
                        place(
                            dx: _star_pos.x.lt_twelve.at(pos),
                            dy: _star_pos.y,
                            image(starPath),
                        )
                    }
                } else {
                    for pos in range(level) {
                        place(
                            dx: _star_pos.x.lt_twelve.at(11 - pos),
                            dy: _star_pos.y,
                            image(starPath),
                        )
                    }
                }
            } else {
                let width = _star_pos.x.gt_twelve.ed - _star_pos.x.gt_twelve.st
                let step = width / (13 - 1) - 0.72pt
                for pos in range(13) {
                    place(
                        dx: _star_pos.x.gt_twelve.st + step * pos,
                        dy: _star_pos.y,
                        image(starPath),
                    )
                }
            }
        }
        let barPath = if { if isLink { assets.indicators.atk-link } else { assets.indicators.atk-def } } != none {
            if isLink {
                assets.indicators.atk-link
            } else {
                assets.indicators.atk-def
            }
        } else {
            assetsPath + "figure/indicators/" + if isLink { "atk-link" } else { "atk-def" } + ".png"
        }
        place(
            dx: _bar_pos.x,
            dy: _bar_pos.y,
            image(barPath),
        )
        place(
            dx: _atk_pos.x,
            dy: _atk_pos.y,
            block(
                width: 15pt,
                height: 6pt,
                // stroke: .1pt,
                inset: (x: 1pt, y: 1pt),
                {
                    set align(right + horizon)
                    set text(font: fonts.ATK-DEF-SCALE, size: 7pt, fill: black)
                    let atk = if atk == -1 {
                        "   ?"
                    } else {
                        if str(atk).len() < 4 {
                            " " * (4 - str(atk).len()) + str(atk)
                        } else {
                            str(atk)
                        }
                    }
                    str(atk)
                },
            ),
        )
        if isLink {
            place(
                dx: _link_val_pos.x,
                dy: _link_val_pos.y,
                block(
                    width: 6pt,
                    height: 6pt,
                    // stroke: .1pt,
                    inset: (x: 1pt, y: 1pt),
                    {
                        set align(center + horizon)
                        set text(font: fonts.LINK, size: 5.2pt, fill: black)
                        str(linkVal)
                    },
                ),
            )
        } else {
            place(
                dx: _def_pos.x,
                dy: _def_pos.y,
                block(
                    width: 15pt,
                    height: 6pt,
                    // stroke: .1pt,
                    inset: (x: 1pt, y: 1pt),
                    {
                        set align(right + horizon)
                        set text(font: fonts.ATK-DEF-SCALE, size: 7pt, fill: black)
                        let def = if def == -1 {
                            "   ?"
                        } else {
                            if str(def).len() < 4 {
                                " " * (4 - str(def).len()) + str(def)
                            } else {
                                str(def)
                            }
                        }
                        str(def)
                    },
                ),
            )
        }
    }
}
