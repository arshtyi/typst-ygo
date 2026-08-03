#import "../lib/mod.typ": ot-card, ot-cards, rd-card, rd-cards


#let ot-data = ot-cards()
#let rd-data = rd-cards()

#let ot-demo-ids = (
    10000022,
    13332685,
    54701958,
    35952884,
    48348921,
    54842941,
    4731783,
    66518509,
    34298391,
)
#let rd-demo-ids = (
    120293068,
    120231069,
    120257066,
    120293046,
    120287032,
    120305014,
    120155021,
    120155022,
    120155023,
)

#{
    set page(width: auto, height: auto, margin: 4pt)
    grid(
        columns: 3, gutter: 3pt,
        ..ot-demo-ids.map(id => ot-card(id, cards: ot-data)) + rd-demo-ids.map(id => rd-card(id, cards: rd-data)),
    )
}

#{
    set page(width: auto, height: auto, margin: 0pt)
    for id in ot-demo-ids {
        ot-card(id, cards: ot-data)
        pagebreak(weak: true)
    }
    for id in rd-demo-ids {
        rd-card(id, cards: rd-data)
        pagebreak(weak: true)
    }
}
