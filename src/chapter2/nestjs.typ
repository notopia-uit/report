== Tổng quan về NestJS

=== Giới thiệu

NestJS là một framework progressive Node.js được xây dựng để phát triển các ứng
dụng server-side hiệu quả, đáng tin cậy và có khả năng mở rộng cao. Được phát
triển bởi Kamil Myśliwiec và ra mắt lần đầu vào năm 2017, NestJS kết hợp các
khái niệm từ Angular, Spring Framework và các framework hiện đại khác.

NestJS được xây dựng trên nền tảng Express.js (hoặc Fastify) và sử dụng
TypeScript @typescript làm ngôn ngữ chính. Framework này tổ chức code theo mô
hình kiến trúc mô-đun rõ ràng, bao gồm controllers, services, middleware,
guards, interceptors, và pipes, tương tự như Spring Framework của Java.

Trong dự án này, NestJS được xây dựng với:
- Rspack là bundler mới được hỗ trợ, với SWC cho quá trình transpile nhanh, đảm
  bảo thời gian build tối ưu

=== Ưu điểm

NestJS mang lại nhiều lợi ích cho phát triển backend:

- TypeScript First, hỗ trợ TypeScript đầy đủ với type-safety từ đầu, không cần
  cấu hình thêm
- Kiến trúc rõ ràng, tổ chức code theo modules, dễ tổ chức, bảo trì và mở rộng
  quy mô
- Dependency Injection mạnh mẽ, quản lý dependencies tự động và dễ dàng cho
  testing
- Built-in Testing Utilities, hỗ trợ unit tests và e2e tests ngay từ khởi đầu
- Ecosystem phong phú, có nhiều packages chính thức như GraphQL, WebSockets,
  Microservices
- Scalability, phù hợp cho cả microservices lẫn monolithic applications

=== Nhược điểm

Bên cạnh các ưu điểm, NestJS có một số hạn chế:

- Learning Curve cao, cần học nhiều concepts như Dependency Injection (runtime),
  decorators, modules, providers
- Boilerplate Code, cần viết nhiều decorators, setup code, định nghĩa providers,
  controllers, services
- Performance Overhead, các abstraction layers có thể ảnh hưởng hiệu suất nhẹ so
  với framework tối giản
