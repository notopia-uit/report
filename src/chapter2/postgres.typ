== Tổng quan về PostgreSQL

=== Giới thiệu

PostgreSQL (còn gọi là Postgres) là một hệ quản trị cơ sở dữ liệu quan hệ đối
tượng (ORDBMS) mã nguồn mở, mạnh mẽ và tiên tiến. PostgreSQL được phát triển từ
dự án POSTGRES tại Đại học California, Berkeley vào năm 1986 và đã phát triển
hơn 35 năm với cộng đồng đóng góp tích cực.

PostgreSQL nổi tiếng vì sự tuân thủ nghiêm ngặt các chuẩn SQL, hỗ trợ ACID
transactions đầy đủ, và khả năng mở rộng cao thông qua các kiểu dữ liệu tùy
chỉnh và extensions như PostGIS, pgcrypto, và full-text search.

#figure(
  image("../assets/images/postgres-logo.svg", height: 80pt),
  caption: [PostgreSQL logo],
)

=== Ưu điểm

PostgreSQL mang lại nhiều lợi ích cho phát triển ứng dụng:
- ACID đầy đủ, đảm bảo toàn vẹn dữ liệu
- Hỗ trợ JSON/JSONB, arrays, custom types, geometric data
- Mở rộng qua extensions (PostGIS, pgcrypto, uuid-ossp)
- Full-text search tích hợp sẵn
- MVCC cho đọc/ghi đồng thời không cần locks
- Tuân thủ SQL chuẩn, hỗ trợ window functions, CTEs, lateral joins
- Mã nguồn mở, miễn phí, cộng đồng lớn

=== Nhược điểm

Bên cạnh các ưu điểm, PostgreSQL có một số hạn chế:
- Hiệu năng thấp hơn MySQL trong một số tác vụ, replication phức tạp hơn
- Nhiều features nâng cao cần thời gian thành thạo
