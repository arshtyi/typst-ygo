// Scale text horizontally to fit the available width without enlarging it.
#let scale_x_to_fit(min_x_scale: 50%, body) = context {
    let content_size = measure(body)
    layout(size => {
        if content_size.width > 0pt {
            let ratio = size.width / content_size.width
            let min_ratio = min_x_scale / 100%
            let effective_ratio = if ratio < min_ratio {
                min_ratio
            } else if ratio > 1 {
                1
            } else {
                ratio
            }
            scale(x: 100% * effective_ratio, y: 100%, reflow: true, body)
        }
    })
}
