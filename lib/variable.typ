/**
 * size in ps.
 */
#let _card_width_in_ps = 1394
#let _card_height_in_ps = 2031
#let _image_in_ps = (
    pos: (
        pendulum: (x: 95, y: 365),
        normal: (x: 169, y: 376),
    ),
    size: (
        normal: (width: 1055, height: 1053),
        pendulum: (width: 1205, height-1: 1546, height-2: 900),
    ),
)
#let _attribute_pos_in_ps = (
    x: 1166,
    y: 96,
)
#let _name_area_in_ps = (
    st: (x: 100, y: 100),
    ed: (x: 1160, y: 225),
)
#let _scale_area_in_ps = (
    x: (
        left: 100,
        right: 1202,
    ),
    y: 1370,
)
#let _ppi_in_ps_ = 600

// The unit in typst is 1/72 inch.
#let _convert(data) = {
    let _unit = 72pt
    data * _unit / _ppi_in_ps_
}

/**
 * convert to typst unit.
 */
#let _card_width = _convert(_card_width_in_ps)
#let _card_height = _convert(_card_height_in_ps)
#let _image = (
    pos: (
        normal: (
            x: _convert(_image_in_ps.pos.normal.x),
            y: _convert(_image_in_ps.pos.normal.y),
        ),
        pendulum: (
            x: _convert(_image_in_ps.pos.pendulum.x),
            y: _convert(_image_in_ps.pos.pendulum.y),
        ),
    ),
    size: (
        normal: (
            width: _convert(_image_in_ps.size.normal.width),
            height: _convert(_image_in_ps.size.normal.height),
        ),
        pendulum: (
            width: _convert(_image_in_ps.size.pendulum.width),
            height-1: _convert(_image_in_ps.size.pendulum.height-1),
            height-2: _convert(_image_in_ps.size.pendulum.height-2),
        ),
    ),
)
#let _attribute_pos = (
    x: _convert(_attribute_pos_in_ps.x),
    y: _convert(_attribute_pos_in_ps.y),
)
#let _name_area = (
    st: (
        x: _convert(_name_area_in_ps.st.x),
        y: _convert(_name_area_in_ps.st.y),
    ),
    ed: (
        x: _convert(_name_area_in_ps.ed.x),
        y: _convert(_name_area_in_ps.ed.y),
    ),
)
#let _scale_area = (
    x: (
        left: _convert(_scale_area_in_ps.x.left),
        right: _convert(_scale_area_in_ps.x.right),
    ),
    y: _convert(_scale_area_in_ps.y),
)
#let _ppi = _ppi_in_ps_

/**
 * card types.
 *
 * so far, no link-spell and link-pendulum.
 */
#let _card_type = (
    monster: "monster",
    spell: "spell",
    trap: "trap",
)
#let _card_hint = (
    pendulum: "pendulum",
    xyz: "xyz",
    link: "link",
)
#let _frame_type = (
    _card_type.monster: (
        normal: (
            token: "token",
            normal: "normal",
            effect: "effect",
            fusion: "fusion",
            ritual: "ritual",
            synchro: "synchro",
            xyz: "xyz",
        ),
        pendulum: (
            normal: "normal",
            effect: "effect",
            fusion: "fusion",
            ritual: "ritual",
            synchro: "synchro",
            xyz: "xyz",
            // link: "link",
        ),
        link: (
            link: "link",
        ),
    ),
    _card_type.spell: (
        normal: "normal",
        field: "field",
        equip: "equip",
        continuous: "continuous",
        quick-play: "quick-play",
        ritual: "ritual",
        // link: "link",
    ),
    _card_type.trap: (
        normal: "normal",
        continuous: "continuous",
        counter: "counter",
    ),
)
