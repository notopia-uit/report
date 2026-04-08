#let project_info = (
  upperUniName: "ĐẠI HỌC QUỐC GIA THÀNH PHỐ HỒ CHÍ MINH",
  uniName: "TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN",
  falculty: "KHOA CÔNG NGHỆ PHẦN MỀM",
  title: "Notopia - Ứng dụng ghi chú thông minh hỗ trợ quản lý tri thức bằng biểu đồ quan hệ",
  supervisor: "GIẢNG VIÊN HƯỚNG DẪN",
  supervisorName: "ThS. Trần Thị Hồng Yến",
  students: (
    (id: "23520161", name: "Trần Nguyễn Thái Bình"),
    (id: "2521049", name: "Nguyễn Thái Gia Nguyễn"),
  ),
  report: "TP. Hồ Chí Minh, tháng 05, năm 2026",
)

#let coverpage() = {
  set page(numbering: none)
  set align(center)

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
