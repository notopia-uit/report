= Kết luận <conclusion>

#emph[
  Chương này trình bày phần kết luận của đồ án, nhằm tổng hợp và đánh giá các
  kết quả đạt được trong quá trình nghiên cứu, phân tích, thiết kế và xây dựng
  hệ thống. Nội dung chương tập trung vào việc đánh giá sản phẩm đã triển khai,
  nhận xét những thuận lợi, khó khăn, ưu điểm và hạn chế của hệ thống, đồng thời
  đề xuất các hướng phát triển trong tương lai nhằm nâng cao tính hoàn thiện và
  khả năng ứng dụng thực tế.
]

== Kết quả đạt được

=== Về sản phẩm

Nhóm đã hoàn thiện hệ thống ghi chú với các tính năng:

- Ứng dụng Web cho người dùng cuối, quản lý và tổ chức ghi chú.
- Hỗ trợ cộng tác thời gian thực với phân quyền.
- Tích hợp tìm kiếm ghi chú.
- Backend API microservices, hiệu suất cao.
- Source code tại https://github.com/notopia-uit/notopia.
- Document website tại https://notopia-uit.github.io/notopia.

=== Về công nghệ

Dự án áp dụng các công nghệ hiện đại:
- BlockNote (block-based editor), Yjs (CRDT), Hocuspocus (cộng tác)
  _(@general-for-blocknote, @blocknote-model-in-system, @general-for-yjs)_.
- React, NextJS, TypeScript, TailwindCSS, Shadcnui cho frontend.
- Go _(@general-for-go)_ và NestJS _(@general-for-nestjs)_ cho backend.
- Phân quyền với Casbin _(@general-for-casbin, @casbin-model-in-system)_.
- Xác thực OAuth2/OIDC với Authentik.
- gRPC cho inter-service communication.
- Traefik cho API gateway, Docker containerization, CI/CD với GitHub Actions.
- Meilisearch cho tìm kiếm.
- Database: SQL thuần và ORM.
- Monorepo với Nx, cache từng project -- dependency graph tại @appendix-nx.
- *Contract First*: OpenAPI spec, mock API, phát triển song song
  frontend/backend.
- *SQLC Dynamic Filter*: Plugin `vtuanjs/sqlc-gen-go` @sqlc_dynamic_filter cho
  dynamic WHERE conditions.
- *Observability*: Grafana, Prometheus, Loki, Tempo, Alloy -- xem tại
  @appendix-observability.

== Nhận xét

=== Thuận lợi

- Được giảng viên hướng dẫn tận tình, giúp định hướng rõ ràng, tránh dùng công
  nghệ không cần thiết _(như Neo4j, thay bằng SQL Recursive CTE)_.
- BlockNote giúp xây dựng editor nhanh, tập trung phát triển tính năng đặc thù.
- Các công nghệ hiện đại (React, NextJS, NestJS, Go, gRPC, Traefik, Casbin,
  Authentik, Meilisearch) tăng tốc phát triển và đảm bảo hiệu suất.
- Cộng tác nhóm hiệu quả nhờ Contract First (OpenAPI, Protobuf), giảm xung đột
  code.

=== Khó khăn

- Dữ liệu mẫu từ Obsidian Vault (`TrshPuppy/obsidian-notes`
  @trshpuppy_obsidian_notes) không chuẩn xác do parse bằng text, code block chứa
  `#`/`#!` bị parse thành tag. Hệ thống không support nested tags như Obsidian.
- Việc học nhiều công nghệ mới cùng lúc tạo learning curve dốc, dù đã có kinh
  nghiệm với OAuth2/OIDC, SQLC.
- Kiến trúc microservices đòi hỏi quản lý nhiều service, đảm bảo communication,
  xử lý distributed systems issues (latency, fault tolerance).
- Casbin có learning curve cao, cần hiểu rõ RBAC để thiết kế policy phù hợp.
- Các khái niệm event bus, command bus từ Watermill và Event-Driven Architecture
  nói chung đòi hỏi hiểu rõ để triển khai đúng.
- Thiết lập monorepo TypeScript/JavaScript phức tạp, tốn thời gian cấu hình.
- RustFS chưa stable, gặp vấn đề `rustfs/rustfs/issues/2587`
  @rustfs_server_domains_issue do thành viên nhóm phát hiện.

=== Ưu điểm

- Trải nghiệm người dùng trực quan, giao diện hiện đại, thống nhất.
- Xử lý graph nhanh nhờ Go, hạn chế con trỏ và đối tượng heap khi Read.
- Kiến trúc microservices dễ mở rộng, maintainability cao nhờ Clean
  Architecture, DDD, CQRS cho service `note`.
- DevOps tốt với CI/CD nhanh nhờ Nx: 30 giây (cache hit), 10 phút (ignore
  cache).
- Các service Go (`note`, `authorization`) có health check endpoint đầy đủ.

=== Nhược điểm

- Microservices architecture có độ phức tạp cao.
- Tốn tài nguyên infrastructure: tổng RAM ~2.5GB khi chạy toàn bộ, riêng
  Authentik ~1.5GB _(chấp nhận đánh đổi lấy enterprise ready, feature rich)_.
- Các service JS chưa cấu hình được telemetry và health check endpoint.
- Xử lý lỗi async event còn hạn chế: chưa có retry và dead letter queue cho tất
  cả service (hiện chỉ có service `note`).

== Hướng phát triển

- Tính năng subscription: thương mại hóa sản phẩm dưới dạng SaaS.
- Tích hợp AI: `@blocknote/xl-ai` @blocknote_ai_docs, hybrid search với
  Meilisearch @meilisearch_solutions_hybrid_search, tool thông qua API hệ thống.
- Deploy: thiết lập quy trình release container, sẵn sàng triển khai.
- Sử dụng Istio Gateway thay Traefik trên môi trường deploy _(service mesh,
  auth, retry tại gateway)_ phù hợp Kubernetes.

== Lời kết

#import "../lib/metadata.typ": project-metadata

Dự án đã đạt được mục tiêu đề ra và mang lại nhiều bài học quý giá cho nhóm phát
triển. Hệ thống "#project-metadata.vietnamese-name-description" không chỉ là sản
phẩm hoàn chỉnh mà còn là nền tảng để tiếp tục nghiên cứu và phát triển trong
tương lai.
