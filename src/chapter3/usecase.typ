#import "../lib/usecase.typ": usecase, usecase-figure

== Mô tả các Use Case

Nhóm chỉ xác định một vài use case phức tạp, có nhiều luồng, tác động đến nhiều
dịch vụ.

=== Mô tả use case Create Note

#figure(
  image("../assets/diagrams/create-note-seq.svg"),
  caption: [Sequence diagram mô tả create note use case],
)

#usecase-figure(
  usecase(
    id: [UC01],
    name: [Create Note],
    description: [Use case này mô tả quy trình tạo ghi chú mới],
    actors: [User],
    priority: [Cao],
    trigger: [Người dùng muốn tạo một ghi chú mới],
    pre-conditions: [
      - Người dùng sử dụng thiết bị có kết nối internet
      - Người dùng đã đăng nhập vào hệ thống
      - Người dùng có quyền tạo ghi chú trong không gian làm việc hiện tại
    ],
    post-conditions: [
      - Người dùng tạo ghi chú thành công
    ],
    basic-flow: [
      + Người dùng truy cập vào hệ thống
      + Người dùng chọn nút "Tạo ghi chú mới" được hiển thị
      + Người dùng nhập vào các trường thông tin của ghi chú _(tiêu đề, v.v...)_
      + Hệ thống kiểm tra quyền của người dùng để tạo ghi chú
      + Hệ thống tạo ghi chú mới và trả về ID của ghi chú
      + Hệ thống publish domain event `NoteCreatedEvent` tới Message Broker
      + Hệ thống chuyển đổi domain event thành workspace event và publish
      + Hệ thống publish integration event `NoteCreatedEvent` tới Message Broker
      + `search-worker` nhận integration event và xử lý
      + `search-worker` gửi yêu cầu Index Note đến Search service
      + Search service nhận yêu cầu Index Note và tiến hành indexing ghi chú mới
    ],
    alternate-flow: [
      + Bước 6: Hệ thống gặp lỗi khi gửi domain event `NoteCreatedEvent`
        + Hệ thống tự động retry publish domain event
      + Bước 7: Hệ thống gặp lỗi khi chuyển đổi hoặc publish workspace event
        + Hệ thống ghi log lỗi và bỏ qua việc publish workspace event
      + Bước 8: Hệ thống gặp lỗi khi publish integration event
        + Hệ thống tự động retry publish integration event
      + Bước 9: `search-worker` gặp lỗi khi xử lý `NoteCreatedEvent`
        + `search-worker` ghi log lỗi và bỏ qua event
      + Bước 10: Search service gặp lỗi khi indexing ghi chú mới
        + Search service ghi log lỗi và bỏ qua yêu cầu indexing
    ],
    exception-flow: [
      + Bước 4: Người dùng không có quyền tạo ghi chú trong workspace hiện tại
        + Hệ thống trả về lỗi `forbidden`
        + Use case dừng lại
      + Bước 5: Hệ thống gặp lỗi khi tạo ghi chú mới
        + Hệ thống trả về lỗi
        + Use case dừng lại
    ],
  ),
  caption: [Mô tả chi tiết use case UC01 - Create Note],
)

=== Mô tả use case Get Note

#figure(
  image("../assets/diagrams/get-note-seq.svg", height: 90%),
  caption: [Sequence diagram mô tả get note use case],
)

#usecase-figure(
  usecase(
    id: [UC02],
    name: [Get Note],
    description: [Use case này mô tả quy trình lấy nội dung ghi chú và chuyển
      sang chế độ chỉnh sửa],
    actors: [User],
    priority: [Cao],
    trigger: [Người dùng chọn một ghi chú để xem hoặc chỉnh sửa],
    pre-conditions: [
      - Người dùng sử dụng thiết bị có kết nối internet
      - Người dùng đã đăng nhập vào hệ thống
      - Người dùng có quyền xem ghi chú trong không gian làm việc hiện tại
    ],
    post-conditions: [
      - Người dùng nhận được thông tin ghi chú
      - Kết nối Hocuspocus được thiết lập để xem và _(tùy chọn)_ chỉnh sửa ghi
        chú
    ],
    basic-flow: [
      + Người dùng chọn ghi chú cần xem
      + Hệ thống lấy thông tin ghi chú từ `note` service
      + Hệ thống kiểm tra quyền xem ghi chú với `authorization` service
      + Hệ thống trả về thông tin ghi chú cho người dùng
      + Hệ thống thiết lập kết nối Hocuspocus để xem nội dung ghi chú
      + Nếu người dùng chọn chỉnh sửa, Hệ thống sẽ giữ kết nối và cho phép gửi
        các thao tác chỉnh sửa
      + `document` service kiểm tra bộ nhớ nội bộ trước
      + Nếu tài liệu chưa tồn tại trong bộ nhớ nội bộ, `document` service kiểm
        tra với `note` service
      + Nếu ghi chú tồn tại, `document` service khởi tạo tài liệu và lưu vào bộ
        nhớ nội bộ
      + `document` service trả về kết nối Hocuspocus cho người dùng
      + Nếu có thao tác chỉnh sửa, `document` service lưu thay đổi và phát sóng
        cho các client khác
    ],
    alternate-flow: [
      + Bước 8-9: Tài liệu đã tồn tại trong bộ nhớ nội bộ của `document` service
        + `document` service bỏ qua bước kiểm tra với `note` service
        + `document` service trả về kết nối Hocuspokus trực tiếp
      + Bước 12: Người dùng không chọn chỉnh sửa _(chỉ xem)_
        + Kết nối Hocuspoccus duy trì ở chế độ xem
        + Không có thao tác chỉnh sửa nào được thực hiện
      + Bước 13: Lỗi khi lưu thay đổi tài liệu trong quá trình debounce
        + `document` service ghi log lỗi và thử lại sau thời gian debounce
    ],
    exception-flow: [
      + Bước 4: Người dùng không có quyền xem ghi chú
        + Hệ thống trả về lỗi `forbidden`
        + Use case dừng lại
      + Bước 9: Ghi chú không tồn tại trong `note` service
        + Hệ thống trả về lỗi `noteNotFound`
        + Use case dừng lại
    ],
  ),
  caption: [Mô tả chi tiết use case UC02 - Get Note],
)

=== Mô tả use case Commit Document

#figure(
  image("../assets/diagrams/commit-document-seq.svg"),
  caption: [Sequence diagram mô tả commit document use case],
)

#usecase-figure(
  usecase(
    id: [UC03],
    name: [Commit Document],
    description: [Use case này mô tả quy trình lưu và publish event cập nhật tài
      liệu _(nội dung của ghi chú)_],
    actors: [User],
    priority: [Cao],
    trigger: [Người dùng chọn lưu tài liệu để cập nhật],
    pre-conditions: [
      - Người dùng đã đăng nhập vào hệ thống
      - Người dùng có quyền chỉnh sửa tài liệu trong không gian làm việc hiện
        tại
      - Tài liệu đã tồn tại trong hệ thống
    ],
    post-conditions: [
      - Tài liệu được tạo ra phiên bản lưu trữ _(revision)_ mới
      - Integration Event `DocumentCommittedEvent` được publish
      - Việc cập nhật được phản ánh vào hệ thống nhận xét và tìm kiếm
    ],
    basic-flow: [
      + Người dùng chọn hành động "Commit Document" trên giao diện
      + `document` service tạo phiên bản lưu trữ mới của tài liệu
      + `document` service publish integration event `DocumentCommittedEvent`
        vào Message Broker
      + Message Broker phân phối event cho `note` service và `search-worker`
      + `note` service nhận event và cập nhật các thông tin như size, tags
      + `search-worker` nhận event và chuyển đổi thành markdownContent, tags
      + Search service nhận yêu cầu index lại ghi chú và thực hiện indexing
      + Các thay đổi được đăng báo lại cho các client thông qua Hocuspocus
    ],
    alternate-flow: [
      + Bước 4: Lỗi khi tạo revision mới của tài liệu
        + Hệ thống ghi log và thông báo lỗi cho người dùng
      + Bước 6: Dữ liệu BlockNote không đúng với schema
        + Hệ thống discard event và ghi log lỗi
    ],
    exception-flow: [
      + Bước 2: Lỗi khi lấy quyền edit
        + Trả về lỗi `forbidden` và dừng quy trình
    ],
  ),
  caption: [Mô tả chi tiết use case UC03 - Commit Document],
)

=== Mô tả use case Update Note

// This use case is not right, because we do more fine-grained than just update

#figure(
  image("../assets/diagrams/update-note-seq.svg"),
  caption: [Sequence diagram mô tả update note use case],
)

#usecase-figure(
  usecase(
    id: [UC04],
    name: [Update Note],
    description: [Use case này mô tả quy trình cập nhật thông tin cơ bản của ghi
      chú],
    actors: [User],
    priority: [Cao],
    trigger: [Người dùng chỉnh sửa và lưu thay đổi thông tin ghi chú],
    pre-conditions: [
      - Người dùng đã đăng nhập vào hệ thống
      - Người dùng có quyền chỉnh sửa ghi chú trong không gian làm việc hiện tại
      - Ghi chú tồn tại trong hệ thống
    ],
    post-conditions: [
      - Thông tin ghi chú được cập nhật thành công
      - `NoteUpdatedEvent` được publish tới các dịch vụ khác
    ],
    basic-flow: [
      + Người dùng chỉnh sửa thông tin ghi chú và chọn lưu
      + Hệ thống kiểm tra quyền chỉnh sửa ghi chú với `authorization` service
      + Hệ thống cập nhật thông tin ghi chú trong `note` service
      + Hệ thống trả về kết quả thành công cho người dùng
      + Hệ thống publish `NoteUpdatedEvent` tới Message Broker (có retry nếu
        chưa published)
      + `search-worker` nhận `NoteUpdatedEvent` và xử lý
      + Search service nhận yêu cầu Index Note và thực hiện indexing
    ],
    alternate-flow: [
      + Bước 3: Hệ thống gặp lỗi kiểm tra quyền
        + Ghi log lỗi và trả về thông báo cho người dùng
      + Bước 5: Chưa published được `NoteUpdatedEvent`
        + Hệ thống tự động retry cho đến khi thành công
      + Bước 7: Lỗi khi xử lý `NoteUpdatedEvent` ở `search-worker`
        + Ghi log và bỏ qua event này
      + Bước 8: Lỗi khi indexing ở Search service
        + Ghi log và thử lại sau debounce
    ],
    exception-flow: [
      + Bước 2: Người dùng không có quyền chỉnh sửa ghi chú
        + Hệ thống trả về lỗi `forbidden`
        + Use case dừng lại
      + Bước 4: Lỗi khi cập nhật thông tin ghi chú
        + Hệ thống trả về lỗi
        + Use case dừng lại
    ],
  ),
  caption: [Mô tả chi tiết use case UC04 - Update Note],
)
