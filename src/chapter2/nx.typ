== Tổng quan về Nx <general-for-nx>

=== Giới thiệu

Nx @nx là build system và monorepo management tool được phát triển bởi Nrwl. Nx
cung cấp các tính năng cho task orchestration, caching intelligent,
visualization của dependency graph, code generation, và workspace analysis.

Trong dự án, Nx được sử dụng như task runner và build system, thiết lập toàn bộ
luồng code gen cho GRPC, OpenAPI, SQLC,... Trước đây, nhóm đã từng thiết lập
Bazel nhưng đã chuyển sang Nx vì Bazel chỉ giải quyết được vấn đề build, không
giúp việc dev trở nên dễ dàng hơn.

=== Ưu điểm

- Task Orchestration, quản lý và chạy tasks phụ thuộc, song song một cách tối ưu
- Intelligent Caching, caching của build artifacts dựa trên file changes
- Dependency Graph Visualization, hiểu dependencies giữa các packages
- Workspace Analysis, phân tích codebase để xác định affected projects
- Hỗ trợ thiết lập monorepo Typescript dễ dàng hơn, song, vẫn cần kiến thức vững
  vàng về typescript và hệ sinh thái typescript _(@general-for-typescript)_

=== Nhược điểm

- Learning Curve, cần hiểu Nx concepts và configuration
- Configuration Complexity, setup phức tạp cho custom use cases, như các luồng
  code gen, thiết lập với Go, vì không hỗ trợ chính thức cho Go
- Overhead cho Small Projects, overhead không cần thiết cho projects nhỏ
