#let ppi = 600
#let to_pt(value) = value * 72pt / ppi

#let rd_layout = (
    page: (
        width: to_pt(1394),
        height: to_pt(2031),
    ),
    name_area: (
        start: (x: to_pt(60), y: to_pt(70)),
        end: (x: to_pt(1100), y: to_pt(170)),
    ),
    attribute_pos: (
        x: to_pt(1140),
        y: to_pt(68),
    ),
    legend_pos: (
        x: to_pt(80),
        y: to_pt(215),
    ),
    image: (
        pos: (x: to_pt(70), y: to_pt(200)),
        size: (width: to_pt(1258), height: to_pt(1258)),
    ),
    level: (
        pos: (x: to_pt(80), y: to_pt(1210)),
        number_pos: (x: to_pt(80), y: to_pt(1280)),
    ),
    maximum_part_area: (
        start: (x: to_pt(250), y: to_pt(1210)),
        end: (x: to_pt(520), y: to_pt(1285)),
    ),
    typeline_area: (
        start: (x: to_pt(90), y: to_pt(1470)),
        end: (x: to_pt(1100), y: to_pt(1530)),
    ),
    typeline_icon_height: to_pt(60),
    description_area: (
        start: (x: to_pt(90), y: to_pt(1550)),
        end: (x: to_pt(1300), y: to_pt(1880)),
    ),
    password_pos: (
        x: to_pt(75),
        y: to_pt(1890),
    ),
    bar_pos: (
        x: to_pt(185),
        y: to_pt(1350),
    ),
    atk_pos: (
        x: to_pt(300),
        y: to_pt(1348),
    ),
    def_pos: (
        x: to_pt(745),
        y: to_pt(1348),
    ),
    maximum_atk: (
        bar_pos: (x: to_pt(190), y: to_pt(1248)),
        value_pos: (x: to_pt(730), y: to_pt(1245)),
    ),
)
