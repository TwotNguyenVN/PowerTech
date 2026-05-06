dotnet ef migrations add AddUpdatedAtToUsers


dotnet ef database update


dotnet run















GIAM10, KM50K








3. Nhóm lệnh Entity Framework Core (Database)
Đối với các dự án web có sử dụng SQL Server hoặc database khác, bạn cần cài đặt dotnet-ef tool trước (dotnet tool install --global dotnet-ef).

dotnet ef migrations add <NAME>: Tạo một file migration mới dựa trên những thay đổi trong Code First.

dotnet ef database update: Áp dụng các migration vào database thật.

dotnet ef dbcontext info: Kiểm tra thông tin về DbContext và database đang kết nối.

dotnet ef migrations remove: Xóa bản migration cuối cùng (nếu chưa update database).

Email: admin@powertech.com
Mật khẩu: Admin@123


dotnet restore
dotnet build
dotnet run
dotnet watch run
dotnet clean && dotnet restore && dotnet build

🔑 Thông tin Đăng nhập Admin (Mặc định):
Tài khoản: admin@powertech.com
Mật khẩu: Admin@123


Mật khẩu: Admin@123
Admin@123
👤 Danh sách tài khoản mẫu
Vai trò	Email / Tài khoản	Tên người dùng
Quản trị viên (Admin)	admin@powertech.com	System Administrator
Quản trị viên (Admin)	admin@powertech.vn	PowerTech Admin
Nhân viên Bán hàng (Sales)	sales1@powertech.vn	Nguyễn Thị Sales
Nhân viên Kho (Warehouse)	warehouse1@powertech.vn	Lê Văn Kho
Nhân viên Kho (Warehouse)	warehouse2@powertech.vn	Phạm Thị Nhập Kho
Nhân viên Hỗ trợ (Support)	support1@powertech.vn	Trần Thị Support
Khách hàng (Customer)	customer1@powertech.vn	Nguyễn Văn A

Nếu máy bạn chưa có tree thì:

brew install tree

Sau đó có mấy cách hay dùng:

1. Xem toàn bộ cây thư mục

tree

2. Chỉ lấy tên thư mục

tree -d

3. Xuất cây thư mục ra file txt

tree > caythumuc.txt

4. Bỏ qua các thư mục rác như bin, obj, node_modules, .git

tree -I "bin|obj|node_modules|.git"

5. Vừa gọn vừa thực tế cho project code

tree -a -I "bin|obj|node_modules|.git|.vs"

Nếu bạn đang dùng macOS và muốn copy nhanh để gửi cho AI hoặc dán báo cáo:

tree -a -I "bin|obj|node_modules|.git|.vs" > structure.txt

rồi mở file structure.txt để copy.

Nếu không muốn cài tree, có thể dùng lệnh có sẵn:

find . -print

nhưng nó xấu và khó đọc hơn tree.

Mẫu mình khuyên dùng nhất cho project ASP.NET / Flutter / web:

tree -a -I "bin|obj|node_modules|.git|.vs|build|dist"




# PowerTech - E-Commerce Solutions for Retail Tech

PowerTech là hệ thống thương mại điện tử chuyên sâu cho lĩnh vực bán sỉ & lẻ linh kiện máy tính, PC build và thiết bị công nghệ. Dự án được tối ưu hóa cho hiệu năng cao, quản lý kho thông minh và quy trình hỗ trợ khách hàng chuyên nghiệp.

---

## 🌟 Phân hệ chính (Key Modules)

Hệ thống được chia thành 6 phân hệ (Areas) với vai trò riêng biệt:

1.  **Storefront**: Trang mua sắm công khai, bộ lọc sản phẩm thông minh, chi tiết cấu hình kỹ thuật.
2.  **Customer Area**: Quản lý đơn hàng cá nhân, sổ địa chỉ, ví điện tử (giả lập) và lịch sử hỗ trợ.
3.  **Sales Area (POS)**: Dành cho nhân viên bán hàng tại quầy và xử lý đơn hàng online nhanh chóng.
4.  **Warehouse Area**: Quản lý tồn kho vật lý, phiếu nhập kho, kiểm kê và lịch sử biến động hàng hóa.
5.  **Support Area**: Hệ thống Ticket (vé hỗ trợ), quản lý đánh giá khách hàng (Review) và FAQ.
6.  **Shipper Area**: Hệ thống quản lý đơn hàng giao hàng.
7.  **Admin Panel**: Quản trị master data (Category, Brand, Product), phân quyền Role và báo cáo doanh thu.

---

## 🚀 Hướng dẫn Cài đặt & Khởi chạy (Setup & Run)

### 1. Yêu cầu hệ thống

- **.NET 9.0 SDK** (Yêu cầu bắt buộc).
- **Microsoft SQL Server** (2019 hoặc mới hơn).
- **SQL Server Management Studio (SSMS)** để quản lý database.

### 2. Thiết lập Database (Database Setup)

Việc đầu tiên bạn cần làm là mở file `PowerTech/appsettings.json` và thay đổi chuỗi kết nối tại `DefaultConnection` sao cho phù hợp với SQL Server của bạn:

```json
"DefaultConnection": "Server=TÊN_SERVER_CỦA_BẠN;Database=TechZoneStoreDb;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=True"
```

Sau đó, chọn **một trong hai** trường hợp dưới đây:

---

#### 📌 Trường hợp 1: Cài đặt kèm dữ liệu mẫu (Khuyên dùng)

_Dành cho người muốn chạy thử dự án ngay với đầy đủ hàng trăm sản phẩm, đơn hàng và thương hiệu có sẵn._

1.  Mở **SQL Server Management Studio (SSMS)**.
2.  Tạo một Database mới tên là `TechZoneStoreDb`.
3.  Kéo file **`TechZoneStoreDb.sql`** (nằm ở thư mục gốc của dự án) vào SSMS.
4.  Nhấn nút **Execute (F5)** để chạy toàn bộ script. Hệ thống sẽ tự tạo bảng và đổ dữ liệu vào cho bạn.

---

#### 📌 Trường hợp 2: Cài đặt hệ thống trống (Khởi đầu mới)

_Dành cho người muốn phát triển từ đầu, tự tay thêm sản phẩm và danh mục thông qua trang quản trị._

1.  Tạo một Database trống trên SQL Server của bạn (ví dụ: `TechZoneStoreDb`).
2.  Mở Terminal (Command Prompt) tại thư mục `PowerTech` và chạy lệnh sau để tự tạo cấu trúc bảng:
    ```bash
    dotnet ef database update
    ```
    _(Lưu ý: Nếu chưa cài đặt EF Tool, hãy chạy lệnh `dotnet tool install --global dotnet-ef` trước)_.

---

### 3. Khởi chạy ứng dụng

Sau khi đã thiết lập database xong, bạn chỉ cần thực hiện các lệnh sau để chạy web:

```bash
cd PowerTech
dotnet run
```

Truy cập trình duyệt theo địa chỉ: `https://localhost:5029` (hoặc cổng hiển thị trên terminal).

---

## 🔐 Tài khoản Đăng nhập (Test Credentials)

Bạn có thể sử dụng các tài khoản sau để kiểm tra đầy đủ các tính năng của hệ thống:

| Role                      | Email                     | Password    | Ghi chú                   |
| :------------------------ | :------------------------ | :---------- | :------------------------ |
| **Quản trị viên (Admin)** | `admin@powertech.com`     | `Admin@123` | Toàn quyền hệ thống       |
| **Nhân viên Bán hàng**    | `sales@powertech.com`     | `Admin@123` | Truy cập Sales Area / POS |
| **Nhân viên Kho**         | `warehouse@powertech.com` | `Admin@123` | Truy cập Warehouse Area   |
| **Nhân viên CSKH**        | `support@powertech.com`   | `Admin@123` | Truy cập Support Area     |
| **Nhân viên Giao hàng**   | `shipper@powertech.com`   | `Admin@123` | Truy cập Shipper Area     |
| **Khách hàng mẫu**        | `customer@gmail.com`      | `Admin@123` | Đăng nhập/Mua hàng online |

Tài khoản tạo bằng Code (Seeding)
Email: admin@powertech.com
Mật khẩu: Admin@123
Quyền (Role): Admin (Quản trị viên toàn hệ thống)

> [!NOTE]
> Sau khi đăng nhập với tài khoản Admin, bạn có thể vào mục **Admin > Users** để tạo mới hoặc thay đổi quyền hạn cho các tài khoản khác.

---

## 🛠 Công nghệ sử dụng

- **Backend**: ASP.NET Core MVC 9.0, Entity Framework Core.
- **Identity**: ASP.NET Core Identity (Identity Framework).
- **Frontend**: HTML5, Vanilla CSS (Thiết kế Custom), JavaScript ES6+.
- **Real-time**: SignalR (Thông báo đơn hàng & Chat hỗ trợ).

---

## 📝 Liên hệ & Bản quyền

Dự án được phát triển nhằm mục đích phục vụ học tập và nghiên cứu. Mọi đóng góp vui lòng liên hệ qua email quản trị.
