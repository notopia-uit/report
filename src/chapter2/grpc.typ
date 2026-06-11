== Tổng quan về gRPC <general-for-grpc>

=== Giới thiệu

GRPC là một framework RPC hiện đại được phát triển bởi Google, sử dụng Protocol
Buffers cho định nghĩa service và HTTP/2 cho communication. GRPC được thiết kế
để cung cấp hiệu suất cao, latency thấp, và tích hợp tốt với distributed
systems.

#figure(
  image("../assets/images/grpc-logo.svg", height: 80pt),
  caption: [gRPC logo],
)

=== gRPC Features

- High Performance, Protocol Buffers và HTTP/2 cho throughput cao
- Bidirectional Streaming, hỗ trợ streaming từ client-to-server và
  server-to-client
- OpenTelemetry Support, hỗ trợ native tracing với OpenTelemetry
- Type Safety, Protocol Buffers cung cấp strong typing
- Multi-Language, code generation cho nhiều ngôn ngữ

=== gRPC Tooling

- Buf @buf: Build system cho Protocol Buffers, hỗ trợ remote gen không cần cài
  dependencies, cung cấp code generation, linting, và breaking change detection
- GRPC Go @grpc_go: Implementation gRPC cho Go, cung cấp high-performance gRPC
  server và client
- ts-proto @ts_proto: Code generator cho TypeScript, tương thích với NestJS

=== Ưu điểm

- Protocol Buffers và HTTP/2 cho throughput cao
- Strong typing từ Protocol Buffers
- Native bidirectional streaming
- Tích hợp OpenTelemetry
- Code generation cho nhiều ngôn ngữ

=== Nhược điểm

- Cần học Protocol Buffers và gRPC
- Yêu cầu HTTP/2, hỗ trợ trình duyệt hạn chế
- Binary format khó debug hơn text-based protocols
- Yêu cầu setup code generation pipeline
