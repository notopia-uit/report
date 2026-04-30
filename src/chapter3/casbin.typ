== Mô hình Casbin trong hệ thống <casbin-model-in-system>

Casbin hỗ trợ biểu diễn nhiều mô hình kiểm soát truy cập khác nhau, chi tiết xem
tại @general-for-casbin. Trong đó, hệ thống tập trung sử dụng mô hình RBAC để
quản lý quyền truy cập dựa trên vai trò _(role)_ của người dùng, trong mỗi không
gian làm việc. Đối với Casbin, workspace được xem như một domain.

=== Mô hình Casbin trong hệ thống

#figure(
  [
    ```toml
    [request_definition]
    r = sub, dom, obj, act

    [policy_definition]
    p = sub, obj, act

    [role_definition]
    g = _, _, _
    g2 = _, _

    [policy_effect]
    e = some(where (p.eft == allow))

    [matchers]
    m = g(r.sub, p.sub, r.dom) \
      && g2(r.obj, p.obj) \
      && r.act == p.act
    ```
  ],
  caption: [Model Casbin trong hệ thống],
)

Trong đó, các phần được định nghĩa như sau:
- `request_definition` định nghĩa cấu trúc của một yêu cầu truy cập, bao gồm
  người dùng _(sub)_, không gian làm việc _(dom)_, đối tượng _(obj)_ và hành
  động
  _(act)_
- `policy_definition` định nghĩa cấu trúc của một chính sách, bao gồm vai trò
  _(sub)_, đối tượng _(obj)_ và hành động _(act)_
- `role_definition` định nghĩa cách thức xác định vai trò của người dùng trong
  một không gian làm việc _(g)_ và cách thức xác định mối quan hệ giữa đối tượng
  và chính sách _(g2)_
- `policy_effect` định nghĩa hiệu ứng của chính sách, trong trường hợp này là
  cho phép truy cập nếu có ít nhất một chính sách cho phép
- `matchers` định nghĩa cách thức so khớp giữa yêu cầu truy cập và chính sách,
  trong đó yêu cầu truy cập sẽ được phép nếu người dùng có vai trò phù hợp trong
  không gian làm việc, đối tượng phù hợp với chính sách và hành động phù hợp với
  chính sách

=== Chính sách Casbin trong hệ thống

#figure(
  [
    ```csv
    # owner
    p, owner, workspace, read
    p, owner, workspace, edit
    p, owner, workspace, delete
    p, owner, workspace_item, read
    p, owner, workspace_item, write
    p, owner, workspace_item, delete
    # editor
    p, editor, workspace, read
    p, editor, workspace_item, read
    p, editor, workspace_item, write
    p, editor, workspace_item, delete
    # viewer
    p, viewer, workspace, read
    p, viewer, workspace_item, read
    # object hierarchy
    g2, note, workspace_item
    g2, folder, workspace_item
    ```
  ],
  caption: [Policy Casbin trong hệ thống],
)

Trong đó, các chính sách được định nghĩa như sau:
- Vai trò `owner` có quyền đọc, chỉnh sửa và xóa trên không gian làm việc và các
  mục trong không gian làm việc
- Vai trò `editor` có quyền đọc trên không gian làm việc và quyền đọc, chỉnh sửa
  và xóa trên các mục trong không gian làm việc
- Vai trò `viewer` chỉ có quyền đọc trên không gian làm việc và các mục trong
  không gian làm việc
- Các đối tượng `note` và `folder` được xác định là các mục trong không gian làm
  việc thông qua mối quan hệ g2

==== Mẫu minh hoạ yêu cầu truy cập và so khớp chính sách

Giả sử ta có ba người dùng: `110`, `111` và `112`, với các vai trò và quyền truy
cập như sau:

#figure(
  [
    ```csv
    # workspace 111
    g, user:111, owner, workspace:00000000-0000-0000-0000-000000000111
    g, user:112, editor, workspace:00000000-0000-0000-0000-000000000111
    g, user:110, viewer, workspace:00000000-0000-0000-0000-000000000111
    # workspace 112
    g, user:112, owner, workspace:00000000-0000-0000-0000-000000000112
    g, user:111, editor, workspace:00000000-0000-0000-0000-000000000112
    # workspace 110
    g, user:110, owner, workspace:00000000-0000-0000-0000-000000000110
    ```
  ],
  caption: [Mẫu minh hoạ yêu cầu truy cập và so khớp chính sách],
)

Trong đó:
- Người dùng `111` là chủ sở hữu _(owner)_ của không gian làm việc `111`
- Người dùng `112` là biên tập viên _(editor)_ của không gian làm việc `111` và
  chủ sở hữu của không gian làm việc `112`
- Người dùng `110` là người xem _(viewer)_ của không gian làm việc `111` và chủ
  sở hữu của không gian làm việc `110`

#figure(
  [
    #table(
      columns: (auto, auto),
      align: (center + horizon),
      table.header([*Loại*], [*Code*]),
      [Request],
      [
        ```csv
        user:111, workspace:111, workspace, read
        user:111, workspace:111, note, write
        user:112, workspace:111, workspace, delete
        user:112, workspace:111, note, write
        user:112, workspace:111, folder, write
        user:110, workspace:111, workspace, read
        ```
      ],

      [Result],
      [
        ```js
        true Reason: ["owner","workspace","read"]
        true Reason: ["owner","workspace_item","write"]
        false
        true Reason: ["editor","workspace_item","write"]
        true Reason: ["editor","workspace_item","write"]
        true Reason: ["viewer","workspace","read"]
        ```
      ],
    )
  ],
)

==== Giải thích cho yêu cầu truy cập đầu tiên

Người dùng `111` yêu cầu đọc không gian làm việc `111`. Kết quả là true vì người
dùng `111` có vai trò `owner` trong không gian làm việc `111` và có chính sách
cho phép đọc không gian làm việc. Các bước suy luận dựa trên matcher `m`:
+ Người dùng `111` có vai trò `owner` trong không gian làm việc `111` thông qua
  chính sách g. Ta có thể xác định rằng `g(user:111, owner, workspace:111)` là
  true.
+ Đối tượng `workspace` cũng chứa trong `workspace` _(`workspace` #sym.subset.eq
  `workspace`)_ thông qua chính sách g2. Ta có thể xác định rằng
  `g2(workspace, workspace)` là true.
+ Hành động `read` phù hợp với chính sách `read` của vai trò `owner` trên không
  gian làm việc. Ta có thể xác định rằng `read == read` là true.

==== Giải thích cho yêu cầu truy cập thứ hai

Người dùng `111` yêu cầu viết vào note trong không gian làm việc `111`. Kết quả
là true vì người dùng `111` có vai trò `owner` trong không gian làm việc `111`
và có chính sách cho phép viết vào các mục trong không làm việc. Các bước suy
luận:
+ Người dùng `111` có vai trò `owner` trong không gian làm việc `111` thông qua
  chính sách g. Ta có thể xác định rằng `g(user:111, owner, workspace:111)` là
  true.
+ Đối tượng `note` chứa trong `workspace_item` _(`note` #sym.subset.eq
  `workspace_item`)_ thông qua chính sách g2 Ta có thể xác định rằng
  `g2(note, workspace_item)` là true.
+ Hành động `write` phù hợp với chính sách `write` của vai trò `owner` trên các
  mục trong không làm việc. Ta có thể xác định rằng `write == write` là true.

==== Giải thích cho yêu cầu truy cập thứ ba

Người dùng `112` yêu cầu xóa không gian làm việc `111`. Kết quả là false vì
người dùng `112` chỉ có vai trò `editor` trong không gian làm việc `111` và
không có chính sách nào cho phép `editor` xóa không gian làm việc. Các bước suy
luận:
+ Người dùng `112` có vai trò `editor` trong không gian làm việc `111` thông qua
  chính sách g. Ta có thể xác định rằng `g(user:112, editor, workspace:111)` là
  true.
+ Đối tượng `workspace` cũng chứa trong `workspace` _(`workspace` #sym.subset.eq
  `workspace`)_ thông qua chính sách g2. Ta có thể xác định rằng
  `g2(workspace, workspace)` là true.
+ Hành động `delete` không phù hợp với chính sách `delete` của vai trò `editor`
  trên không gian làm việc. Ta có thể xác định rằng `delete == delete` là true,
  nhưng vì không có chính sách nào cho phép `editor` xóa không gian làm việc,
  nên yêu cầu truy cập này bị từ chối.

Tương tự, các yêu cầu truy cập khác cũng được đánh giá dựa trên vai trò của
người dùng trong không gian làm việc và các chính sách đã định nghĩa. Kết quả
của mỗi yêu cầu sẽ cho biết liệu yêu cầu đó có được phép hay không, cùng với lý
do dựa trên chính sách nào đã cho phép hoặc từ chối yêu cầu đó. Chi tiết có thể
xem tại website playground của casbin cho ví dụ trên tại
https://editor.casbin.org/#E7VKBXR2T.
