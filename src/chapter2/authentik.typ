== Tổng quan về Authentik <general-for-authentik>

=== Giới thiệu

Authentik là một nền tảng identity provider mã nguồn mở được thiết kế để cung
cấp các dịch vụ xác thực và cấp quyền tập trung @authentik. Authentik hỗ trợ các
chuẩn hiện đại như OIDC (OpenID Connect) và OAuth 2.0, cho phép kết nối dễ dàng
với nhiều ứng dụng và dịch vụ.

Authentik có giao diện quản lý thân thiện, cung cấp các tính năng bảo mật nâng
cao cho việc quản lý danh tính người dùng trong các tổ chức.

=== Ưu điểm

Authentik có nhiều ưu điểm nổi bật:

- OIDC và OAuth 2.0 Support, hỗ trợ đầy đủ các chuẩn authorization và
  authentication hiện đại
- Self-Hosted, có thể triển khai trên hạ tầng riêng, tránh phụ thuộc vào dịch vụ
  external
- Flexible User Management, quản lý người dùng, nhóm, và phân quyền linh hoạt
- Provider Support, hỗ trợ tích hợp với nhiều external providers (Google,
  GitHub, SAML, v.v.)
- Phù hợp cho developement nhờ vào tính năng Authentik Blueprint, dễ dàng cấu
  hình và áp dụng tự động, thuận tiện hơn Keycloak rất nhiều khi phải sử dụng
  Terraform hay Ansible

=== Nhược điểm

Bên cạnh các ưu điểm, Authentik có một số hạn chế:

- Deployment Complexity, yêu cầu cấu hình và triển khai phức tạp
- Learning Curve, cần thời gian để hiểu các khái niệm OIDC, OAuth, và cấu hình
  policies
- Performance, Authentik được viết bàng Python là chính, nhưng các thành phần
  trọng yếu vẫn được viết bằng Go và Rust. Dù vậy, mức độ sử dụng RAM của
  Authentik ngang với Keycloak khi sử dụng trong quá trình phát triển
- Áp dụng Authentik Blueprint đôi khi lỗi nhưng không có log
