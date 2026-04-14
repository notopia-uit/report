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
hiện đại hỗ trợ liên kết hai chiều #footnote[khái niệm từ Obsidian bao gồm
  outgoing link - liên kế từ một đối tượng này đến các đối tượng khác, và
  backlink - liên kết từ các đối tượng khác ngược lại đến đối tượng này
], kết hợp trực quan hóa kiến thức thành biểu đồ quan hệ.

== Mục đích và mục tiêu nghiên cứu

=== Mục đích nghiên cứu

Giúp người dùng quản lý tri thức cá nhân trên nền tảng web, trực quan hoá bằng
biểu đồ quan hệ _(Graph View)_, cộng tác _(collaborate)_ theo thời gian thực.
Ứng dụng đảm bảo tối thiểu các chức năng của một trình quản lý ghi chú bao gồm
tạo, sửa, xoá tạm thời, xoá vĩnh viễn, khôi phục ghi chú, tìm kiếm toàn văn.

=== Mục tiêu nghiên cứu

- Nghiên cứu các phương pháp tổ chức ghi chú dạng cấu trúc thư mục
- Nghiên cứu cách thức liên kết các ghi chú với nhau để tạo thành mạng lưới tri
  thức
- Tích hợp công nghệ hỗ trợ viết nội dung ghi chú _(sử dụng thư viện ngoài để xử
  lý các tác vụ, format)_ với cách quản lý các đối tượng trong hệ thống
- Nghiên cứu cách triển khai cộng tác theo thời gian thực
- Trực quan hoá các ghi chú bằng biểu đồ quan hệ
- Định danh, phân quyền người dùng đối với không gian làm việc
- Thiết kế kiến trúc hệ thống dễ mở rộng, bảo trì và có hiệu suất cao

== Đối tượng và phạm vi nghiên cứu

=== Đối tượng nghiên cứu

==== Đối tượng nghiên cứu về mặt nghiệp vụ

- Hệ thống quản lý tri thức cá nhân (Personal Knowledge Management - PKM):
  Nghiên cứu các mô hình lưu trữ thông tin, đặc biệt là cách thức kết nối các ý
  tưởng rời rạc thành một mạng lưới tri thức
- Cấu trúc dữ liệu ghi chú: Loại định dạng nội dung ghi chú Block-based với thư
  viện BlockNote
- Luồng tương tác cộng tác: Nghiên cứu các cơ chế đồng bộ dữ liệu khi nhiều
  người cùng làm việc trên một tài liệu _(kiểu dữ liệu CRDT)_ và không gian làm
  việc

==== Đối tượng nghiên cứu về mặt kỹ thuật

- Kiến trúc hệ thống: Nghiên cứu và áp dụng kiến trúc Microservices kết hợp với
  Clean Architecture đối với domain phức tạp để đảm bảo tính mở rộng
- Cơ chế liên kết và truy vấn dữ liệu: Cách thức triển khai liên kết hai chiều
  và truy vấn quan hệ giữa các ghi chú để tạo Graph View
- Giao thức kết nối: Sử dụng Rest API để giao tiếp giữa Web App với API service,
  SSE để cập nhật dữ liệu thời gian thực, và gRPC để giao tiếp giữa các service
  trong hệ thống
- Công nghệ tìm kiếm và xử lý ngôn ngữ: Cách tích hợp tìm kiếm toàn văn
  _(Full-text search)_ để hỗ trợ người dùng truy xuất thông tin
- Hạ tầng và vận hành: Nghiên cứu việc triển khai hệ thống với Docker, quản lý
  định danh, phân quyền, giám sát hệ thống _(Observability)_

/ SSE: Server-Sent Events, một công nghệ cho phép máy chủ gửi dữ liệu thời gian
  thực đến trình duyệt mà không cần thiết lập kết nối WebSocket phức tạp. Đây là
  một giải pháp nhẹ nhàng để cập nhật dữ liệu liên tục.

=== Phạm vi nghiên cứu

==== Định danh người dùng _(Authentication)_

Sử dụng Authentik để quản lý đăng ký, đăng nhập, thông qua OAuth2 và OpenID
Connect, đảm bảo an toàn và dễ dàng tích hợp với các dịch vụ khác trong hệ
thống.

==== Ghi chú _(Note)_

Quản lý không gian làm việc (Workspace), sắp xếp các ghi chú theo cấu trúc thư
mục, biểu diễn quan hệ giữa các ghi chú, hỗ trợ cộng tác theo thời gian thực ở
góc độ lưu trữ và tổ chức thông tin.

Đây là phạm vi cốt lõi của hệ thống, tập trung vào việc tổ chức và lưu trữ thông
tin một cách hiệu quả.

==== Tài liệu _(Document)_

Nội dung của ghi chú được lưu trữ dưới dạng tài liệu, sử dụng định dạng
Block-based bởi thư viện BlockNote, cho phép linh hoạt trong việc trình bày và
chỉnh sửa nội dung. Đồng thời, hỗ trợ cộng tác theo thời gian thực trên tài
liệu.

Các tệp tin đính kèm trong ghi chú thông qua giải pháp lưu trữ đối tượng (Object
Storage).

==== Phân quyền _(Authorization)_

Quản lý quyền truy cập vào không gian làm việc. Không gian làm việc có thể được
chia sẻ với nhiều người dùng, mỗi người có quyền hạn khác nhau, đảm bảo an toàn
và kiểm soát truy cập hiệu quả.

==== Tìm kiếm _(Search)_

Lắng nghe và cập nhật nội dung ghi chú khi thay đổi, cập nhật vào dịch vụ tìm
kiếm (Meilisearch).

==== Hạ tầng _(Infrastructure)_

Thiết kế kiến trúc hệ thống theo mô hình Microservices, giao tiếp nội bộ qua
gRPC để tối ưu hiệu suất và message broker cho các tác vụ bất đồng bộ.

Triển khai quy trình CI/CD, đóng gói ứng dụng với Docker.

API được thiết kế đứng sau một API Gateway.

Xây dựng hệ thống giám sát để theo dõi vết _(tracing)_, chỉ số đo lường
_(metric)_ và nhật ký hệ thống _(logging)_ trong môi trường phân tán.

== Phương pháp nghiên cứu

Dự án áp dụng phương pháp tiếp cận kỹ thuật hệ thống, kết hợp giữa nghiên cứu lý
thuyết về quản lý tri thức và triển khai thực nghiệm các công nghệ phần mềm tiên
tiến.

=== Phương pháp thu thập và phân tích yêu cầu

Khảo sát các ứng dụng quản lý ghi chú hiện có (Notion, Obsidian) để rút ra các
tính năng cần thiết.

== Chức năng

=== Các đặc điểm chính

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    align: (x, y) => (center, center, center).at(x),
    [*Tính năng*], [*Mô tả*], [*Ưu điểm*],
    [Ghi chú nhanh], [Ghi âm hoặc gõ chữ], [Tiết kiệm thời gian],
    [Tìm kiếm toàn văn], [Tìm kiếm nhanh], [Dễ tìm thông tin],
    [Đồng bộ hóa], [Đồng bộ trên nhiều thiết bị], [Truy cập mọi lúc],
  ),
  caption: [Bảng so sánh các tính năng chính của hệ thống],
)

== Công nghệ sử dụng
