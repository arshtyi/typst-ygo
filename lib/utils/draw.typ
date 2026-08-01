#let canvas(size, body) = {
    let fixed = block(
        width: size.width,
        height: size.height,
        clip: true,
        {
            set place(top + left)
            body
        },
    )

    layout(available => {
        let x = if available.width < size.width { available.width / size.width } else { 1 }
        let y = if available.height < size.height { available.height / size.height } else { 1 }
        let factor = calc.min(x, y)

        scale(factor * 100%, origin: top + left, reflow: true, fixed)
    })
}

#let layer(pos, body) = place(dx: pos.x, dy: pos.y, body)

#let area(region, inset: 0pt, body) = layer(
    region.start,
    block(
        width: region.end.x - region.start.x,
        height: region.end.y - region.start.y,
        inset: inset,
        body,
    ),
)
