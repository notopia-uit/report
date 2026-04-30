== Sơ đồ lớp (Class Diagram)

Dưới đây là sơ đồ lớp cho các service trong hệ thống, bao gồm `note` service và
`document` service, không bao gồm `authorization` service vì tính đặc thù của
service không thể biểu diễn một cách dễ dàng, và `search-worker` vì xử lý dữ
liệu không phức tạp. Sơ đồ lớp giúp minh họa cấu trúc của các lớp, các thuộc
tính và phương thức của chúng, cũng như mối quan hệ giữa các lớp.

=== Sơ đồ lớp cho note service

Sơ đồ lớp cho `note` service được chia thành hai phần: tầng application và tầng
domain. Tầng application tập trung vào các lớp mô hình dữ liệu và interface của
service, trong khi tầng domain tập trung vào các lớp đại diện cho các aggregate
và logic nghiệp vụ.

==== Sơ đồ lớp tầng application

#figure(
  image("../assets/sync-diagrams/class-diagram-note-application.svg"),
  caption: [Sơ đồ lớp tầng application cho `note` service],
)

Tầng application bao gồm các lớp mô hình dữ liệu _(model)_ cho việc read _(theo
CQRS)_ và các interface của service. Các lớp mô hình dữ liệu đại diện cho các
thực thể trong hệ thống như `Note`, `Folder`, `Workspace`, v.v. Các interface
của service định nghĩa các phương thức mà tầng infrastructure sẽ triển khai.

==== Sơ đồ lớp tầng domain

#figure(
  image("../assets/sync-diagrams/class-diagram-note-domain.svg"),
  caption: [Sơ đồ lớp tầng domain cho `note` service],
)

Tầng domain, áp dụng Domain Driven Design Pattern, bao gồm các lớp đại diện cho
các aggregate như `Note`, `Folder`, `Workspace`, v.v. Các lớp này chứa các thuộc
tính và phương thức liên quan đến logic nghiệp vụ của chúng. Ngoài ra, tầng
domain cũng bao gồm các interface của repository để truy cập dữ liệu. Tuy nhiên,
tầng domain không được trực tiếp gọi service được định nghĩa hay repository
interface được khai báo.

=== Sơ đồ lớp cho document service

#figure(
  image("../assets/sync-diagrams/class-diagram-document.svg"),
  caption: [Sơ đồ lớp cho `document` service],
)

Sơ đồ tinh gọn cho `document` service, bao gồm các thực thể, services, và đối
tượng liên quan. Ở thiết kế này không bao gồm repository vì đã được TypeORM
abstract đi, tức, service sẽ trực tiếp gọi các phương thức của TypeORM để truy
cập dữ liệu.
