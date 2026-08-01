#let canvas(size, body) = block(
    width: size.width,
    height: size.height,
    clip: true,
    {
        set place(top + left)
        body
    },
)

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
