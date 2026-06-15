#import "renderer.typ": render_card

#let ot_card_data(path: "../../assets/ot/card/ot.json") = json(path)
#let ot_image_index(path: "../../assets/ot/images/index.json") = json(path)

#let has_type(card, name) = card.type.contains(name)

#let ot_monster_frame_asset(card) = {
    if has_type(card, "连接") {
        "link"
    } else if has_type(card, "融合") {
        "fusion"
    } else if has_type(card, "仪式") {
        "ritual"
    } else if has_type(card, "同调") {
        "synchro"
    } else if has_type(card, "超量") {
        "xyz"
    } else if has_type(card, "衍生物") {
        "token"
    } else if has_type(card, "通常") {
        "normal"
    } else if has_type(card, "效果") {
        "effect"
    } else {
        none
    }
}

#let ot_frame_asset(card) = {
    if has_type(card, "魔法") {
        "spell"
    } else if has_type(card, "陷阱") {
        "trap"
    } else {
        let frame = ot_monster_frame_asset(card)
        if has_type(card, "连接") {
            "link"
        } else if has_type(card, "灵摆") {
            frame + "-pendulum"
        } else {
            frame
        }
    }
}

#let ot_attribute_asset(card) = {
    if has_type(card, "魔法") {
        "spell"
    } else if has_type(card, "陷阱") {
        "trap"
    } else if card.attribute == 0 {
        "devine"
    } else if card.attribute == 1 {
        "light"
    } else if card.attribute == 2 {
        "dark"
    } else if card.attribute == 3 {
        "wind"
    } else if card.attribute == 4 {
        "earth"
    } else if card.attribute == 5 {
        "fire"
    } else if card.attribute == 6 {
        "water"
    } else {
        panic("unsupported OT attribute: " + str(card.attribute))
    }
}

#let ot_race_icon_asset(card) = {
    if has_type(card, "魔法") {
        if has_type(card, "场地") {
            "field"
        } else if has_type(card, "装备") {
            "equip"
        } else if has_type(card, "永续") {
            "continuous"
        } else if has_type(card, "速攻") {
            "quick-play"
        } else if has_type(card, "仪式") {
            "ritual"
        } else {
            none
        }
    } else if has_type(card, "陷阱") {
        if has_type(card, "永续") {
            "continuous"
        } else if has_type(card, "反击") {
            "counter"
        } else {
            none
        }
    } else {
        none
    }
}

#let ot_level_or_rank(card) = {
    if has_type(card, "超量") {
        card.at("rank", default: 0)
    } else {
        card.at("level", default: 0)
    }
}

#let ot_description(card) = {
    if has_type(card, "怪兽") {
        "【" + card.type.slice(1).join("/") + "】\n" + card.description
    } else {
        card.description
    }
}

#let ot_image_path(image_id, images) = {
    let file = images.at(str(image_id), default: none)
    assert(file != none, message: "OT image not found: " + str(image_id))
    "../../assets/ot/images/" + file
}

#let ot_render_model(card, images) = {
    let is_monster = has_type(card, "怪兽")
    let is_spell = has_type(card, "魔法")
    let is_trap = has_type(card, "陷阱")

    assert(is_monster or is_spell or is_trap, message: "OT card must have one of 怪兽/魔法/陷阱 in type")

    (
        id: card.id,
        name: card.name,
        description: ot_description(card),
        frame_asset: ot_frame_asset(card),
        attribute_asset: ot_attribute_asset(card),
        image_path: ot_image_path(card.image, images),
        atk: card.at("atk", default: 0),
        def: card.at("def", default: 0),
        is_link: has_type(card, "连接"),
        is_monster: is_monster,
        is_pendulum: has_type(card, "灵摆"),
        is_spell: is_spell,
        is_trap: is_trap,
        is_xyz: has_type(card, "超量"),
        level: ot_level_or_rank(card),
        link_markers: card.at("linkMarker", default: ()),
        link_value: card.at("linkValue", default: none),
        pendulum_description: card.at("pendulumDescription", default: none),
        race_icon_asset: ot_race_icon_asset(card),
        scale: card.at("pendulumScale", default: none),
    )
}

#let ot_card(card, images: none) = {
    let resolved_images = if images == none { ot_image_index() } else { images }
    render_card(ot_render_model(card, resolved_images))
}

#let ot_card_by_id(id, cards: none, images: none) = {
    let resolved_cards = if cards == none { ot_card_data() } else { cards }
    let card = resolved_cards.filter(card => card.id == id).first(default: none)
    assert(card != none, message: "OT card not found: " + str(id))
    ot_card(card, images: images)
}
