// Use case specification library
// Define use cases as data, render as tables

/// Renders a use case specification table with flexible field parameters
///
/// Supported fields:
/// - id: string (Use Case ID)
/// - name: string (Use Case Name)
/// - description: string (Description)
/// - actors: string (Actor(s))
/// - priority: string (Priority level)
/// - trigger: string (What triggers this use case)
/// - preconditions: content (Pre-condition(s))
/// - postconditions: content (Post-condition(s))
/// - basicFlow: content (Basic Flow steps)
/// - alternateFlow: content (Alternate Flow steps)
/// - exceptionFlow: content (Exception Flow steps)
/// - businessRules: string (Business Rules)
/// - nfRequirements: string (Non-Functional Requirements)
///
/// - style: optional styling configuration (columnWidths, etc.)
///
/// Example:
/// ```
/// #usecase(
///   id: "UC01",
///   name: "Create Note",
///   description: "User creates a new note",
///   actors: "User",
///   basicFlow: [...],
/// )
/// ```
// usecase: renders a use-case specification as a two-column table
// (Trường | Nội dung).  Only fields that are not `none` are included so
// call sites can omit fields that don't apply to a given use case.
// Column widths default to (9em, 1fr) — fixed label column, stretchy value
// column — and can be overridden via `column-widths` for wider label needs.
// Table paragraph justification is disabled inside the table to prevent
// awkward stretching in narrow value cells.
#let usecase(
  id: none,
  name: none,
  description: none,
  actors: none,
  priority: none,
  trigger: none,
  pre-conditions: none,
  post-conditions: none,
  basic-flow: none,
  alternate-flow: none,
  exception-flow: none,
  business-rules: none,
  nf-requirements: none,
  column-widths: (9em, 1fr),
) = {
  let fields = (
    "ID": id,
    "Name": name,
    "Description": description,
    "Actor(s)": actors,
    "Priority": priority,
    "Trigger": trigger,
    "Pre-condition(s)": pre-conditions,
    "Post-condition(s)": post-conditions,
    "Basic Flow": basic-flow,
    "Alternate Flow": alternate-flow,
    "Exception Flow": exception-flow,
    "Business Rules": business-rules,
    "Non-Functional Requirements": nf-requirements,
  )

  // Build a flat cell array from only the non-none fields: bold label then
  // value, alternating, matching the two-column table layout.
  let cells = fields
    .pairs()
    .filter(pair => pair.at(1) != none)
    .map(pair => ([*#pair.at(0)*], pair.at(1)))
    .flatten()

  show table: set par(justify: false)

  table(
    columns: column-widths,
    align: left,
    stroke: 0.5pt,
    table.header([*Trường*], [*Nội dung*]),
    ..cells
  )
}

// usecase-figure: wraps a usecase table in a figure so it appears in the
// "Danh mục bảng biểu" outline and can be cross-referenced.
// breakable defaults to true because use-case tables are often long and must
// be allowed to split across pages.
#let usecase-figure(
  usecase-data,
  breakable: true,
  caption: none,
) = {
  show figure: set block(breakable: breakable)

  figure(
    caption: caption,
    usecase-data,
  )
}
