== Thiết kế hệ thống

#import "./architecture.typ"

=== Quy trình phát triển

#figure(
  table(
    columns: (0.5fr, 1fr, 1fr, 1fr),
    align: center,
    stroke: 0.5pt,
    [Giai đoạn], [Thời gian], [Hoạt động], [Kết quả],

    [1],
    [26/01 - 04/02],
    [Khởi động & Nghiên cứu],
    [Xác định yêu cầu, nghiên cứu công nghệ],

    [2],
    [05/02 - 12/02],
    [Thiết lập],
    [Môi trường làm việc, CI Pipeline sẵn sàng],

    [3],
    [13/02 - 25/02],
    [Phân tích & Thiết kế],
    [Đặc tả Use Case, thiết kế Database Schema, UI/UX],

    [4],
    [26/02 - 05/04],
    [Phát triển & Tích hợp (Đợt 1)],
    [Hệ thống đăng nhập và quản lý ghi chú cơ bản hoạt động],

    [5],
    [06/04 - 10/05],
    [Phát triển & Tích hợp (Đợt 2)],
    [Ứng dụng đầy đủ tính năng với Graph View và cộng tác thời gian thực],

    [6],
    [11/05 - 17/05],
    [Hoàn thiện Sản phẩm],
    [Sản phẩm hoàn thiện về tính năng và thẩm mỹ],

    [7],
    [18/05 - 31/05],
    [Báo cáo & Tổng kết],
    [Báo cáo cuối kỳ và source code hoàn chỉnh],
  ),
  caption: [Lịch trình các giai đoạn phát triển dự án],
)
