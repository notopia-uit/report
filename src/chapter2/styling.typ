== Tổng quan về TailwindCSS, PostCSS, shadcnui

=== Giới thiệu

Styling được thực hiện bằng TailwindCSS, một CSS framework utility-first, kết
hợp với PostCSS cho các biến đổi CSS nâng cao. ShadcnUI cung cấp các pre-built
components theo design system với styling được tích hợp sẵn.

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: -200pt,
    image("../assets/images/tailwindcss-logo.svg", height: 80pt),
    image("../assets/images/shadcnui-logo.svg", height: 80pt),
  ),
  caption: [TailwindCSS, ShadcnUI Logo],
)

=== TailwindCSS

TailwindCSS là CSS framework utility-first được viết bằng PostCSS. Thay vì viết
CSS tùy chỉnh, developer sử dụng các utility classes được định sẵn. Approach này
tăng tốc độ phát triển, tăng consistency, và giảm CSS bundle size.

=== PostCSS

PostCSS là một công cụ cho việc biến đổi CSS sử dụng JavaScript plugins. PostCSS
cung cấp khả năng mở rộng, hỗ trợ modern CSS features, vendor prefixing tự động,
và tích hợp tốt với TailwindCSS.

=== shadcnui <general-for-shadcnui>

ShadcnUI cung cấp một bộ sưu tập các component React đẹp mắt, accessible, và tùy
chỉnh cao. Components được xây dựng trên Radix UI cho accessibility và được
styled bằng TailwindCSS cho consistency với design system.

=== Ưu điểm

TailwindCSS, PostCSS và ShadcnUI mang lại nhiều lợi ích cho styling:
- TailwindCSS: Phát triển nhanh, thiết kế nhất quán, output được tối ưu
- PostCSS: Khả năng mở rộng cao, biến đổi CSS mạnh mẽ, hỗ trợ CSS hiện đại
- ShadcnUI: Component đẹp, accessibility cao, kiểm soát tuỳ chỉnh hoàn toàn

=== Nhược điểm

Bên cạnh các ưu điểm, các công nghệ styling này có một số hạn chế:
- TailwindCSS: HTML dài dòng, learning curve dốc cho developer quen CSS-first
- ShadcnUI: Tuỳ chỉnh component có thể phức tạp, quản lý dependency
