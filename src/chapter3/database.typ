== Thiết kế cơ sở dữ liệu

Các service trong hệ thống sẽ sử dụng cơ sở dữ liệu PostgreSQL để lưu trữ và quản lý dữ liệu. Dưới đây là thiết kế cơ sở dữ liệu cho các service, bao gồm các bảng chính và mối quan hệ giữa chúng.

#import "../lib/database.typ": column, db-table

=== Cơ sở dữ liệu cho Note Service

#figure(
  image("../assets/sync-diagrams/database-diagram-note.svg"),
  caption: [Sơ đồ cơ sở dữ liệu cho `note` service],
)

==== Bảng Workspaces

#figure(
  db-table(
    column("id", "UUID", "Mã định danh duy nhất của workspace", key: "PK"),
    column("slug", "TEXT", "URL-friendly slug của workspace", key: "UQ"),
    column("name", "TEXT", "Tên của workspace"),
    column("created_at", "TIMESTAMPTZ", "Thời gian tạo"),
    column("updated_at", "TIMESTAMPTZ", "Thời gian cập nhật gần nhất"),
    column("deleted_at", "TIMESTAMPTZ", "Thời gian xóa (soft delete, Nullable)"),
  ),
  caption: [Bảng Workspaces - Các không gian làm việc - Note Service],
)

==== Bảng Folders

#figure(
  db-table(
    column("id", "UUID", "Mã định danh duy nhất của folder", key: "PK"),
    column("name", "TEXT", "Tên của folder (Nullable)"),
    column("icon", "TEXT", "Icon của folder (Nullable)"),
    column("workspace_id", "UUID", "ID workspace chứa folder này", key: "FK"),
    column(
      "parent_id",
      "UUID",
      "ID folder cha (for nested structure) (Nullable)",
      key: "FK",
    ),
    column("created_at", "TIMESTAMPTZ", "Thời gian tạo"),
    column("updated_at", "TIMESTAMPTZ", "Thời gian cập nhật gần nhất"),
    column("trashed_by", "ENUM", "Loại xóa (purpose | parent, Nullable)"),
    column("trashed_at", "TIMESTAMPTZ", "Thời gian xóa (Nullable)"),
  ),
  caption: [Bảng Folders - Các thư mục của một không gian làm việc - Note Service],
)

==== Bảng Notes

#figure(
  db-table(
    column("id", "UUID", "Mã định danh duy nhất của ghi chú", key: "PK"),
    column("name", "TEXT", "Tên của ghi chú"),
    column("icon", "TEXT", "Icon của ghi chú (Nullable)"),
    column("folder_id", "UUID", "ID folder chứa ghi chú này", key: "FK"),
    column("tags", "TEXT[]", "Danh sách tag của ghi chú (Nullable)"),
    column("size", "INTEGER", "Kích thước của ghi chú (bytes)"),
    column("created_at", "TIMESTAMPTZ", "Thời gian tạo"),
    column("updated_at", "TIMESTAMPTZ", "Thời gian cập nhật gần nhất"),
    column("trashed_by", "ENUM", "Loại xóa (purpose | parent, Nullable)"),
    column("trashed_at", "TIMESTAMPTZ", "Thời gian xóa (Nullable)"),
  ),
  caption: [Bảng Notes - Các ghi chú - Note Service],
)

==== Bảng Note Links

#figure(
  db-table(
    column("source_id", "UUID", "ID ghi chú nguồn", key: "PK, FK"),
    column("target_id", "UUID", "ID ghi chú đích", key: "PK, FK"),
  ),
  caption: [Bảng Note Links - Mối quan hệ giữa các ghi chú - Note Service],
)

=== Cơ sở dữ liệu cho Document Service

#figure(
  image("../assets/sync-diagrams/database-diagram-document.svg"),
  caption: [Sơ đồ cơ sở dữ liệu cho `document` service],
)

==== Bảng Documents

#figure(
  db-table(
    column("id", "UUID", "Mã định danh duy nhất của document", key: "PK"),
    column("data", "BYTEA", "Dữ liệu nhị phân yjs của document"),
    column("modified", "BOOLEAN", "Trạng thái đã được chỉnh sửa hay chưa"),
  ),
  caption: [Bảng Documents - Lưu trữ các tài liệu - Document Service],
)

==== Bảng Revisions

#figure(
  db-table(
    column("id", "UUID", "Mã định danh duy nhất của revision", key: "PK"),
    column("name", "TEXT", "Tên của revision (Nullable)"),
    column("data", "JSON", "Dữ liệu blocknote của revision"),
    column("document_id", "UUID", "ID document liên kết với revision", key: "FK"),
    column("created_at", "TIMESTAMPTZ", "Thời gian tạo"),
    column("deleted_at", "TIMESTAMPTZ", "Thời gian xóa (Nullable)"),
  ),
  caption: [Bảng Revisions - Lưu trữ các phiên bản của tài liệu - Document Service],
)

=== Cơ sở dữ liệu cho Authorization Service

Vì tính đặc thù của thư viện Casbin, bảng dữ liệu của service này không thuộc phạm vi quản lý của hệ thống, mà sẽ được Casbin tự động tạo ra và quản lý dựa trên cấu hình của nó.

#figure(
  image("../assets/sync-diagrams/database-diagram-authorization.svg", height:
    20em),
  caption: [Sơ đồ cơ sở dữ liệu cho `authorization` service],
)

==== Bảng Casbin Rules

#figure(
  db-table(
    column("id", "UUID", "Mã định danh duy nhất của rule", key: "PK"),
    column("ptype", "TEXT", "Loại rule (p, g, ...)"),
    column("v0", "TEXT", "Trường dữ liệu 0"),
    column("v1", "TEXT", "Trường dữ liệu 1"),
    column("v2", "TEXT", "Trường dữ liệu 2"),
    column("v3", "TEXT", "Trường dữ liệu 3 (Nullable)"),
    column("v4", "TEXT", "Trường dữ liệu 4 (Nullable)"),
    column("v5", "TEXT", "Trường dữ liệu 5 (Nullable)"),
  ),
  caption: [Bảng Casbin Rules - Lưu trữ các quy tắc phân quyền - Authorization Service],
)