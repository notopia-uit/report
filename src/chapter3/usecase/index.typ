== Mô tả các trường hợp sử dụng (Use Case)

#import "../../lib/usecase.typ": usecase

=== Use Case tổng quát

#lorem(80)

=== Chi tiết Use Case

#figure(
  usecase(
    id: [UC01],
    name: [Đăng ký],
    description: [Cho phép người dùng chưa có tài khoản đăng ký để đăng nhập vào hệ thống.],
    actors: [STU, TEA],
    priority: [Cao],
    trigger: [Người dùng muốn đăng ký tài khoản của ứng dụng.],
    preconditions: [
      - Người dùng sử dụng thiết bị có kết nối internet.
    ],
    postconditions: [
      - Người dùng đăng ký tài khoản thành công.
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

#lorem(60)
