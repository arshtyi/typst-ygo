#let ppi = 600
#let to-pt(value) = value * 72pt / ppi

#let layout = (
    card-size: (width: to-pt(1393), height: to-pt(2031)),
    name-area: (
        start: (x: to-pt(60), y: to-pt(70)),
        end: (x: to-pt(1100), y: to-pt(170)),
    ),
    attribute-pos: (
        x: to-pt(1135),
        y: to-pt(68),
    ),
    legend-pos: (
        x: to-pt(80),
        y: to-pt(215),
    ),
    image: (
        pos: (x: to-pt(70), y: to-pt(200)),
        size: (width: to-pt(1258), height: to-pt(1258)),
    ),
    level: (
        pos: (x: to-pt(80), y: to-pt(1210)),
        number-pos: (x: to-pt(80), y: to-pt(1280)),
    ),
    type-area: (
        start: (x: to-pt(90), y: to-pt(1470)),
        end: (x: to-pt(1100), y: to-pt(1530)),
    ),
    type-icon-height: to-pt(60),
    description-area: (
        start: (x: to-pt(90), y: to-pt(1550)),
        end: (x: to-pt(1300), y: to-pt(1880)),
    ),
    password-pos: (
        x: to-pt(75),
        y: to-pt(1890),
    ),
    bar-pos: (
        x: to-pt(185),
        y: to-pt(1350),
    ),
    atk-pos: (
        x: to-pt(300),
        y: to-pt(1348),
    ),
    def-pos: (
        x: to-pt(745),
        y: to-pt(1348),
    ),
    maximum-atk: (
        bar-pos: (x: to-pt(190), y: to-pt(1248)),
        value-pos: (x: to-pt(730), y: to-pt(1245)),
    ),
)
