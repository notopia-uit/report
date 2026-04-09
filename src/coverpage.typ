#import "./lib/metadata.typ": project-metadata

#let project_info = (
  upperUniName: project-metadata.university,
  uniName: project-metadata.school,
  falculty: project-metadata.faculty,
  title: project-metadata.title,
  supervisor: project-metadata.supervisor,
  supervisorName: project-metadata.supervisorName,
  students: project-metadata.students,
  report: project-metadata.location,
)

#let coverpage() = {
  set page(numbering: none)
  set align(center)

  // Accessibility: Add semantic heading
  [#heading(level: 1, numbering: none)[#project_info.title]]
  
  text(weight: "bold", size: 14pt, project_info.upperUniName)
  v(0.2cm)
  text(weight: "bold", size: 14pt, project_info.uniName)
  v(0.2cm)
  text(weight: "bold", size: 12pt, project_info.falculty)

  v(2cm)
  image("assets/images/uit-logo.jpg", width: 30%)

  v(2cm)
  text(weight: "bold", size: 16pt, "ĐỒ ÁN 1")
  v(1cm)
  text(weight: "bold", size: 18pt, project_info.title)

  v(3cm)
  grid(
    columns: (1fr, 1.5fr),
    row-gutter: 1em,
    align: left,
    [#project_info.supervisor:], [#project_info.supervisorName],

    [SINH VIÊN THỰC HIỆN:],
    [
      #for student in project_info.students [
        #student.name - #student.id \
      ]
    ],
  )

  v(1fr)
  text(project_info.report)
}

#coverpage()
