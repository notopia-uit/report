== Tổng quan về TailwindCSS, PostCSS, shadcnui

=== Giới thiệu

Styling được thực hiện bằng TailwindCSS @tailwindcss, một CSS framework
utility-first, kết hợp với PostCSS cho các biến đổi CSS nâng cao. ShadcnUI
@shadcnui cung cấp các pre-built components theo design system với styling được
tích hợp sẵn.

=== TailwindCSS

TailwindCSS là CSS framework utility-first được viết bằng PostCSS @tailwindcss.
Thay vì viết CSS tùy chỉnh, developer sử dụng các utility classes được định sẵn.
Approach này tăng tốc độ phát triển, tăng consistency, và giảm CSS bundle size.

=== PostCSS

PostCSS là một công cụ cho việc biến đổi CSS sử dụng JavaScript plugins. PostCSS
cung cấp khả năng mở rộng, hỗ trợ modern CSS features, vendor prefixing tự động,
và tích hợp tốt với TailwindCSS.

=== shadcnui <general-for-shadcnui>

ShadcnUI cung cấp một bộ sưu tập các component React đẹp mắt, accessible, và tùy
chỉnh cao @shadcnui. Components được xây dựng trên Radix UI cho accessibility và
được styled bằng TailwindCSS cho consistency với design system.

=== Ưu điểm

- TailwindCSS: Rapid development, consistent design, optimized output
- PostCSS: Extensible, powerful transformations, modern CSS support
- ShadcnUI: Beautiful components, high accessibility, full customization control

=== Nhược điểm

- TailwindCSS: HTML verbosity, steep learning curve cho CSS-first developers
- ShadcnUI: Component customization có thể phức tạp, dependency management
