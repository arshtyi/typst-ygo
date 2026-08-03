#let has-type(card, name) = card.type.contains(name)

#let monster-frame(card) = {
    if has-type(card, "连接") {
        "007"
    } else if has-type(card, "融合") {
        "004"
    } else if has-type(card, "仪式") {
        "003"
    } else if has-type(card, "同调") {
        "005"
    } else if has-type(card, "超量") {
        "006"
    } else if has-type(card, "衍生物") {
        "000"
    } else if has-type(card, "通常") {
        "001"
    } else if has-type(card, "效果") {
        "002"
    } else {
        none
    }
}

#let frame(card) = {
    if has-type(card, "魔法") {
        "100"
    } else if has-type(card, "陷阱") {
        "200"
    } else {
        let base = monster-frame(card)

        if has-type(card, "连接") {
            base
        } else if has-type(card, "灵摆") {
            (
                "001": "011",
                "002": "012",
                "003": "013",
                "004": "014",
                "005": "015",
                "006": "016",
            ).at(base)
        } else {
            base
        }
    }
}

#let attribute(card) = {
    if has-type(card, "魔法") {
        "10"
    } else if has-type(card, "陷阱") {
        "20"
    } else {
        assert(card.attribute in range(7), message: "unsupported OT attribute: " + str(card.attribute))
        ("00", "01", "02", "03", "04", "05", "06").at(card.attribute)
    }
}

#let spell-trap-icon(card) = {
    if has-type(card, "魔法") {
        if has-type(card, "场地") {
            "4"
        } else if has-type(card, "装备") {
            "3"
        } else if has-type(card, "永续") {
            "1"
        } else if has-type(card, "速攻") {
            "2"
        } else if has-type(card, "仪式") {
            "0"
        }
    } else if has-type(card, "陷阱") {
        if has-type(card, "永续") {
            "1"
        } else if has-type(card, "反击") {
            "5"
        }
    }
}

#let level(card) = if has-type(card, "超量") {
    card.at("rank", default: 0)
} else {
    card.at("level", default: 0)
}

#let description(card, fullwidth-slash) = if has-type(card, "怪兽") {
    let slash = if fullwidth-slash { "／" } else { "/" }
    "【" + card.type.slice(1).join(slash) + "】\n" + card.description
} else {
    card.description
}

#let build(card, compact: true, password: true, fullwidth-slash: false) = {
    let monster = has-type(card, "怪兽")
    let spell = has-type(card, "魔法")
    let trap = has-type(card, "陷阱")

    assert(monster or spell or trap, message: "OT card type must include 怪兽, 魔法, or 陷阱")

    (
        id: card.id,
        name: card.name,
        description: description(card, fullwidth-slash),
        frame: frame(card),
        attribute: attribute(card),
        image: card.image,
        atk: card.at("atk", default: 0),
        def: card.at("def", default: 0),
        link: has-type(card, "连接"),
        monster: monster,
        pendulum: has-type(card, "灵摆"),
        spell: spell,
        trap: trap,
        xyz: has-type(card, "超量"),
        level: level(card),
        link-markers: card.at("linkMarker", default: ()),
        link-value: card.at("linkValue", default: none),
        pendulum-text: card.at("pendulumDescription", default: none),
        compact: compact,
        password: password,
        icon: spell-trap-icon(card),
        scale: card.at("pendulumScale", default: none),
    )
}
