= Giới thiệu đề tài <introduction>

#emph[
  Chương này trình bày bối cảnh thực tiễn và lý do lựa chọn đề tài, từ đó làm rõ
  mục tiêu, phạm vi và đối tượng nghiên cứu của dự án. Nội dung của chương nhằm
  giúp người đọc có cái nhìn toàn diện về định hướng nghiên cứu, cơ sở khoa học
  và giá trị ứng dụng thực tiễn của đề tài trước khi đi sâu vào các chương phân
  tích và thiết kế chi tiết ở các phần tiếp theo.
]

== Lý do chọn đề tài

Trong kỷ nguyên bùng nổ thông tin, việc quản lý kiến thức cá nhân _(Personal
Knowledge Management - PKM)_ trở thành một kỹ năng thiết yếu. Các phương pháp
ghi chú truyền thống theo dạng danh sách hoặc thư mục dần bộc lộ hạn chế trong
việc kết nối các ý tưởng rời rạc. Lấy cảm hứng từ các ứng dụng như Notion,
Obsidian, chúng em xây dựng nền tảng ghi chú hiện đại hỗ trợ liên kết hai chiều
#footnote[Liên kết hai chiều gồm outgoing link -- liên kết từ ghi chú này đến
  ghi chú khác -- và backlink -- liên kết ngược lại
], kết hợp trực quan hóa kiến thức thành biểu đồ quan hệ.

== Mục đích và mục tiêu nghiên cứu

=== Mục đích nghiên cứu

Xây dựng nền tảng web quản lý tri thức cá nhân, trực quan hoá bằng biểu đồ quan
hệ _(Graph View)_, cộng tác theo thời gian thực. Ứng dụng cung cấp các chức năng
ghi chú cơ bản: tạo, sửa, xoá tạm thời, xoá vĩnh viễn, khôi phục, tìm kiếm toàn
văn _(full-text search)_ và phân quyền truy cập không gian làm việc
_(workspace)_.

=== Mục tiêu nghiên cứu

- Nghiên cứu các phương pháp tổ chức ghi chú dạng cấu trúc thư mục.
- Nghiên cứu cách thức liên kết các ghi chú với nhau để tạo thành mạng lưới tri
  thức.
- Tích hợp thư viện soạn thảo nội dung ghi chú _(block-based editor)_ với cách
  quản lý đối tượng trong hệ thống.
- Nghiên cứu cách triển khai cộng tác theo thời gian thực.
- Định danh, phân quyền người dùng đối với không gian làm việc.
- Thiết kế kiến trúc hệ thống dễ mở rộng, bảo trì và có hiệu suất cao.

== Đối tượng và phạm vi nghiên cứu

=== Đối tượng nghiên cứu

==== Đối tượng nghiên cứu về mặt nghiệp vụ

- Hệ thống quản lý tri thức cá nhân _(Personal Knowledge Management - PKM)_:
  Nghiên cứu mô hình lưu trữ và kết nối các ý tưởng rời rạc thành mạng lưới tri
  thức.
- Cấu trúc dữ liệu ghi chú: Loại định dạng nội dung ghi chú Block-based với thư
  viện BlockNote.
- Luồng tương tác cộng tác: Cơ chế đồng bộ dữ liệu khi nhiều người cùng làm việc
  trên một tài liệu _(CRDT)_ và không gian làm việc.

/ CRDT: Conflict-free Replicated Data Type, cấu trúc dữ liệu cho phép hợp nhất
  tự động các thay đổi từ nhiều người dùng mà không gây xung đột, phù hợp cho
  ứng dụng cộng tác thời gian thực.

==== Đối tượng nghiên cứu về mặt kỹ thuật

- _Kiến trúc hệ thống_: Áp dụng Microservices kết hợp Clean Architecture, Domain
  Driven Design, Event Driven Architecture cho domain phức tạp, đảm bảo tính mở
  rộng.
- _Cơ chế liên kết và truy vấn dữ liệu_: Cách thức triển khai liên kết hai chiều
  và truy vấn quan hệ giữa các ghi chú để tạo Graph View.
- _Giao thức kết nối_: Sử dụng Rest API để giao tiếp giữa Web App với API
  service, SSE để cập nhật thông tin thời gian thực #footnote[Thông tin theo
    thời gian thực sử dụng SSE bao gồm các sự kiện thay đổi tổng quát trong
    không gian làm việc _("metadata")_, khác với CRDT dùng để đồng bộ nội dung
    ghi chú theo thời gian thực], và gRPC để giao tiếp giữa các service trong hệ
  thống.
- _Công nghệ tìm kiếm_: Cách tích hợp Full-text search để hỗ trợ người dùng truy
  xuất thông tin.
- _Hạ tầng và vận hành_: Nghiên cứu việc triển khai hệ thống với Docker, quản lý
  định danh, phân quyền, giám sát hệ thống _(Observation)_.

/ SSE: Server-Sent Events, công nghệ cho phép máy chủ gửi dữ liệu thời gian thực
  đến trình duyệt mà không cần WebSocket phức tạp.

=== Phạm vi nghiên cứu

#heading(level: 3, numbering: none, outlined: false)[
  Định danh người dùng _(Identity)_
]

Sử dụng dịch vụ thứ bên thứ 3 để quản lý đăng ký, đăng nhập, thông qua
OAuth2/OpenID Connect, đảm bảo an toàn và dễ dàng tích hợp với các dịch vụ khác
trong hệ thống.

#heading(level: 3, numbering: none, outlined: false)[
  Ghi chú _(Note)_
]

Quản lý không gian làm việc, sắp xếp các ghi chú theo cấu trúc thư mục, biểu
diễn quan hệ giữa các ghi chú, hỗ trợ cộng tác theo thời gian thực ở góc độ lưu
trữ và tổ chức thông tin.

#heading(level: 3, numbering: none, outlined: false)[
  Tài liệu _(Document)_
]

Nội dung ghi chú được lưu trữ dưới dạng tài liệu Block-based (BlockNote), cho
phép trình bày và chỉnh sửa linh hoạt, đồng thời hỗ trợ cộng tác thời gian thực.
Tệp tin đính kèm được lưu qua Object Storage.

#heading(level: 3, numbering: none, outlined: false)[
  Phân quyền _(Authorization)_
]

Quản lý quyền truy cập vào không gian làm việc. Không gian làm việc có thể chia
sẻ với nhiều người dùng với quyền hạn khác nhau, đảm bảo an toàn và kiểm soát
truy cập.

#heading(level: 3, numbering: none, outlined: false)[
  Tìm kiếm _(Search)_
]

Lắng nghe và đồng bộ nội dung ghi chú khi thay đổi đến dịch vụ tìm kiếm bên thứ
ba.

#heading(level: 3, numbering: none, outlined: false)[
  Hạ tầng _(Infrastructure)_
]

- Thiết kế kiến trúc hệ thống theo mô hình Microservices, giao tiếp nội bộ qua
  gRPC và message broker cho tác vụ bất đồng bộ.
- Triển khai quy trình CI/CD, đóng gói ứng dụng vào container.
- API được thiết kế đứng sau một API Gateway.
- Xây dựng hệ thống giám sát để theo dõi vết _(tracing)_, chỉ số đo lường
  _(metric)_ và nhật ký hệ thống _(logging)_ trong môi trường phân tán.

== Phương pháp nghiên cứu

Dự án áp dụng phương pháp tiếp cận kỹ thuật hệ thống, kết hợp nghiên cứu lý
thuyết quản lý tri thức và triển khai thực nghiệm công nghệ phần mềm.

#heading(level: 3, numbering: none, outlined: false)[
  Phương pháp thu thập và phân tích yêu cầu
]

Khảo sát các ứng dụng quản lý ghi chú hiện có _(Notion, Obsidian,
`jackyzha0/quartz`)_ để rút ra các tính năng cần thiết.

#heading(level: 3, numbering: none, outlined: false)[
  Phương pháp thiết kế và mô hình hoá hệ thống
]

Sử dụng UML cho sơ đồ lớp _(class diagram)_ và sơ đồ tuần tự _(sequence
diagram)_. Dùng D2 cho sơ đồ triển khai _(deployment diagram)_ và cơ sở dữ liệu
quan hệ. Trong đó:
- Đối với sơ đồ tuần tự, chỉ đặc tả các use case quan trọng để làm rõ luồng
  tương tác giữa các thành phần chính của hệ thống.
- Đối với class diagram, chỉ tập trung vào các lớp cốt lõi liên quan đến nghiệp
  vụ chính của hệ thống, tránh mô hình hoá chi tiết quá mức làm rối sơ đồ.

#heading(level: 3, numbering: none, outlined: false)[
  Phương pháp phát triển API
]

Thiết kế API theo chuẩn RESTful, sử dụng OpenAPI 3.0 để mô tả API giữa Web App
và API service, Protocol Buffers 3 cho giao tiếp giữa các service nội bộ. Áp
dụng hướng tiếp cận "Contract First", đảm bảo tính nhất quán từ giai đoạn thiết
kế đến triển khai.

Nhờ đặc tả này, có thể tự động sinh mã nguồn client và server, giảm lỗi và tăng
tốc phát triển.

== Chức năng

Notopia là nền tảng quản lý tri thức cá nhân, hỗ trợ người dùng tổ chức, kết nối
và trực quan hóa kiến thức trên web với khả năng cộng tác thời gian thực. Các
nhóm chức năng chính bao gồm:

#heading(level: 4, numbering: none)[
  Tạo và quản lý không gian làm việc
]

Người dùng có thể tạo các không gian làm việc riêng biệt, chia sẻ và quản lý
quyền truy cập linh hoạt. Mỗi không gian là vùng lưu trữ độc lập cho ghi chú và
dự án.

#heading(level: 4, numbering: none)[
  Tổ chức ghi chú theo cấu trúc thư mục
]

Người dùng sắp xếp ghi chú thành thư mục lồng nhau, tạo cấu trúc dữ liệu rõ
ràng, giúp quản lý số lượng lớn ghi chú hiệu quả.

#heading(level: 4, numbering: none)[
  Tạo các liên kết hai chiều giữa ghi chú
]

Người dùng liên kết ghi chú qua cơ chế liên kết hai chiều, tạo mạng lưới tri
thức động. Hệ thống tự động ghi nhận backlink, giúp hiểu rõ mối quan hệ giữa các
ý tưởng.

#heading(level: 4, numbering: none)[
  Soạn thảo nội dung dạng block-based
]

Nội dung ghi chú được tổ chức thành các khối độc lập, cho phép linh hoạt xây
dựng và chỉnh sửa tài liệu. Mỗi khối có thể là văn bản, hình ảnh, mã code hoặc
loại nội dung khác.

#heading(level: 4, numbering: none)[
  Cộng tác theo thời gian thực
]

Nhiều người dùng có thể làm việc đồng thời trên cùng ghi chú. Hệ thống đồng bộ
thay đổi tức thời và giải quyết xung đột tự động.

#heading(level: 4, numbering: none)[
  Trực quan hóa mối quan hệ bằng biểu đồ quan hệ
]

Người dùng xem mạng lưới tri thức dưới dạng biểu đồ quan hệ _(Graph View)_, hiển
thị liên kết và mối quan hệ giữa các ghi chú, trực quan hơn cách tổ chức tuyến
tính truyền thống.

#heading(level: 4, numbering: none)[
  Tìm kiếm nhanh chóng
]

Hệ thống hỗ trợ tìm kiếm toàn văn trên mọi nội dung ghi chú, giúp người dùng
nhanh chóng tìm ra thông tin cần thiết.

#heading(level: 4, numbering: none)[
  Quản lý quyền truy cập và phân quyền
]

Chủ sở hữu không gian làm việc quản lý quyền từng thành viên (xem, chỉnh sửa,
xóa) với nhiều cấp độ quyền, đảm bảo an toàn và kiểm soát truy cập.

#heading(level: 4, numbering: none)[
  Quản lý vòng đời tài liệu
]

Ghi chú có thể xóa tạm thời (vào thùng rác) hoặc xóa vĩnh viễn. Người dùng có
thể khôi phục ghi chú đã xóa tạm thời, tránh mất dữ liệu.

== Công nghệ sử dụng

Notopia ứng dụng bộ công nghệ được lựa chọn kỹ lưỡng, đảm bảo mở rộng, hiệu suất
cao và bảo trì dài hạn.

#heading(level: 4, numbering: none)[
  Web App
]

- Framework: Next.js (React), cung cấp server-side rendering và tối ưu hiệu
  suất.
- State Management: Redux Toolkit với DevTools và middleware mạnh mẽ.
- Styling: TailwindCSS, PostCSS và ShadcnUI.
- Editor Content: BlockNote (block-based, trên Tiptap) với tùy chỉnh cao.

#heading(level: 4, numbering: none)[
  Backend
]

- Identity service _(Authentik)_: Identity provider mã nguồn mở hỗ trợ
  OAuth2/OIDC.
- `document` service: NestJS (TypeScript), kiến trúc mô-đun, build với Rspack.
- `notes` service: Go với SQLC cho raw SQL tối ưu, phù hợp truy vấn đồ thị phức
  tạp.
- `authorization` service: Go với Casbin (RBAC) cho quản lý quyền linh hoạt.
- `search-worker`: NestJS lắng nghe thay đổi dữ liệu và đồng bộ với Meilisearch.
- Search Service _(Meilisearch)_: Search engine mã nguồn mở (Rust), tìm kiếm
  toàn văn nhanh và dễ triển khai.

#heading(level: 4, numbering: none)[
  Cơ sở dữ liệu
]

- PostgreSQL: Hệ quản trị cơ sở dữ liệu quan hệ mạnh mẽ, tuân thủ ACID
  transactions và hỗ trợ các tính năng nâng cao.
- ORM/Query Builder/Query codegen: TypeORM cho NestJS service, SQLC cho Go
  service để tối ưu hiệu suất.

#heading(level: 4, numbering: none)[
  Cộng tác theo thời gian thực
]

- yjs: Thư viện CRDT cho phép hợp nhất tự động các thay đổi từ nhiều người dùng
  mà không gây xung đột.
- Hocuspocus: Máy chủ WebSocket cho Yjs, abstract hóa yjs nên không cần quan tâm
  chi tiết triển khai.

#heading(level: 4, numbering: none)[
  Giao tiếp API
]

- REST API: Thiết kế theo OpenAPI 3.0 cho giao tiếp frontend-backend.
- gRPC: Framework RPC sử dụng Protocol Buffers, cung cấp hiệu suất cao cho giao
  tiếp giữa các dịch vụ nội bộ.

Bên cạnh đó, các dịch vụ không hỗ trợ gRPC có SDK hoặc REST API _(ví dụ
Authentik có SDK cho Go và NodeJS)_.

#heading(level: 4, numbering: none)[
  Kiến trúc sự kiện
]

- Watermill: Thư viện Go cho event-driven architecture, hỗ trợ nhiều message
  broker khác nhau.
- Redpanda: Message broker tương thích với Kafka, được sử dụng cho streaming sự
  kiện phân tán.

NestJS hỗ trợ sẵn event-driven architecture, không cần thư viện ngoài.

#heading(level: 4, numbering: none)[
  Giám sát
]

- OpenTelemetry: Tiêu chuẩn mã nguồn mở cho metrics, logs và traces.
- Grafana Stack: Prometheus (metrics), Loki (logs), Tempo (distributed tracing),
  Grafana (visualization). Alloy agent cho forwarding logs và metrics.

#heading(level: 4, numbering: none)[
  Hạ tầng
]

- Docker: Đóng gói ứng dụng, đảm bảo nhất quán giữa các môi trường.
- Traefik: API Gateway với routing, load balancing và auto-discovery.
- RustFS: Object storage mã nguồn mở cho tệp đính kèm trong ghi chú.
