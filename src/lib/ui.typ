// ui-figure: thin wrapper around Typst's built-in figure + image that
// exposes only the fields used in this report (src path, caption, height).
// Keeps call sites concise and ensures all UI screenshots are wrapped as
// figures so they appear in the "Danh mục hình ảnh" outline.
//   image-src — path to the image file (relative to the document root)
//   caption   — figure caption content
//   height    — optional image height; defaults to auto (full natural size)
#let ui-figure(
  image-src,
  caption,
  height: auto,
) = figure(
  image(
    image-src,
    height: height,
  ),
  caption: caption,
)

/// - name: string (Column name)
/// - type: string (Data type)
/// - description: string (Column description)
#let column(name, type, description) = {
  (name: name, type: type, description: description)
}

/// - columns: variadic column definitions (created with column() function)
///
/// Example:
/// ```
/// #figure(
///   ui-table(
///     column("Button", "Button", "Clickable element"),
///   ),
///   caption: [UI component table],
/// )
/// ```
// ui-table: renders a UI-component description table with four fixed columns
// (STT / Tên / Loại / Mô tả).  Rows are auto-numbered starting at 1.
// Column widths are all `auto` so the table fills its container evenly.
// Column definitions are passed as variadic args via the `column()` helper.
#let ui-table(
  ..cols,
) = {
  let columns = cols.pos()

  table(
    columns: (auto, auto, auto, auto),
    align: (center, left, left, left),
    stroke: 0.5pt,

    table.header([*STT*], [*Tên*], [*Loại*], [*Mô tả*]),

    ..columns
      .enumerate()
      .map(((i, col)) => (
        [#(i + 1)],
        [#col.name],
        [#col.type],
        [#col.description],
      ))
      .flatten(),
  )
}

// ui-table-figure: wraps a ui-table (or any table content) in a figure and
// applies smart breakable logic:
//   - If the rendered figure height fits within the current page, breakable is
//     forced to false — the whole figure jumps to the next page intact rather
//     than splitting into a few orphan rows.
//   - If the figure is taller than one page, the caller-supplied breakable
//     value is used (default: true) so the table can split across pages.
// This avoids both orphan-row splits on short tables and infinite-loop layout
// issues on tables that genuinely exceed a full page.
#let ui-table-figure(
  table-data,
  breakable: true,
  caption: none,
) = layout(size => context {
  let fig = figure(table-data, caption: caption)
  let fig-height = measure(block(width: size.width, fig)).height

  // If the figure fits on a single page, force breakable: false so Typst
  // keeps it as one unit — it will jump to the next page as a whole instead
  // of splitting and showing only a few rows. For figures taller than one
  // page the caller-supplied breakable is used (must allow splitting).
  let effective-breakable = if fig-height > size.height { breakable } else { false }

  show figure: set block(breakable: effective-breakable)
  fig
})
