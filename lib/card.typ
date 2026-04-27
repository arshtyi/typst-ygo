#import "variable.typ": *
#import "one-line.typ": squeeze-to-width

#let card(
    name: "冥骸合龙-莫忘冥地王灵",
    id: 23288411,
    description: "这张卡不能通常召唤。让这张卡以外的自己的手卡·墓地的「莫忘」怪兽5种类各1只回到卡组·额外卡组的场合才能从手卡·墓地特殊召唤。\n①：自己场上没有其他怪兽存在的场合，这张卡可以向对方怪兽全部各作1次攻击。②：1回合1次，对方把魔法·陷阱·怪兽的效果发动的场合才能发动。从自己的手卡·墓地把1只「莫忘」怪兽特殊召唤。",
    pendulumDescription: none,
    scale: none,
    linkVal: none,
    linkMarkers: none,
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
        indicator: none,
    ),
) = {
    // Assert some info here.
    assert(cardImage != none or assets.cardImage != none, message: "card image is required.")
    assert(frameType != none or assets.card != none, message: "card frame is required.")
    assert(attribute != none or assets.attribute != none, message: "attribute icon is required.")
    assert(
        cardType == _card_type.monster
            or ((cardType == _card_type.spell or cardType == _card_type.trap) and race != none),
        message: "spell and trap card must have a race.",
    )
    assert(name != none, message: "card name is required.")

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
}

