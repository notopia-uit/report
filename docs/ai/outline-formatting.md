# Outline (Mục lục / Danh mục) Formatting

How the outline entries in `src/main.typ` are styled, and the key principle
that keeps cross-references clean while letting outlines look however we want.

Typst version assumed: **0.14.x**.

## The core principle: format the entry, not the numbering

Typst calls the **same `numbering` function** for two purposes:

1. **Heading/figure display** — the number shown before the title in the body
   *and* the number shown in the outline.
2. **Cross-reference display** — the number rendered when `@label` cites that
   element from elsewhere.

There is no way to return different strings for these two contexts from one
`numbering` function. So any dot/format we bake into `numbering` (e.g. changing
`"A.1"` to `"A.1."`) also leaks into `@ref`, producing artefacts like
`Phụ lục B.1..` at the end of a sentence. (Full background:
[numbering-appendix.md](./numbering-appendix.md).)

**Therefore: never change a `numbering` function just to fix how an outline
looks.** Instead, override the `outline.entry` show rule. The entry rendering is
display-only — `@ref` never goes through it — so refs stay untouched.

## The `outline.entry` API we rely on (Typst 0.14)

- `entry.prefix()` — the formatted number. For **figures/equations** it also
  includes the supplement (so `Hình 2.1`); for **headings** it is the number
  only (e.g. `1.` or `A`), *without* the supplement.
- `entry.inner()` — body + fill (the leader dots) + page number, combined.
- `entry.body()` — just the title/caption text.
- `entry.page()` — the page number.
- `entry.indented(prefix, inner, gap: 0.5em)` — the default two-column layout.
- `entry.fill` — the leader; default `repeat([.])`.

## What `src/main.typ` does (in the `#context` block near the top)

### 1. Main TOC — uppercase only the level-1 title

Chapter headings render in the body as `Chương 1` + `upper(body)`. To match that
in the TOC without uppercasing the `Chương` supplement, the level-1 entry uses:

```typst
it.indented(new-prefix, upper(it.inner()))
```

`upper()` on the whole `inner()` is safe because `inner()` is title + dots +
page digits: only the title has letters to uppercase; dots and digits are
unaffected. The supplement lives in `new-prefix` (built manually as
`[#elem.supplement #it.prefix()]`), so it is **not** uppercased — exactly
"uppercase the inner title, not the supplement".

### 2. Figure & appendix lists — add a colon after the number

The figure `numbering` is `"1.1"` and the appendix `numbering` is `"A"` / `"A.1"`
(both **without** a trailing dot, deliberately, so refs stay clean). To show a
colon in the lists only, a helper appends `:` to the prefix:

```typst
let coloned-entry = it => {
  let prefix = it.prefix()
  let new-prefix = if prefix != none { [#prefix:] } else { none }
  it.indented(new-prefix, it.inner())
}
```

It is applied via `show outline.entry: coloned-entry` scoped to a block wrapping
the three figure outlines (`kind: image` / `table` / `raw`) and the "Phụ lục"
outline. Results:

| List              | Before        | After          |
|-------------------|---------------|----------------|
| Danh mục hình ảnh | `Hình 2.1`    | `Hình 2.1:`    |
| Danh mục bảng biểu| `Bảng 2.1`    | `Bảng 2.1:`    |
| Danh mục chương trình | `Chương trình 3.1` | `Chương trình 3.1:` |
| Phụ lục           | `A  BlockNote`| `A: BlockNote` |

## Gotchas / do-not-regress

- The `coloned-entry` rule is **scoped** to the figure/appendix lists only. Do
  **not** promote it to a global `show outline.entry`: the main TOC level-1
  numbering is `"1."` (already ends in a dot), so a global rule would yield
  `1..`.
- Keep the figure/appendix `numbering` functions dot-free. The dot is a
  display concern handled here; baking it into `numbering` reintroduces the
  `@ref` double-dot problem.
- All of the above is verified by rendering the outline pages to PNG and
  eyeballing them (`typst compile src/main.typ out_{p}.png --pages 3-14`).
