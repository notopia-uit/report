== Tổng quan về Database, ORM, và Query Patterns

=== Giới thiệu

Dự án sử dụng nhiều tool và framework cho data persistence:
- SQLC @sqlc cho Go, sinh type-safe SQL code
- TypeORM @typeorm cho NestJS, ORM object-relational mapping

=== SQLC - Type-Safe SQL Code Generation

SQLC @sqlc là tool sinh Go code từ SQL queries. Thay vì viết ORM-style code, SQLC cho phép viết SQL trực tiếp và tự động sinh type-safe Go functions.

Custom plugin sqlc-gen-go-dynamic-filter @sqlc_dynamic_filter được phát triển bởi Nguyễn Văn Tuấn hỗ trợ dynamic filter queries, giải quyết vấn đề không thể sinh dynamic WHERE conditions trong SQLC tiêu chuẩn.

=== TypeORM - ORM cho TypeScript

TypeORM @typeorm là ORM mã nguồn mở cho TypeScript, hỗ trợ multiple database backends (PostgreSQL @postgres, MySQL, SQLite, Oracle, v.v.). TypeORM cung cấp decorator-based API, tương thích với NestJS dependency injection.

=== Ưu điểm

- SQLC: Type safety, performance, explicit SQL control, generated code readability
- TypeORM: Familiar ORM patterns, decorator support, async/await API, migration support

=== Nhược điểm

- SQLC: Requires writing SQL, less abstraction, dynamic queries need custom plugins
- TypeORM: Performance overhead of ORM, complexity với advanced queries, learning curve

