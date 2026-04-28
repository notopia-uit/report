== Tổng quan về Meilisearch <general-for-meilisearch>

=== Giới thiệu

Meilisearch là một search engine mã nguồn mở được viết bằng Rust @meilisearch,
thiết kế để cung cấp trải nghiệm tìm kiếm nhanh, liên quan, và dễ sử dụng.
Meilisearch được phát triển với mục tiêu là một giải pháp tìm kiếm dễ triển khai
hơn Elasticsearch, phù hợp cho các ứng dụng từ nhỏ đến lớn.

=== Ưu điểm

Meilisearch mang lại nhiều lợi ích cho phát triển search:

- Easy to Deploy, single binary executable, dễ triển khai trên bất kỳ hạ tầng
  nào
- Fast Search, hiệu suất cao với latency thấp nhờ Rust implementation
- Rich Features, hỗ trợ full-text search, hybrid search, facets, filters,
  sorting, ranking
- Typo Tolerance, tự động xử lý typo và fuzzy search
- Multi-Language Support, hỗ trợ indexing và search cho nhiều ngôn ngữ
- Open Source, mã nguồn mở, có thể tùy chỉnh theo nhu cầu
- Low Resource Usage, sử dụng ít CPU và RAM so với Elasticsearch

=== Nhược điểm

Bên cạnh các ưu điểm, Meilisearch có một số hạn chế:

- Community Size, cộng đồng nhỏ hơn Elasticsearch, ít plugin có sẵn
- Advanced Features, thiếu một số advanced features của Elasticsearch, không hỗ
  kiểu dữ liệu nested phức tạp
