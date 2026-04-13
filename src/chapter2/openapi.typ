== Tổng quan về OpenAPI và Code Generation

=== Giới thiệu

OpenAPI là một specification cho mô tả HTTP APIs theo cách chuẩn hóa. OpenAPI
cho phép sinh code từ contracts, tạo điều kiện cho contract-first development,
và tự động tạo documentation.

Dự án sử dụng OpenAPI cho HTTP API definitions, kết hợp với contract-first
approach để đảm bảo tính consistency giữa frontend và backend.

=== OpenAPI Specification

OpenAPI (trước đây được gọi là Swagger) là một format standardized cho mô tả
RESTful APIs. OpenAPI specification định nghĩa endpoints, parameters,
request/response schemas, và error codes theo cách machine-readable.

=== Code Generation từ OpenAPI

- Redocly @redocly: Tool cho OpenAPI specification, cung cấp documentation
  generator, linting, violation rules
- TypeScript: heyapi/openapi-ts @heyapi sinh TypeScript types từ OpenAPI spec
- Go: oapi-codegen @oapi_codegen sinh Go code từ OpenAPI spec, hỗ trợ HTTP API
  generation

=== OpenAPI Features

- Standardized Format, OpenAPI là standardized format cho API documentation
- Interactive Documentation, API explorer và interactive documentation generator
- Type Safety, code generation tạo type-safe clients và servers
- Multi-Language, code generation cho nhiều ngôn ngữ
- API Testing, tooling hỗ trợ testing API với generated clients

=== Contract-First Development

Contract-first approach định nghĩa API contracts trước khi implement logic. Điều
này đảm bảo tính consistency, tạo điều kiện cho parallel development, và giảm
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
