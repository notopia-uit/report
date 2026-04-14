#import "./lib/metadata.typ": project-metadata

#set document(
  title: project-metadata.title,
  author: project-metadata.authors,
  keywords: project-metadata.keywords,
)

#set page(
  paper: "a4",
  margin: (left: 3.5cm, right: 2cm, top: 2cm, bottom: 2cm),
)

#set text(
  font: "SVN-Times New Roman 2",
  size: 13pt,
  lang: "vi",
)

#set table(
  inset: 0.5em,
)

#set par(justify: true)

#set heading(numbering: "1.1.1")

#show heading.where(level: 1): set heading(supplement: [Chương])

#show heading.where(level: 1): it => context {
  if it.numbering != none {
    let nums = counter(heading).get()
    align(center, upper([#it.supplement #nums.at(0). #it.body]))
  } else {
    align(center, upper(it.body))
  }
}

#show figure.caption: emph

#include "./coverpage.typ"
#pagebreak()

#set page(numbering: "1")
#counter(page).update(1)

#include "./thanks.typ"
#pagebreak()

#outline(title: "Mục lục", depth: 3)
#pagebreak()

#outline(title: "Danh mục hình ảnh", target: figure.where(kind: image))
#pagebreak()

#outline(title: "Danh mục bảng biểu", target: figure.where(kind: table))
#pagebreak()

#set page(
  numbering: "1",
)
#counter(page).update(1)

#include "summary.typ"
#pagebreak()

#include "./chapter1/index.typ"
#pagebreak()

#include "./chapter2/index.typ"
#pagebreak()

#include "./chapter3/index.typ"
#pagebreak()

#include "./chapter4/index.typ"
#pagebreak()

#include "./chapter5/index.typ"
#pagebreak()

#include "./glossaries.typ"
#pagebreak()

#show bibliography: set heading(numbering: "1.")
#bibliography("./ref.bib", title: "Tài liệu tham khảo", style: "ieee")
