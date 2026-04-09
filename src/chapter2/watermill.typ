== Tổng quan về Watermill

=== Giới thiệu

Watermill @watermill là library Go cho event-driven architecture, hỗ trợ multiple message routers. Watermill được thiết kế để tạo điều kiện cho asynchronous message processing, event streaming, và reactive architectures.

=== Watermill Architecture

Watermill cung cấp abstraction trên các message brokers khác nhau, cho phép viết event processing logic một lần và sử dụng trên múi các transports.

=== Message Routers

- Kafka integration với Redpanda @redpanda cho distributed streaming
- Redis pub/sub @redis cho lightweight pub/sub messaging trong cùng cluster
- Internal Go channels cho in-process communication

=== OpenTelemetry Integration

Watermill hỗ trợ OpenTelemetry @opentelemetry integration thông qua watermill-opentelemetry package, cho phép trace event processing workflow. Điều này cung cấp observability cho event-driven systems.

=== Ưu điểm

- Flexible Routing, hỗ trợ multiple transport backends
- Multiple Transport Backends, Kafka, Redis, và in-memory transports
- Structured Event Handling, type-safe event processing
- Excellent Performance, optimized cho high throughput
- Observability, native OpenTelemetry integration

=== Nhược điểm

- Event-Driven Complexity, event-driven adds complexity so với request-response
- Debugging, debugging distributed events là challenge
- Operational Overhead, yêu cầu manage message broker infrastructure
- Learning Curve, event-driven patterns cần được hiểu rõ
