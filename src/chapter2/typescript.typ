== Tổng quan về TypeScript <general-for-typescript>

=== Giới thiệu

TypeScript là một ngôn ngữ lập trình mã nguồn mở được phát triển và duy trì bởi
Microsoft. TypeScript là một superset của JavaScript, nghĩa là mọi code
JavaScript hợp lệ đều là code TypeScript hợp lệ. Được ra mắt lần đầu vào năm
2012 bởi Anders Hejlsberg (người thiết kế C\#), TypeScript bổ sung hệ thống kiểu
dữ liệu tĩnh trên nền tảng JavaScript để tăng độ tin cậy và khả năng duy trì của
code.

TypeScript hoạt động thông qua một bước biên dịch: mã TypeScript được biên dịch
thành mã JavaScript, sau đó được chạy trên JavaScript runtime (trình duyệt hoặc
Node.js).

#figure(
  image("../assets/images/typescript-logo.svg", height: 80pt),
  caption: [TypeScript logo],
)

=== Ưu điểm

TypeScript mang lại nhiều lợi ích khi phát triển ứng dụng JavaScript:
- Phát hiện lỗi compile-time, giảm bugs
- Types tự động document code
- Tương thích mọi thư viện JavaScript

=== Nhược điểm

Bên cạnh các ưu điểm, TypeScript có một số hạn chế:
- Cần học type system và features như decorators, generics
- Cần biên dịch, tăng thời gian build
- Bước compile/transpile được thực hiện bằng nhiều công cụ

=== Hệ sinh thái và công cụ

Dự án `microsoft/typescript-go` đang phát triển một implementation của
TypeScript được viết hoàn toàn bằng Go, thay vì TypeScript hiện tại được viết
bằng TypeScript. Dự án này hướng tới việc cải thiện hiệu suất.

Dự án được thiết lập với monorepo, các package được chia build riêng biệt
(`SWC`, `Rspack`, `tsgo`, `vite`) để tăng tốc thời gian build, Oxlint thay cho
ESLint, Oxfmt thay cho Prettier để tăng tốc độ linting và formatting, CI, ngoại
trừ web vì sử dụng NextJS.
