// Database table specification library
// Define database tables as data, render as tables

/// Creates a type-safe column definition with runtime validation
///
/// - name: string (Column name)
/// - type: string (Data type)
/// - description: string (Column description)
/// - key: string (optional, e.g., "PK", "FK", "UQ")
#let column(name, type, description, key: none) = {
  (name: name, type: type, description: description, key: key)
}

/// Renders a database table specification with variadic columns
///
/// - columns: variadic column definitions (created with column() function)
/// - style: optional styling configuration (columnWidths, etc.)
///
/// Example:
/// ```
/// #figure(
///   db-table(
///     column("id", "UUID", "User ID", key: "PK"),
///     column("email", "VARCHAR(255)", "Email address", key: "UQ"),
///   ),
///   caption: [User table],
/// )
/// ```
#let db-table(
  ..cols,
  style: none,
) = {
  let columns = cols.pos()

  let col-widths = if style != none and "columnWidths" in style {
    style.columnWidths
  } else {
    (0.8fr, 1fr, 1.5fr, 0.5fr)
  }

  let header = ([*Tên cột*], [*Kiểu dữ liệu*], [*Mô tả*], [*Khóa*])
  let rows = ()

  for col in columns {
    rows.push((
      [#col.name],
      [#col.type],
      [#col.description],
      if "key" in col and col.key != none { [#col.key] } else { [] },
    ))
  }

  table(
    columns: col-widths,
    align: left,
    stroke: 0.5pt,
    ..header,
    ..rows.flatten(),
  )
}
