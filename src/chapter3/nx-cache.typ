== Hạn chế CI của Nx và giải pháp custom cache

Nx hướng developer dùng Nx Cloud cho CI, nhưng nhóm đã tự xây dựng giải pháp
cache riêng cho GitHub Actions: `KevinNitroG/nx-cache-action` @nx_cache_action.
Script lấy cảm hứng từ `raegen/nx` @raegen_nx (đã deprecated), nhưng cơ chế khác
biệt: khởi động NodeJS ExpressJS server implement OpenAPI Spec của Nx
@nx_remote_cache_openapi_spec, forward lệnh Nx cho child process, server nhận
request cache và giao tiếp với GitHub Actions cache API qua
`actions/toolkit/cache` @actions_toolkit_cache.

Vấn đề: Nx lưu cache task khoảng một tháng kể từ lần cuối sử dụng. Không dùng
`nx-cache-action`, cache được lưu toàn bộ project task cache (~5GB/lần). 10
commit thay đổi source code tạo 10 cache (~50GB), vượt giới hạn 10GB của GitHub
Actions. Chưa kể còn phải cache node modules, Go packages, system dependencies.

Với `nx-cache-action`, cache lưu theo từng project nhỏ (vài trăm KB đến hơn
10MB/task), chỉ tạo cache mới khi project đó thay đổi. Điều này tối ưu dung
lượng, tránh vượt giới hạn GitHub Actions, tăng cache hit.

Nhược điểm: cache phải download qua `actions/toolkit/cache` rồi pipe vào lại Nx
process qua HTTP, thay vì giao tiếp trực tiếp với GitHub Actions cache Rest API.
Đây là cách dễ dàng nhất để triển khai.
