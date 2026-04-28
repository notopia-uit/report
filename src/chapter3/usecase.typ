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
      - Người dùng có quyền tạo ghi chú trong workspace hiện tại
    ],
    post-conditions: [
      - Người dùng tạo ghi chú thành công
    ],
    basic-flow: [
      + Người dùng truy cập vào hệ thống
      + Người dùng chọn nút "Tạo ghi chú mới" được hiển thị
      + Người dùng nhập vào các trường thông tin của ghi chú (tiêu đề,...)
      + Hệ thống kiểm tra quyền của người dùng để tạo ghi chú
      + Hệ thống tạo ghi chú mới và trả về ID của ghi chú
      + Hệ thống phát hành domain event `NoteCreatedEvent` tới Message Broker
      + Hệ thống chuyển đổi domain event thành workspace event và phát hành
      + Hệ thống phát hành integration event `NoteCreatedEvent` tới Message Broker
      + Search Worker nhận integration event và xử lý
      + Search Worker gửi yêu cầu Index Note đến Search Service
      + Search Service nhận yêu cầu Index Note và tiến hành indexing ghi chú mới
    ],
    alternate-flow: [
      + Bước 6: Hệ thống gặp lỗi khi gửi domain event `NoteCreatedEvent`
        + Hệ thống tự động retry phát hành domain event
      + Bước 7: Hệ thống gặp lỗi khi chuyển đổi hoặc phát hành workspace event
        + Hệ thống ghi log lỗi và bỏ qua việc phát hành workspace event
      + Bước 8: Hệ thống gặp lỗi khi phát hành integration event
        + Hệ thống tự động retry phát hành integration event
      + Bước 9: Search Worker gặp lỗi khi xử lý `NoteCreatedEvent`
        + Search Worker ghi log lỗi và bỏ qua sự kiện
      + Bước 10: Search Service gặp lỗi khi indexing ghi chú mới
        + Search Service ghi log lỗi và bỏ qua yêu cầu indexing
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

=== Mô tả use case Get Node

#figure(
  image("../assets/diagrams/get-node-seq.svg"),
  caption: [Sequence diagram mô tả get node use case],
)

#usecase-figure(
  usecase(
    id: [UC02],
    name: [Get Node],
    description: [Use case này mô tả quy trình lấy nội dung ghi chú và chuyển sang chế độ chỉnh sửa],
    actors: [User],
    priority: [Cao],
    trigger: [Người dùng chọn một ghi chú để xem hoặc chỉnh sửa],
    pre-conditions: [
      - Người dùng sử dụng thiết bị có kết nối internet
      - Người dùng đã đăng nhập vào hệ thống
      - Người dùng có quyền xem ghi chú trong workspace hiện tại
    ],
    post-conditions: [
      - Người dùng nhận được thông tin ghi chú
      - Nếu chọn chỉnh sửa, kết nối Hocuspocus được thiết lập
    ],
    basic-flow: [
      + Người dùng chọn ghi chú cần xem
      + Hệ thống lấy thông tin ghi chú từ Note Service
      + Hệ thống kiểm tra quyền xem ghi chú với Authorization Service
      + Hệ thống trả về thông tin ghi chú cho người dùng
      + Người dùng chọn chế độ chỉnh sửa
      + Người dùng yêu cầu kết nối WsDocument thông qua Document Service
      + Document Service kiểm tra bộ nhớ nội bộ (document cache) trước
      + Nếu tài liệu chưa tồn tại trong bộ nhớ nội bộ, Document Service kiểm tra với Note Service
      + Nếu ghi chú không tồn tại, trả về lỗi "Not found" và dừng quy trình
      + Nếu ghi chú tồn tại, Document Service khởi tạo tài liệu và lưu vào bộ nhớ nội bộ
      + Document Service trả về kết nối Hocuspocus cho người dùng
      + Người dùng thực hiện các thao tác chỉnh sửa, Document Service lưu thay đổi và phát sóng cho các client khác
    ],
    alternate-flow: [
      + Bước 6-7: Tài liệu đã tồn tại trong bộ nhớ nội bộ của Document Service
        + Document Service bỏ qua bước kiểm tra với Note Service
        + Document Service trả về kết nối Hocuspocus trực tiếp
      + Bước 11: Lỗi khi lưu thay đổi tài liệu trong quá trình debounce
        + Document Service ghi log lỗi và thử lại sau thời gian debounce
    ],
    exception-flow: [
      + Bước 4: Người dùng không có quyền xem ghi chú
        + Hệ thống trả về lỗi `forbidden`
        + Use case dừng lại
      + Bước 9: Ghi chú không tồn tại trong Note Service
        + Hệ thống trả về lỗi `not found`
        + Use case dừng lại
    ],
  ),
  caption: [Mô tả chi tiết use case UC02 - Get Node],
)
