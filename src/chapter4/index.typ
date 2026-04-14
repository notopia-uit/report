= Xây dựng ứng dụng <implementation>

== Mô hình Miền (Domain Model)
#figure(
  image("../assets/sync-diagrams/class-diagram-note.svg"),
  caption: [Mô hình miền (Domain Model) của hệ thống],
)

== Giao diện ứng dụng

=== Giao diện Mobile

#lorem(100)

=== Giao diện Web Admin

#lorem(100)

=== Giao diện Backend API

#lorem(100)

== Kết quả và kết luận

Sau khi hoàn thành các giai đoạn phát triển, hệ thống ghi chú thông minh đã đạt
được các mục tiêu dự kiến.

#figure(
  rect(
    width: 100%,
    fill: rgb("#e8f4f8"),
    inset: 1em,
    [
      #set text(size: 11pt)
      #heading(level: 3, numbering: none)[Thành tựu chính]

      - Phát triển thành công ứng dụng ghi chú với giao diện thân thiện
      - Triển khai hệ thống đồng bộ hóa dữ liệu thời gian thực
      - Tạo ra công cụ tìm kiếm toàn văn hiệu quả
      - Đạt được độ hài lòng của người dùng cao (trên 4.5/5 sao)
    ],
  ),
  caption: [Các thành tựu chính của dự án],
)

#lorem(80)

=== Sơ đồ kiến trúc chi tiết

#figure(
  image("../assets/sync-diagrams/architecture-diagram.svg"),
  caption: [Sơ đồ kiến trúc hệ thống Notopia],
)
