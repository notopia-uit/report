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
