== Tổng quan về Redpanda <general-for-redpanda>

=== Giới thiệu

Redpanda là một nền tảng event streaming mã nguồn mở được viết bằng C++ với API
tương thích Kafka @redpanda. Redpanda được thiết kế để cung cấp hiệu suất cao
hơn Kafka trong khi duy trì tính tương thích hoàn toàn với Kafka protocol và
ecosystem.

#figure(
  image("../assets/images/redpanda-logo.svg", height: 80pt),
  caption: [Redpanda Logo],
)

Redpanda được sử dụng như một message broker trong dự án, hỗ trợ pub/sub
patterns cho event-driven architecture.

=== Ưu điểm

Redpanda mang lại nhiều lợi ích cho phát triển event-driven:
- Đã dùng trong production bởi nhiều công ty lớn
- Tương thích Kafka API, dùng được Kafka clients, SDK và tools
- Single binary, dễ triển khai hơn Kafka
- Ít tốn CPU và RAM hơn Kafka
- Tích hợp schema registry, không cần tool riêng
- Hỗ trợ triển khai nhiều cloud providers
- Custom plugins bằng Go, Python qua Redpanda Connect SDK

=== Nhược điểm

Bên cạnh các ưu điểm, Redpanda có một số hạn chế:
- Cần hiểu event-driven architecture và Kafka concepts
- Cần kiến thức vận hành distributed messaging
- Cộng đồng nhỏ hơn Kafka, ít tài liệu nâng cao
- `postgres_cdc` @redpanda_connect_postgres_cdc yêu cầu bản trả phí, có thể dùng
  Debezium hoặc `sql_select` @redpanda_connect_sql_select
