== Thiết kế health check ở các service

=== Mục tiêu của health check endpoint

Health check endpoint là cơ chế tự kiểm tra giúp hệ thống giám sát phát hiện sớm
sự cố (lỗi kết nối DB, rò rỉ bộ nhớ, thành phần phụ thuộc sập). Từ đó,
Kubernetes có thể tự động khởi động lại container hoặc ngừng gửi traffic đến
service lỗi.

Có 3 loại probe theo Kubernetes:
- *Startup probe*: kiểm tra service đã khởi động xong chưa, thất bại → restart
- *Liveness probe*: kiểm tra service còn sống không, thất bại → restart
- *Readiness probe*: kiểm tra service sẵn sàng nhận traffic chưa, thất bại →
  ngừng gửi traffic

Bảng dưới đây tóm tắt trạng thái triển khai health check. Do thời gian có hạn,
nhóm chỉ triển khai đầy đủ cho các Go service; các service còn lại sẽ bổ sung
sau.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (left, center, center, center),
    table.header([*Service*], [*Startup*], [*Liveness*], [*Readiness*]),

    [`note` (Go)], [#sym.checkmark], [#sym.checkmark], [#sym.checkmark],

    [`authorization` (Go)],
    [#sym.checkmark],
    [#sym.checkmark],
    [#sym.checkmark],

    [`document` (NestJS)], [#sym.dash.en], [#sym.dash.en], [#sym.dash.en],

    [`search-worker` (NestJS)], [#sym.dash.en], [#sym.dash.en], [#sym.dash.en],

    [`web` (NextJS)], [#sym.dash.en], [#sym.dash.en], [#sym.dash.en],
  ),
  caption: [Trạng thái triển khai health check theo service],
)

Ví dụ chi tiết payload response của từng loại probe trên `note` service có thể
xem tại @appendix-healthcheck-note.

=== Health check ở các Go service

Sử dụng thư viện `github.com/alexliesenfeld/health` @alexliesenfeld_health. Thư
viện hỗ trợ kiểm tra đồng bộ và bất đồng bộ (chạy tác vụ nặng trong nền theo chu
kỳ, trả về kết quả từ cache), cấu hình TTL cho cache để giảm tải hạ tầng, và bọc
tích hợp với các thư viện health check phổ biến khác (`health-go`,
`etherlabsio/healthcheck`, `heptiolabs/healthcheck`, `InVisionApp/go-health`).
