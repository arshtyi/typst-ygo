#let ppi = 600
#let to_pt(value) = value * 72pt / ppi

#let layout = (
    page: (
        width: to_pt(1394),
        height: to_pt(2031),
    ),
    image: (
        pos: (
            normal: (x: to_pt(169), y: to_pt(376)),
            pendulum: (x: to_pt(95), y: to_pt(365)),
        ),
        size: (
            normal: (width: to_pt(1055), height: to_pt(1053)),
            pendulum: (
                width: to_pt(1205),
                tall_height: to_pt(1546),
                short_height: to_pt(900),
            ),
        ),
    ),
    attribute_pos: (
        x: to_pt(1166),
        y: to_pt(96),
    ),
    name_area: (
        start: (x: to_pt(100), y: to_pt(100)),
        end: (x: to_pt(1160), y: to_pt(225)),
    ),
    scale_area: (
        x: (left: to_pt(100), right: to_pt(1202)),
        y: to_pt(1386),
    ),
    password_pos: (
        x: to_pt(60),
        y: to_pt(1910),
    ),
    race_pos: (
        x: (
            with_icon: to_pt(850),
            without_icon: to_pt(890),
        ),
        y: to_pt(245),
    ),
    star_pos: (
        x: (
            up_to_twelve: (
                to_pt(148),
                to_pt(238),
                to_pt(332),
                to_pt(424),
                to_pt(515),
                to_pt(608),
                to_pt(700),
                to_pt(791),
                to_pt(884),
                to_pt(976),
                to_pt(1067),
                to_pt(1160),
            ),
            over_twelve: (
                start: to_pt(100),
                end: to_pt(1280),
            ),
        ),
        y: to_pt(249),
    ),
    bar_pos: (
        x: to_pt(106),
        y: to_pt(1848),
    ),
    atk_pos: (
        x: to_pt(870),
        y: to_pt(1856),
    ),
    def_pos: (
        x: to_pt(1160),
        y: to_pt(1856),
    ),
    link_value_pos: (
        x: to_pt(1222),
        y: to_pt(1856),
    ),
    link_marker_pos: (
        top-left: (x: to_pt(117), y: to_pt(321)),
        top: (x: to_pt(569), y: to_pt(298)),
        top-right: (x: to_pt(1149), y: to_pt(321)),
        left: (x: to_pt(93), y: to_pt(773)),
        right: (x: to_pt(1223), y: to_pt(773)),
        bottom-left: (x: to_pt(117), y: to_pt(1352)),
        bottom: (x: to_pt(572), y: to_pt(1428)),
        bottom-right: (x: to_pt(1149), y: to_pt(1352)),
    ),
    pendulum_description_area: (
        start: (x: to_pt(210), y: to_pt(1285)),
        end: (x: to_pt(1180), y: to_pt(1495)),
    ),
    description_area: (
        start: (x: to_pt(104), y: to_pt(1530)),
        end: (x: to_pt(1290), y: to_pt(1836)),
    ),
)

