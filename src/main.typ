#import "./lib/metadata.typ": project-metadata

// Document metadata: sets the PDF title, author list, and keywords from the
// shared metadata module so they appear in the document properties.
#set document(
  title: project-metadata.vietnamese-report-title,
  author: project-metadata.authors,
  keywords: project-metadata.keywords,
)

// Cover-page margins: tight on all four sides (2 cm each) because the cover
// page has its own internal layout that handles spacing.
#set page(
  paper: "a4",
  margin: (
    left: 2cm,
    right: 2cm,
    top: 2cm,
    bottom: 2cm,
  ),
)

// Global body font: SVN-Times New Roman 2 at 13 pt, Vietnamese locale so
// Typst applies correct hyphenation and quotation rules.
#set text(
  font: "SVN-Times New Roman 2",
  size: 13pt,
  lang: "vi",
)

// Table header row: fill the first row (y: 0) of every table with a light gray
// background to visually distinguish headers from data rows.
#show table.cell.where(y: 0): set table.cell(fill: gray.lighten(30%))

// Table paragraph: disable justification inside tables so cell text stays
// left-aligned and does not stretch awkwardly in narrow columns.
#show table: set par(justify: false)

// Body paragraph style: justified text, 1 em line spacing, 1 em between
// paragraphs, and a 1 em first-line indent only on paragraphs that follow
// another paragraph (all: false — headings and lists are excluded).
#set par(
  justify: true,
  leading: 1em,
  spacing: 1em,
  first-line-indent: (
    amount: 1em,
    all: false,
  ),
)

// Hyperlink colour: render all links in a dark blue so they are clearly
// distinguishable from body text without being distracting.
#show link: set text(fill: blue.darken(30%))

// Code / raw text: shrink to 9 pt so inline snippets and code blocks do not
// overpower the surrounding 13 pt body text.
#show raw: set text(size: 9pt)

// Chapter heading (level 1) font size: 14 pt, one step above body, to give
// chapter titles appropriate visual weight.
#show heading.where(level: 1): set text(size: 14pt)

// Chapter heading (level 1) block spacing: 0.65 em below the heading text
// before the first paragraph of the chapter body begins.
#show heading.where(level: 1): set block(below: 0.65em)

// Chapter heading (level 1) render rule:
//   - Resets per-chapter figure counters (image, table, raw) so numbering
//     restarts at 1 for each chapter (e.g. "Hình 2.1").
//   - Forces a page break before every level-1 heading.
//   - Centres the heading; numbered headings prepend "Chương N" above the
//     title text; the title itself is uppercased.
#show heading.where(level: 1): it => context {
  let is-chapter = type(it.numbering) == str
  if is-chapter {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
  }
  pagebreak()
  align(center, [
    #if is-chapter [
      #it.supplement #counter(heading).display(it.numbering)
    ]
    #upper(it.body)
  ])
}

// Section heading (level 2) block spacing: 1.1 em below to create clear
// visual separation before the following content.
#show heading.where(level: 2): set block(below: 1.1em)

// Subsection heading (level 3) block spacing: same 1.1 em as level 2.
#show heading.where(level: 3): set block(below: 1.1em)

// Sub-levels font size: headings deeper than level 1 are explicitly set to
// 13 pt (matching body text) so they rely on weight/numbering alone for
// hierarchy rather than size increases.
#show heading: it => {
  if it.level > 1 {
    set text(size: 13pt)
    it
  } else {
    it
  }
}

// Figure numbering: use "chapter.figure" format (e.g. "2.3") by combining the
// current chapter counter with the per-chapter figure counter.
#set figure(
  numbering: (..num) => {
    numbering("1.1", counter(heading).get().first(), num.pos().first())
  },
)

// Figure caption style: italicise all captions for visual distinction.
#show figure.caption: emph

// Figure caption colour and size: grey at 50 % darkness, 11 pt — clearly
// subordinate to the 13 pt body text.
#show figure.caption: set text(gray.darken(50%), size: 11pt)

// Table caption position: place captions above tables (standard academic
// convention) instead of the default below.
#show figure.where(kind: table): set figure.caption(position: top)

// Caption sticky block: keep the caption glued to the figure body when the
// figure spans a page break, so the caption never appears alone on a page.
#show figure.caption: set block(sticky: true)

#include "./coverpage.typ"

// Body-page margins: wider left margin (3.5 cm) for binding, larger top/bottom
// (3 cm / 3.5 cm) for header/footer clearance; right margin stays at 2 cm.
#set page(
  margin: (
    top: 3cm,
    bottom: 3.5cm,
    left: 3.5cm,
    right: 2cm,
  ),
)

#include "./thanks.typ"

// Front-matter block: builds all outlines (TOC, figures, tables, code
// listings, appendix) dynamically.
//
// The <end-content> label marks the boundary between main content and the
// appendix so that each outline can be scoped to the correct range.
//
// `target` — headings before <end-content> (main chapters)
// `target-appendix` — headings after <end-content> (appendix entries)
//
// TOC (main outline):
//   - Level-1 entries are bold.
//   - Numbered level-1 entries prepend "Chương N" and are uppercased.
//   - Link colour is overridden to black so TOC entries do not appear blue.
//   - Depth: 3 levels; indented 1 em per level.
//
// Figure / table / code outlines: each uses `coloned-entry` which appends a
// colon after the prefix number (e.g. "Hình 2.1:") for display only —
// cross-reference labels (@fig-...) are unaffected.
//
// Appendix outline: limited to depth 2, targets only headings whose
// supplement is "Phụ lục" and that appear after <end-content>.
#context {
  let loc = query(<end-content>)

  let target = if loc.len() > 0 {
    selector(heading).before(loc.first().location())
  } else {
    heading
  }

  let target-appendix = if loc.len() > 0 {
    selector(heading).after(loc.first().location())
  } else {
    heading
  }

  // Display-only: add a colon after the entry number (e.g. "Hình 2.1:" or
  // "A:") in figure/appendix outlines, without touching any `numbering`
  // function (so cross-references like `@fig-...` stay clean -- see
  // docs/ai/numbering-appendix.md).
  let coloned-entry = it => {
    let prefix = it.prefix()
    let new-prefix = if prefix != none { [#prefix:] } else { none }
    show link: set text(fill: luma(0%))
    link(it.element.location(), it.indented(new-prefix, it.inner()))
  }

  {
    show outline.entry.where(level: 1): set text(weight: "bold")
    show outline.entry.where(level: 1): it => {
      let elem = it.element

      let new-prefix = if elem.numbering != none {
        [#elem.supplement #it.prefix()]
      } else {
        none
      }

      show link: set text(fill: luma(0%))
      link(
        elem.location(),
        it.indented(new-prefix, upper(it.inner())),
      )
    }
    outline(
      depth: 3,
      indent: 1em,
      target: target,
    )
  }
  {
    show outline.entry: coloned-entry
    outline(
      title: "Danh mục hình ảnh",
      target: figure
        .where(
          kind: image,
        )
        .before(
          loc.first().location(),
          inclusive: false,
        ),
    )

    outline(
      title: "Danh mục bảng biểu",
      target: figure
        .where(
          kind: table,
        )
        .before(
          loc.first().location(),
          inclusive: false,
        ),
    )

    outline(
      title: "Danh mục bảng chương trình",
      target: figure
        .where(
          kind: raw,
        )
        .before(
          loc.first().location(),
          inclusive: false,
        ),
    )

    outline(
      title: "Phụ lục",
      depth: 2,
      target: heading
        .where(supplement: [Phụ lục], level: 2)
        .or(heading.where(supplement: [Phụ lục], level: 3))
        .and(target-appendix),
    )
  }
}

// Code block styling: initialise codly for syntax-highlighted code figures;
// disable zebra striping (alternating row background) for a cleaner look.
#import "@preview/codly:1.3.0": *
#show: codly-init.with()
#codly(
  zebra-fill: none,
)

#include "./glossaries.typ"

// Page numbering: Arabic numerals centred in the footer, separated from the
// page content by a thin top-border rule.  Counter is reset to 1 here so the
// first numbered page (after the front-matter) is page 1.
#set page(
  numbering: "1",
  footer: context {
    align(center)[
      #box(width: 100%, stroke: (top: 0.5pt), inset: (top: 1em))[
        #counter(page).display()
      ]
    ]
  },
)

#counter(page).update(1)

#include "summary.typ"

// Main chapters block: applies Arabic heading numbering ("1.", "1.1.", …)
// with supplement "Chương" so level-1 headings render as "Chương 1".
// Headings deeper than level 3 suppress their number and show only the body
// text (used for unnumbered sub-items inside chapters).
#{
  set heading(numbering: "1.")

  set heading(supplement: [Chương])

  show heading: it => context {
    if it.level <= 3 {
      it
    } else {
      it.body
    }
  }
  include "./chapter1/index.typ"

  include "./chapter2/index.typ"

  include "./chapter3/index.typ"

  include "./chapter4/index.typ"

  include "./chapter5/index.typ"

  bibliography(
    "./ref.bib",
    title: "Tài liệu tham khảo",
    style: "ieee",
  )

  // Marks the end of main content; outlines and figure counters use this
  // label as a boundary to exclude appendix material.
  [#metadata(none)<end-content>]
}


#include "./appendix/index.typ"
