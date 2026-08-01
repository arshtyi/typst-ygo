#let read-be16(data, index) = data.at(index) * 256 + data.at(index + 1)

#let is-sof(marker) = (
    (marker >= 0xc0 and marker <= 0xc3)
        or (marker >= 0xc5 and marker <= 0xc7)
        or (marker >= 0xc9 and marker <= 0xcb)
        or (marker >= 0xcd and marker <= 0xcf)
)

#let parse-size(data, path) = {
    assert(
        data.len() >= 4 and data.at(0) == 0xff and data.at(1) == 0xd8,
        message: "expected JPEG image: " + path,
    )

    let index = 2
    let size = none

    while size == none and index + 8 < data.len() {
        while index < data.len() and data.at(index) != 0xff {
            index += 1
        }
        while index < data.len() and data.at(index) == 0xff {
            index += 1
        }

        if index + 8 >= data.len() {
            index = data.len()
        } else {
            let marker = data.at(index)

            if marker == 0xda or marker == 0xd9 {
                index = data.len()
            } else if marker == 0x01 or (marker >= 0xd0 and marker <= 0xd7) {
                index += 1
            } else {
                let segment = read-be16(data, index + 1)

                if is-sof(marker) {
                    size = (
                        width: read-be16(data, index + 6),
                        height: read-be16(data, index + 4),
                    )
                } else {
                    index += 1 + segment
                }
            }
        }
    }

    assert(size != none, message: "could not read JPEG image size: " + path)
    size
}

#let jpeg-size(path) = parse-size(read(path, encoding: none), path)
