== Tổng quan về Traefik <general-for-traefik>

=== Giới thiệu

Traefik là một API gateway mã nguồn mở @traefik, hiện đại, được viết bằng Go.
Traefik được thiết kế để tự động phát hiện và kết nối các dịch vụ, loại bỏ nhu
cầu cấu hình thủ công. Traefik hỗ trợ OpenTelemetry
_(@general-for-observability)_ cho distributed tracing, cho phép quan sát
performance toàn bộ request flow.

Traefik hoạt động tốt trong các môi trường container-orchestrated như Docker,
Kubernetes, Docker Swarm và cũng có thể chạy standalone cho các ứng dụng
non-containerized.

#figure(
  image("../assets/images/traefik-logo.svg", height: 80pt),
  caption: [Traefik Logo],
)

Dự án sử dụng `agilezebra/jwt-middleware` @agilezebra_jwt_middleware để xác minh
request đến các API endpoint, thông tin được chuyển đổi sang request headers
giúp cho các service không cần phải thực hiện quá trình xác minh riêng.

=== Ưu điểm

Traefik mang lại nhiều lợi ích cho phát triển API gateway:
- Tự động phát hiện services, không cần cấu hình thủ công
- Hỗ trợ native OTLP cho distributed tracing
- Thiết kế tối ưu cho Docker và Kubernetes
- Middleware extensible cho custom logic
- Cấu hình thay đổi runtime không cần restart
- Hỗ trợ HTTP, HTTPS, gRPC, WebSocket
- Hiệu suất cao nhờ Go
- Dự án được duy trì tích cực

=== Nhược điểm

Bên cạnh các ưu điểm, Traefik có một số hạn chế:
- Cần học provider concept và configuration syntax
- Cấu hình nâng cao có thể phức tạp
- Cộng đồng nhỏ hơn Nginx, ít plugin third-party
- Khó debug khi routing rules không hoạt động đúng
- Ít integration third-party so với các gateway khác
