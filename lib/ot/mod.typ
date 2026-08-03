#import "data.typ" as data
#import "model.typ" as model
#import "render.typ" as render

#let cards = data.load

#let card(source, cards: none, compact: true, password: true, fullwidth-slash: false) = {
    let value = if type(source) == dictionary {
        source
    } else {
        assert(type(source) == int, message: "OT card source must be a card or integer ID")
        data.find(source, if cards == none { data.load() } else { cards })
    }

    render.card(model.build(
        value,
        compact: compact,
        password: password,
        fullwidth-slash: fullwidth-slash,
    ))
}
