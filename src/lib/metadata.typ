// Project metadata: single source of truth for all document-level information.
// Imported by main.typ for the PDF document properties (title, authors,
// keywords) and by coverpage.typ / thanks.typ for the printed cover details.
//
// Fields:
//   name                      — short project name used in headings/references
//   vietnamese-description    — one-line Vietnamese description (no name prefix)
//   vietnamese-name-description — full "Name - Description" string for sub-titles
//   vietnamese-report-title   — PDF document title and main cover title
//   authors                   — array of full author names (used in #set document)
//   keywords                  — array of Vietnamese keywords for PDF metadata
//   university                — full university name (uppercase)
//   school                    — full school/college name (uppercase)
//   faculty                   — department name (uppercase)
//   supervisor-name           — thesis supervisor with academic title prefix
//   students                  — array of (id, name) dicts for the cover page
//   location                  — city and date string printed at the bottom of
//                               the cover page
#let project-metadata = (
  name: "Notopia",
  vietnamese-description: "Ứng dụng ghi chú thông minh hỗ trợ quản lý tri thức bằng biểu đồ quan hệ",
  vietnamese-name-description: "Notopia - Ứng dụng ghi chú thông minh hỗ trợ quản lý tri thức bằng biểu đồ quan hệ",
  vietnamese-report-title: "Notopia - Ứng dụng ghi chú thông minh hỗ trợ quản lý tri thức bằng biểu đồ quan hệ",
  authors: ("Trần Nguyễn Thái Bình", "Nguyễn Thái Gia Nguyễn"),
  keywords: ("Notopia", "ghi chú", "quản lý tri thức", "biểu đồ quan hệ"),
  university: "ĐẠI HỌC QUỐC GIA THÀNH PHỐ HỒ CHÍ MINH",
  school: "TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN",
  faculty: "KHOA CÔNG NGHỆ PHẦN MỀM",
  supervisor-name: "ThS. Trần Thị Hồng Yến",
  students: (
    (id: "23520161", name: "Trần Nguyễn Thái Bình"),
    (id: "23521049", name: "Nguyễn Thái Gia Nguyễn"),
  ),
  location: "TP. Hồ Chí Minh, tháng 06, năm 2026",
)
