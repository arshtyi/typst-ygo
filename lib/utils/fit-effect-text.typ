// Shrink effect text after optionally compacting explicit breaks that waste lines.
#let compact_effect_breaks(body) = {
    body
        .replace(regex("\\r?\\n([②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳])"), match => match.captures.at(0))
        .replace(regex("\\r?\\n(●)"), match => match.captures.at(0))
}

#let estimated_effect_lines(width, font_size, body) = {
    let render(value) = block(width: width, text(size: font_size, value))
    let one_line_height = measure(width: width, render("字")).height
    let two_line_height = measure(width: width, render("字\n字")).height
    let line_step = two_line_height - one_line_height
    let body_height = measure(width: width, render(body)).height

    if body_height <= 0pt {
        0
    } else if line_step <= 0pt {
        calc.ceil(body_height / one_line_height)
    } else {
        calc.ceil((body_height - one_line_height) / line_step + 1)
    }
}

#let fit_effect_text_to_box(max_estimated_lines, min_size: 1pt, step: 0.1pt, body, compress: true) = context {
    let max_size = text.size
    layout(size => {
        let estimated_lines = estimated_effect_lines(size.width, max_size, body)
        let fitted_body = if compress and estimated_lines > max_estimated_lines {
            compact_effect_breaks(body)
        } else {
            body
        }
        let render(current_size) = block(width: size.width, text(size: current_size, fitted_body))
        let fits(current_size) = measure(width: size.width, render(current_size)).height <= size.height

        if step <= 0pt or min_size >= max_size or fits(max_size) {
            text(size: max_size, fitted_body)
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
            text(size: best, fitted_body)
        }
    })
}
