== Thiết kế cơ sở dữ liệu

#import "../lib/database.typ": column, db-table

=== Mô tả các bảng dữ liệu

==== Bảng Workspaces

#figure(
  db-table(
    column("id", "UUID", "Mã định danh duy nhất của workspace", key: "PK"),
    column("slug", "TEXT", "URL-friendly slug của workspace", key: "UQ"),
    column("name", "TEXT", "Tên của workspace"),
    column("created_at", "TIMESTAMPTZ", "Thời gian tạo"),
    column("updated_at", "TIMESTAMPTZ", "Thời gian cập nhật gần nhất"),
    column("deleted_at", "TIMESTAMPTZ", "Thời gian xóa (soft delete)"),
  ),
  caption: [Bảng Workspaces - Không gian làm việc của người dùng],
)

==== Bảng Folders

#figure(
  db-table(
    column("id", "UUID", "Mã định danh duy nhất của folder", key: "PK"),
    column("name", "TEXT", "Tên của folder"),
    column("icon", "TEXT", "Icon của folder"),
    column("workspace_id", "UUID", "ID workspace chứa folder này", key: "FK"),
    column(
      "parent_id",
      "UUID",
      "ID folder cha (for nested structure)",
      key: "FK",
    ),
    column("created_at", "TIMESTAMPTZ", "Thời gian tạo"),
    column("updated_at", "TIMESTAMPTZ", "Thời gian cập nhật gần nhất"),
    column("trashed_by", "ENUM", "Loại xóa (purpose | parent)"),
    column("trashed_at", "TIMESTAMPTZ", "Thời gian xóa"),
  ),
  caption: [Bảng Folders - Các thư mục chứa ghi chú],
)

==== Bảng Notes

#figure(
  db-table(
    column("id", "UUID", "Mã định danh duy nhất của ghi chú", key: "PK"),
    column("name", "TEXT", "Tên của ghi chú"),
    column("icon", "TEXT", "Icon của ghi chú"),
    column("folder_id", "UUID", "ID folder chứa ghi chú này", key: "FK"),
    column("tags", "TEXT[]", "Danh sách nhãn của ghi chú"),
    column("size", "INTEGER", "Kích thước của ghi chú (bytes)"),
    column("created_at", "TIMESTAMPTZ", "Thời gian tạo"),
    column("updated_at", "TIMESTAMPTZ", "Thời gian cập nhật gần nhất"),
    column("trashed_by", "ENUM", "Loại xóa (purpose | parent)"),
    column("trashed_at", "TIMESTAMPTZ", "Thời gian xóa"),
  ),
  caption: [Bảng Notes - Các ghi chú trong hệ thống],
)

==== Bảng Note Links

#figure(
  db-table(
    column("source_id", "UUID", "ID ghi chú nguồn", key: "PK, FK"),
    column("target_id", "UUID", "ID ghi chú đích", key: "PK, FK"),
  ),
  caption: [Bảng Note Links - Mối quan hệ giữa các ghi chú],
)
