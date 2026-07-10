#import "renderer.typ": render_card

#let rd_card_data(path: "../../assets/rd/card/rd.json") = json(path)

#let has_card_type(card, name) = card.type.contains(name)

#let rd_frame_name(card) = {
    if has_card_type(card, "魔法") {
        "spell"
    } else if has_card_type(card, "陷阱") {
        "trap"
    } else if has_card_type(card, "融合") {
        "fusion"
    } else if has_card_type(card, "仪式") {
        "ritual"
    } else if has_card_type(card, "通常") {
        "normal"
    } else {
        "effect"
    }
}

#let rd_attribute_name(card) = {
    if has_card_type(card, "魔法") {
        "spell"
    } else if has_card_type(card, "陷阱") {
        "trap"
    } else if card.attribute == 0 {
        "light"
    } else if card.attribute == 1 {
        "dark"
    } else if card.attribute == 2 {
        "windy"
    } else if card.attribute == 3 {
        "earth"
    } else if card.attribute == 4 {
        "fire"
    } else if card.attribute == 5 {
        "water"
    } else {
        panic("unsupported RD attribute: " + str(card.attribute))
    }
}

#let rd_spell_trap_icon_name(type_name) = {
    if type_name == "场地" {
        "field"
    } else if type_name == "装备" {
        "equip"
    } else if type_name == "永续" {
        "continuous"
    } else if type_name == "仪式" {
        "ritual"
    } else {
        none
    }
}

#let rd_typeline_parts(card) = {
    if has_card_type(card, "怪兽") {
        card.type.filter(item => item != "怪兽")
    } else if has_card_type(card, "魔法") {
        ("魔法卡",) + card.type.filter(item => item != "魔法")
    } else if has_card_type(card, "陷阱") {
        ("陷阱卡",) + card.type.filter(item => item != "陷阱")
    } else {
        card.type
    }
}

#let rd_typeline_icon_names(card, parts) = parts.map(part => {
    if has_card_type(card, "魔法") or has_card_type(card, "陷阱") {
        rd_spell_trap_icon_name(part)
    } else {
        none
    }
})

#let rd_card_image_path(image_id) = "../../assets/rd/images/" + str(image_id) + ".jpg"

#let rd_card_description(card, compress_description: true) = {
    if compress_description {
        card.description.replace(regex("】\\r?\\n"), "】")
    } else {
        card.description
    }
}

#let rd_card_model(card, compress_description: true) = {
    let is_monster = has_card_type(card, "怪兽")
    let is_spell = has_card_type(card, "魔法")
    let is_trap = has_card_type(card, "陷阱")

    assert(is_monster or is_spell or is_trap, message: "RD card must have one of 怪兽/魔法/陷阱 in type")
    let typeline_parts = rd_typeline_parts(card)

    (
        id: card.id,
        name: card.name,
        typeline_parts: typeline_parts,
        typeline_icon_names: rd_typeline_icon_names(card, typeline_parts),
        description: rd_card_description(card, compress_description: compress_description),
        frame_name: rd_frame_name(card),
        attribute_name: rd_attribute_name(card),
        image_path: rd_card_image_path(card.image),
        atk: card.at("atk", default: 0),
        def: card.at("def", default: 0),
        is_monster: is_monster,
        is_spell: is_spell,
        is_trap: is_trap,
        level: card.at("level", default: 0),
        legend: card.legend,
        maximum_atk: card.at("maximumAtk", default: none),
    )
}

#let rd_card(card, compress_description: true) = {
    render_card(rd_card_model(card, compress_description: compress_description))
}

#let rd_card_by_id(id, cards: none, compress_description: true) = {
    let resolved_cards = if cards == none { rd_card_data() } else { cards }
    let card = resolved_cards.filter(card => card.id == id).first(default: none)
    assert(card != none, message: "RD card not found: " + str(id))
    rd_card(card, compress_description: compress_description)
}
