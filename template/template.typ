#import "../lib/mod.typ": ot_card_by_id, ot_card_data, ot_image_index

#let cards = ot_card_data()
#let images = ot_image_index()

#let demo_ids = (
    10000022,
    13332685,
    54701958,
    35952884,
    48348921,
    54842941,
    4731783,
    66518509,
    23002292,
)

#for id in demo_ids {
    ot_card_by_id(id, cards: cards, images: images)
}
