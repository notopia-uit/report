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
