== Tổng quan về gRPC <general-for-grpc>

=== Giới thiệu

GRPC là một framework RPC hiện đại được phát triển bởi Google @grpc, sử dụng
Protocol Buffers cho định nghĩa service và HTTP/2 cho communication. GRPC được
thiết kế để cung cấp hiệu suất cao, latency thấp, và tích hợp tốt với
distributed systems.

#figure(
  image("../assets/images/grpc-logo.svg", height: 80pt),
  caption: [gRPC logo],
)

=== gRPC Features

- High Performance, Protocol Buffers và HTTP/2 cho throughput cao
- Bidirectional Streaming, hỗ trợ streaming từ client-to-server và
  server-to-client
- OpenTelemetry Support @opentelemetry, hỗ trợ native tracing với OpenTelemetry
- Type Safety, Protocol Buffers cung cấp strong typing
- Multi-Language, code generation cho nhiều ngôn ngữ

=== gRPC Tooling

- Buf @buf: Build system cho Protocol Buffers, hỗ trợ remote gen không cần cài
  dependencies, cung cấp code generation, linting, và breaking change detection
- GRPC Go @grpc_go: Implementation gRPC cho Go, cung cấp high-performance gRPC
  server và client
- ts-proto @ts_proto: Code generator cho TypeScript, tương thích với NestJS

=== Ưu điểm

- High Performance, Protocol Buffers và HTTP/2 cho throughput cao
- Type Safety, Protocol Buffers cung cấp strong typing
- Streaming Support, native bidirectional streaming support
- Observability, tích hợp tốt với OpenTelemetry
- Multi-Language, code generation cho nhiều ngôn ngữ

=== Nhược điểm

- Learning Curve, cần học Protocol Buffers và gRPC concepts
- Browser Compatibility, gRPC yêu cầu HTTP/2 support (limited browser support)
- Debugging Complexity, binary format khó debug so với text-based protocols
- Tooling Setup, yêu cầu setup code generation pipeline
