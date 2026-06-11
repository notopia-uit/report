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
  data types và quản lý đồng bộ giữa các peer. Mỗi Y.Doc có clientID duy nhất
  để phân biệt thay đổi từ những người dùng khác nhau.

- *Shared Data Types*: kiểu dữ liệu đặc biệt tự động đồng bộ giữa các peer,
  hoạt động tương tự kiểu JavaScript nhưng hợp nhất xung đột không cần máy chủ
  trung tâm và hỗ trợ observe thay đổi.

- *Provider*: kết nối Y.Doc với peer khác qua các giao thức mạng, từ WebSocket
  đến WebRTC peer-to-peer hoặc dịch vụ đám mây.

- *Editor Binding*: cầu nối đồng bộ shared types với editor phổ biến, biến editor
  thông thường thành collaborative editor.

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
    [Mảng có thứ tự, hỗ trợ chèn, xóa và truy xuất theo chỉ số],
    [Danh sách công việc, hàng đợi, bộ sưu tập có thứ tự],

    [`Y.Map`],
    [Key-value store với khả năng lồng ghép shared types khác],
    [Cấu hình, metadata, thuộc tính động],

    [`Y.Text`],
    [Văn bản phong phú với hỗ trợ định dạng ký tự inline],
    [Nội dung text có style như bold, italic, link],

    [`Y.XmlFragment`],
    [Fragment XML chứa nhiều node con Y.XmlElement và Y.XmlText],
    [Cấu trúc block-based editor, document tree],

    [`Y.XmlElement`],
    [Phần tử XML với thuộc tính và node con],
    [Block elements, thẻ HTML, thành phần có cấu trúc],

    [`Y.XmlText`],
    [Văn bản XML kế thừa từ Y.Text, hỗ trợ xuất XML string],
    [Nội dung text trong XML hierarchy],
  ),
  caption: [Các shared data types của Yjs],
)

Mỗi shared type hỗ trợ observe để theo dõi thay đổi:

- `observe()`: lắng nghe thay đổi trực tiếp trên type, trả về delta (Y.Array,
  Y.Text) hoặc key change (Y.Map)
- `observeDeep()`: lắng nghe thay đổi trên toàn bộ cây shared types, gồm nested
  types

=== Editor Bindings

Yjs không đi kèm editor riêng mà tích hợp với editor phổ biến qua binding. Editor
binding là cầu nối giữa Y.Text/Y.XmlFragment và editor, tự động đồng bộ nội dung
và con trỏ.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    table.header([*Editor*], [*Gói binding*], [*Mô tả*]),
    [ProseMirror],
    [`y-prosemirror`],
    [Toolkit xây dựng rich text editor với document model có cấu trúc, hỗ trợ
      schema tùy chỉnh và collaborative editing thông qua Yjs],

    [Tiptap],
    [`@tiptap/extension-collaboration`],
    [Headless rich text editor framework dựa trên ProseMirror, cung cấp
      extension chính thức tích hợp Yjs với API đơn giản],

    [Monaco],
    [`y-monaco`],
    [Code editor lõi của VS Code, hỗ trợ collaborative code editing với syntax
      highlighting, IntelliSense và multi-cursor thông qua Yjs],

    [Quill],
    [`y-quill`],
    [Rich text editor với API đơn giản, hỗ trợ collaborative editing và cursor
      awareness thông qua Yjs],

    [CodeMirror],
    [`y-codemirror.next`],
    [Code editor nhẹ, có thể mở rộng, tích hợp Yjs qua extension yCollab hỗ trợ
      shared undo/redo và awareness],

    [Remirror],
    [`@remirror/extension-yjs`],
    [ProseMirror-based editor với kiến trúc extension, tích hợp Yjs thông qua
      y-prosemirror, hỗ trợ collaboration và real-time editing],
  ),
  caption: [Các editor được Yjs hỗ trợ thông qua editor bindings],
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
    [Provider mặc định, sử dụng mô hình client-server qua WebSocket với server
      đi kèm có thể mở rộng, hỗ trợ persistence, authentication và awareness],

    [`y-webrtc`],
    [WebRTC],
    [Provider peer-to-peer sử dụng WebRTC, không cần server trung tâm cho dữ
      liệu, phù hợp demo và ứng dụng nhỏ],

    [`y-webxdc`],
    [WebXDC],
    [Provider chạy trong ứng dụng chat như Delta Chat, Cheogram, đồng bộ dữ liệu
      qua tin nhắn chat với mã hóa end-to-end],

    [`y-dat`],
    [Dat Protocol],
    [Provider sử dụng giao thức Dat (Hypercore Protocol), hỗ trợ peer-to-peer
      phân tán với khả năng đồng bộ dữ liệu mạnh mẽ],

    [`y-sweet`],
    [WebSocket],
    [Provider đám mây từ Jamsocket, khởi tạo server real-time tự động, hỗ trợ
      persistence S3, authentication và offline support],

    [Liveblocks],
    [WebSocket],
    [Nền tảng đám mây toàn diện, cung cấp Yjs provider với tự động scale,
      persistence, presence và REST API],

    [SuperViz],
    [WebSocket],
    [Nền tảng collaboration đa kênh, tích hợp Yjs provider với hỗ trợ real-time
      đồng bộ, awareness và quản lý phiên làm việc],

    [Hocuspocus],
    [WebSocket],
    [Server WebSocket chuyên dụng cho Yjs từ Tiptap Collective, hỗ trợ
      persistence, authentication, webhook và extension],
  ),
  caption: [Các connection providers của Yjs],
)

Dự án chọn Hocuspocus @hocuspocus làm provider chính nhờ khả năng mở rộng và
tích hợp sâu với Tiptap/BlockNote.

=== Undo/Redo Manager

Yjs cung cấp `Y.UndoManager` cho undo/redo trên shared types, lưu thao tác đảo
ngược trên undo-stack và thực thi lại khi cần.

- *Scoped tracking*: theo dõi thay đổi theo transaction origin, chỉ undo thay đổi
  từ nguồn cụ thể (ví dụ: chỉ undo của user hiện tại, không undo từ remote)
- *Capture timeout*: thay đổi trong captureTimeout (mặc định 500ms) tự động gộp
  vào một StackItem, giúp undo mượt mà hơn
- *Metadata*: gắn thêm thông tin (ví dụ vị trí con trỏ) vào StackItem để khôi
  phục trạng thái chính xác khi undo/redo

=== Awareness

Awareness chia sẻ thông tin trạng thái tạm thời giữa người dùng (vị trí con trỏ,
vùng chọn, tên, màu sắc). Không lưu trong Y.Doc mà dùng Awareness CRDT riêng
trong `y-protocols`.

- *Không bền vững*: dữ liệu tự động xóa khi người dùng ngắt kết nối
- *Timeout tự động*: client không gửi tín hiệu trong 30 giây bị đánh dấu offline
- *Tùy chỉnh dữ liệu*: trường awareness không chuẩn hóa, gửi JSON-encodable bất
  kỳ. Editor binding thường dùng `"user"` (tên, màu) và `"cursor"` (vị trí con trỏ)

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
