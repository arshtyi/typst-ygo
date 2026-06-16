#import "../lib/mod.typ": ot_card_by_id, ot_card_data, rd_card_by_id, rd_card_data

#let ot_cards = ot_card_data()
#let rd_cards = rd_card_data()

#let ot_demo_ids = (
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

#for id in ot_demo_ids {
    ot_card_by_id(id, cards: ot_cards)
}

#let rd_demo_ids = (
    120244055,
    120181003,
    120105013,
    120121001,
    120280001,
    120279005,
    120249015,
    120249016,
    120249017,
)

#for id in rd_demo_ids {
    rd_card_by_id(id, cards: rd_cards)
}
