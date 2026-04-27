// Inspired by https://github.com/mtolk/one-liner
#let fit-to-box(minsize: 4pt, it) = context {
    let maxsize = text.size
    layout(size => {
        let fontsize = maxsize
        let render(s) = block(
            width: size.width,
            text(size: s, it),
        )
        let measured = measure(width: size.width, render(fontsize))
        while fontsize > minsize and measured.height > size.height {
            fontsize -= 0.25pt
            measured = measure(width: size.width, render(fontsize))
        }
        text(size: fontsize, it)
    })
}
