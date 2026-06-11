== Tổng quan về React và NextJS <general-for-frontend>

=== Giới thiệu

Frontend của dự án được xây dựng với React, một thư viện JavaScript cho xây dựng
user interfaces với component-based architecture. Next.js được sử dụng như một
framework trên React, cung cấp server-side rendering, static generation, và
routing tích hợp.
// Redux Toolkit được sử dụng cho state management.

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: -100pt,
    image("../assets/images/react-logo.svg", height: 80pt),
    image("../assets/images/nextjs-logo.svg", height: 80pt),
    // image("../assets/images/redux-logo.svg", height: 80pt),
  ),
  caption: [React, NextJS Logo],
)

=== React <general-for-react>

React là thư viện JavaScript mã nguồn mở từ Meta (Facebook) cho xây dựng user
interfaces. React sử dụng virtual DOM để tối ưu rendering, component-based
architecture cho reusability, và declarative syntax làm cho code dễ đọc hơn.

=== Next.js

Next.js là framework React được phát triển bởi Vercel, cung cấp Server-Side
Rendering (SSR), Static Site Generation (SSG), Incremental Static Regeneration
(ISR), và API routes tích hợp. Next.js giúp tối ưu hiệu suất và SEO mà không cần
setup phức tạp.

// === Redux Toolkit
//
// Redux Toolkit là state management library cho React, cung cấp một cách đơn giản
// để quản lý application state. Redux Toolkit giảm boilerplate của Redux truyền
// thống, hỗ trợ DevTools integration, middleware support, và immer integration cho
// immutable updates.

=== Ưu điểm

React và NextJS mang lại nhiều lợi ích cho phát triển frontend:
- React: Component-based, tái sử dụng code, hệ sinh thái phong phú
- NextJS: Tối ưu sẵn có, zero-config, SEO tốt, API routes tích hợp
// - Redux Toolkit: DevTools mạnh mẽ, hỗ trợ middleware, kiến trúc dễ mở rộng

=== Nhược điểm

Bên cạnh các ưu điểm, các công nghệ frontend này có một số hạn chế:
- React: Learning curve cao, quản lý state phức tạp
- NextJS: Routing đôi khi không trực quan, SSR thêm độ phức tạp
// - Redux Toolkit: Nhiều boilerplate hơn so với các giải pháp nhẹ hơn, learning
// curve dốc hơn
