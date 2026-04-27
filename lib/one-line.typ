// Only scale in x direction, never smaller than min-x-scale and never larger than 100% (no scaling up)
// Inspired by https://github.com/mtolk/one-liner, just: https://github.com/mtolk/one-liner/pull/2
#let squeeze-to-width(min-x-scale: 50%, it) = context {
    let contentsize = measure(it)
    layout(size => {
        if contentsize.width > 0pt {
            // Prevent failure on empty content
            let ratio-x = size.width / contentsize.width
            let min-ratio-x = min-x-scale / 100%
            let effective-ratio-x = if ratio-x < min-ratio-x {
                min-ratio-x
            } else if ratio-x > 1 {
                1
            } else {
                ratio-x
            }
            scale(x: 100% * effective-ratio-x, y: 100%, reflow: true, it)
        }
    })
}
