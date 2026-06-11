== Tổng quan về Meilisearch <general-for-meilisearch>

=== Giới thiệu

Meilisearch là một search engine mã nguồn mở được viết bằng Rust, thiết kế để
cung cấp trải nghiệm tìm kiếm nhanh, liên quan, và dễ sử dụng. Meilisearch được
phát triển với mục tiêu là một giải pháp tìm kiếm dễ triển khai hơn
Elasticsearch, phù hợp cho các ứng dụng từ nhỏ đến lớn.

#figure(
  image("../assets/images/meilisearch-logo.svg", height: 80pt),
  caption: [Meilisearch Logo],
)

=== Ưu điểm

Meilisearch mang lại nhiều lợi ích cho phát triển search:
- Single binary, dễ triển khai
- Hiệu suất cao, latency thấp nhờ Rust
- Full-text search, hybrid search, facets, filters, sorting, ranking
- Tự động xử lý typo và fuzzy search
- Indexing và search đa ngôn ngữ
- Mã nguồn mở, tùy chỉnh theo nhu cầu
- Ít tốn CPU và RAM hơn Elasticsearch

=== Nhược điểm

Bên cạnh các ưu điểm, Meilisearch có một số hạn chế:
- Cộng đồng nhỏ hơn Elasticsearch, ít plugin
- Thiếu một số advanced features, không hỗ trợ nested type phức tạp
