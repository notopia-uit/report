== Tổng quan về PostgreSQL

=== Giới thiệu

PostgreSQL (còn gọi là Postgres) là một hệ quản trị cơ sở dữ liệu quan hệ đối
tượng (ORDBMS) mã nguồn mở @postgres, mạnh mẽ và tiên tiến. PostgreSQL được phát
triển từ dự án POSTGRES tại Đại học California, Berkeley vào năm 1986 và đã phát
triển hơn 35 năm với cộng đồng đóng góp tích cực.

PostgreSQL nổi tiếng vì sự tuân thủ nghiêm ngặt các chuẩn SQL, hỗ trợ ACID
transactions đầy đủ, và khả năng mở rộng cao thông qua các kiểu dữ liệu tùy
chỉnh và extensions như PostGIS, pgcrypto, và full-text search.

#figure(
  image("../assets/images/postgres-logo.svg", height: 80pt),
  caption: [PostgreSQL logo],
)

=== Ưu điểm

PostgreSQL mang lại nhiều lợi ích cho phát triển ứng dụng:
- ACID Compliance, tuân thủ đầy đủ các thuộc tính ACID (Atomicity, Consistency,
  Isolation, Durability) đảm bảo tính toàn vẹn dữ liệu
- Rich Data Types, hỗ trợ nhiều kiểu dữ liệu phong phú bao gồm JSON/JSONB,
  arrays, custom types, geometric data
- Extensibility cao, cho phép mở rộng chức năng thông qua extensions (PostGIS,
  pgcrypto, uuid-ossp)
- Full-Text Search tích hợp, hỗ trợ tìm kiếm toàn văn mà không cần các công cụ
  bên ngoài
- MVCC (Multi-Version Concurrency Control) hiệu quả, cho phép đọc và ghi đồng
  thời mà không cần locks
- Standards Compliance, tuân thủ đầy đủ các chuẩn SQL và hỗ trợ các features
  nâng cao như window functions, CTEs, lateral joins
- Open Source, miễn phí và có cộng đồng lớn hỗ trợ

=== Nhược điểm

Bên cạnh các ưu điểm, PostgreSQL có một số hạn chế:
- Performance, có thể chậm hơn MySQL trong một số workloads read-heavy đơn giản
- Memory Usage cao, sử dụng nhiều RAM hơn các RDBMS khác như MySQL
- Replication phức tạp, phức tạp hơn so với MySQL/MariaDB, đặc biệt trong setup
  streaming replication
- Learning Curve cao, nhiều features nâng cao cần thời gian để thành thạo như
  partitioning, custom types
