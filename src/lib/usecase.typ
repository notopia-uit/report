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
#let usecase(
  id: none,
  name: none,
  description: none,
  actors: none,
  priority: none,
  trigger: none,
  preconditions: none,
  postconditions: none,
  basicFlow: none,
  alternateFlow: none,
  exceptionFlow: none,
  businessRules: none,
  nfRequirements: none,
  style: none,
) = {
  let col-widths = if style != none and "columnWidths" in style {
    style.columnWidths
  } else {
    (1fr, 2fr)
  }

  let rows = ()

  // Required fields
  if id != none {
    rows.push(([*Use Case ID*], [#id]))
  }
  if name != none {
    rows.push(([*Use Case Name*], [#name]))
  }
  if description != none {
    rows.push(([*Description*], [#description]))
  }
  if actors != none {
    rows.push(([*Actor(s)*], [#actors]))
  }
  if priority != none {
    rows.push(([*Priority*], [#priority]))
  }
  if trigger != none {
    rows.push(([*Trigger*], [#trigger]))
  }

  // Optional fields
  if preconditions != none {
    rows.push(([*Pre-condition(s)*], preconditions))
  }
  if postconditions != none {
    rows.push(([*Post-condition(s)*], postconditions))
  }
  if basicFlow != none {
    rows.push(([*Basic Flow*], basicFlow))
  }
  if alternateFlow != none {
    rows.push(([*Alternate Flow*], alternateFlow))
  }
  if exceptionFlow != none {
    rows.push(([*Exception Flow*], exceptionFlow))
  }
  if businessRules != none {
    rows.push(([*Business Rules*], [#businessRules]))
  }
  if nfRequirements != none {
    rows.push(([*Non-Functional Requirements*], [#nfRequirements]))
  }

  table(
    columns: col-widths,
    align: left,
    stroke: 0.5pt,
    ..rows.flatten(),
  )
}
