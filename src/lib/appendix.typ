// source: https://github.com/maucejo/elsearticle/blob/main/src/els-environment.typ

// appendix(body): wraps all appendix content and applies appendix-specific
// heading numbering, figure counters, and equation numbering so they are
// visually and logically distinct from the main chapter content.
//
// Heading numbering scheme:
//   level 1 — suppressed (the enclosing block acts as the implicit root)
//   level 2 — single letter "A", "B", … (one letter per appendix section)
//   level 3 — "A.1", "A.2", … (sub-sections within a lettered appendix)
//   level 4+ — suppressed (no number shown)
//
// Heading counter is reset to 0 on entry so appendix letters start at "A"
// regardless of how many chapters precede it.
//
// Figure counters (image, table, raw) are reset to 0 on entry and again at
// the start of each level-2 heading so figures are numbered per appendix
// section (e.g. "A1", "A2", "B1", …).
//
// Level-2 heading render rule:
//   - Page-breaks before every appendix except the first (idx > 1).
//   - Rendered as bold 14 pt text in the form "Phụ lục A. TITLE" (uppercased).
//   - Figure counters are reset here so per-appendix figure numbering works.
//
// Equation numbering: "(A.1a)", "(A.2a)", … — letter from the current
// appendix, sequential number within that appendix, then the equation index.
//
// Figure numbering: "A1", "A2", … — letter concatenated with the sequential
// figure counter for the current appendix section.
#let appendix(body) = {
  set heading(
    numbering: (..nums) => {
      let n = nums.pos()
      if n.len() == 1 {
        none
      } else if n.len() == 2 {
        numbering("A", n.at(1))
      } else if n.len() == 3 {
        numbering("A.1", n.at(1), n.at(2))
      } else {
        none
      }
    },
    supplement: [Phụ lục],
  )
  counter(heading).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: raw)).update(0)

  show heading.where(level: 2): it => context {
    let idx = counter(heading).get().at(1)
    if idx > 1 { pagebreak() }

    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)

    let letter = numbering("A", idx)
    text(size: 14pt, weight: "bold", [Phụ lục #letter. #upper(it.body)])
  }

  let numbering-eq = (..n) => {
    let h = counter(heading).get()
    let idx = if h.len() >= 2 { h.at(1) } else { h.first() }
    numbering("(A.1a)", idx, ..n)
  }
  set math.equation(numbering: numbering-eq)

  let numbering-fig = n => {
    let h = counter(heading).get()
    let idx = if h.len() >= 2 { h.at(1) } else { h.first() }
    numbering("A", idx) + str(n)
  }
  set figure(numbering: numbering-fig)

  body
}
