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
Obsidian, chúng em quyết định thực hiện đề tài xây dựng một nền tảng ghi chú
hiện đại hỗ trợ liên kết hai chiều #footnote[Liên hai chiều là khái niệm từ
  Obsidian, bao gồm outgoing link - liên kế từ một đối tượng này đến các đối
  tượng khác, và backlink - liên kết từ các đối tượng khác ngược lại đến đối
  tượng này
], kết hợp trực quan hóa kiến thức thành biểu đồ quan hệ.

== Mục đích và mục tiêu nghiên cứu

=== Mục đích nghiên cứu

Giúp người dùng quản lý tri thức cá nhân trên nền tảng web, trực quan hoá bằng
biểu đồ quan hệ _(Graph View)_, cộng tác _(collaborate)_ theo thời gian thực.
Ứng dụng đảm bảo tối thiểu các chức năng của một trình quản lý ghi chú _(note)_
bao gồm tạo, sửa, xoá tạm thời, xoá vĩnh viễn, khôi phục ghi chú, tìm kiếm toàn
văn _(full-text search)_, phân quyền truy cập vào không gian làm việc
_(workspace)_.

=== Mục tiêu nghiên cứu

- Nghiên cứu các phương pháp tổ chức ghi chú dạng cấu trúc thư mục.
- Nghiên cứu cách thức liên kết các ghi chú với nhau để tạo thành mạng lưới tri
  thức.
- Tích hợp công nghệ hỗ trợ viết nội dung ghi chú _(sử dụng thư viện thứ ba để
  xử lý các tác vụ liên quan đến định dạng nội dung)_ với cách quản lý các đối
  tượng trong hệ thống.
- Nghiên cứu cách triển khai cộng tác theo thời gian thực.
- Định danh, phân quyền người dùng đối với không gian làm việc.
- Thiết kế kiến trúc hệ thống dễ mở rộng, bảo trì và có hiệu suất cao.

== Đối tượng và phạm vi nghiên cứu

=== Đối tượng nghiên cứu

==== Đối tượng nghiên cứu về mặt nghiệp vụ

- Hệ thống quản lý tri thức cá nhân _(Personal Knowledge Management - PKM)_:
  Nghiên cứu các mô hình lưu trữ thông tin, đặc biệt là cách thức kết nối các ý
  tưởng rời rạc thành một mạng lưới tri thức.
- Cấu trúc dữ liệu ghi chú: Loại định dạng nội dung ghi chú Block-based với thư
  viện BlockNote.
- Luồng tương tác cộng tác: Nghiên cứu các cơ chế đồng bộ dữ liệu khi nhiều
  người cùng làm việc trên một tài liệu _(kiểu dữ liệu CRDT)_ và không gian làm
  việc.

/ CRDT: Conflict-free Replicated Data Type, một loại cấu trúc dữ liệu cho phép
  hợp nhất tự động các thay đổi từ nhiều người dùng mà không gây xung đột, rất
  phù hợp cho các ứng dụng cộng tác theo thời gian thực.

==== Đối tượng nghiên cứu về mặt kỹ thuật

- _Kiến trúc hệ thống_: Nghiên cứu và áp dụng kiến trúc Microservices kết hợp
  với Clean Architecture, Domain Driven Design, Event Driven Architecture đối
  với domain phức tạp để đảm bảo tính mở rộng.
- _Cơ chế liên kết và truy vấn dữ liệu_: Cách thức triển khai liên kết hai chiều
  và truy vấn quan hệ giữa các ghi chú để tạo Graph View.
- _Giao thức kết nối_: Sử dụng Rest API để giao tiếp giữa Web App với API
  service, SSE để cập nhật thông tin thời gian thực #footnote[Thông tin theo
    thời gian thực sử dụng SSE bao gồm các sự kiện thay đổi mang tính chất tổng
    quát trong không gian làm việc _("metadata" thay đổi)_, khác với hệ thống hỗ
    trợ cộng tác sử đổi nội dung ghi chú theo thời gian thực sử dụng CRDT], và
  gRPC để giao tiếp giữa các service trong hệ thống.
- _Công nghệ tìm kiếm_: Cách tích hợp Full-text search để hỗ trợ người dùng truy
  xuất thông tin.
- _Hạ tầng và vận hành_: Nghiên cứu việc triển khai hệ thống với Docker, quản lý
  định danh, phân quyền, giám sát hệ thống _(Observation)_.

/ SSE: Server-Sent Events, một công nghệ cho phép máy chủ gửi dữ liệu thời gian
  thực đến trình duyệt mà không cần thiết lập kết nối WebSocket phức tạp. Đây là
  một giải pháp nhẹ nhàng để cập nhật dữ liệu liên tục.

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

Đây là phạm vi cốt lõi của hệ thống, tập trung vào việc tổ chức và lưu trữ thông
tin một cách hiệu quả.

#heading(level: 3, numbering: none, outlined: false)[
  Tài liệu _(Document)_
]

Nội dung của ghi chú được lưu trữ dưới dạng tài liệu, sử dụng định dạng
Block-based bởi thư viện BlockNote, cho phép linh hoạt trong việc trình bày và
chỉnh sửa nội dung. Đồng thời, hỗ trợ cộng tác theo thời gian thực trên tài
liệu. Các tệp tin đính kèm trong ghi chú thông qua giải pháp lưu trữ đối tượng
_(Object Storage)_.

#heading(level: 3, numbering: none, outlined: false)[
  Phân quyền _(Authorization)_
]

Quản lý quyền truy cập vào không gian làm việc. Không gian làm việc có thể được
chia sẻ với nhiều người dùng, mỗi người có quyền hạn khác nhau, đảm bảo an toàn
và kiểm soát truy cập hiệu quả.

#heading(level: 3, numbering: none, outlined: false)[
  Tìm kiếm _(Search)_
]

Lắng nghe và cập nhật nội dung ghi chú khi thay đổi thông qua một "worker", cập
nhật vào dịch vụ tìm kiếm bên thứ ba.

#heading(level: 3, numbering: none, outlined: false)[
  Hạ tầng _(Infrastructure)_
]

- Thiết kế kiến trúc hệ thống theo mô hình Microservices, giao tiếp nội bộ để
  tối ưu hiệu suất và message broker cho các tác vụ bất đồng bộ.
- Triển khai quy trình CI/CD, đóng gói ứng dụng vào container.
- API được thiết kế đứng sau một API Gateway.
- Xây dựng hệ thống giám sát để theo dõi vết _(tracing)_, chỉ số đo lường
  _(metric)_ và nhật ký hệ thống _(logging)_ trong môi trường phân tán.

== Phương pháp nghiên cứu

Dự án áp dụng phương pháp tiếp cận kỹ thuật hệ thống, kết hợp giữa nghiên cứu lý
thuyết về quản lý tri thức và triển khai thực nghiệm các công nghệ phần mềm tiên
tiến.

#heading(level: 3, numbering: none, outlined: false)[
  Phương pháp thu thập và phân tích yêu cầu
]

Khảo sát các ứng dụng quản lý ghi chú hiện có _(Notion, Obsidian,
`jackyzha0/quartz`)_ để rút ra các tính năng cần thiết.

#heading(level: 3, numbering: none, outlined: false)[
  Phương pháp thiết kế và mô hình hoá hệ thống
]

Sử dụng UML để mô hình hoá kiến trúc hệ thống, bao gồm sơ đồ lớp _(class
diagram)_, sơ đồ tuần tự _(sequence diagram)_. Sử dụng D2 để mô hình hoá sơ đồ
triển khai _(deployment diagram)_, cơ sở dữ liệu quan hệ. Trong đó:
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

Nhờ vào việc đặc tả này, chúng ta có thể tự động sinh mã nguồn cho client và
server, giảm thiểu lỗi và tăng tốc độ phát triển.

== Chức năng

Hệ thống Notopia được xây dựng như một nền tảng quản lý tri thức cá nhân, hỗ trợ
người dùng tổ chức, kết nối và trực quan hóa kiến thức trên môi trường web hợp
tác theo thời gian thực. Các nhóm chức năng chính bao gồm:

#heading(level: 4, numbering: none)[
  Tạo và quản lý không gian làm việc
]

Người dùng có thể tạo các không gian làm việc riêng biệt, chia sẻ với người khác
và quản lý quyền truy cập một cách linh hoạt. Mỗi không gian làm việc hoạt động
như một vùng lưu trữ độc lập cho các ghi chú và dự án của người dùng.

#heading(level: 4, numbering: none)[
  Tổ chức ghi chú theo cấu trúc thư mục
]

Hệ thống cho phép người dùng sắp xếp ghi chú thành các thư mục lồng nhau, tạo
thành một cấu trúc dữ liệu rõ ràng. Cách tổ chức này giúp người dùng quản lý số
lượng lớn ghi chú một cách hiệu quả.

#heading(level: 4, numbering: none)[
  Tạo các liên kết hai chiều giữa ghi chú
]

Người dùng có thể liên kết các ghi chú với nhau thông qua cơ chế liên kết hai
chiều, tạo thành một mạng lưới tri thức động. Hệ thống tự động ghi nhận các liên
kết ngược, giúp hiểu rõ mối quan hệ giữa các ý tưởng.

#heading(level: 4, numbering: none)[
  Soạn thảo nội dung dạng block-based
]

Nội dung ghi chú được tổ chức thành các khối độc lập, cho phép người dùng linh
hoạt trong việc xây dựng và chỉnh sửa tài liệu. Mỗi khối có thể là văn bản, hình
ảnh, mã code hoặc các loại nội dung khác.

#heading(level: 4, numbering: none)[
  Cộng tác theo thời gian thực
]

Nhiều người dùng có thể làm việc cùng một ghi chú hoặc tài liệu một cách đồng
thời. Hệ thống đảm bảo các thay đổi được đồng bộ hóa tức thời và các xung đột
được giải quyết tự động mà không cần can thiệp thủ công.

#heading(level: 4, numbering: none)[
  Trực quan hóa mối quan hệ bằng biểu đồ quan hệ
]

Người dùng có thể xem toàn bộ mạng lưới tri thức của mình dưới dạng biểu đồ quan
hệ _(Graph View)_, giúp hiển thị các liên kết và mối quan hệ giữa các ghi chú.
Biểu diễn này cung cấp một cái nhìn trực quan hơn so với cách tổ chức tuyến tính
truyền thống.

#heading(level: 4, numbering: none)[
  Tìm kiếm nhanh chóng
]

Hệ thống hỗ trợ tìm kiếm toàn văn trên tất cả nội dung ghi chú, cho phép người
dùng nhanh chóng tìm ra thông tin cần thiết.

#heading(level: 4, numbering: none)[
  Quản lý quyền truy cập và phân quyền
]

Chủ sở hữu không gian làm việc có thể quản lý chi tiết quyền của từng thành
viên, chẳng hạn như quyền xem, chỉnh sửa hoặc xóa. Hệ thống hỗ trợ các cấp độ
quyền khác nhau để đảm bảo an toàn và kiểm soát truy cập hiệu quả.

#heading(level: 4, numbering: none)[
  Quản lý vòng đời tài liệu
]

Ghi chú có thể được xóa tạm thời, di chuyển vào thùng rác hoặc xóa vĩnh viễn.
Người dùng cũng có khả năng khôi phục ghi chú đã xóa tạm thời, giúp tránh mất dữ
liệu không mong muốn.

== Công nghệ sử dụng

Dự án Notopia ứng dụng một bộ công nghệ tiên tiến và được lựa chọn kỹ lưỡng, đảm
bảo tính mở rộng, hiệu suất cao và khả năng bảo trì dài hạn.

#heading(level: 4, numbering: none)[
  Web App
]

- Framework: Next.js, được xây dựng trên nền tảng React, cung cấp server-side
  rendering và tối ưu hóa hiệu suất.
- State Management: Redux Toolkit, một thư viện quản lý trạng thái với DevTools
  integration và middleware support mạnh mẽ.
- Styling: TailwindCSS kết hợp với PostCSS cho phát triển giao diện nhanh chóng,
  và ShadcnUI cung cấp các component có sẵn được styled phù hợp.
- Editor Content: BlockNote, một editor block-based được xây dựng trên Tiptap,
  hỗ trợ tùy chỉnh cao và tích hợp dễ dàng với React.

#heading(level: 4, numbering: none)[
  Backend
]

- Identity service _(Authentik)_: Một nền tảng identity provider mã nguồn mở hỗ
  trợ OAuth2/OIDC, đảm bảo an toàn trong quản lý danh tính người dùng.
- `document` service: Viết bằng Typescript sử dụng framework NestJS, với kiến
  trúc mô-đun rõ ràng và Dependency Injection mạnh mẽ, được xây dựng với Rspack
  để tối ưu hiệu suất build.
- `notes` service: Viết bằng Go, một ngôn ngữ lập trình hiệu suất cao, được sử
  dụng với SQLC cho xử lý raw SQL tối ưu, đảm bảo truy vấn nhanh chóng đặc biệt
  cho các truy vấn đồ thị phức tạp.
- `authorization` service: Viết bằng Go, sử dụng thư viện Casbin, một framework
  authorization mã nguồn mở hỗ trợ RBAC cho phép quản lý quyền truy cập linh
  hoạt.
- `search-worker` worker: Viết bằng NestJS lắng nghe sự thay đổi dữ liệu, xử lý
  và đồng bộ nội dung với Meilisearch.
- Search Service _(Meilisearch)_: Search engine mã nguồn mở được viết bằng Rust,
  cung cấp tìm kiếm toàn văn nhanh chóng và dễ triển khai.

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
- Hocuspocus: Máy chủ WebSocket hỗ trợ Yjs, tạo điều kiện cho đồng bộ hóa dữ
  liệu thời gian thực. Hocuspocus sẽ abstract yjs nên không cần quan tâm đến chi
  tiết triển khai của yjs.

#heading(level: 4, numbering: none)[
  Giao tiếp API
]

- REST API: Được thiết kế theo OpenAPI 3.0 cho giao tiếp giữa frontend và các
  dịch vụ backend.
- gRPC: Framework RPC sử dụng Protocol Buffers, cung cấp hiệu suất cao cho giao
  tiếp giữa các dịch vụ nội bộ.

Bên cạnh đó, các dịch vụ không thể giao tiếp qua gRPC, nhưng có SDK, hoặc có thể
giao tiếp qua REST API _(ví dụ như Authentik hỗ trợ SDK cho Go và NodeJS)_.

#heading(level: 4, numbering: none)[
  Kiến trúc sự kiện
]

- Watermill: Thư viện Go cho event-driven architecture, hỗ trợ nhiều message
  broker khác nhau.
- Redpanda: Message broker tương thích với Kafka, được sử dụng cho streaming sự
  kiện phân tán.

Đối với NestJS đã hỗ trợ sẵn event-driven architecture, không cần sử dụng thêm
thư viện bên ngoài hệ sinh thái NestJS.

#heading(level: 4, numbering: none)[
  Giám sát
]

- OpenTelemetry: Một tiêu chuẩn mã nguồn mở cho việc thu thập metrics, logs và
  traces.
- Grafana Stack: Bao gồm Prometheus cho metrics, Loki cho logs, Tempo cho
  distributed tracing, và Grafana cho visualization tập trung. Alloy, một agent
  của Grafana cho forwarding logs và metrics.

#heading(level: 4, numbering: none)[
  Hạ tầng
]

- Docker: Đóng gói ứng dụng vào container, đảm bảo tính nhất quán giữa các môi
  trường phát triển.
- Traefik: API Gateway hiện đại hỗ trợ routing, load balancing và
  auto-discovery, đứng phía trước các dịch vụ backend và Web App.
- RustFS: Giải pháp lưu trữ đối tượng mã nguồn mở, được sử dụng để lưu trữ các
  tệp đính kèm trong ghi chú.
