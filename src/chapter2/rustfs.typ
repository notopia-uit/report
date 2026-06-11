== Tổng quan về RustFS <general-for-rustfs>

=== Giới thiệu

RustFS @rustfs là một hệ thống lưu trữ object storage được viết hoàn toàn bằng
Rust, tương thích với API của Amazon S3. RustFS được phát triển như một giải
pháp thay thế hiệu suất cao hơn cho MinIO _(đã ngừng phát triển)_, đặc biệt là
trong các trường hợp cần throughput lớn và latency thấp.

Rust được chọn vì hiệu suất và an toàn bộ nhớ, giúp RustFS cung cấp một cơ sở hạ
tầng lưu trữ đáng tin cậy với resource overhead tối thiểu.

#figure(
  image("../assets/images/rustfs-logo.svg", height: 30pt),
  caption: [RustFS Logo],
)

=== Ưu điểm

RustFS mang lại nhiều lợi ích cho phát triển object storage:

- Tương thích S3 API, dễ thay thế MinIO/S3
- Hiệu suất vượt trội nhờ Rust
- Xử lý đồng thời tối ưu nhờ async/await
- Giao tiếp qua MinIO CLI
- Hỗ trợ cloud native, triển khai Kubernetes

=== Nhược điểm

Bên cạnh các ưu điểm, RustFS có một số hạn chế:

- Còn mới so với MinIO, ecosystem chưa hoàn chỉnh
- Chưa có phiên bản ổn định tại thời điểm thực hiện dự án
