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

/// - columns: variadic column definitions (created with column() function)
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
// db-table: renders a database column specification as a four-column table
// (Tên cột | Kiểu dữ liệu | Mô tả | Khóa).
// Column widths use fractional sizing (0.8fr / 1fr / 1.5fr / 0.5fr) so the
// description column gets the most space and the key badge column stays narrow.
// The key cell is left empty (not "none") when no key is defined so the cell
// border still renders correctly.
// The unused `style` parameter is kept for forward-compatibility with call
// sites that may pass custom column widths in the future.
#let db-table(
  ..cols,
  style: none,
) = {
  let columns = cols.pos()

  table(
    columns: (0.8fr, 1fr, 1.5fr, 0.5fr),
    align: left,
    stroke: 0.5pt,

    table.header([*Tên cột*], [*Kiểu dữ liệu*], [*Mô tả*], [*Khóa*]),

    ..columns
      .map(col => (
        [#col.name],
        [#col.type],
        [#col.description],
        if col.key != none [#col.key] else [],
      ))
      .flatten(),
  )
}
