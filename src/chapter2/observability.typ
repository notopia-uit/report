== Tổng quan về OpenTelemetry và Observability Stack

=== Giới thiệu

OpenTelemetry Protocol (OTLP) là một tiêu chuẩn mã nguồn mở cho việc thu thập và
xuất dữ liệu observability (metrics, logs, traces) @opentelemetry. OTLP được hỗ
trợ bởi hầu hết các công cụ monitoring hiện đại, bao gồm Grafana @grafana,
Prometheus @prometheus, Loki @loki, và Tempo @tempo.

Dự án này sử dụng một stack observability hoàn chỉnh bao gồm:
- Prometheus @prometheus, cho metrics collection
- Loki @loki, cho logs aggregation
- Tempo @tempo, cho distributed tracing
- Grafana @grafana, cho visualization tập trung
- Grafana Alloy, cho log/metrics forwarding agent

Các service được instrumented bằng:
- Node.js: `@opentelemetry/auto-instrumentations-node` cho auto instrumentation
- Go: `go.opentelemetry.io/contrib/exporters/autoexport` cho auto setup
  exporters

=== Ưu điểm

Stack observability mang lại nhiều lợi ích:

- Unified Observability, tập trung logs, metrics, và traces trong một platform
- Standards-Based, sử dụng OTLP, một tiêu chuẩn mở được nhiều tool hỗ trợ
- Auto Instrumentation, tự động capture telemetry data mà không cần code changes
- Cost-Effective, hầu hết components là mã nguồn mở và có thể tự triển khai
- Scalability, được thiết kế để xử lý large-scale deployments
- Multi-Language Support, hỗ trợ instrumentation cho nhiều ngôn ngữ lập trình
- Real-Time Insights, cung cấp real-time visibility vào application performance

=== Nhược điểm

Bên cạnh các ưu điểm, stack này có một số hạn chế:

- Operational Complexity, triển khai và maintain toàn bộ stack yêu cầu kiến thức
  sâu
- Data Volume, observability data có thể lớn, yêu cầu storage và retention
  planning
- Learning Curve, cần học cách cấu hình và sử dụng từng thành phần
- Network Overhead, thu thập observability data có thể thêm network traffic
- Cost of Storage, lưu trữ long-term observability data có thể tốn kém
