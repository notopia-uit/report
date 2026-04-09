src := "src/main.typ"
out_name := "DA1_23520161_TranNguyenThaiBinh_23521049_NguyenThaiGiaNguyen_SE121.Q21"

[parallel]
build: build-pdf build-html

mkdir:
    mkdir -p build

build-pdf: mkdir
    typst compile {{ src }} ./build/{{ out_name }}.pdf

build-html: mkdir
    typst compile --features html {{ src }} ./build/index.html

dev-zathura: build-pdf
    zathura ./build/{{ out_name }}.pdf &
    typst watch {{ src }} ./build/{{ out_name }}.pdf

dev: mkdir
    tinymist preview {{ src }}

preview-zathura: build-pdf
    zathura ./build/{{ out_name }}.pdf
