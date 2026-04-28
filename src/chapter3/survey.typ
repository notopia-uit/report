== Khảo sát hiện trạng

=== Các hệ thống hiện có

Hiện nay có nhiều hệ thống quản lý kiến thức cá nhân khác nhau, mỗi hệ thống đều
có những ưu điểm và nhược điểm riêng. Dưới đây là một số hệ thống phổ biến mà
nhóm đã khảo sát.

==== Notion

#figure(
  image("../assets/images/notion-logo.svg", height: 80pt),
  caption: [Notion logo],
)

Notion là một nền tảng làm việc tích hợp được ra mắt vào năm 2013, kết hợp tài
liệu, cơ sở dữ liệu, wiki và quản lý dự án trong một nền tảng duy nhất. Với hơn
30 triệu người dùng toàn cầu, Notion đã phát triển từ một ứng dụng ghi chú đơn
giản thành một hệ thống kiến thức toàn diện.

Lịch sử phát triển của Notion bắt đầu với phiên bản 1.0 tập trung vào hợp tác
tài liệu thời gian thực và tổ chức tài liệu phong cách wiki. Điểm đột phá lớn
nhất đến với phiên bản 2.0 vào tháng 3 năm 2018 khi giới thiệu tính năng
Database, nâng cấp Notion lên một tầm cao mới và cho phép tạo ra các công cụ ứng
dụng. Hiện tại, Notion liên tục được cập nhật với các tính năng mới như AI
agents, hệ thống tự động hóa hoàn chỉnh và nhiều loại giao diện cơ sở dữ liệu
mới.

Các tính năng chính bao gồm editor module hóa với các khối có thể sắp xếp linh
hoạt, cơ sở dữ liệu đa dạng _(bảng, Kanban, lịch trình, gallery)_, khả năng hợp
tác thời gian thực, và tích hợp AI. Giao diện của Notion được đánh giá cao về
tính thẩm mỹ và sự linh hoạt, cho phép người dùng tùy chỉnh không gian làm việc
theo nhu cầu riêng.

Tuy nhiên, Notion cũng có những hạn chế nhất định. Hệ thống phân cấp và tổ chức
có thể trở nên phức tạp với các dự án lớn. Tốc độ tải trang đôi khi chậm với các
cơ sở dữ liệu chứa nhiều dữ liệu. Mặc dù cung cấp nhiều tính năng, Notion không
chuyên sâu bằng các công cụ chuyên dụng trong từng lĩnh vực cụ thể.

==== Obsidian

#figure(
  image("../assets/images/obsidian-logo.svg", height: 80pt),
  caption: [Obsidian logo],
)

Obsidian là một ứng dụng ghi chú và quản lý kiến thức dựa trên tệp Markdown,
được phát triển bởi Shida Li và Erica Xu và ra mắt vào năm 2020. Với triết lý
"local-first", Obsidian đảm bảo dữ liệu của người dùng luôn nằm trên thiết bị
của họ, mang lại quyền sở hữu và tính linh hoạt tối đa.

Obsidian hoạt động với một "vault" chứa các tài liệu văn bản, mỗi ghi chú mới
tạo ra một tệp Markdown riêng. Điểm mạnh nổi bật nhất của Obsidian là khả năng
liên kết hai chiều _(bidirectional linking)_ và chế độ xem graph _(graph view)_
giúp người dùng hình dung mối quan hệ giữa các ghi chú. Người dùng có thể tạo
liên kết nội dung bằng Wikilinks hoặc liên kết Markdown thông thường, và tất cả
các liên kết này đều được hiển thị trong graph view tương tác.

Các tính năng chính bao gồm chế độ xem graph giúp phân tích mối quan hệ giữa các
ghi chú, Canvas cho phép sắp xếp ghi chú trực quan không giới hạn, hệ thống
plugin mở rộng do cộng đồng phát triển, và khả năng tích hợp với nhiều công cụ
khác. Obsidian cũng hỗ trợ chế độ chỉnh sửa song song giữa Source Mode và Live
Preview, cùng với đầy đủ các công cụ tìm kiếm và tổ chức.

Mặc dù mạnh mẽ, Obsidian cũng có những thách thức. Learning curve khá cao, đặc
biệt với người mới bắt đầu. Thiếu tính năng hợp tác thời gian thực là một hạn
chế quan trọng. Giao diện mặc định có thể trông đơn giản so với các đối thủ cạnh
tranh. Obsidian phù hợp nhất với các nhà nghiên cứu, nhà văn, lập trình viên và
người làm việc kiến thức muốn kiểm soát sâu sắc ghi chú của mình.

==== `jackyzha0/quartz`

#figure(
  image("../assets/images/quartz-logo.png", height: 80pt),
  caption: [Quartz logo],
)

Quartz là một static-site generator nhanh, được thiết kế để biến nội dung
Markdown thành các website hoàn toàn chức năng. Được phát triển bởi jackyzha0,
Quartz hoạt động như một giải pháp self-hosted thay thế cho Obsidian Publish,
cho phép người dùng xuất bản ghi chú và digital gardens của mình lên web một
cách dễ dàng.

Quartz tương thích hoàn toàn với Obsidian, hỗ trợ đầy đủ các tính năng như
wikilinks, backlinks, transclusions, graph view và full-text search. Nó được xây
dựng trên công nghệ TypeScript và cung cấp khả năng tùy chỉnh cao thông qua JSX
layouts và page components. Một trong những điểm mạnh của Quartz là tốc độ tải
trang cực nhanh và kích thước bundle nhỏ.

Các tính năng chính bao gồm hỗ trợ LaTeX, Mermaid diagrams, dark mode,
breadcrumbs, popover previews, internationalization, và hệ thống comments.
Quartz cũng hỗ trợ Docker, RSS feeds, và có hệ thống plugin mở rộng. Nó đặc biệt
phù hợp cho các cá nhân muốn chia sẻ kiến thức của mình dưới dạng website công
khai hoặc digital garden.

Mặc dù mạnh mẽ, Quartz cũng có những hạn chế. Nó yêu cầu kiến thức kỹ thuật về
Git và hosting để thiết lập. Không có tính năng hợp tác thời gian thực như
Notion. Giao diện quản lý nội dung không trực quan bằng các ứng dụng desktop.
Quartz phù hợp nhất với các nhà phát triển, sinh viên, và giáo viên muốn xuất
bản ghi chú của mình dưới dạng website.

=== So sánh các hệ thống hiện có

#figure(
  table(
    columns: (auto, auto, auto),
    align: left,
    [*Hệ thống*], [*Ưu điểm*], [*Nhược điểm*],
    [Notion],
    [Giao diện đẹp, đa tính năng, hợp tác thời gian thực],
    [Phức tạp khi quản lý dự án lớn, tốc độ tải chậm với dữ liệu lớn],

    [Obsidian],
    [Local-first, graph view mạnh mẽ, liên kết hai chiều, plugin đa dạng],
    [Thiếu hợp tác thời gian thực, learning curve cao],

    [Quartz],
    [Tốc độ nhanh, tương thích Obsidian, dễ xuất bản website, tùy chỉnh cao],
    [Yêu cầu kiến thức kỹ thuật, không có hợp tác thời gian thực, giao diện đơn
      giản],
  ),
  caption: [So sánh các hệ thống hiện có],
)

Xuất phát từ đó, nhóm đã xác định được những điểm mạnh và hạn chế của từng hệ
thống, từ đó rút ra những bài học quan trọng để áp dụng vào thiết kế hệ thống
của mình. Nhưng cũng cần nhấn mạnh rằng Notopia không nhằm mục đích thay thế
hoàn toàn các hệ thống hiện có, mà chỉ thực hiện một số chức năng nhất định,
mang tính chất nghiên cứu, học tập, áp dụng công nghệ và quy trình phát triển
phần mềm.
