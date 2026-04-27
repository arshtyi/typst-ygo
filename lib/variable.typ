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
#let _ppi_in_ps_ = 600

/**
 * convert to typst unit.
 */
#let _card_width = _card_width_in_ps / _ppi_in_ps_ * 72pt
#let _card_height = _card_height_in_ps / _ppi_in_ps_ * 72pt
#let _image = (
    pos: (
        normal: (
            x: _image_in_ps.pos.normal.x / _ppi_in_ps_ * 72pt,
            y: _image_in_ps.pos.normal.y / _ppi_in_ps_ * 72pt,
        ),
        pendulum: (
            x: _image_in_ps.pos.pendulum.x / _ppi_in_ps_ * 72pt,
            y: _image_in_ps.pos.pendulum.y / _ppi_in_ps_ * 72pt,
        ),
    ),
    size: (
        normal: (
            width: _image_in_ps.size.normal.width / _ppi_in_ps_ * 72pt,
            height: _image_in_ps.size.normal.height / _ppi_in_ps_ * 72pt,
        ),
        pendulum: (
            width: _image_in_ps.size.pendulum.width / _ppi_in_ps_ * 72pt,
            height-1: _image_in_ps.size.pendulum.height-1 / _ppi_in_ps_ * 72pt,
            height-2: _image_in_ps.size.pendulum.height-2 / _ppi_in_ps_ * 72pt,
        ),
    ),
)
#let _ppi = _ppi_in_ps_

/**
 * card types.
 *
 * so far, no link-spell and link-pendulum.
 */
#let _card_type = (
    "monster",
    "spell",
    "trap",
)
#let _frame_type = (
    "monster": (
        "normal": (
            "token",
            "normal",
            "effect",
            "fusion",
            "ritual",
            "synchro",
            "xyz",
        ),
        "pendulum": (
            "normal",
            "effect",
            "fusion",
            "ritual",
            "synchro",
            "xyz",
            // "link",
        ),
        "link": (
            "link"
        ),
    ),
    "spell": (
        "normal",
        "field",
        "equip",
        "continuous",
        "quick-play",
        "ritual",
        // "link",
    ),
    "trap": (
        "normal",
        "continuous",
        "counter",
    ),
)
