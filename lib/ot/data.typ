#import "renderer.typ": render_card

#let ot_card_data(path: "../../assets/ot/card/ot.json") = json(path)

#let has_card_type(card, name) = card.type.contains(name)

#let ot_monster_frame_name(card) = {
    if has_card_type(card, "连接") {
        "007"
    } else if has_card_type(card, "融合") {
        "004"
    } else if has_card_type(card, "仪式") {
        "003"
    } else if has_card_type(card, "同调") {
        "005"
    } else if has_card_type(card, "超量") {
        "006"
    } else if has_card_type(card, "衍生物") {
        "000"
    } else if has_card_type(card, "通常") {
        "001"
    } else if has_card_type(card, "效果") {
        "002"
    } else {
        none
    }
}

#let ot_frame_name(card) = {
    if has_card_type(card, "魔法") {
        "100"
    } else if has_card_type(card, "陷阱") {
        "200"
    } else {
        let frame = ot_monster_frame_name(card)
        if has_card_type(card, "连接") {
            frame
        } else if has_card_type(card, "灵摆") {
            (
                "001": "011",
                "002": "012",
                "003": "013",
                "004": "014",
                "005": "015",
                "006": "016",
            ).at(frame)
        } else {
            frame
        }
    }
}

#let ot_attribute_name(card) = {
    if has_card_type(card, "魔法") {
        "10"
    } else if has_card_type(card, "陷阱") {
        "20"
    } else if card.attribute == 0 {
        "00"
    } else if card.attribute == 1 {
        "01"
    } else if card.attribute == 2 {
        "02"
    } else if card.attribute == 3 {
        "03"
    } else if card.attribute == 4 {
        "04"
    } else if card.attribute == 5 {
        "05"
    } else if card.attribute == 6 {
        "06"
    } else {
        panic("unsupported OT attribute: " + str(card.attribute))
    }
}

#let ot_spell_trap_icon_name(card) = {
    if has_card_type(card, "魔法") {
        if has_card_type(card, "场地") {
            "4"
        } else if has_card_type(card, "装备") {
            "3"
        } else if has_card_type(card, "永续") {
            "1"
        } else if has_card_type(card, "速攻") {
            "2"
        } else if has_card_type(card, "仪式") {
            "0"
        } else {
            none
        }
    } else if has_card_type(card, "陷阱") {
        if has_card_type(card, "永续") {
            "1"
        } else if has_card_type(card, "反击") {
            "5"
        } else {
            none
        }
    } else {
        none
    }
}

#let ot_level_or_rank(card) = {
    if has_card_type(card, "超量") {
        card.at("rank", default: 0)
    } else {
        card.at("level", default: 0)
    }
}

#let ot_card_description(card) = {
    if has_card_type(card, "怪兽") {
        "【" + card.type.slice(1).join("/") + "】\n" + card.description
    } else {
        card.description
    }
}

#let ot_card_image_path(image_id) = "../../assets/ot/images/" + str(image_id) + ".jpg"

#let ot_card_model(card, compress_description: true, draw_password: true) = {
    let is_monster = has_card_type(card, "怪兽")
    let is_spell = has_card_type(card, "魔法")
    let is_trap = has_card_type(card, "陷阱")

    assert(is_monster or is_spell or is_trap, message: "OT card must have one of 怪兽/魔法/陷阱 in type")

    (
        id: card.id,
        name: card.name,
        description: ot_card_description(card),
        frame_name: ot_frame_name(card),
        attribute_name: ot_attribute_name(card),
        image_path: ot_card_image_path(card.image),
        atk: card.at("atk", default: 0),
        def: card.at("def", default: 0),
        is_link: has_card_type(card, "连接"),
        is_monster: is_monster,
        is_pendulum: has_card_type(card, "灵摆"),
        is_spell: is_spell,
        is_trap: is_trap,
        is_xyz: has_card_type(card, "超量"),
        level: ot_level_or_rank(card),
        link_markers: card.at("linkMarker", default: ()),
        link_value: card.at("linkValue", default: none),
        pendulum_description: card.at("pendulumDescription", default: none),
        compress_description: compress_description,
        draw_password: draw_password,
        spell_trap_icon_name: ot_spell_trap_icon_name(card),
        scale: card.at("pendulumScale", default: none),
    )
}

#let ot_card(card, compress_description: true, draw_password: true) = {
    render_card(ot_card_model(
        card,
        compress_description: compress_description,
        draw_password: draw_password,
    ))
}

#let ot_card_by_id(id, cards: none, compress_description: true, draw_password: true) = {
    let resolved_cards = if cards == none { ot_card_data() } else { cards }
    let card = resolved_cards.filter(card => card.id == id).first(default: none)
    assert(card != none, message: "OT card not found: " + str(id))
    ot_card(card, compress_description: compress_description, draw_password: draw_password)
}
