== Hạn chế CI của Nx và giải pháp custom cache

Đối với CI, Nx hướng developer sử dụng hệ sinh thái của Nx Cloud, nhưng nhóm đã
tự xây dựng một giải pháp cache riêng cho Github Actions,
`KevinNitroG/nx-cache-action` @nx_cache_action. Script hoạt động theo cơ chế
cache từng project thay vì toàn bộ cache lớn của cả workspace.

Script được lấy cảm hứng từ `raegen/nx` @raegen_nx #footnote[`raegen/nx` không
  được hỗ trợ chính thức bởi Nx, đã deprecated], cache tại project level. Nhưng
cơ chế hoạt động khác biệt:
+ Script sẽ khởi động một NodeJS ExpressJS server implement OpenAPI Spec
  @nx_remote_cache_openapi_spec chính thức từ Nx.
+ Forward lệnh Nx cho 1 child process, kèm theo thiết lập để Nx gửi request
  cache đến server.
+ Server nhận request cache, xử lý giao tiếp với Github Actions cache API thông
  qua `actions/toolkit/cache` @actions_toolkit_cache.

Vì Nx sẽ lưu cache từng task ước chừng khoảng một tháng kể từ lần cuối sử dụng
mới được xoá. Đối với dự án khi không sử dụng `KevinNitroG/nx-cache-action`,
cache được lưu theo dạng toàn bộ project task cache, có thể lên đến khoảng 5GB
trong mỗi lần lưu cache. Và hiển nhiên rằng, mỗi lần chạy thay đổi là một cache
mới được tạo ra. Nếu có 10 commit được tạo ra và thay đổi source code, thì sẽ có
10 cache được tạo ra, tổng dung lượng cache có thể lên đến 50GB, vượt qua mức
10GB giới hạn của Github Actions cache. Hơn nữa, vẫn cần chừa dung lượng để
cache node modules, go packages, system dependencies, v.v..., nên việc cache
toàn bộ project task cache là không tối ưu.

Khi sử dụng `KevinNitroG/nx-cache-action`, cache được lưu theo dạng từng project
nhỏ, mỗi project task có thể chỉ khoảng vài trăm KB, đến hơn 10MB tùy vào task,
và chỉ khi nào project đó thay đổi source code mới tạo cache mới. Điều này giúp
tối ưu hóa dung lượng cache, tránh vượt quá giới hạn của Github Actions, và tăng
hiệu quả cache hit.

Script có một nhược điểm là phải thông qua `actions/toolkit/cache` để download
cache về local, và pipe cache vào lại Nx process. Có thể hiểu là cache đã được
tải xuống nhưng lưu ở một nơi khác, và phải truyền vào Nx process thông qua HTTP
request một lần nữa. Nhưng đây là cách dễ dàng nhất, không phải giao tiếp trực
tiếp với Github Actions cache Rest API phức tạp hơn.
