== Tổng quan về Go (Golang)

=== Giới thiệu

Go (còn gọi là Golang) là ngôn ngữ lập trình mã nguồn mở được phát triển bởi
Google vào năm 2007 và chính thức phát hành vào năm 2009. Được thiết kế bởi
Robert Griesemer, Rob Pike và Ken Thompson, Go nhằm mục tiêu tạo ra một ngôn ngữ
hiệu quả, dễ học, và phù hợp cho lập trình hệ thống quy mô lớn.

Go bao gồm hai thành phần chính:
- Một Compiler (gc): Biên dịch mã Go thành native code cho các nền tảng khác
  nhau (Linux, macOS, Windows)
- Một Runtime: Bao gồm Scheduler quản lý goroutines, Garbage Collector, và
  Memory Management

Trong dự án này, chúng em sử dụng Go cùng với các công cụ và thư viện hiện đại
để xây dựng backend scalable:
- Dependency Injection với goforj/wire @goforj_wire, một fork của Google Wire có
  hỗ trợ cache fast để tối ưu thời gian build

=== Ưu điểm

Go mang lại nhiều lợi ích trong phát triển backend:

- Hiệu suất cao, Go biên dịch thành native code và thực thi nhanh chóng tương
  đương C/C++
- Đồng thời dễ dàng, hỗ trợ Goroutines và Channels cho phép xử lý hàng nghìn
  luồng đồng thời với chi phí tài nguyên thấp
- Deployment đơn giản, chỉ cần một single binary độc lập, không phụ thuộc vào
  external libraries
- Cross-compilation hỗ trợ biên dịch cho nhiều nền tảng khác nhau từ một máy
- Cộng đồng lớn, Go được sử dụng trong Kubernetes, Docker, Terraform, Prometheus

=== Nhược điểm

Bên cạnh các ưu điểm, Go có một số hạn chế:

- Error handling dài dòng, pattern `if err != nil` xuất hiện lặp đi lặp lại làm
  code phồng phức
- Thiếu Generics trước Go 1.18, giới hạn khả năng tái sử dụng code, không
  support generic method. #footnote[Generic proposal đã được phê duyệt theo
    https://www.reddit.com/r/golang/comments/1rfmjbq/the_proposal_for_generic_methods_for_go_from/]
- Không có inheritance, chỉ hỗ trợ composition mà không hỗ trợ OOP truyền thống
- Learning curve với các khái niệm như interfaces và goroutines cần thời gian để
  hiểu rõ
