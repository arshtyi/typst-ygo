#let default-path = "../../assets/rd/card/rd.json"

#let load(path: default-path) = json(path)

#let find(id, cards) = {
    let card = cards.find(card => card.id == id)
    assert(card != none, message: "RD card not found: " + str(id))
    card
}
