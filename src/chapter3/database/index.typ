== Thiết kế cơ sở dữ liệu

#import "../../lib/database.typ": db-table, column

=== Tổng quan kiến trúc dữ liệu

Hệ thống ghi chú được thiết kế với cơ sở dữ liệu quan hệ (RDBMS) để đảm bảo tính toàn vẹn dữ liệu, tính nhất quán và khả năng truy vấn hiệu quả. Các bảng được chuẩn hóa theo mô hình ba bình thường (3NF).

#lorem(80)

=== Mô tả các bảng dữ liệu

==== Bảng Users

#figure(
  db-table(
    columns: (
      column("user_id", "UUID", "Mã định danh duy nhất của người dùng", key: "PK"),
      column("email", "VARCHAR(255)", "Địa chỉ email của người dùng", key: "UQ"),
      column("username", "VARCHAR(100)", "Tên đăng nhập", key: "UQ"),
      column("password_hash", "VARCHAR(255)", "Hash mật khẩu"),
      column("first_name", "VARCHAR(100)", "Họ của người dùng"),
      column("last_name", "VARCHAR(100)", "Tên của người dùng"),
      column("created_at", "TIMESTAMP", "Thời gian tạo tài khoản"),
      column("updated_at", "TIMESTAMP", "Thời gian cập nhật gần nhất"),
    ),
  ),
  caption: [Bảng Users - Thông tin người dùng],
)

==== Bảng Notes

#figure(
  db-table(
    columns: (
      column("note_id", "UUID", "Mã định danh duy nhất của ghi chú", key: "PK"),
      column("user_id", "UUID", "ID của người dùng sở hữu ghi chú", key: "FK"),
      column("title", "VARCHAR(200)", "Tiêu đề ghi chú"),
      column("content", "TEXT", "Nội dung ghi chú"),
      column("tags", "JSON", "Danh sách nhãn của ghi chú"),
      column("is_pinned", "BOOLEAN", "Ghi chú được ghim hay không"),
      column("created_at", "TIMESTAMP", "Thời gian tạo ghi chú"),
      column("updated_at", "TIMESTAMP", "Thời gian cập nhật ghi chú"),
      column("deleted_at", "TIMESTAMP", "Thời gian xóa mềm (soft delete)"),
    ),
  ),
  caption: [Bảng Notes - Thông tin các ghi chú],
)

=== Mối quan hệ giữa các bảng

#figure(
  rect(
    width: 100%,
    fill: rgb("#f5f5f5"),
    stroke: 1pt,
    inset: 1.5em,
    [
      #set align(center)
      #set text(size: 10pt)
      
      *Mối quan hệ One-to-Many*
      
      #v(0.8em)
      
      *Users* (1) ─────→ (Many) *Notes*
      
      #v(0.5em)
      
      Một người dùng có thể sở hữu nhiều ghi chú, nhưng mỗi ghi chú chỉ thuộc về một người dùng duy nhất.
    ],
  ),
  caption: [Sơ đồ mối quan hệ dữ liệu],
)

#lorem(60)
