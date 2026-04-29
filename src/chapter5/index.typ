= Kết luận <conclusion>

#emph[
  Chương này trình bày phần kết luận của đồ án, nhằm tổng hợp và đánh giá các
  kết quả đạt được trong quá trình nghiên cứu, phân tích, thiết kế và xây dựng
  hệ thống. Nội dung chương tập trung vào việc đánh giá sản phẩm đã triển khai,
  nhận xét những thuận lợi, khó khăn, ưu điểm và hạn chế của hệ thống, đồng thời
  đề xuất các hướng phát triển trong tương lai nhằm nâng cao tính hoàn thiện và
  khả năng ứng dụng thực tế.
]

== Kết quả đạt được

=== Về sản phẩm

Sau quá trình phát triển, nhóm đã hoàn thiện được hệ thống ghi chú với đầy đủ
các tính năng đã đề ra:

- Ứng dụng Web cho người dùng cuối, cho phép quản lý và tổ chức ghi chú
- Hỗ trợ cộng tác thời gian thực quyền hạn riêng
- Tích hợp tìm kiếm ghi chú
- Backend API với kiến trúc microservices, đảm bảo hiệu suất cao
- Source code được tổ chức trong monorepo tại
  https://github.com/notopia-uit/notopia
- Document website tại https://notopia-uit.github.io/notopia, gồm các diagram và
  OpenAPI contract
- Source code báo cáo tại https://github.com/notopia-uit/report, viết bằng Typst

=== Về công nghệ

Dự án đã áp dụng thành công các công nghệ hiện đại:

- Tiếp cận mô hình block-based của blocknote _(@general-for-blocknote)_, mô hình
  CDRT từ yjs và hỗ trợ cộng tác từ công nghệ Hocuspocus _(@general-for-yjs)_
- React, NextJS, TypeScript, TailwindCSS, Shadcnui ở frontend development
- Go _(Golang)_ _(@general-for-go)_ và NestJS _(@general-for-nestjs)_ framework
  ở backend services
- Phân quyền với thư viện Casbin mạnh mẽ _(@general-for-casbin)_
- Quản lý người dùng thông qua Oauth2/OIDC với Authentik
  _(@general-for-authentik)_
- gRPC cho communication giữa các microservices _(@general-for-grpc)_
- Gateway API với Traefik _(@general-for-traefik)_
- Database management, kết hợp sử dụng SQL thuần và ORM
  _(@general-for-database)_
- Tìm kiếm thông minh với Meilisearch _(@general-for-meilisearch)_
- Docker containerization
- CI/CD pipeline với GitHub Actions
- Quản lý monorepo, CI pipeline với Nx, giúp tối ưu hóa workflow, cache riêng lẻ
  từng project nhỏ, và tăng hiệu quả phát triển _(@general-for-nx)_

Trong đó, dự án đã đặc biệt tiếp cận đến một số công nghệ đặc biệt mới như:

==== Công cụ quản lý monorepo Nx

Nhóm đã tối ưu hoá workflow, thiết lập từ code generate, lint, test, build,
deploy cho từng project nhỏ trong monorepo bằng công cụ Nx. Nhưng đối với CI, Nx
hướng developer sử dụng hệ sinh thái của Nx Cloud, nhưng nhóm đã tự xây dựng một
giải pháp cache riêng cho Github Actions.

`KevinNitroG/nx-cache-action` @nx_cache_action được phát triển bởi thành viên
trong nhóm _(Trần Nguyễn Thái Bình)_, hỗ trợ Nx cache trong GitHub Actions, tối
ưu hóa build times trong CI/CD. Script hoạt động theo cơ chế cache từng project
thay vì toàn bộ cache lớn của cả workspace, giúp cache hiệu quả hơn khi sử dụng
với Github Actions.

Script được lấy cảm hứng từ `raegen/nx` #footnote[https://github.com/raegen/nx,
  không hỗ trợ chính thức bởi Nx, đã bị deprecated], cache tại project level.
Nhưng cơ chế hoạt động khác biệt:
+ Script sẽ khởi động một NodeJS ExpressJS server implement OpenAPI Spec
  #footnote[https://nx.dev/docs/guides/tasks--caching/self-hosted-caching#open-api-specification]
  chính thức từ Nx.
+ Forward lệnh nx cho 1 child process, kèm theo thiêt lập để nx gửi request
  cache đến server.
+ Server nhận request cache, xử lý giao tiếp với Github Actions cache API thông
  qua `actions/toolkit/cache`
  #footnote[https://github.com/actions/toolkit/tree/main/packages/cache]

Script có một nhược điểm là phải thông qua `actions/toolkit/cache` để download
cache về local, và pipe cache vào lại Nx process. Nhưng đây là cách dễ dàng
nhất, không phải giao tiếp trực tiếp với Github Actions cache Rest API phức tạp
hơn.

==== SQLC Dynamic filter

SQLC là một công cụ code generation cho SQL queries, giúp tạo ra code type-safe
cho database access _(@general-for-sqlc)_. Tuy nhiên, SQLC không hỗ trợ dynamic
query, cũng không phải là một ORM hay query builder, mà chỉ đơn thuần là code
generator cho SQL queries đã viết sẵn. Điều này gây khó khăn khi cần sinh
dynamic `WHERE` conditions, ví dụ như khi có nhiều optional filters khác nhau.
Trước đây _(cũng là phiên bản chính thức SQLC)_ phải sử dụng syntax `WHERE` và
`CASE ... WHEN` ở dưới tầng SQL, ảnh hưởng đến hiệu năng dưới tầng database. Đặc
biệt với `FOR UPDATE` queries, bắt buộc phải duplicate query cho từng trường
hợp, dẫn đến code duplication và khó maintain.

Ví dụ đây là một query SQLC tiêu chuẩn cho việc lấy notes với nhiều optional
filters:

#figure(
  [
    ```sql
    SELECT
      *
    FROM
      notes
    CASE
      WHEN CARDINALITY(sqlc.narg('ids')) > 0
        THEN id = ANY(sqlc.narg('ids')::uuid[])
        ELSE TRUE
      END
    CASE
      WHEN sqlc.narg('workspace_id') IS NOT NULL
        THEN folder_id IN (
          SELECT id FROM folders WHERE workspace_id = sqlc.narg('workspace_id')::uuid
        )
        ELSE TRUE
      END
    CASE
      WHEN sqlc.narg('trashed_by') IS NOT NULL
        THEN (trashed_by = sqlc.narg('trashed_by')::text OR trashed_by IS NULL)
        ELSE TRUE
      END
    CASE
      WHEN sqlc.arg('trashed_only') = true
        THEN trashed_by IS NOT NULL
        ELSE TRUE
      END;
    ```
  ],
  caption: [Ví dụ SQL query với nhiều optional filters trong SQLC tiêu chuẩn],
)

Custom plugin `vtuanjs/sqlc-gen-go` @sqlc_dynamic_filter _(được phát triển bởi
anh Nguyễn Văn Tuấn)_ hỗ trợ dynamic filter queries, giải quyết vấn đề không thể
sinh dynamic WHERE conditions trong SQLC tiêu chuẩn, cũng như hỗ trợ dynamic
`FOR UPDATE`. Plugin hoạt động bằng cách parse SQL query đã viết sẵn, nhận diện
các phần có thể trở thành dynamic filter bằng các comment, và sinh ra code Go
tương ứng để xây dựng dynamic query tại runtime.

Dưới đây là ví dụ SQL query khi sử dụng với `vtuanjs/sqlc-gen-go`:

#figure(
  [
    ```sql
    SELECT
      *
    FROM
      notes
    WHERE
      id = ANY(sqlc.narg('ids')::uuid[]) -- :if @ids
      AND folder_id IN (
        SELECT id FROM folders WHERE workspace_id = sqlc.narg('workspace_id')::uuid
      ) -- :if @workspace_id
      AND ( -- :if @trashed_by
        trashed_by = sqlc.narg('trashed_by')::text
        OR trashed_by IS NULL
      )
      AND trashed_by IS NOT NULL -- :if @trashed_only
    FOR UPDATE -- :if @for_update
    ;
    ```
  ],
  caption: [Ví dụ SQL query với dynamic filters sử dụng custom plugin
    `vtuanjs/sqlc-gen-go`],
)

== Nhận xét

=== Thuận lợi

Trong quá trình thực hiện đề tài, hệ thống nhận được nhiều thuận lợi trong khâu
nghiên cứu, phát triển và triển khai, tạo điều kiện cho việc hoàn thiện các chức
năng và đạt được mục tiêu đề ra.

- Được sự hướng dẫn tận tình từ giảng viên, giúp định hướng rõ ràng, tránh đi
  lệch hướng, sử dụng công nghệ không cần thiết và giải quyết kịp thời các vấn
  đề phát sinh trong quá trình phát triển _(không sử dụng Neo4j để lưu quan hệ,
  mà sử dụng SQL Recursive CTE để build graph)_
- Thư viện cốt lõi là Blocknote giúp xử lý nhanh việc xây dựng editor, tập trung
  vào việc phát triển các tính năng đặc thù của hệ thống thay vì phải xây dựng
  editor từ đầu
- Sự hỗ trợ của các công nghệ hiện đại và framework mạnh mẽ như React, NextJS,
  NestJS, Go, gRPC, Traefik, Casbin, Authentik, Meilisearch đã giúp tăng tốc quá
  trình phát triển và đảm bảo hiệu suất cao cho hệ thống
- Cộng tác hiệu quả trong nhóm, với sự phân công công việc rõ ràng, áp dụng
  phương pháp Contract First từ OpenAPI, Protobuf giúp giảm thiểu xung đột code
  và tăng hiệu quả phát triển

=== Khó khăn

Dự án cũng gặp phải nhiều khó khăn và thách thức trong quá trình thực hiện, đòi
hỏi sự nỗ lực và kiên trì từ nhóm phát triển để vượt qua và hoàn thiện hệ thống.

- Dữ liệu mẫu chuyển hoá từ Obsidian Vault từ `TrshPuppy/obsidian-notes`
  @trshpuppy_obsidian_notes không được chuẩn xác hoàn toàn. Vì cơ chế parse bằng
  text, không phải cây ngôn ngữ, nên các code block chứa comment như ký tự `#`
  hay shebang `#!` bị parse thành tag. Đồng thời, hệ thống không support nested
  tags như obsidian. Cũng như công việc chuyển hoá và seed vào service phức tạp
  _(markdown #sym.arrow custom markdown/HTML #sym.arrow Blocknote/yjs binary)_
- Các block của shadcn từ cộng đồng nhìn chung khá đa dạng tuy nhiên phần lớn
  chúng lại nằm trong các gói trả phí, nên vẫn phải tốn nhiều thời gian để code
  lại các phần giao diện từ các components nguyên thủy của shadcn
- Việc học và áp dụng nhiều công nghệ mới cùng lúc, tạo ra một learning curve
  khá dốc và đòi hỏi thời gian để làm quen và thành thạo. Dẫu vậy, các thành
  viên cũng đã có kinh nghiệm về một số công nghệ như Oauth2/OIDC, SQLC, nên đã
  phần nào giảm bớt khó khăn này
- Độ phức tạp của kiến trúc microservices, đòi hỏi phải quản lý nhiều service
  nhỏ, đảm bảo communication giữa các service, và xử lý các vấn đề liên quan đến
  distributed systems như latency, fault tolerance, v.v.
- Mô hình Casbin rất trừu tượng và có learning curve cao, đòi hỏi phải hiểu rõ
  về mô hình RBAC để thiết kế chính sách phân quyền phù hợp và hiệu quả
- Các khái niệm về event bus, event processor, command bus, command processor từ
  thư viện `ThreeDotsLabs/Watermill` nói riêng, và kiến trúc Event Drive
  Architecture nói chung, đòi hỏi phải hiểu rõ để thiết kế và triển khai đúng
  cách
- `ThreeDotsLabs/watermill-kafka` sử dụng `IBM/sarama` không hỗ trợ subcribe
  regex topic, phải iterate toàn bộ topic bằng tay để subcribe
- `vtuanjs/sqlc-gen-go` là một plugin mới, chưa được sử dụng rộng rãi, tính
  production ready chưa được kiểm chứng
- Quá trình thiết lập monorepo, đặc biệt đối với TypeScript/JavaScript rất phức
  tạp, tốn nhiều thời gian để cấu hình cho đúng.
- RustFS là một công nghệ mới, chưa stable, còn gặp nhiều vấn đề. Trong đó, có
  vấn đề `rustfs/rustfs/issues/2587`
  #footnote[https://github.com/rustfs/rustfs/issues/2587 do thành viên nhóm phát
    hiện]
- Việc xây dựng cây thư mục lúc đầu khá khó khăn do một số vấn đề về việc không
  tương thích với các components có sẵn của shadcn, nhưng sau đó đã tìm ra được
  giải pháp từ `shadcn-ui/ui/issues/355`
  #footnote[https://github.com/shadcn-ui/ui/issues/355], nhưng vẫn phải dành
  thời gian để chỉnh sửa lại vì vẫn xảy ra một số lỗi

=== Ưu điểm

Hệ thống ghi chú thông minh đã đạt được nhiều ưu điểm đáng kể.

- Xử lý graph rất nhanh nhờ vào ngôn ngữ Go, hạn chế sử dụng con trỏ, tránh đối
  tượng trong heap trong quá trình Read
- Kiến trúc microservices dễ mở rộng
- DevOps practices tốt với CI/CD nhanh nhờ vào kinh nghiệm thiết lập, cũng như
  sử dụng Nx. 30 giây cho trường hợp cache hit toàn bộ project _(không có
  project nào thay đổi source code)_, đến 10 phút cho trường hợp ignore toàn bộ
  cache, build, lint, test, release. Nếu không được tối ưu, thời gian có thể lên
  đến 25 phút trong trường hợp chạy tuần tự các task cho toàn bộ project
- Code maintainability cao nhờ vào việc áp dụng kiến trúc Clean Architecture,
  Domain Driven Design, CQRS đối với service `note` có business phức tạp nhất

=== Nhược điểm

Tuy đã đạt được nhiều ưu điểm, hệ thống cũng còn tồn tại một số nhược điểm cần
được cải thiện trong tương lai.

- Độ phức tạp cao của microservices architecture
- Cần nhiều tài nguyên hơn cho infrastructure, đặc biệt là Authentik viết bằng
  Python, mức sử dụng RAM có thể lên đến 1.5GB chỉ trong quá trình development.
  Điều này phải chấp nhận đánh đổi về tính enterprise ready, feature rich, cộng
  đồng support tốt
- Các service bên JS chưa dược thành công cấu hình gửi telemetry đến
  Observability Stack
- Khả năng xử lý lỗi từ các async event còn hạn chế, cần đảm bảo retry và dead
  letter queue cho các event thất bại cho toàn bộ các service. Hiện tại chỉ có
  service `note` có retry và dead letter queue

== Hướng phát triển

// === Ngắn hạn (3-6 tháng)
//
// - Tối ưu hóa hiệu suất database với indexing
// - Thêm caching layer với Redis
// - Cải thiện UI/UX dựa trên feedback người dùng
// - Mở rộng test coverage
//
// === Trung hạn (6-12 tháng)
//
// - Tích hợp AI/ML cho smart suggestions
// - Hỗ trợ collaborative editing
// - Mobile apps cho iOS và Android native
// - CDN integration cho static assets
//
// === Dài hạn (> 12 tháng)
//
// - Mở rộng sang platform khác (Desktop apps)
// - Blockchain integration cho decentralized storage
// - Advanced analytics và reporting
// - Multi-language support

== Lời kết

Dự án đã đạt được mục tiêu đề ra và mang lại nhiều bài học quý giá cho nhóm phát
triển. Hệ thống ghi chú thông minh không chỉ là sản phẩm hoàn chỉnh mà còn là
nền tảng để tiếp tục nghiên cứu và phát triển trong tương lai.

=== NOTE

Deploy bằng istio thay vì traefik

Vitepress docs and repo (notopia & report) here
