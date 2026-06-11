== Tổng quan về Database, ORM, và Query Patterns <general-for-database>

=== Giới thiệu

Dự án sử dụng nhiều tool và framework cho data persistence:
- SQLC cho Go, sinh type-safe SQL code
- TypeORM cho NestJS, ORM object-relational mapping

=== SQLC <general-for-sqlc>

SQLC là tool sinh Go code từ SQL queries. Thay vì viết ORM-style code, SQLC cho
phép viết SQL trực tiếp và tự động sinh type-safe Go functions.

=== TypeORM

TypeORM là ORM mã nguồn mở cho TypeScript, hỗ trợ multiple database backends
(PostgreSQL MySQL, SQLite, Oracle, v.v.). TypeORM cung cấp decorator-based API,
tương thích với tốt NestJS. Đặc biệt, TypeORM tính đến thời điểm hiện tại sắp ra
phiên bản 1.0.0 sau 9 năm phát triển #footnote[Theo dõi tại Github issue
  https://github.com/typeorm/typeorm/issues/11819]

=== Ưu điểm

- SQLC: Type safety, hiệu năng cao nhờ SQL thuần, check syntax lúc generate
- TypeORM: Abstraction cao, tích hợp tốt NestJS, hỗ trợ nhiều database

=== Nhược điểm

- SQLC: Không hỗ trợ dynamic queries (cần plugin), viết SQL thủ công, khó syntax
  check với recursive query và CTE
- TypeORM: Abstraction gây performance overhead, khó khăn với complex
  queries/migrations, thiết lập script TypeScript phức tạp
