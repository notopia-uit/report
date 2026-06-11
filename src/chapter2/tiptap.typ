== Tổng quan về Tiptap <general-for-tiptap>

=== Giới thiệu

Tiptap là headless rich text editor framework trên nền tảng ProseMirror @tiptap,
thuộc tổ chức ueberdosis (Tiptap Collective), cùng tổ chức phát triển Hocuspocus.

Khác biệt cốt lõi với ProseMirror là mức độ trừu tượng: ProseMirror là toolkit
cấp thấp cung cấp công cụ nền tảng, Tiptap là framework hoàn chỉnh với API thân
thiện, kiến trúc extension linh hoạt và tích hợp sẵn nhiều UI framework.

#figure(
  image("../assets/images/tiptap-logo.svg", height: 60pt),
  caption: [Tiptap Logo],
)

=== Kiến trúc

Tiptap được thiết kế theo ba trụ cột chính:

- *Extensions*: đơn vị chức năng cơ bản, định nghĩa node (paragraph, heading,
  image), mark (bold, italic, link) hoặc chức năng (placeholder, collaboration,
  undo/redo). Cho phép lắp ráp editor từ module nhỏ, chỉ gồm tính năng cần thiết.

- *Commands*: hàm thao tác editor, có thể xích chuỗi. Mỗi command trả về `true`
  nếu thành công, cho phép kiểm tra trạng thái trước khi thực thi.

- *Events*: hệ thống sự kiện vòng đời, can thiệp vào quá trình xử lý từ tạo tài
  liệu, selection change, cập nhật nội dung đến focus/blur.

#figure(
  table(
    columns: (auto, 2fr, 3.5fr),
    align: (left, left, left),
    table.header([*Kiến trúc*], [*Mô tả*], [*Ví dụ*]),
    [Extensions],
    [Đơn vị chức năng, định nghĩa node, mark, tính năng],
    [`StarterKit`, `Collaboration`, `Placeholder`],

    [Commands],
    [Hàm thao tác editor, có thể xích chuỗi],
    [`editor.chain().toggleBold().focus().run()`],

    [Events],
    [Sự kiện vòng đời editor],
    [`onCreate`, `onUpdate`, `onSelectionUpdate`],
  ),
  caption: [Ba trụ cột kiến trúc của Tiptap],
)

=== So sánh với ProseMirror

Bảng dưới đây phân biệt rõ vai trò của ProseMirror và Tiptap trong hệ sinh thái:

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    table.header([*Tiêu chí*], [*ProseMirror*], [*Tiptap*]),
    [Mức độ], [Low-level toolkit], [High-level framework],
    [Mục đích],
    [Cung cấp công cụ nền tảng],
    [Cho phép tạo editor nhanh, dễ dàng],

    [Kiến trúc],
    [4 thư viện riêng, tích hợp thủ công],
    [Thống nhất, extension-based],

    [Sử dụng],
    [Cần tự xây dựng editor từ đầu],
    [Cấu hình qua extensions, dùng ngay],

    [UI Framework], [Không hỗ trợ sẵn], [Hỗ trợ React, Vue, Svelte],
    [Hệ sinh thái],
    [Cộng đồng, plugin rải rác],
    [Kho extension tập trung, Pro features],
  ),
  caption: [So sánh giữa ProseMirror và Tiptap],
)

=== Tích hợp Yjs và Cộng tác

Tiptap cung cấp extension `@tiptap/extension-collaboration` tích hợp Yjs
_(@general-for-yjs)_:

- Đồng bộ nội dung editor với Y.Text/Y.XmlFragment qua `y-prosemirror`
- Tích hợp UndoManager của Yjs, thay thế undo/redo mặc định
- Hỗ trợ awareness hiển thị con trỏ cộng tác viên

Kết hợp với Hocuspocus _(@general-for-hocuspocus)_, Tiptap trở thành collaborative
editor hoàn chỉnh với máy chủ đồng bộ qua WebSocket.

=== Vai trò với BlockNote

BlockNote _(@general-for-blocknote)_ xây dựng trên Tiptap và ProseMirror:

- ProseMirror là động cơ — xử lý document model, transform, state management
- Tiptap là khung gầm — extension system, commands, events
- BlockNote là thân xe hoàn chỉnh — block component cho soạn thảo block-based

BlockNote tận dụng extension system của Tiptap để định nghĩa block (paragraph,
heading, image, table, quote) và thêm tính năng đặc thù như AI-powered editing,
drag-and-drop giữa các block.
