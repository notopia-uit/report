== Tổng quan về Database, ORM, và Query Patterns <general-for-database>

=== Giới thiệu

Dự án sử dụng nhiều tool và framework cho data persistence:
- SQLC @sqlc cho Go, sinh type-safe SQL code
- TypeORM @typeorm cho NestJS, ORM object-relational mapping

=== SQLC <general-for-sqlc>

SQLC @sqlc là tool sinh Go code từ SQL queries. Thay vì viết ORM-style code,
SQLC cho phép viết SQL trực tiếp và tự động sinh type-safe Go functions.

=== TypeORM

TypeORM @typeorm là ORM mã nguồn mở cho TypeScript, hỗ trợ multiple database
backends (PostgreSQL @postgres, MySQL, SQLite, Oracle, v.v.). TypeORM cung cấp
decorator-based API, tương thích với tốt NestJS. Đặc biệt, TypeORM tính đến thời
điểm hiện tại sắp ra phiên bản 1.0.0 sau 9 năm phát triển #footnote[Theo dõi tại
  Github issue https://github.com/typeorm/typeorm/issues/11819]

=== Ưu điểm

- SQLC: Type safety, hiệu năng cao nhờ vào SQL thuần, được check syntax SQL từ
  lúc generate
- TypeORM: Abstraction cao, dễ sử dụng, tích hợp tốt với NestJS, hỗ trợ nhiều
  database, có cộng đồng lớn và nhiều tài liệu tham khảo

=== Nhược điểm

- SQLC: Không hỗ trợ dynamic queries mà phải nhờ plugin hỗ trợ dyanmic filter,
  phải viết SQL thủ công, gặp khó khăn với khả năng syntax check đối với
  recursive query và CTE
- TypeORM: Abstraction có thể gây performance overhead, có thể gặp vấn đề với
  complex queries và migrations, thiết lập script TypeORM bằng typescript phức
  tạp, chạy bằng tsx @tsx
