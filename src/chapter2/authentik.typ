== Tổng quan về Authentik <general-for-authentik>

=== Giới thiệu

Authentik là một nền tảng identity provider mã nguồn mở được thiết kế để cung
cấp các dịch vụ xác thực và cấp quyền tập trung. Authentik hỗ trợ các chuẩn hiện
đại như OIDC (OpenID Connect) và OAuth 2.0, cho phép kết nối dễ dàng với nhiều
ứng dụng và dịch vụ.

#figure(
  image("../assets/images/authentik-logo.svg", height: 80pt),
  caption: [Authentik Logo],
)

=== Ưu điểm

Authentik có nhiều ưu điểm nổi bật:
- Hỗ trợ đầy đủ OIDC và OAuth 2.0
- Triển khai trên hạ tầng riêng, không phụ thuộc dịch vụ ngoài
- Quản lý người dùng, nhóm và phân quyền linh hoạt
- Tích hợp nhiều providers ngoài (Google, GitHub, SAML,...)
- Authentik Blueprint cấu hình và áp dụng tự động, thuận tiện hơn Keycloak khi
  phải dùng Terraform/Ansible

=== Nhược điểm

Bên cạnh các ưu điểm, Authentik có một số hạn chế:
- Cấu hình và triển khai phức tạp
- Cần thời gian để hiểu OIDC, OAuth và policies
- Viết bằng Python, nhưng thành phần chính viết bằng Go/Rust; mức dùng RAM tương
  đương Keycloak khi phát triển
- Authentik Blueprint đôi khi lỗi nhưng không có log
