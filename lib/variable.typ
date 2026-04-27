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
    y: 1386,
)
#let _passwd_pos_in_ps = (
    x: 60,
    y: 1910,
)
#let _race_pos_in_ps = (
    x: (hasIcon: 850, noIcon: 890),
    y: 245,
)
#let _star_pos_in_ps = (
    x: (
        lt_twelve: (
            148,
            238,
            332,
            424,
            515,
            608,
            700,
            791,
            884,
            976,
            1067,
            1160,
        ),
        gt_twelve: (
            st: 100,
            ed: 1280,
        ),
    ),
    y: 249,
)
#let _bar_pos_in_ps = (
    x: 106,
    y: 1848,
)
#let _atk_pos_in_ps = (
    x: 870,
    y: 1856,
)
#let _def_pos_in_ps = (
    x: 1160,
    y: 1856,
)
#let _link_val_pos_in_ps = (
    x: 1222,
    y: 1856,
)
#let _link_markers_pos_in_ps = (
    top-left: (x: 117, y: 321),
    top: (x: 569, y: 298),
    top-right: (x: 1149, y: 321),
    left: (x: 93, y: 773),
    right: (x: 1223, y: 773),
    bottom-left: (x: 117, y: 1352),
    bottom: (x: 572, y: 1428),
    bottom-right: (x: 1149, y: 1352),
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
#let _passwd_pos = (
    x: _convert(_passwd_pos_in_ps.x),
    y: _convert(_passwd_pos_in_ps.y),
)
#let _race_pos = (
    x: (
        hasIcon: _convert(_race_pos_in_ps.x.hasIcon),
        noIcon: _convert(_race_pos_in_ps.x.noIcon),
    ),
    y: _convert(_race_pos_in_ps.y),
)
#let _star_pos = (
    x: (
        lt_twelve: (
            _convert(_star_pos_in_ps.x.lt_twelve.at(0)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(1)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(2)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(3)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(4)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(5)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(6)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(7)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(8)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(9)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(10)),
            _convert(_star_pos_in_ps.x.lt_twelve.at(11)),
        ),
        gt_twelve: (
            st: _convert(_star_pos_in_ps.x.gt_twelve.st),
            ed: _convert(_star_pos_in_ps.x.gt_twelve.ed),
        ),
    ),
    y: _convert(_star_pos_in_ps.y),
)
#let _bar_pos = (
    x: _convert(_bar_pos_in_ps.x),
    y: _convert(_bar_pos_in_ps.y),
)
#let _atk_pos = (
    x: _convert(_atk_pos_in_ps.x),
    y: _convert(_atk_pos_in_ps.y),
)
#let _def_pos = (
    x: _convert(_def_pos_in_ps.x),
    y: _convert(_def_pos_in_ps.y),
)
#let _link_val_pos = (
    x: _convert(_link_val_pos_in_ps.x),
    y: _convert(_link_val_pos_in_ps.y),
)
#let _link_markers_pos = (
    top-left: (
        x: _convert(_link_markers_pos_in_ps.top-left.x),
        y: _convert(_link_markers_pos_in_ps.top-left.y),
    ),
    top: (
        x: _convert(_link_markers_pos_in_ps.top.x),
        y: _convert(_link_markers_pos_in_ps.top.y),
    ),
    top-right: (
        x: _convert(_link_markers_pos_in_ps.top-right.x),
        y: _convert(_link_markers_pos_in_ps.top-right.y),
    ),
    left: (
        x: _convert(_link_markers_pos_in_ps.left.x),
        y: _convert(_link_markers_pos_in_ps.left.y),
    ),
    right: (
        x: _convert(_link_markers_pos_in_ps.right.x),
        y: _convert(_link_markers_pos_in_ps.right.y),
    ),
    bottom-left: (
        x: _convert(_link_markers_pos_in_ps.bottom-left.x),
        y: _convert(_link_markers_pos_in_ps.bottom-left.y),
    ),
    bottom: (
        x: _convert(_link_markers_pos_in_ps.bottom.x),
        y: _convert(_link_markers_pos_in_ps.bottom.y),
    ),
    bottom-right: (
        x: _convert(_link_markers_pos_in_ps.bottom-right.x),
        y: _convert(_link_markers_pos_in_ps.bottom-right.y),
    ),
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
