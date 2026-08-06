#let has-type(card, name) = card.type.contains(name)

#let frame(card) = {
    if has-type(card, "魔法") {
        "4"
    } else if has-type(card, "陷阱") {
        "5"
    } else if has-type(card, "融合") {
        "3"
    } else if has-type(card, "仪式") {
        "2"
    } else if has-type(card, "通常") {
        "0"
    } else {
        "1"
    }
}

#let attribute(card) = {
    if has-type(card, "魔法") {
        "10"
    } else if has-type(card, "陷阱") {
        "20"
    } else {
        assert(card.attribute in range(6), message: "unsupported RD attribute: " + str(card.attribute))
        ("00", "01", "02", "03", "04", "05").at(card.attribute)
    }
}

#let spell-trap-icon(name) = if name == "场地" {
    "3"
} else if name == "装备" {
    "1"
} else if name == "永续" {
    "2"
} else if name == "仪式" {
    "0"
}

#let type-parts(card) = {
    if has-type(card, "怪兽") {
        card.type.filter(item => item != "怪兽")
    } else if has-type(card, "魔法") {
        ("魔法卡",) + card.type.filter(item => item != "魔法")
    } else if has-type(card, "陷阱") {
        ("陷阱卡",) + card.type.filter(item => item != "陷阱")
    } else {
        card.type
    }
}

#let type-icons(card, parts) = parts.map(part => {
    if has-type(card, "魔法") or has-type(card, "陷阱") {
        spell-trap-icon(part)
    }
})

#let description(card, compact) = if compact {
    card.description
        .replace(regex("】\\r?\\n"), "】")
        .replace(regex("\\r?\\n(●)"), match => match.captures.at(0))
} else {
    card.description
}

#let build(card, compact: true, password: true, fullwidth-slash: false, limit: none) = {
    let monster = has-type(card, "怪兽")
    let spell = has-type(card, "魔法")
    let trap = has-type(card, "陷阱")

    assert(monster or spell or trap, message: "RD card type must include 怪兽, 魔法, or 陷阱")
    assert(
        limit == none or (type(limit) == int and limit in range(3)),
        message: "RD limit must be none or an integer from 0 to 2",
    )
    let parts = type-parts(card)

    (
        id: card.id,
        name: card.name,
        type-parts: parts,
        type-icons: type-icons(card, parts),
        description: description(card, compact),
        frame: frame(card),
        attribute: attribute(card),
        image: card.image,
        atk: card.at("atk", default: 0),
        def: card.at("def", default: 0),
        monster: monster,
        spell: spell,
        trap: trap,
        level: card.at("level", default: 0),
        legend: card.legend,
        maximum-atk: card.at("maximumAtk", default: none),
        password: password,
        limit: limit,
        fullwidth-slash: fullwidth-slash,
    )
}
