#import "./lib/metadata.typ": project-metadata

#let coverpage() = {
  set page(numbering: none)
  set align(center)

  rect(
    width: 100%,
    height: 100%,
    fill: none,
    stroke: 1pt + black,
    inset: 2em,
    [
      #set text(weight: "bold")
      #text(size: 14pt, project-metadata.university)
      \
      #text(size: 16pt, project-metadata.school)
      \
      #text(size: 16pt, project-metadata.faculty)

      #v(4em)
      #image("assets/images/uit-logo.jpg", width: 30%)

      #v(4em)
      #text(size: 16pt, "ĐỒ ÁN 1")
      #v(1em)
      #upper(
        text(
          weight: "bold",
          size: 15pt,
          project-metadata.vietnamese-report-title,
        ),
      )

      #v(5em)
      #grid(
        columns: (auto, 1fr),
        row-gutter: 1em,
        gutter: 1em,
        align: left,
        [GIẢNG VIÊN HƯỚNG DẪN:], [#upper(project-metadata.supervisor-name)],

        [SINH VIÊN THỰC HIỆN:],
        [
          #for student in project-metadata.students [
            #upper(student.name) -- #student.id \
          ]
        ],
      )

      #v(1fr)
      #text(project-metadata.location)
    ],
  )
}

#coverpage()
