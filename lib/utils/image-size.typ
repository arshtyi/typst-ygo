#let be16(data, index) = data.at(index) * 256 + data.at(index + 1)

#let be32(data, index) = {
    (
        data.at(index) * 256 * 256 * 256
            + data.at(index + 1) * 256 * 256
            + data.at(index + 2) * 256
            + data.at(index + 3)
    )
}

#let is_jpeg_sof_marker(marker) = {
    (
        (marker >= 0xc0 and marker <= 0xc3)
            or (marker >= 0xc5 and marker <= 0xc7)
            or (marker >= 0xc9 and marker <= 0xcb)
            or (marker >= 0xcd and marker <= 0xcf)
    )
}

#let jpeg_size(data, path) = {
    assert(
        data.len() >= 4 and data.at(0) == 0xff and data.at(1) == 0xd8,
        message: "expected JPEG image: " + path,
    )

    let index = 2
    let size = none

    while size == none and index + 8 < data.len() {
        while index < data.len() and data.at(index) != 0xff {
            index = index + 1
        }
        while index < data.len() and data.at(index) == 0xff {
            index = index + 1
        }

        if index + 8 >= data.len() {
            index = data.len()
        } else {
            let marker = data.at(index)

            if marker == 0xda or marker == 0xd9 {
                index = data.len()
            } else if marker == 0x01 or (marker >= 0xd0 and marker <= 0xd7) {
                index = index + 1
            } else {
                let segment_len = be16(data, index + 1)

                if is_jpeg_sof_marker(marker) {
                    size = (
                        width: be16(data, index + 6),
                        height: be16(data, index + 4),
                    )
                } else {
                    index = index + 1 + segment_len
                }
            }
        }
    }

    assert(size != none, message: "could not read JPEG image size: " + path)
    size
}

#let png_size(data, path) = {
    assert(
        data.len() >= 24
            and data.at(0) == 0x89
            and data.at(1) == 0x50
            and data.at(2) == 0x4e
            and data.at(3) == 0x47
            and data.at(4) == 0x0d
            and data.at(5) == 0x0a
            and data.at(6) == 0x1a
            and data.at(7) == 0x0a,
        message: "expected PNG image: " + path,
    )

    (
        width: be32(data, 16),
        height: be32(data, 20),
    )
}

#let is_jpeg(data) = data.len() >= 2 and data.at(0) == 0xff and data.at(1) == 0xd8

#let is_png(data) = {
    (
        data.len() >= 8
            and data.at(0) == 0x89
            and data.at(1) == 0x50
            and data.at(2) == 0x4e
            and data.at(3) == 0x47
    )
}

#let image_size(path) = {
    let data = read(path, encoding: none)

    if is_jpeg(data) {
        jpeg_size(data, path)
    } else if is_png(data) {
        png_size(data, path)
    } else {
        panic("unsupported image format: " + path)
    }
}
