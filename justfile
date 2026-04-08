[parallel]
build: build-pdf build-html

mkdir:
    mkdir -p build

build-pdf: mkdir
    typst compile ./src/main.typ ./build/main.pdf

build-html out="main": mkdir
    typst compile --features html ./src/main.typ ./build/{{ out }}.html

zathura: build-pdf
    zathura ./build/main.pdf
