// Shrink text until it fits inside the current layout box.
#let fit_text_to_box(min_size: 1pt, step: 0.1pt, body) = context {
    let max_size = text.size
    layout(size => {
        let render(current_size) = block(width: size.width, text(size: current_size, body))
        let fits(current_size) = measure(width: size.width, render(current_size)).height <= size.height
        if step <= 0pt or min_size >= max_size or fits(max_size) {
            text(size: max_size, body)
        } else {
            let low = min_size
            let high = max_size
            let best = min_size

            if fits(min_size) {
                best = min_size

                while high - low > step {
                    let mid = low + (high - low) / 2

                    if fits(mid) {
                        best = mid
                        low = mid
                    } else {
                        high = mid
                    }
                }
            }
            text(size: best, body)
        }
    })
}
