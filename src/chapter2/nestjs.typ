== Tổng quan về NestJS <general-for-nestjs>

=== Giới thiệu

NestJS là một framework progressive Node.js được xây dựng để phát triển các ứng
dụng server-side hiệu quả, đáng tin cậy và có khả năng mở rộng cao. Được phát
triển bởi Kamil Myśliwiec và ra mắt lần đầu vào năm 2017, NestJS kết hợp các
khái niệm từ Angular, Spring Framework và các framework hiện đại khác.

NestJS được xây dựng trên nền tảng Express.js (hoặc Fastify) và sử dụng
TypeScript làm ngôn ngữ chính. Framework này tổ chức code theo mô hình kiến trúc
mô-đun rõ ràng, bao gồm controllers, services, middleware, guards, interceptors,
và pipes, tương tự như Spring Framework của Java.

Trong dự án này, NestJS được xây dựng với:
- Rspack là bundler mới được hỗ trợ, với SWC cho quá trình transpile nhanh, đảm
  bảo thời gian build tối ưu

#figure(
  image("../assets/images/nestjs-logo.svg", height: 80pt),
  caption: [NestJS logo],
)

=== Ưu điểm

NestJS mang lại nhiều lợi ích cho phát triển backend:
- TypeScript đầy đủ, type-safety từ đầu
- Module-based, dễ tổ chức và bảo trì
- DI mạnh mẽ, dễ dàng testing
- Hỗ trợ unit test và e2e test sẵn có
- Nhiều packages chính thức (GraphQL, WebSockets, Microservices)
- Phù hợp microservices và monolithic

=== Nhược điểm

Bên cạnh các ưu điểm, NestJS có một số hạn chế:
- Cần học nhiều concepts (DI, decorators, modules, providers)
- Boilerplate code (decorators, providers, controllers, services)
- Abstraction layers ảnh hưởng hiệu suất nhẹ
