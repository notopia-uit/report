== Tổng quan về BlockNote <general-for-blocknote>

=== Giới thiệu

BlockNote là một thư viện editor được xây dựng trên nền tảng Tiptap và
ProseMirror @blocknote. BlockNote cung cấp một công cụ soạn thảo văn bản phong
phú với kiến trúc block-based tương tự như Notion, cho phép người dùng xây dựng
các khối nội dung một cách linh hoạt.

#figure(
  image("../assets/images/blocknote-logo.svg", height: 80pt),
  caption: [BlockNote logo],
)

BlockNote được thiết kế để dễ tích hợp vào các ứng dụng React
_(@general-for-react)_, với API rõ ràng và khả năng tùy chỉnh cao, tương thích
với màu sắc của shadcnui . Thư viện này hoạt động dựa trên ProseMirror, một
editor framework mạnh mẽ và có cấu trúc rõ ràng. Có thể hình dung ProseMirror
như một bộ công cụ xây dựng editor, trong khi BlockNote là một implementation cụ
thể, dễ dàng sử dụng nhanh.

BlockNote là một hệ sinh thái mã nguồn mở hoàn toàn, miễn phí sử dụng công cộng.
Chỉ riêng các gói thư viện `@blocknote/xl-*` có giấy phép copyleft, yêu cầu mua
giấy phép nếu sử dụng trong sản phẩm mã nguồn đóng, hoặc thương mại.

=== Model dữ liệu của BlockNote

Model dữ liệu của BlockNote được tổ chức thành các block, mỗi block đại diện cho
một phần nội dung riêng biệt, như đoạn văn, hình ảnh, bảng,... Mỗi block có một
cấu trúc dữ liệu riêng, bao gồm loại block, nội dung và các thuộc tính liên quan
_(xem thêm về cấu trúc dữ liệu của block trong BlockNote tại
@appendix-blocknote-model)_.

=== Ưu điểm

BlockNote mang lại nhiều lợi ích cho phát triển editor:

- Kiến trúc block-based, tổ chức nội dung thành khối độc lập
- Xây dựng trên Tiptap, kế thừa toàn bộ tính năng
- Dễ thêm/xoá tính năng qua extension
- Thiết kế tối ưu cho React với hooks và component API
- Tích hợp Yjs và CRDT cho cộng tác thời gian thực
- Hỗ trợ text, image, video, code blocks, tables,...

=== Nhược điểm

Bên cạnh các ưu điểm, BlockNote có một số hạn chế:

- Cần thời gian để hiểu kiến trúc block-based và cách tùy chỉnh
- Một số tính năng yêu cầu trình duyệt hiện đại
