#import "../lib/usecase.typ": usecase, usecase-figure

== Mô tả các Use Case

Nhóm chỉ xác định một vài use case phức tạp, có nhiều luồng, tác động đến nhiều
dịch vụ.

=== Mô tả use case Create Note

// language: mermaid
#let sequence = ```
sequenceDiagram
    autonumber

    actor U as User
    participant NS as Note Service
    participant AS as Authorization Service
    participant MB as Message Broker
    participant SW as Search Worker
    participant SS as Search Service

    U->>+NS: CreateNote
    NS->>+AS: HasWorkspacePermission
    break Authorization Failed
        AS-->>NS: No Permission
        NS-->>U: No Permission
    end
    AS-->>-NS: Ok
    NS->>NS: Create Note
    par Response
        NS-->>-U: Note ID
    and NoteCreated event
        NS-)MB: Publish NoteCreatedEvent
        MB-)SW: Retrieve NoteCreatedEvent
        SW->>SW: Process NoteCreatedEvent
        SW->>+SS: Index Note info
        SS->>+SS: Index Note
    end
```.text

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
      + Hệ thống gửi sự kiện `NoteCreatedEvent` đến Message Broker
      + Search Worker nhận sự kiện `NoteCreatedEvent` và xử lý
      + Search Worker gửi yêu cầu Index Note đến Search Service
      + Search Service nhận yêu cầu Index Note và tiến hành indexing ghi chú mới
    ],
    alternate-flow: [
      + Bước 6a: Hệ thống gặp lỗi khi gửi sự kiện `NoteCreatedEvent`
        + Hệ thống tự động retry
      + Bước 7a: Search Worker gặp lỗi khi xử lý `NoteCreatedEvent`
        + Search Worker ghi log lỗi và bỏ qua sự kiện
      + Bước 8a: Search Service gặp lỗi khi indexing ghi chú mới
        + Search Service ghi log lỗi và bỏ qua yêu cầu indexing
    ],
    exception-flow: [
      + Bước 4a: Người dùng không có quyền tạo ghi chú trong workspace hiện tại
        + Hệ thống trả về lỗi `forbidden`
        + Use case dừng lại
      + Bước 5a: Hệ thống gặp lỗi khi tạo ghi chú mới
        + Hệ thống trả về lỗi
        + Use case dừng lại
    ],
  ),
  caption: [Mô tả chi tiết use case UC01 - Create Note],
)


/*
This is example from another project, not us
#figure(
  usecase(
    id: [UC01],
    name: [Create Note],
    description: [Use case này mô tả quy trình tạo ghi chú mới.],
    actors: [User],
    priority: [Cao],
    trigger: [Người dùng muốn tạo một ghi chú mới.],
    preconditions: [
      - Người dùng sử dụng thiết bị có kết nối internet.
    ],
    postconditions: [
      - Người dùng tạo ghi chú thành công.
    ],
    basicFlow: [
      + Người dùng truy cập vào hệ thống Idest.
      + Người dùng chọn nút "Tớ chưa có tài khoản" được hiển thị vào màn hình.
      + Website chuyển đến trang "Đăng ký".
      + Người dùng nhập vào các trường trong biểu mẫu.
      + Hệ thống gửi mail xác nhận cho người dùng.
      + Người dùng xác nhận thông tin qua email.
      + Người dùng được đăng ký thành công.
    ],
    alternateFlow: [
      + Bước 4a: Người dùng chọn đăng ký bằng Google.
        + Hệ thống hiển thị đăng ký bằng Google và chọn tài khoản để đăng ký.
        + Use case tiếp tục đến bước 7.
    ],
    exceptionFlow: [
      + Bước 6a: Người dùng không xác nhận thông tin qua email.
        + Hệ thống không thay đổi.
        + Use case dừng lại.
    ],
    businessRules: [BR01, BR02, BR03],
    nfRequirements: [NFR01],
  ),
  caption: [Mô tả chi tiết use case UC01 - Đăng ký],
)
*/
