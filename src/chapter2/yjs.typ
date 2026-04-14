== Tổng quan về Yjs

=== Giới thiệu

Yjs là một thư viện CRDT (Conflict-free Replicated Data Type) được viết bằng
JavaScript, thiết kế để hỗ trợ real-time collaboration trên nhiều nền tảng. CRDT
cho phép các thay đổi từ nhiều người dùng được tự động hợp nhất mà không cần
xung đột, làm cho Yjs trở thành lựa chọn lý tưởng cho các ứng dụng
collaborative.

Yjs được sử dụng trong BlockNote @blocknote và nhiều editor khác để cung cấp khả
năng collaborative editing. Thư viện này có thể hoạt động với các transport khác
nhau như WebSocket, qua các dịch vụ như Hocuspocus @hocuspocus.

=== Ưu điểm

Yjs mang lại nhiều lợi ích cho phát triển collaborative:

- CRDT-Based Merging, xung đột được giải quyết tự động mà không cần quản lý
  conflict manual
- Người dùng có thể tiếp tục làm việc offline và dữ liệu sẽ đồng bộ khi quay lại
  online
- Framework Agnostic, Yjs hoạt động độc lập với UI framework, có thể tích hợp
  với bất kỳ framework nào
- Được tối ưu cho hiệu suất cao, hỗ trợ xử lý các thay đổi lớn một cách hiệu quả
- Hỗ trợ nhiều binding và integration với các tool khác như Tiptap, Monaco
  Editor, CodeMirror
- Cung cấp khái niệm "awareness" để hiển thị con trỏ và lựa chọn của người dùng
  khác

=== Nhược điểm

Bên cạnh các ưu điểm, Yjs có một số hạn chế:

- Complexity, CRDT là một khái niệm phức tạp, cần hiểu rõ để tối ưu hiệu suất
- Memory Usage, lưu trữ lịch sử của tất cả thay đổi có thể tiêu thụ bộ nhớ
- Network Bandwidth, đồng bộ hóa có thể tạo ra lưu lượng network lớn với các
  thay đổi tần suất cao
- Learning Curve, cần thời gian để hiểu cách sử dụng và cách tích hợp với ứng
  dụng
