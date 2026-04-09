=== Kiến trúc hệ thống

Dự án được thiết kế theo các nguyên tắc Domain-Driven Design @laszczak2020dddlite để đảm bảo rõ ràng về yêu cầu kinh doanh và tính linh hoạt trong phát triển.

#lorem(100)

Kiến trúc của hệ thống ghi chú được thiết kế theo mô hình phân tầng để đảm bảo tính linh hoạt và khả năng mở rộng.

#figure(
  rect(
    width: 100%,
    fill: rgb("#f0f0f0"),
    [
      #set align(center)
      *Presentation Layer* \
      User Interface (UI)

      #v(1em)
      #line(length: 80%)

      *Application Layer* \
      Business Logic

      #v(1em)
      #line(length: 80%)

      *Data Layer* \
      Database & Storage
    ],
  ),
  caption: [Kiến trúc ba tầng của hệ thống ghi chú],
)
