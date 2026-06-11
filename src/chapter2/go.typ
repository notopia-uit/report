== Tổng quan về Go (Golang) <general-for-go>

=== Giới thiệu

Go (còn gọi là Golang) là ngôn ngữ lập trình mã nguồn mở được phát triển bởi
Google vào năm 2007 và chính thức phát hành vào năm 2009. Được thiết kế bởi
Robert Griesemer, Rob Pike và Ken Thompson, Go nhằm mục tiêu tạo ra một ngôn ngữ
hiệu quả, dễ học, và phù hợp cho lập trình hệ thống quy mô lớn.

#figure(
  image("../assets/images/go-logo.svg", height: 80pt),
  caption: [Golang logo],
)

Dự án sử dụng Go cùng với công cụ `goforj/wire`, một fork của `google/wire`,
giúp dependencies injection có hỗ trợ cache fast để tối ưu thời gian build.

=== Ưu điểm

Go mang lại nhiều lợi ích trong phát triển backend:
- Biên dịch native code, hiệu suất tương đương C/C++
- Goroutines và Channels xử lý đồng thời với chi phí thấp
- Single binary, không phụ thuộc thư viện ngoài
- Cross-compilation cho nhiều nền tảng từ một máy
- Được dùng trong Kubernetes, Docker, Terraform, Prometheus

=== Nhược điểm

Bên cạnh các ưu điểm, Go có một số hạn chế:
- Error handling dài dòng với `if err != nil`
- Thiếu Generics trước 1.18, không hỗ trợ generic method. #footnote[Generic
    proposal đã được phê duyệt, theo @reddit_proposal_generic_methods_go]
- Không có inheritance, chỉ hỗ trợ composition
- Cần thời gian để hiểu interfaces và goroutines
