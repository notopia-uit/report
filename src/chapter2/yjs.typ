== Tổng quan về Yjs <general-for-yjs>

=== Giới thiệu

Yjs là thư viện CRDT (Conflict-free Replicated Data Type) viết bằng JavaScript,
hỗ trợ real-time collaboration @yjs. CRDT cho phép thay đổi từ nhiều người dùng
tự động hợp nhất mà không cần xử lý xung đột thủ công.

#figure(
  image("../assets/images/yjs-logo.svg", height: 80pt),
  caption: [Yjs Logo],
)

=== Kiến trúc

Yjs được tổ chức xoay quanh các khái niệm chính sau:

- *Y.Doc*: đơn vị trung tâm đại diện cho tài liệu collaborative, chứa shared
  data types và quản lý đồng bộ giữa các peer. Mỗi Y.Doc có clientID duy nhất để
  phân biệt thay đổi từ những người dùng khác nhau.

- *Shared Data Types*: kiểu dữ liệu đặc biệt tự động đồng bộ giữa các peer, hoạt
  động tương tự kiểu JavaScript nhưng hợp nhất xung đột không cần máy chủ trung
  tâm và hỗ trợ observe thay đổi.

- *Provider*: kết nối Y.Doc với peer khác qua các giao thức mạng, từ WebSocket
  đến WebRTC peer-to-peer hoặc dịch vụ đám mây.

- *Editor Binding*: cầu nối đồng bộ shared types với editor phổ biến, biến
  editor thông thường thành collaborative editor.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (left, left, left, left),
    table.header([*Kiến trúc*], [*Mô tả*], [*Ví dụ*], [*Ghi chú*]),
    [Y.Doc], [Tài liệu gốc], [`new Y.Doc()`], [Quản lý tất cả shared types],
    [Shared Types],
    [Dữ liệu tự động đồng bộ],
    [`Y.Array`, `Y.Map`, `Y.Text`],
    [Có thể observe thay đổi],

    [Provider],
    [Kết nối mạng],
    [`WebsocketProvider`, `WebrtcProvider`],
    [Chọn provider dựa trên nhu cầu],

    [Editor Binding],
    [Tích hợp editor],
    [`y-prosemirror`, `y-quill`],
    [Biến editor thành collaborative],
  ),
  caption: [Các thành phần kiến trúc chính của Yjs],
)

=== Shared Data Types

Yjs cung cấp sáu shared data types, mỗi loại phục vụ mục đích khác nhau. Có thể
lấy từ Y.Doc qua getter hoặc khởi tạo trực tiếp làm nested types.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    table.header([*Kiểu dữ liệu*], [*Mô tả*], [*Ứng dụng*]),
    [`Y.Array`],
    [Mảng có thứ tự, hỗ trợ chèn/xóa theo chỉ số],
    [Danh sách, hàng đợi],

    [`Y.Map`],
    [Key-value store, lồng ghép shared types khác],
    [Cấu hình, metadata],

    [`Y.Text`],
    [Văn bản với hỗ trợ định dạng ký tự inline],
    [Nội dung text có style],

    [`Y.XmlFragment`],
    [Fragment XML chứa nhiều node con],
    [Cấu trúc block-based editor],
  ),
  caption: [Các shared data types chính của Yjs],
)

Mỗi shared type hỗ trợ observe để theo dõi thay đổi:

- `observe()`: lắng nghe thay đổi trực tiếp trên type, trả về delta (Y.Array,
  Y.Text) hoặc key change (Y.Map)
- `observeDeep()`: lắng nghe thay đổi trên toàn bộ cây shared types, gồm nested
  types

=== Editor Bindings

Yjs không đi kèm editor riêng mà tích hợp với editor phổ biến qua binding.
Editor binding là cầu nối giữa Y.Text/Y.XmlFragment và editor, tự động đồng bộ
nội dung và con trỏ.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    table.header([*Editor*], [*Gói binding*], [*Mô tả*]),
    [ProseMirror],
    [`y-prosemirror`],
    [Toolkit rich text editor với document model có cấu trúc],

    [Tiptap],
    [`@tiptap/extension-collaboration`],
    [Framework headless rich text editor dựa trên ProseMirror],
  ),
  caption: [Editor bindings chính cho Yjs trong dự án],
)

=== Connection Providers

Provider truyền tải thay đổi của Y.Doc giữa các peer, từ giao thức peer-to-peer
đến dịch vụ đám mây có quản lý.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    table.header([*Provider*], [*Giao thức*], [*Mô tả*]),
    [`y-websocket`],
    [WebSocket],
    [Provider mặc định, client-server, hỗ trợ persistence và authentication],

    [`y-webrtc`], [WebRTC], [Provider peer-to-peer, không cần server trung tâm],

    [Hocuspocus],
    [WebSocket],
    [Server WebSocket chuyên dụng cho Yjs, hỗ trợ persistence, authentication,
      webhook và extension],
  ),
  caption: [Các connection providers chính của Yjs],
)

Dự án chọn Hocuspocus @hocuspocus làm provider chính nhờ khả năng mở rộng và
tích hợp sâu với Tiptap/BlockNote.

=== Undo/Redo Manager

Yjs cung cấp `Y.UndoManager` cho undo/redo trên shared types. Hỗ trợ scoped
tracking (chỉ undo thay đổi từ nguồn cụ thể), capture timeout (gộp thay đổi
trong 500ms), và metadata (ví dụ vị trí con trỏ).

=== Awareness

Awareness chia sẻ thông tin trạng thái tạm thời giữa người dùng (con trỏ, vùng
chọn, tên, màu sắc) thông qua CRDT riêng trong `y-protocols`. Dữ liệu tự động
xóa khi người dùng ngắt kết nối, client không gửi tín hiệu trong 30 giây bị đánh
dấu offline.

=== Ưu điểm

Yjs mang lại nhiều lợi ích:

- *CRDT-Based Merging*: xung đột tự động giải quyết, không cần quản lý thủ công
- *Offline-First*: làm việc offline, đồng bộ khi quay lại online
- *Framework Agnostic*: độc lập UI framework, tích hợp với bất kỳ framework nào
- *Hiệu suất cao*: tối ưu xử lý thay đổi lớn hiệu quả
- *Hệ sinh thái phong phú*: nhiều editor binding và connection provider

=== Nhược điểm

Yjs có một số hạn chế:

- *Complexity*: CRDT phức tạp, cần hiểu rõ để tối ưu hiệu suất
- *Memory Usage*: lưu trữ lịch sử thay đổi tiêu thụ bộ nhớ đáng kể với tài liệu
  lớn và nhiều người dùng
- *Network Bandwidth*: đồng bộ tạo lưu lượng lớn với thay đổi tần suất cao, đặc
  biệt với state-based CRDT
- *Learning Curve*: cần thời gian để hiểu cách sử dụng và tích hợp
- *UndoManager với nhiều nguồn*: khó undo chỉ thay đổi của user cụ thể nếu thiếu
  cấu hình trackedOrigins phù hợp
