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
  column-widths: (9em, 1fr),
) = {
  let fields = (
    "Use Case ID": id,
    "Use Case Name": name,
    "Description": description,
    "Actor(s)": actors,
    "Priority": priority,
    "Trigger": trigger,
    "Pre-condition(s)": preconditions,
    "Post-condition(s)": postconditions,
    "Basic Flow": basicFlow,
    "Alternate Flow": alternateFlow,
    "Exception Flow": exceptionFlow,
    "Business Rules": businessRules,
    "Non-Functional Requirements": nfRequirements,
  )

  let cells = fields
    .pairs()
    .filter(pair => pair.at(1) != none)
    .map(pair => ([*#pair.at(0)*], pair.at(1)))
    .flatten()

  table(
    columns: column-widths,
    align: left,
    stroke: 0.5pt,
    table.header([*Trường*], [*Nội dung*]),
    ..cells
  )
}
