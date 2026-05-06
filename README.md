# PowerTech - E-Commerce cho Linh Kiện Máy Tính

PowerTech là một hệ thống thương mại điện tử chuyên nghiệp được thiết kế đặc biệt cho lĩnh vực bán lẻ linh kiện máy tính, PC build và các thiết bị công nghệ (Retail-Tech). Hệ thống giúp quản lý toàn diện quy trình từ trưng bày sản phẩm, bán hàng đến quản lý kho và chăm sóc khách hàng.

## Mục lục

- [Giới thiệu](#giới-thiệu)
- [Tính năng](#tính-năng)
- [Công nghệ sử dụng](#công-nghệ-sử-dụng)
- [Cài đặt](#cài-đặt)
- [Cách sử dụng](#cách-sử-dụng)
- [Cấu trúc thư mục](#cấu-trúc-thư-mục)
- [Cấu hình môi trường](#cấu-hình-môi-trường)
- [Scripts / Commands](#scripts--commands)
- [API / Demo](#api--demo)
- [Đóng góp](#đóng-góp)
- [License](#license)
- [Liên hệ](#liên-hệ)

## Giới thiệu

Dự án PowerTech ra đời nhằm cung cấp một giải pháp phần mềm hoàn chỉnh cho các cửa hàng, doanh nghiệp kinh doanh linh kiện máy tính. Mục tiêu là số hóa các hoạt động bán lẻ, từ việc khách hàng mua sắm trực tuyến cho đến các hoạt động nghiệp vụ nội bộ như quản lý kho bãi, bán hàng tại quầy (POS), và hỗ trợ khách hàng. Đối tượng sử dụng bao gồm khách hàng mua sắm trực tuyến, nhân viên bán hàng, nhân viên kho, nhân viên chăm sóc khách hàng và ban giám đốc. Dự án này được thực hiện trong khuôn khổ đồ án môn học.

## Tính năng

Hệ thống được chia thành 6 phân hệ (Areas) với cơ chế phân quyền (Role-based access control) chặt chẽ:

- **Storefront (Hiển thị công khai)**
  - Trang chủ linh động (Banners, Sản phẩm nổi bật/mới/sale).
  - Danh sách sản phẩm với bộ lọc phức hợp (Danh mục, Thương hiệu, Phân khúc giá, Sắp xếp).
  - Trang chi tiết hiển thị Specs, Gallery ảnh và trạng thái tồn kho thực tế.
- **Customer Area (Khách hàng)**
  - Quản lý hồ sơ, thẻ thông tin cá nhân và sổ địa chỉ giao hàng.
  - Quản lý giỏ hàng & quy trình thanh toán (Checkout flow).
  - Lịch sử mua hàng, trạng thái đơn và tính năng Hủy đơn.
- **Sales Area (Nhân viên Bán hàng)**
  - Dashboard xử lý đơn hàng.
  - POS (Tạo đơn hàng tại quầy nhanh chóng).
- **Warehouse Area (Nhân viên Kho)**
  - Quản lý danh mục hàng hóa vật lý, thống kê tồn kho, cảnh báo sắp hết hàng.
  - Thực hiện phiếu nhập kho (Ghi nhận Lịch sử/Audit Trail).
- **Support Area (Nhân viên CSKH)**
  - Hệ thống quản lý khiếu nại & vé hỗ trợ (Support Tickets).
  - Kiểm duyệt đánh giá (Reviews) từ người dùng.
- **Admin Panel (Ban Giám Đốc / Quản trị viên)**
  - Quản lý toàn hệ thống, Master Data: Category, Brand, Product, Spec...
  - Quản lý Người dùng & Cơ cấu tổ chức (Phân quyền Roles linh hoạt).

## Công nghệ sử dụng

- **Frontend:** HTML5, Vanilla CSS (Thiết kế độc quyền Retail-Tech theme), JavaScript (ES6+).
- **Backend:** ASP.NET Core MVC (Version 9.0).
- **Database:** Microsoft SQL Server, Entity Framework Core (Tiếp cận Code First - Synchronized với DB có sẵn).
- **Khác:** ASP.NET Core Identity (Role-based & Multiple Roles), Dotnet CLI.

## Cài đặt

```bash
git clone <repo-url>
cd PowerTech
dotnet restore
dotnet build
```

## Cách sử dụng

Sau khi cài đặt xong, bạn có thể chạy dự án bằng lệnh:
```bash
dotnet run
```
Trang web sẽ được chạy trên trình duyệt tại địa chỉ `http://localhost:5000` hoặc `https://localhost:5001`.
Hệ thống sử dụng cơ chế Tự động Seed dữ liệu. Bảng cấu hình và dữ liệu mẫu sẽ được tự tạo trong lần khởi chạy đầu tiên nếu Database chưa tồn tại.

## Cấu trúc thư mục

- `/Areas/`: Chứa các module nghiệp vụ tách biệt (Admin, Store, Sales, Warehouse, Support, Customer). Mỗi Area có `Controllers` và `Views` riêng.
- `/Models/Entities/`: Lớp Models mapped với Database.
- `/Models/ViewModels/`: DTOs (Data Transfer Objects) chuyên biệt để render View, tránh rò rỉ Entity.
- `/Data/`: DbContext và các logic Migration, Seeding Data.
- `/wwwroot/`: Chứa các tài sản Front-end (CSS, JS) và thư viện ảnh (`/images/`, `/uploads/`).

## Cấu hình môi trường

Mở file `PowerTech/appsettings.json` và cập nhật `DefaultConnection` trỏ tới hệ thống SQL Server của bạn. Đảm bảo thêm `TrustServerCertificate=True` nếu dùng localhost.

Ví dụ:
```json
"ConnectionStrings": {
  "DefaultConnection": "Server=localhost;Database=PowerTechDb;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=True"
}
```

## Scripts / Commands

Các lệnh thao tác cơ bản với dự án:

- **Khôi phục các gói phụ thuộc:** `dotnet restore`
- **Biên dịch dự án:** `dotnet build`
- **Chạy dự án:** `dotnet run`
- **Tạo migration mới:** `dotnet ef migrations add <MigrationName>`
- **Cập nhật database:** `dotnet ef database update`

## API / Demo

*(Hiện tại dự án đang sử dụng kiến trúc MVC truyền thống, phần API và Link Demo trực tuyến sẽ được cập nhật sau)*

## Đóng góp

Nếu bạn muốn đóng góp cho dự án, vui lòng:

1. Fork kho lưu trữ
2. Tạo một nhánh mới (`git checkout -b feature/AmazingFeature`)
3. Commit những thay đổi của bạn (`git commit -m 'Add some AmazingFeature'`)
4. Push lên nhánh đó (`git push origin feature/AmazingFeature`)
5. Mở một Pull Request

## License

Dự án thực hiện cho đồ án môn học. Các hình ảnh minh họa thuộc về nhà cung cấp/hãng nguyên bản (ASUS, Intel, NVIDIA...).

## Liên hệ

Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ qua email hoặc tạo Issue trên Github.
