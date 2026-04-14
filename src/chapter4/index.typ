= Xây dựng ứng dụng <implementation>

== Mô hình Miền (Domain Model)

#import "@preview/mmdr:0.2.1": mermaid

// language: mermaid
#let mermaid-source = ```
classDiagram
  class TrashedBy {
    <<enumeration>>
    UNSPECIFIED
    PURPOSE
    PARENT
  }

  class Workspace {
    id: UUID
    name: string
    slug: string
    rootFolderID: UUID
    deletedAt: *time.Time
    Rename(name string)
    Delete()
  }

  class Folder {
    id: UUID
    name: string
    icon: *string
    workspaceID: UUID
    folderHierarchy: FolderHierarchy
    trashed: *Trashed
    Rename(name string)
    SetIcon(icon string)
    ParentID() *UUID
    IsRoot() bool
    MoveToFolder(folderID UUID)
    Trash(trashedBy TrashedBy)
    Restore()
  }

  class FolderHierarchy {
    <<valueobject>>
    parentID: *UUID
    ParentID() *UUID
    IsRoot() bool
  }

  class Note {
    id: UUID
    name: string
    icon: *string
    tags: []string
    size: uint
    folderID: UUID
    outgoingLinks: UUID[]
    trashed: *Trashed
    Rename(name string)
    SetIcon(icon string)
    SetTags(tags []string)
    SetSize(size uint)
    MoveToFolder(folderID UUID)
    SetOutgoingLinks(outgoingLinks UUID[])
    Trash(trashedBy TrashedBy)
    Restore()
  }

  class Trashed {
    <<valueobject>>
    by: TrashedBy
    at: time.Time
  }

  class NoteService {
    UpdateNoteSizeBasedOnContent(note *Note, content any) error
  }

  class WorkspaceRepo {
    <<interface>>
    GetBySlug(ctx context.Context, slug string, forUpdate bool) (*Workspace, error)
    GetIDBySlug(ctx context.Context, slug string) (*UUID, error)
    CheckSlugExists(ctx context.Context, slug string) (bool, error)
    Save(ctx context.Context, workspace *Workspace) error
  }

  class FolderRepo {
    <<interface>>
    GetByID(ctx context.Context, id UUID, forUpdate bool) (*Folder, error)
    GetByIDs(ctx context.Context, ids UUID[], forUpdate bool) ([]Folder, error)
    Save(ctx context.Context, folder *Folder) error
    SaveMany(ctx context.Context, folders []Folder) error
    AreAllInWorkspace(ctx context.Context, ids []UUID, workspaceID UUID) (bool, error)
    GetTrashedByWorkspaceID(ctx context.Context, workspaceID UUID, trashedBy TrashedBy) ([]Folder, error)
    PermanentlyDeleteByID(ctx context.Context, id UUID) error
    PermanentlyDeleteByIDs(ctx context.Context, ids UUID[]) error
  }

  class NoteRepo {
    <<interface>>
    GetByID(ctx context.Context, id UUID, forUpdate bool) (*Note, error)
    GetByIDs(ctx context.Context, ids UUID[], forUpdate bool) ([]Note, error)
    Save(ctx context.Context, note *Note) error
    SaveMany(ctx context.Context, notes []Note) error
    AreAllInWorkspace(ctx context.Context, ids []UUID, workspaceID UUID) (bool, error)
    GetTrashedByWorkspaceID(ctx context.Context, workspaceID UUID) ([]Note, error)
    PermanentlyDeleteByID(ctx context.Context, id UUID) error
    PermanentlyDeleteByIDs(ctx context.Context, ids UUID[]) error
  }

  Workspace "1" *-- "1..*" Folder : contains
  Folder "1" *-- "1" FolderHierarchy : has
  Folder "1" *-- "0..*" Note : contains
  Note "0..*" -- "0..*" Note : links
  Note --> Trashed : may have
  Folder --> Trashed : may have
  Note --> NoteService : uses
  Workspace --> WorkspaceRepo : uses
  Folder --> FolderRepo : uses
  Note --> NoteRepo : uses
  Trashed --> TrashedBy : contains
```.text

#figure(
  mermaid(mermaid-source),
  caption: [Mô hình miền (Domain Model) của hệ thống],
)

== Giao diện ứng dụng

=== Giao diện Mobile

#lorem(100)

=== Giao diện Web Admin

#lorem(100)

=== Giao diện Backend API

#lorem(100)

== Kết quả và kết luận

Sau khi hoàn thành các giai đoạn phát triển, hệ thống ghi chú thông minh đã đạt
được các mục tiêu dự kiến.

#figure(
  rect(
    width: 100%,
    fill: rgb("#e8f4f8"),
    inset: 1em,
    [
      #set text(size: 11pt)
      #heading(level: 3, numbering: none)[Thành tựu chính]

      - Phát triển thành công ứng dụng ghi chú với giao diện thân thiện
      - Triển khai hệ thống đồng bộ hóa dữ liệu thời gian thực
      - Tạo ra công cụ tìm kiếm toàn văn hiệu quả
      - Đạt được độ hài lòng của người dùng cao (trên 4.5/5 sao)
    ],
  ),
  caption: [Các thành tựu chính của dự án],
)

#lorem(80)

=== Sơ đồ kiến trúc chi tiết

#import "@preview/tiago:0.1.0": render

// language: d2
#let d2-source = ```
direction: right

user: User
gateway: Gateway
web: Web

services: Services {
  identity_provider: Identity Provider
  object_storage: Object Storage

  document_service: Document Service {
    database_doc: Database
  }

  note_service: Note Service {
    database_note: Database
  }

  authorization_service: Authorization Service {
    database_auth: Database
  }

  search_service: Meilisearch {
    sync_worker: Sync Worker
  }

  event_bus: Event Bus
  monitoring: Monitoring {
    prometheus: Prometheus
    grafana: Grafana
    loki: Loki
  }
}

user -> gateway
gateway -> web
gateway -> services.identity_provider
gateway -> services.object_storage

web -> services.identity_provider
web -> services.object_storage

services.document_service -> services.database_doc
services.document_service -> services.note_service
services.document_service -> services.event_bus
services.document_service -> services.authorization_service
services.document_service -> services.object_storage

services.note_service -> services.database_note
services.note_service -> services.event_bus
services.note_service -> services.authorization_service

services.search_service -> services.sync_worker
services.event_bus -> services.search_service

services.monitoring.prometheus -> services.monitoring.grafana
services.monitoring.loki -> services.monitoring.grafana

style.border-radius: 12
*.style.border-radius: 12
*.*.style.border-radius: 12
```.text

#figure(
  render(d2-source, engine: "elk"),
  caption: [Sơ đồ kiến trúc hệ thống Notopia],
)
