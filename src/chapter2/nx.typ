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


=== Nx Cache Trong Github Actions

`KevinNitroG/nx-cache-action` @nx_cache_action được phát triển bởi thành viên
trong nhóm _(Trần Nguyễn Thái Bình)_, hỗ trợ Nx cache trong GitHub Actions, tối
ưu hóa build times trong CI/CD. Script hoạt động theo cơ chế cache từng project
thay vì toàn bộ cache lớn của cả workspace, giúp cache hiệu quả hơn khi sử dụng
với Github Actions.

Script được lấy cảm hứng từ `raegen/nx` #footnote[https://github.com/raegen/nx,
  không hỗ trợ chính thức bởi Nx, đã bị deprecated], cache tại project level.
Nhưng cơ chế hoạt động khác biệt:
1. Script sẽ khởi động một NodeJS ExpressJS server implement OpenAPI Spec
  #footnote[https://nx.dev/docs/guides/tasks--caching/self-hosted-caching#open-api-specification]
  chính thức từ Nx.
2. Forward lệnh nx cho 1 child process, kèm theo thiêt lập để nx gửi request
  cache đến server.
3. Server nhận request cache, xử lý giao tiếp với Github Actions cache API thông
  qua `actions/toolkit/cache`
  #footnote[https://github.com/actions/toolkit/tree/main/packages/cache]

Script có một nhược điểm là phải thông qua `actions/toolkit/cache` để download
cache về local, và pipe cache vào lại Nx process. Nhưng đây là cách dễ dàng
nhất, không phải giao tiếp trực tiếp với Github Actions cache Rest API phức tạp
hơn.
