#let card_kind = (
    monster: "monster",
    spell: "spell",
    trap: "trap",
)

#let frame_family = (
    normal: "normal",
    pendulum: "pendulum",
    link: "link",
)

#let spell_race = (
    normal: "normal",
    field: "field",
    equip: "equip",
    continuous: "continuous",
    quick_play: "quick-play",
    ritual: "ritual",
)

#let trap_race = (
    normal: "normal",
    continuous: "continuous",
    counter: "counter",
)

#let monster_frame = (
    token: "token",
    normal: "normal",
    effect: "effect",
    fusion: "fusion",
    ritual: "ritual",
    synchro: "synchro",
    xyz: "xyz",
    link: "link",
)

#let link_marker_order = (
    "top-left",
    "top",
    "top-right",
    "left",
    "right",
    "bottom-left",
    "bottom",
    "bottom-right",
)

#let make_frame(kind, variant, family: frame_family.normal) = (
    kind: kind,
    family: family,
    variant: variant,
)

#let is_monster_frame(frame) = frame.kind == card_kind.monster
#let is_spell_frame(frame) = frame.kind == card_kind.spell
#let is_trap_frame(frame) = frame.kind == card_kind.trap
#let is_link_frame(frame) = is_monster_frame(frame) and frame.family == frame_family.link
#let is_pendulum_frame(frame) = is_monster_frame(frame) and frame.family == frame_family.pendulum
#let is_xyz_frame(frame) = is_monster_frame(frame) and frame.variant == monster_frame.xyz

#let frame_name(frame) = {
    if is_spell_frame(frame) {
        card_kind.spell
    } else if is_trap_frame(frame) {
        card_kind.trap
    } else if frame.family == frame_family.normal {
        frame.variant
    } else if frame.family == frame_family.link {
        monster_frame.link
    } else {
        frame.variant + "-" + frame.family
    }
}
