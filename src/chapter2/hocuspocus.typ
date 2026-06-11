== Tổng quan về Hocuspocus <general-for-hocuspocus>

=== Giới thiệu

Hocuspocus là server WebSocket chuyên dụng cho Yjs, phát triển bởi Tiptap
Collective (ueberdosis) @hocuspocus — cùng tổ chức đứng sau Tiptap, thiết kế làm
backend collaboration cho editor dựa trên ProseMirror và Tiptap.

Hocuspocus đóng vai trò trung gian giữa các client, nhận và phân phối cập nhật
Yjs document qua WebSocket, đồng thời quản lý persistence, authentication,
awareness và cung cấp hệ thống extension.

=== Kiến trúc

Hocuspocus được thiết kế theo kiến trúc server-client đơn giản:

- *Hocuspocus Server*: tiến trình server, quản lý kết nối WebSocket, đồng bộ Yjs
  documents và phân phối cập nhật đến client trong cùng phòng (room).

- *Hocuspocus Provider*: thư viện client (`@hocuspocus/provider`), kết nối server
  qua WebSocket, đồng bộ Y.Doc, quản lý vòng đời kết nối, xác thực và awareness.

Mỗi tài liệu xác định bởi tên phòng (room name). Client kết nối cùng phòng tự
động đồng bộ tài liệu Yjs tương ứng.

Luồng hoạt động:

1. Client khởi tạo HocuspocusProvider với WebSocket server, tên phòng và Y.Doc
2. Provider kết nối server qua WebSocket, kèm token xác thực (nếu cấu hình)
3. Server xác thực qua hook `onAuthenticate`, nếu thành công mở phiên làm việc
4. Server tải tài liệu từ persistence (nếu có) và đồng bộ với client
5. Client thay đổi, Yjs update gửi lên server và phân phối đến client khác
6. Server định kỳ lưu tài liệu xuống persistence qua extension

=== Extension System

Hocuspocus có hệ thống extension mở rộng chức năng server qua hook vòng đời:

- *Persistence*: lưu trữ tài liệu. Extension có sẵn:
  + `@hocuspocus/extension-sqlite`: SQLite
  + `@hocuspocus/extension-postgresql`: PostgreSQL
  + `@hocuspocus/extension-s3`: S3-compatible storage
  + `@hocuspocus/extension-redis`: đồng bộ nhiều instance server

- *Authentication*: xác thực qua hook `onAuthenticate`, kiểm tra token, API key

- *Lifecycle Hooks*: `onConnect`, `onLoadDocument`, `onChange`,
  `onStoreDocument`, `onDisconnect`

=== Tính năng nổi bật

Tính năng chính:

- *Real-time đồng bộ*: WebSocket truyền tải Yjs updates độ trễ thấp
- *Persistence tự động*: lưu trữ và khôi phục khi server khởi động lại
- *Horizontal scaling*: Redis extension đồng bộ giữa nhiều instance server
- *Awareness*: quản lý trạng thái trực tuyến qua awareness CRDT của Yjs
- *Direct Connection API*: REST API thao tác trực tiếp Y.Doc, hỗ trợ ghi nội dung
  từ server hoặc batch jobs
- *Stateless Messages*: gửi thông điệp tùy chỉnh giữa client, không lưu trong
  Y.Doc

=== Vai trò trong dự án

Trong dự án, Hocuspocus là provider chính cho Yjs _(@general-for-yjs)_ vì:

- Tích hợp sâu với Tiptap và BlockNote (cùng hệ sinh thái)
- Extension system tùy chỉnh persistence, authentication và hook xử lý
- Mở rộng ngang qua Redis, phù hợp khi số lượng người dùng tăng cao
- Mã nguồn mở, tự triển khai hoặc dùng bản đám mây
