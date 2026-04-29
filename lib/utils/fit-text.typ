// Shrink text until it fits inside the current layout box.
#let fit_text_to_box(min_size: 4pt, body) = context {
    let max_size = text.size

    layout(size => {
        let font_size = max_size
        let render(current_size) = block(width: size.width, text(size: current_size, body))
        let measured = measure(width: size.width, render(font_size))

        while font_size > min_size and measured.height > size.height {
            font_size -= 0.1pt
            measured = measure(width: size.width, render(font_size))
        }

        text(size: font_size, body)
    })
}
