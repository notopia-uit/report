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

  rect(
    width: 100%,
    height: 100%,
    fill: none,
    stroke: 2pt + black,
    inset: 2.5em,
    [
      #text(weight: "bold", size: 14pt, project_info.upperUniName)
      #v(0.2cm)
      #text(weight: "bold", size: 14pt, project_info.uniName)
      #v(0.2cm)
      #text(weight: "bold", size: 12pt, project_info.falculty)

      #v(2cm)
      #image("assets/images/uit-logo.jpg", width: 30%)

      #v(2cm)
      #text(weight: "bold", size: 16pt, "ĐỒ ÁN 1")
      #v(1cm)
      #text(weight: "bold", size: 18pt, project_info.title)

      #v(3cm)
      #grid(
        columns: (auto, 1fr),
        row-gutter: 1em,
        gutter: 1em,
        align: left,
        [#project_info.supervisor:], [#project_info.supervisorName],

        [SINH VIÊN THỰC HIỆN:],
        [
          #for student in project_info.students [
            #student.name - #student.id \
          ]
        ],
      )

      #v(1fr)
      #text(project_info.report)
    ],
  )
}

#coverpage()
