== Tổng quan về Casbin <general-for-casbin>

=== Giới thiệu

Casbin là một framework authorization mã nguồn mở mạnh mẽ và linh hoạt, hiện
thuộc Apache Software Foundation. Casbin hỗ trợ các mô hình kiểm soát truy cập
như ACL, RBAC, ABAC, và các biến thể khác. Framework này cho phép định nghĩa các
rule authorization một cách khai báo thông qua cấu hình, thay vì hardcode logic
kiểm soát.

#figure(
  image("../assets/images/casbin-logo.svg", height: 80pt),
  caption: [Casbin Logo],
)

Casbin được thiết kế để hoạt động với nhiều ngôn ngữ lập trình, bao gồm Go,
Java, Python, Node.js và hơn thế nữa, giúp đảm bảo tính nhất quán trong
authorization logic trên toàn bộ hệ sinh thái.

So với các giải pháp authorization khác như OPA, SpiceDB _(Google Zanzibar
opensource)_, Casbin tập trung vào sự đơn giản và hiệu quả, cung cấp một cách
tiếp cận.

=== Ưu điểm

Casbin mang lại nhiều lợi ích cho phát triển authorization:
- Cùng một biểu diễn hỗ trợ nhiều mô hình từ ACL đến ABAC
- Định nghĩa rules qua file cấu hình thay vì code
- Implementation cho nhiều ngôn ngữ
- Xử lý nhanh và kiểm tra permission hiệu quả
- Lưu trữ policies trong database hoặc file
- Custom matcher và effect cho phép mở rộng chức năng

=== Nhược điểm

Bên cạnh các ưu điểm, Casbin có một số hạn chế:
- Cần thời gian để hiểu RBAC, ABAC và cách cấu hình
- Use case phức tạp dẫn đến cấu hình khó hiểu
- Khó debug khi policy không hoạt động như mong đợi
- Không dễ scale so với các giải pháp chuyên biệt như OPA hoặc SpiceDB
