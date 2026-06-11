== Tổng quan về Tiptap <general-for-tiptap>

=== Giới thiệu

Tiptap là headless rich text editor framework trên nền tảng ProseMirror @tiptap,
thuộc tổ chức ueberdosis (Tiptap Collective), cùng tổ chức phát triển
Hocuspocus.

Khác biệt cốt lõi với ProseMirror là mức độ trừu tượng: ProseMirror là toolkit
cấp thấp cung cấp công cụ nền tảng, Tiptap là framework hoàn chỉnh với API thân
thiện, kiến trúc extension linh hoạt và tích hợp sẵn nhiều UI framework.

#figure(
  image("../assets/images/tiptap-logo.svg", height: 60pt),
  caption: [Tiptap Logo],
)

=== Kiến trúc

Tiptap được thiết kế theo ba trụ cột chính:

- *Extensions*: đơn vị chức năng cơ bản, định nghĩa node, mark hoặc chức năng
  (placeholder, collaboration, undo/redo). Cho phép lắp ráp editor từ module
  nhỏ.
- *Commands*: hàm thao tác editor, có thể xích chuỗi, mỗi command trả về `true`
  nếu thành công.
- *Events*: hệ thống sự kiện vòng đời, can thiệp vào quá trình xử lý từ tạo tài
  liệu đến focus/blur.

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

Kết hợp với Hocuspocus _(@general-for-hocuspocus)_, Tiptap trở thành
collaborative editor hoàn chỉnh với máy chủ đồng bộ qua WebSocket.

=== Vai trò với BlockNote

BlockNote _(@general-for-blocknote)_ xây dựng trên Tiptap và ProseMirror:
ProseMirror là động cơ (document model, transform, state management), Tiptap là
khung gầm (extension system, commands, events), BlockNote là thân xe hoàn chỉnh
(block component cho soạn thảo block-based).
