#let ppi = 600
#let to-pt(value) = value * 72pt / ppi

#let layout = (
    card-size: (width: to-pt(1393), height: to-pt(2031)),
    name-area: (
        start: (x: to-pt(60), y: to-pt(60)),
        end: (x: to-pt(1110), y: to-pt(190)),
    ),
    attribute-pos: (
        x: to-pt(1136),
        y: to-pt(67),
    ),
    limit-pos: (
        x: to-pt(-5),
        y: to-pt(-5),
    ),
    legend-pos: (
        x: to-pt(75),
        y: to-pt(205),
    ),
    image: (
        pos: (x: to-pt(70), y: to-pt(200)),
        size: (width: to-pt(1258), height: to-pt(1258)),
    ),
    level: (
        pos: (x: to-pt(80), y: to-pt(1218)),
        number-pos: (x: to-pt(110), y: to-pt(1318)),
    ),
    type-area: (
        start: (x: to-pt(75), y: to-pt(1470)),
        end: (x: to-pt(1110), y: to-pt(1530)),
    ),
    type-icon-height: to-pt(60),
    description-area: (
        start: (x: to-pt(90), y: to-pt(1555)),
        end: (x: to-pt(1300), y: to-pt(1880)),
    ),
    password-pos: (
        x: to-pt(70),
        y: to-pt(1905),
    ),
    bar-pos: (
        x: to-pt(185),
        y: to-pt(1358),
    ),
    atk-pos: (
        x: to-pt(485),
        y: to-pt(1358),
    ),
    def-pos: (
        x: to-pt(918),
        y: to-pt(1358),
    ),
    maximum-atk: (
        bar-pos: (x: to-pt(190), y: to-pt(1256)),
        value-pos: (x: to-pt(918), y: to-pt(1255)),
    ),
)
