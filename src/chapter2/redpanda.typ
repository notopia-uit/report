== Tổng quan về Redpanda

=== Giới thiệu

Redpanda là một nền tảng event streaming mã nguồn mở được viết bằng C++ với API tương thích Kafka @redpanda. Redpanda được thiết kế để cung cấp hiệu suất cao hơn Kafka trong khi duy trì tính tương thích hoàn toàn với Kafka protocol và ecosystem.

Redpanda được sử dụng như một message broker trong dự án, hỗ trợ pub/sub patterns cho event-driven architecture trong Go backend với Watermill @watermill.

=== Ưu điểm

Redpanda mang lại nhiều lợi ích cho phát triển event-driven:

- Kafka Compatible, hoàn toàn tương thích với Kafka API, cho phép easy migration
- Superior Performance, hiệu suất cao hơn Kafka với latency thấp hơn
- Single Binary, chỉ một binary executable, dễ triển khai hơn Kafka
- Resource Efficient, sử dụng ít CPU và RAM hơn Kafka
- Built-in Schema Registry, tích hợp schema registry không cần tool riêng
- Multi-Cloud, hỗ trợ triển khai trên nhiều cloud providers
- Active Community, cộng đồng hoạt động với hỗ trợ tốt

=== Nhược điểm

Bên cạnh các ưu điểm, Redpanda có một số hạn chế:

- Younger Ecosystem, tương đối mới so với Kafka, ecosystem chưa hoàn chỉnh
- Learning Curve, cần hiểu event-driven architecture và Kafka concepts
- Operational Knowledge, cần kiến thức vận hành hệ thống distributed messaging
- Community Size, cộng đồng nhỏ hơn Kafka, ít tài liệu nâng cao có sẵn
- Enterprise Features, một số tính năng enterprise của Confluent không khả dụng
