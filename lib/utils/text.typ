// Horizontally shrink content to the available width without enlarging it.
#let fit-width(min: 50%, body) = context {
    let content-size = measure(body)

    layout(size => {
        if content-size.width > 0pt {
            let ratio = calc.clamp(size.width / content-size.width, min / 100%, 1)
            scale(x: 100% * ratio, y: 100%, reflow: true, body)
        }
    })
}

// Shrink text until it fits inside the current layout box.
#let fit-text(min: 1pt, step: 0.1pt, body) = context {
    let max = text.size

    layout(size => {
        let render(current) = block(width: size.width, text(size: current, body))
        let fits(current) = measure(width: size.width, render(current)).height <= size.height

        if step <= 0pt or min >= max or fits(max) {
            text(size: max, body)
        } else {
            let low = min
            let high = max
            let best = min

            if fits(min) {
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

#let compact-breaks(body) = {
    body
        .replace(regex("\\r?\\n([②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳])"), match => match.captures.at(0))
        .replace(regex("\\r?\\n(●)"), match => match.captures.at(0))
}

#let count-lines(width, font-size, body) = {
    let render(value) = block(width: width, text(size: font-size, value))
    let one-line-height = measure(width: width, render("字")).height
    let two-line-height = measure(width: width, render("字\n字")).height
    let line-step = two-line-height - one-line-height
    let body-height = measure(width: width, render(body)).height

    if body-height <= 0pt {
        0
    } else if line-step <= 0pt {
        calc.ceil(body-height / one-line-height)
    } else {
        calc.ceil((body-height - one-line-height) / line-step + 1)
    }
}

// Compact explicit breaks only when the original text would exceed max-lines.
#let fit-effect(max-lines, min: 1pt, step: 0.1pt, body, compact: true) = context {
    let max-size = text.size
    layout(size => {
        let lines = count-lines(size.width, max-size, body)
        let value = if compact and lines > max-lines {
            compact-breaks(body)
        } else {
            body
        }
        let render(current-size) = block(width: size.width, text(size: current-size, value))
        let fits(current) = measure(width: size.width, render(current)).height <= size.height

        if step <= 0pt or min >= max-size or fits(max-size) {
            text(size: max-size, value)
        } else {
            let low = min
            let high = max-size
            let best = min

            if fits(min) {
                best = min

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

            text(size: best, value)
        }
    })
}
