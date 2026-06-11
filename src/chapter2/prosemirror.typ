== Tổng quan về ProseMirror <general-for-prosemirror>

=== Giới thiệu

ProseMirror là toolkit xây dựng rich text editor trên nền tảng web, phát triển
bởi Marijn Haverbeke @prosemirror. Không giống editor truyền thống cung cấp sẵn
giao diện soạn thảo, ProseMirror cung cấp các viên gạch nền tảng để tự xây dựng
editor phù hợp.

ProseMirror sử dụng document model có cấu trúc chặt chẽ thay vì xử lý HTML tự
do, cho phép kiểm soát chính xác nội dung và hỗ trợ các tính năng nâng cao như
collaborative editing, schema validation và transform recording.

#figure(
  image("../assets/images/prosemirror-logo.svg", height: 80pt),
  caption: [ProseMirror Logo],
)

=== Kiến trúc

ProseMirror được tổ chức thành bốn thư viện cốt lõi, mỗi thư viện đảm nhận một
trách nhiệm riêng biệt trong hệ thống:

- *prosemirror-model*: định nghĩa cấu trúc tài liệu qua schema, mô tả node
  (paragraph, heading, image) và mark (bold, italic, link) được phép cùng quy
  tắc lồng ghép, tương tự database schema đảm bảo tài liệu luôn hợp lệ.

- *prosemirror-state*: quản lý EditorState gồm tài liệu, selection, plugin. Mọi
  thay đổi thực hiện qua Transaction — đối tượng bất biến mô tả chính xác thay
  đổi.

- *prosemirror-view*: rendering tài liệu lên DOM và xử lý tương tác người dùng
  (gõ phím, click, copy-paste), quản lý ánh xạ và cập nhật DOM khi state thay
  đổi.

- *prosemirror-transform*: ghi lại thay đổi dạng step có thể tái tạo và đảo
  ngược. Mỗi step là một đơn vị thay đổi nhỏ (chèn ký tự, xóa đoạn), nền tảng
  cho undo history và collaborative editing.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    table.header([*Thư viện*], [*Chức năng*], [*Vai trò*]),
    [`prosemirror-model`],
    [Schema, Document, Node, Mark],
    [Định nghĩa cấu trúc tài liệu hợp lệ],

    [`prosemirror-state`],
    [EditorState, Transaction, Plugin],
    [Quản lý trạng thái và luồng thay đổi],

    [`prosemirror-view`],
    [EditorView, DOM mapping, event handling],
    [Rendering và tương tác người dùng],

    [`prosemirror-transform`],
    [Step, Transform, mapping],
    [Ghi lại thay đổi dạng step có thể replay],
  ),
  caption: [Bốn thư viện cốt lõi của ProseMirror],
)

=== Collaborative Editing với ProseMirror

ProseMirror hỗ trợ collaborative editing qua plugin `prosemirror-collab`, quản
lý phiên bản tài liệu và client ID để đồng bộ qua máy chủ trung tâm (authority):

- *Phiên bản hóa*: mỗi tài liệu có phiên bản tăng dần theo số step đã xác nhận
  bởi authority. Client duy trì phiên bản cục bộ và gửi step chưa xác nhận lên
  server.
- *Gửi thay đổi*: editor tạo step mới, plugin collab đánh dấu "chưa gửi" và cung
  cấp qua `sendableSteps()`.
- *Nhận thay đổi*: client tạo receiveTransaction, ánh xạ selection qua step đã
  rebase để đảm bảo vị trí con trỏ hợp lý.

=== ProseMirror như một Editor Binding cho Yjs

Trong dự án, ProseMirror đóng vai trò editor binding cho Yjs qua
`y-prosemirror`:

- Yjs quản lý trạng thái cộng tác qua shared types _(@general-for-yjs)_, đảm bảo
  dữ liệu hội tụ giữa các client mà không cần authority tập trung
- ProseMirror cung cấp document model có cấu trúc và transform để ánh xạ từ
  Y.XmlFragment hoặc Y.Text thành tài liệu editor
- `y-prosemirror` kết nối hai hệ thống, tạo collaborative editor hoàn chỉnh

=== Vai trò so với Tiptap

ProseMirror là nền tảng cấp thấp xây dựng editor. Trong dự án, BlockNote
_(@general-for-blocknote)_ sử dụng Tiptap _(@general-for-tiptap)_ làm lớp trung
gian trên ProseMirror. Như vậy, ProseMirror là lõi hệ thống editor nhưng không
dùng trực tiếp mà qua Tiptap.
