== Tổng quan về React và NextJS <general-for-frontend>

=== Giới thiệu

Frontend của dự án được xây dựng với React @react, một thư viện JavaScript cho
xây dựng user interfaces với component-based architecture. Next.js @nextjs được
sử dụng như một framework trên React, cung cấp server-side rendering, static
generation, và routing tích hợp. Redux Toolkit @redux_toolkit được sử dụng cho
state management.

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: -100pt,
    image("../assets/images/react-logo.svg", height: 80pt),
    image("../assets/images/nextjs-logo.svg", height: 80pt),
    image("../assets/images/redux-logo.svg", height: 80pt),
  ),
  caption: [React, NextJS, Redux Logo],
)

=== React <general-for-react>

React là thư viện JavaScript mã nguồn mở từ Meta (Facebook) cho xây dựng user
interfaces @react. React sử dụng virtual DOM để tối ưu rendering,
component-based architecture cho reusability, và declarative syntax làm cho code
dễ đọc hơn.

=== Next.js

Next.js là framework React được phát triển bởi Vercel @nextjs, cung cấp
Server-Side Rendering (SSR), Static Site Generation (SSG), Incremental Static
Regeneration (ISR), và API routes tích hợp. Next.js giúp tối ưu hiệu suất và SEO
mà không cần setup phức tạp.

=== Redux Toolkit - State Management

Redux Toolkit là state management library cho React @redux_toolkit, cung cấp một
cách đơn giản để quản lý application state. Redux Toolkit giảm boilerplate của
Redux truyền thống, hỗ trợ DevTools integration, middleware support, và immer
integration cho immutable updates.

=== Ưu điểm

- React: Component reusability, large ecosystem, excellent developer experience
- Next.js: Built-in optimization, zero-config setup, excellent SEO, API routes
- Redux Toolkit: Powerful DevTools, middleware support, scalable architecture

=== Nhược điểm

- React: Learning curve cho beginners, complex state management patterns
- Next.js: Learning curve, routing may be counterintuitive, SSR adds complexity
- Redux Toolkit: More boilerplate so với lighter alternatives, steeper learning
  curve
