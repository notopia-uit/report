== Tổng quan về OpenAPI

=== Giới thiệu

OpenAPI là một specification cho mô tả HTTP APIs theo cách chuẩn hóa. OpenAPI
cho phép sinh code từ contracts, tạo điều kiện cho contract-first development,
và tự động tạo documentation.

OpenAPI _(trước đây được gọi là Swagger)_ là một format standardized cho mô tả
RESTful APIs. OpenAPI specification định nghĩa endpoints, parameters,
request/response schemas, và error codes theo cách machine-readable.

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: -100pt,
    image("../assets/images/openapi-logo.svg", height: 80pt),
    image("../assets/images/redocly-logo.svg", height: 80pt),
    image("../assets/images/scalar-logo.svg", height: 80pt),
  ),
  caption: [OpenAPI, Redocly, Scalar Logo],
)

=== Tooling Ecosystem

- Redocly @redocly: Tool cho OpenAPI specification, trong dự án sử dụng làm
  language server, linter, bundle các file nhỏ thành một file lớn
- Scalar @scalar: Tool cho OpenAPI specification, tương đối giống redocly, trong
  dự án sử dụng để render website documentation từ OpenAPI spec
- `heyapi/openapi-ts` @heyapi sinh TypeScript types từ OpenAPI spec
- `oapi-codegen` @oapi_codegen sinh Go code từ OpenAPI spec, hỗ trợ HTTP API
  generation
- OpenAPI Generator @openapi_generator: Tool đa ngôn ngữ cho code generation từ
  OpenAPI spec, hỗ trợ nhiều languages và frameworks, trong dự án sử dụng
  generator `typescript-nestjs-server` @openapi_generator_nestjs_server

=== Contract-First Development

Contract-first approach định nghĩa API contracts trước khi implement logic, đảm
bảo tính consistency, tạo điều kiện cho parallel development, và giảm
integration issues.

=== Ưu điểm

- Clear Contracts, API contracts rõ ràng được define trước implementation
- Parallel Development, frontend và backend có thể phát triển song song
- Type Safety, code generation tạo type-safe clients và servers
- Documentation, contracts tự động documentation
- Tooling Ecosystem, rộng rãi tooling hỗ trợ OpenAPI

=== Nhược điểm

- Specification Maintenance, specifications cần được updated khi API thay đổi
- Setup Complexity, code generation pipeline yêu cầu cấu hình
- Learning Curve, cần học OpenAPI specification format
- Tooling Overhead, cần maintain generation scripts và tooling
