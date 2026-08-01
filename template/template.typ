#import "../lib/mod.typ": ot-card, ot-cards, rd-card, rd-cards

#set page(width: auto, height: auto, margin: 0pt)

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

#for id in ot-demo-ids {
    ot-card(id, cards: ot-data)
    pagebreak(weak: true)
}

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

#for id in rd-demo-ids {
    rd-card(id, cards: rd-data)
    pagebreak(weak: true)
}
