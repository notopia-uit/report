== Tổng quan về gRPC

=== Giới thiệu

gRPC là một framework RPC hiện đại được phát triển bởi Google @grpc, sử dụng
Protocol Buffers cho định nghĩa service và HTTP/2 cho communication. gRPC được
thiết kế để cung cấp hiệu suất cao, latency thấp, và tích hợp tốt với
distributed systems.

=== gRPC Features

- High Performance, Protocol Buffers và HTTP/2 cho throughput cao
- Bidirectional Streaming, hỗ trợ streaming từ client-to-server và
  server-to-client
- OpenTelemetry Support @opentelemetry, hỗ trợ native tracing với OpenTelemetry
- Type Safety, Protocol Buffers cung cấp strong typing
- Multi-Language, code generation cho nhiều ngôn ngữ

=== Protocol Buffers

Protocol Buffers là method của Google cho serializing structured data. Protocol
Buffers cung cấp compact binary format, cross-language support, backward
compatibility, và automatic code generation.

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
