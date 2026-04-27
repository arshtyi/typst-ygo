#import "variable.typ": *

#let card(
    name: "冥骸合龙-莫忘冥地王灵",
    id: 23288411,
    description: "这张卡不能通常召唤。让这张卡以外的自己的手卡·墓地的「莫忘」怪兽5种类各1只回到卡组·额外卡组的场合才能从手卡·墓地特殊召唤。\n①：自己场上没有其他怪兽存在的场合，这张卡可以向对方怪兽全部各作1次攻击。②：1回合1次，对方把魔法·陷阱·怪兽的效果发动的场合才能发动。从自己的手卡·墓地把1只「莫忘」怪兽特殊召唤。",
    pendulumDescription: none,
    scale: none,
    linkVal: none,
    linkMarkers: none,
    cardTyype: "monster",
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
        path: "../assets/",
        font: (
            SC: "Yu-Gi-Oh! DFKaiW5-A",
            ATK-DEF: "Yu-Gi-Oh! ITC Stone Serif M",
            LINK: "Yu-Gi-Oh! Matrix",
            PASSWD-NO: "Yu-Gi-Oh! Ro GSan Serif Std B",
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
        attibutes: none,
        cards: none,
        icons: none,
        indicators: none,
    ),
) = {
    // Assert some info here.
    assert(cardImage != none or assets.cardImage != none, message: "card image is required.")
    assert(frameType != none or assets.cards != none, message: "card frame is required.")
    assert(attribute != none or assets.attibutes != none, message: "attribute icon is required.")
    // Divide the card types.
    let isXyz = frameType.contains("xyz")
    let isLink = frameType.contains("link")
    let isPendulum = frameType.contains("pendulum")

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
        assets.path + "images/" + str(cardImage) + ".png"
    }
    let frameImagePath = if (assets.cards != none) {
        assets.cards
    } else {
        assets.path + "figure/cards/card-" + frameType + ".png"
    }
    set page(
        width: _card_width,
        height: _card_height,
        margin: 0pt,
        foreground: {
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
        },
    )

    // Attributes.
    let attributeIcon = if assets.attibutes != none { image(assets.attibutes) } else {
        image(
            assets.path + "figure/attributes/attribute-" + attribute + ".png",
        )
    }
}

