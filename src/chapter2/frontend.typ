== Tổng quan về React và NextJS

=== Giới thiệu

Frontend của dự án được xây dựng với React @react, một thư viện JavaScript cho
xây dựng user interfaces với component-based architecture. Next.js @nextjs được
sử dụng như một framework trên React, cung cấp server-side rendering, static
generation, và routing tích hợp. Zustand @zustand được sử dụng cho state
management.

=== React

React là thư viện JavaScript mã nguồn mở từ Meta (Facebook) cho xây dựng user
interfaces @react. React sử dụng virtual DOM để tối ưu rendering,
component-based architecture cho reusability, và declarative syntax làm cho code
dễ đọc hơn.

=== Next.js

Next.js là framework React được phát triển bởi Vercel @nextjs, cung cấp
Server-Side Rendering (SSR), Static Site Generation (SSG), Incremental Static
Regeneration (ISR), và API routes tích hợp. Next.js giúp tối ưu hiệu suất và SEO
mà không cần setup phức tạp.

=== Zustand - State Management

Zustand là state management library cho React @zustand, cung cấp một cách đơn
giản và lightweight để quản lý application state. Zustand tránh boilerplate của
Redux, cung cấp API minimal nhưng mạnh mẽ, và hỗ trợ devtools integration.

=== Ưu điểm

- React: Component reusability, large ecosystem, excellent developer experience
- Next.js: Built-in optimization, zero-config setup, excellent SEO, API routes
- Zustand: Simple API, minimal boilerplate, excellent performance

=== Nhược điểm

- React: Learning curve cho beginners, complex state management patterns
- Next.js: Learning curve, routing may be counterintuitive, SSR adds complexity
- Zustand: Smaller ecosystem so với Redux, ít middleware built-in
