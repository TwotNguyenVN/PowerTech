TRƯỜNG ĐẠI HỌC CÔNG NGHỆ TP.HCM
KHOA CÔNG NGHỆ THÔNG TIN

---

# BÁO CÁO ĐỒ ÁN MÔN HỌC
## ĐỀ TÀI: XÂY DỰNG WEBSITE CỬA HÀNG MÁY TÍNH VÀ LINH KIỆN (POWERTECH)

Sinh viên thực hiện: [Tên của bạn]
Mã số sinh viên: [MSSV của bạn]
Lớp: [Tên lớp]
Giảng viên hướng dẫn: [Tên giảng viên]

---

## LỜI CAM ĐOAN

Tôi xin cam đoan đây là công trình nghiên cứu và phát triển phần mềm của riêng tôi, dưới sự hướng dẫn của giảng viên. Các nội dung tham khảo, trích dẫn đều được ghi chú rõ ràng và tuân thủ đúng quy định về đạo văn. Toàn bộ mã nguồn, cơ sở dữ liệu và thiết kế giao diện đều được tự xây dựng dựa trên các kiến thức đã học, đáp ứng yêu cầu nghiệp vụ thực tế của một hệ thống thương mại điện tử chuyên cung cấp linh kiện máy tính. Nếu có bất kỳ sự sao chép vi phạm nào, tôi xin chịu hoàn toàn trách nhiệm trước nhà trường.

*(Ký và ghi rõ họ tên)*

---

## MỤC LỤC

1. [Chương 1. TỔNG QUAN](#chương-1-tổng-quan)
2. [Chương 2. CƠ SỞ LÝ THUYẾT](#chương-2-cơ-sở-lý-thuyết)
3. [Chương 3. KẾT QUẢ THỰC NGHIỆM VÀ PHÂN TÍCH THIẾT KẾ](#chương-3-kết-quả-thực-nghiệm-và-phân-tích-thiết-kế)
4. [Chương 4. KẾT LUẬN VÀ KIẾN NGHỊ](#chương-4-kết-luận-và-kiến-nghị)
5. [TÀI LIỆU THAM KHẢO](#tài-liệu-tham-khảo)
6. [DANH SÁCH HÌNH ẢNH CẦN BỔ SUNG](#danh-sách-hình-ảnh-cần-bổ-sung)

---

## DANH MỤC CÁC KÝ HIỆU, CÁC CHỮ VIẾT TẮT

- **MVC (Model - View - Controller):** Mô hình kiến trúc phần mềm phân chia ứng dụng thành ba phần: Dữ liệu (Model), Giao diện (View) và Điều khiển (Controller).
- **EF Core (Entity Framework Core):** Một ORM (Object-Relational Mapper) mã nguồn mở của Microsoft.
- **ORM (Object-Relational Mapping):** Kỹ thuật lập trình giúp chuyển đổi dữ liệu giữa hệ thống quản trị cơ sở dữ liệu quan hệ và các đối tượng trong lập trình hướng đối tượng.
- **SQL Server:** Hệ quản trị cơ sở dữ liệu quan hệ của Microsoft.
- **UI/UX (User Interface / User Experience):** Giao diện người dùng / Trải nghiệm người dùng.
- **RBAC (Role-Based Access Control):** Kiểm soát truy cập dựa trên vai trò.
- **UML (Unified Modeling Language):** Ngôn ngữ mô hình hóa thống nhất.
- **ERD (Entity-Relationship Diagram):** Sơ đồ quan hệ thực thể.
- **POS (Point of Sale):** Điểm bán hàng.

---

## DANH MỤC CÁC BẢNG

- Bảng 3.1: Danh sách các quyền hệ thống (Roles)
- Bảng 3.2: Bảng chi tiết thực thể Users
- Bảng 3.3: Bảng chi tiết thực thể Product
- Bảng 3.4: Bảng chi tiết thực thể Order

---

## DANH MỤC CÁC HÌNH VẼ, ĐỒ THỊ

*(Danh sách chi tiết được liệt kê ở phần cuối báo cáo)*

---

# Chương 1. TỔNG QUAN

### 1.1 Giới thiệu và Lý do hình thành đề tài, tính cấp thiết

Trong thời đại số hóa phát triển mạnh mẽ và kỷ nguyên công nghệ thông tin 4.0, các thiết bị máy tính, linh kiện điện tử đã trở thành một phần thiết yếu đối với cả công việc, học tập và giải trí. Nhu cầu tự xây dựng (build) các bộ máy tính cá nhân hóa (Custom PC) đòi hỏi người kinh doanh phải cung cấp những nền tảng thông tin sản phẩm chuẩn xác, trực quan và chuyên nghiệp.

Tuy nhiên, nhiều website kinh doanh linh kiện nhỏ lẻ hiện nay thường gặp hạn chế như: mô tả thông số kỹ thuật (Spec) thiếu tính động, giao diện nhàm chán, hoặc khó khăn trong khâu quản lý luồng đơn hàng và biến động kho. Xuất phát từ thực trạng đó, đề tài **"Xây dựng Website cửa hàng máy tính và linh kiện - PowerTech"** được hình thành. Đề tài không chỉ đáp ứng một giao diện bán hàng chuyên nghiệp (Retail-Tech chuẩn), mà còn giải quyết cấu trúc lưu trữ thông số kỹ thuật linh hoạt cho đa dạng dòng sản phẩm (CPU, RAM, Mainboard, VGA...), đồng thời quản lý chặt chẽ theo phân quyền RBAC đa vai trò từ Customer, Sales, Warehouse đến Admin.

### 1.2 Ý nghĩa khoa học và thực tiễn

- **Ý nghĩa khoa học:** Áp dụng mô hình kiến trúc phần mềm ASP.NET Core MVC, quản lý tương tác dữ liệu thông qua Entity Framework Core (chú trọng cấu hình Fluent API, Check Constraints) giúp nâng cao hiệu suất và tổ chức mã nguồn chặt chẽ. Đồ án giúp minh họa quy trình phát triển từ khâu Phân tích thiết kế, Lên mô hình Dữ liệu chuẩn hóa đến khi Triển khai thành sản phẩm hoàn thiện.
- **Ý nghĩa thực tiễn:** Cung cấp giải pháp phần mềm ngay lập tức áp dụng được cho cửa hàng thực tế. Hệ thống giúp doanh nghiệp quản lý từ đầu vào (nhập kho), đầu ra (đơn hàng online, bán POS tại quầy), đến chăm sóc khách hàng (hỗ trợ tickets, đánh giá sản phẩm). Khách hàng có trải nghiệm mua sắm mượt mà, bộ lọc kỹ thuật mạnh mẽ.

### 1.3 Mục tiêu, Đối tượng và Phạm vi nghiên cứu

- **Mục tiêu nghiên cứu:** Xây dựng thành công Website thương mại điện tử chuyên việt cho lĩnh vực phần cứng máy tính. Áp dụng chuẩn bảo mật danh tính (Identity), phân quyền 6 cấp độ và quy trình mua bán hoàn chỉnh từ Frontend tới Backend.
- **Đối tượng nghiên cứu:** 
  - Khách hàng có nhu cầu mua sắm linh kiện máy tính.
  - Các nghiệp vụ quản trị, bán hàng, kiểm kho, hỗ trợ và giao hàng (Shipper).
  - Quy trình quản lý trạng thái đơn hàng và tồn kho.
- **Phạm vi nghiên cứu:** 
  - Hệ thống áp dụng chủ yếu cho quy mô doanh nghiệp vừa và nhỏ.
  - Quản lý các đối tượng: Sản phẩm, Danh mục, Nhãn hiệu, Thông số kỹ thuật (Dynamic Specs), Đơn hàng, Biến động kho, Đánh giá, Lệnh hỗ trợ (Support Ticket).

### 1.4 Phương pháp thực hiện
- Phương pháp luận phân tích thiết kế hệ thống hướng đối tượng (OOP & UML).
- Phương pháp nghiên cứu tài liệu: Tìm hiểu kiến trúc ASP.NET Core, Design Pattern.
- Phương pháp thực nghiệm: Lập trình, kiểm thử (testing), triển khai trên server cục bộ.

### 1.5 Cấu trúc đồ án

Báo cáo bao gồm 4 chương chính như sau:
- **Chương 1. Tổng quan:** Trình bày lý do chọn đề tài, mục tiêu, đối tượng, phạm vi và phương pháp nghiên cứu.
- **Chương 2. Cơ sở lý thuyết:** Giới thiệu về các ngôn ngữ, khung làm việc (framework) và mô hình kiến trúc sử dụng trong phát triển hệ thống điện toán đám mây và web.
- **Chương 3. Kết quả thực nghiệm / Phân tích thiết kế:** Đi sâu vào phân tích yêu cầu phần mềm, mô hình dữ liệu (ERD), giao diện, và các kết quả tính năng đạt được.
- **Chương 4. Kết luận và kiến nghị:** Đánh giá ưu điểm, khuyết điểm của phần mềm và đề xuất định hướng phát triển ở các phiên bản tiếp theo.

---

# Chương 2. CƠ SỞ LÝ THUYẾT

Chương này trình bày các khái niệm nền tảng, công nghệ và framework đã được lựa chọn để phát triển dự án Website cửa hàng linh kiện PowerTech. Các quyết định này dựa trên sự ổn định, khả năng mở rộng và mức độ bảo mật cao.

### 2.1 Kiến trúc phần mềm và hệ thống

**Mô hình kiến trúc ASP.NET Core MVC**
MVC chia ứng dụng làm 3 phần độc lập, giúp mã nguồn dễ đọc, dễ bảo trì:
- **Model:** Chứa logic nghiệp vụ và dữ liệu hệ thống. Trong dự án, Models tương ứng với các thực thể Database (Domain Entities) cũng như các ViewModels vận chuyển dữ liệu lên View một cách an toàn.
- **View:** Giao diện người dùng được render nhờ Razor engine của ASP.NET. Các View được chia Area rõ ràng (Customer, Admin, Sales...).
- **Controller:** Đóng vai trò cầu nối, đón nhận Request từ người dùng, gọi và xử lý logic định tuyến dựa trên dữ liệu từ Model, sau đó trả Response qua View tương ứng.

**Role-Based Access Control (RBAC)**
Hệ thống sử dụng mô hình bảo mật RBAC với thư viện `ASP.NET Core Identity`. Khác với các hệ thống phân quyền cứng bằng cờ (flag), RBAC chuẩn của Identity cho phép:
- Định nghĩa nhiều chức danh `Roles`.
- Một người dùng (`User`) có thể mang nhiều nhóm quyền độc lập.
- Điều khiển vòng truy cập qua Attribute `[Authorize(Roles="...")]` ngay tại cấp độ Controllers và Actions.

### 2.2 Các công nghệ và Framework lõi

**Ngôn ngữ lập trình C# và .NET Core:** 
Hệ thống chạy trên nền tảng .NET Core mạnh mẽ đa nền tảng, tốc độ phản hồi cực nhanh. C# với kiểu dữ liệu mạnh (strong-typed) cùng tính năng LINQ hỗ trợ khả năng truy vấn xuất sắc.

**Entity Framework Core (EF Core) & Fluent API:**
- EF Core đóng vai trò ORM, dịch các thao tác LINQ thành chuỗi câu lệnh T-SQL tự động. 
- Thay vì dùng Data Annotations phân mảnh, dự án sử dụng **Fluent API** và **Check Constraints** (ví dụ ràng buộc lượng tồn kho không được âm, giá bán không nhỏ hơn 0), giúp toàn vẹn dữ liệu được giám sát ngay từ tầng cơ sở dữ liệu vật lý (SQL Server).

**Hệ quản trị cơ sở dữ liệu SQL Server:**
Cơ sở dữ liệu dạng quan hệ hỗ trợ ACID tốt, giúp giao dịch mua bán (Transaction) – đặt biệt là các tình huống trừ kho hay thanh toán được nguyên lập, đảm bảo không có sai sót trong tài chính.

**HTML, CSS, JavaScript (Giao diện Frontend):**
- Sử dụng chuẩn HTML5 và CSS3 kết hợp với Grid/Flexbox để dựng thiết kế Giao diện **Retail-Tech chuẩn** hiện đại với tone màu chủ đạo chuyên nghiệp, tối màu, box-shadow nổi bật theo đúng triết lý của các trang kinh doanh Gear/Linh kiện máy tính lớn (như GearVN, AnPhat).
- Không lạm dụng Template quá đà, hệ thống có đặc trưng UI riêng tư, độ nhạy cao (Responsive).

---

# Chương 3. KẾT QUẢ THỰC NGHIỆM VÀ PHÂN TÍCH THIẾT KẾ 

### 3.1 Phân tích yêu cầu

#### 3.1.1 Yêu cầu chức năng và phân quyền (Roles)

Hệ thống được chia thành 6 phân hệ (Areas) với 7 vai trò cốt lõi.

**Bảng 3.1: Các nhóm người dùng và chức năng tương ứng**

| Vai trò (Role) | Mô tả và Chức năng chính |
| --- | --- |
| **Guest** (Khách vãng lai) | Được phép xem trang chủ, tìm kiếm bộ lọc linh kiện, xem chi tiết sản phẩm, đọc đánh giá, thêm vào giỏ hàng và đăng ký tài khoản mới. |
| **Customer** (Khách hàng) | Kế thừa quyền của Guest. Đặc quyền: Thanh toán đơn (Checkout), theo dõi trạng thái đơn hàng (Tracking), xem lịch sử mua hàng, quản lý địa chỉ giao hàng cá nhân, viết Đánh giá (Review) và gửi Lệnh hỗ trợ (Ticket). |
| **Sales** (Nhân viên kinh doanh) | Truy cập Admin Dashboard (phân hệ Sales). Chuyên quản lý và duyệt các đơn hàng Online. Được cấp quyền bán trực tiếp tại quầy bằng chức năng **POS** và in hóa đơn (Print Invoice). |
| **Warehouse** (Thủ kho) | Quản lý sự biến động của tồn kho. Nhập kho (Stock Entry), kiểm tra danh sách sản phẩm cảnh báo sắp hết (Low-stock monitoring), xem lịch sử giao dịch Audit Trail kho bãi. |
| **Support** (Nhân viên CSKH) | Phụ trách trả lời các Ticket hỗ trợ từ khách hàng. Duyệt hoặc ẩn các Đánh giá (Review Moderation). |
| **Shipper** (Người giao hàng) | Vai trò tập trung vào xem danh sách đơn đang vận chuyển và cập nhật trạng thái "Đã giao thành công" hoặc "Thất bại". |
| **Admin** (Quản trị viên) | Cấp quyền tuyệt đối. Quản trị phân quyền tài khoản. Quản trị Master Data: Danh mục (Category), Thương hiệu (Brand), Thuộc tính phần cứng động (Dynamic Specs), thông tin Sản phẩm. Xem tổng quan các biểu đồ Doanh thu hệ thống. |

#### 3.1.2 Yêu cầu phi chức năng
- **Bảo mật:** Mật khẩu người dùng phải băm (hashed) bằng hệ chuẩn. Xác thực cookie HTTP-only. 
- **Hiệu năng:** Hệ thống phải duy trì tốc độ tìm kiếm và lọc thiết bị dưới 1 giây.
- **Tính toàn vẹn (Data Integrity):** Dữ liệu khi xóa mục lục không được gây mồ côi (orphan data) với đơn hàng đã bán. 
- **Giao diện (UI/UX):** Màu sắc thu hút tín đồ công nghệ, Responsive thích ứng tốt cả thiết bị di động PC và điện thoại.

### 3.2 Thiết kế hệ thống và Nghiệp vụ

#### 3.2.1 Sơ đồ Use-case tổng quát
Hệ thống xoay quanh 2 trục là "Khách hàng" (Front-end) và "Ban quản trị" (Back-office).
[Chèn hình: Sơ đồ Use Case tổng quát chi tiết theo phân quyền hệ thống]

#### 3.2.2 Quy trình nghiệp vụ cốt lõi
- **Luồng Khách hàng (Customer Journey):**
  Khách hàng vào hệ thống -> Tìm kiếm thiết bị theo bộ lọc (Giá, Brand, Danh mục) -> Xem Thư viện ảnh / Specs chi tiết -> Đưa vào Giỏ Hàng -> Thanh toán (Checkout) -> Sinh ra Mã đơn `ORD-xxxx`.

- **Luồng Bán hàng và Quản lý Đơn (Sales Flow):**
  Nhân viên Sales đăng nhập -> Xem Danh sách Đơn chờ xử lý (Pending) -> Xác nhận (Confirmed) -> Giao cho Shipper -> Hoàn tất. Nếu khách đến trực tiếp, Sales vào chức năng POS, tạo đơn tức thời và nhấp In hóa đơn khổ tiêu chuẩn.

- **Luồng Tư duy Sản phẩm động (Dynamic Specs):**
  Đây là đột phá của đồ án. Thay vì tạo 1 bảng Products chung chung chứa các cột `CPU_Type, RAM_Size...` dẫn đến rác bộ nhớ, dự án dùng hệ thống EAV cơ bản: 
  `Product` <-- `ProductSpecification` --> `SpecificationDefinition`. Điều này giúp Bàn phím thì có Switch Type, còn Màn hình thì có Refresh Rate mà không chung đụng số cột Db.

### 3.3 Thiết kế Cơ sở Dữ liệu

Hệ thống được thiết kế tuân thủ nguyên tắc chuẩn hóa dữ liệu, xóa bỏ dư thừa.

#### 3.3.1 Sơ đồ lớp / Thực thể liên kết (ERD)
Sơ đồ bao quát mối liên hệ giữa các Module User, Order, Product và Warehouse.
[Chèn hình: Sơ đồ thực thể liên kết ERD của hệ thống PowerTech Database]

#### 3.3.2 Thiết kế chi tiết các bảng trọng tâm

**Bảng 3.2: Thực thể Customer / Users (Kế thừa ASP.NET Identity)**
- `Id`: Khoá chính, GUID.
- `UserName`, `Email`, `PasswordHash`: Chuẩn xác thực.
- `FullName`, `PhoneNumber`: Thông tin liên lạc cơ bản.
Quan hệ: 1 User có nhiều `Address` và đa số nhiều `Orders`.

**Bảng 3.3: Thực thể Product (Sản phẩm)**
- `Id`: Khóa chính.
- `Name`: Tên linh kiện.
- `SKU`: Mã lưu kho.
- `Price`, `DiscountPrice`: Giá bán, giá khuyến mãi.
- `CategoryId`, `BrandId`: Khóa ngoại ràng buộc danh mục và nhãn hiệu.
- `CurrentStockQuantity`: Validate >= 0.

**Bảng 3.4: Thực thể Order (Đơn hàng)**
- `Id`: Khóa chính.
- `OrderCode`: Mã string chuyên dùng (`ORD-...`).
- `CustomerId`: Khóa ngoại tới user đặt hàng.
- `TotalAmount`: Tổng tiền hóa đơn.
- `Status`: Trạng thái (Pending, Confirmed, Shipping, Completed, Cancelled).
- `PaymentMethod`: Phương thức (COD, VNPay...).

### 3.4 Thiết kế Giao diện và Ghi nhận kết quả thực hiện

Website sở hữu bộ giao diện được đầu tư kỹ lưỡng, hướng đến tệp người dùng chuyên nghiệp rành về phần cứng. Layout chia khối chuẩn retail công nghệ.

**1. Giao diện Trang Chủ (Storefront)**
Trang chủ hiện đại, tập trung hiển thị Slider khuyến mãi. Khối Danh mục phân cấp rõ ràng (CPU, VGA, Gear). Component Card sản phẩm có gán nhãn `Sale`, hiển thị giá cũ gạch chéo chuyên nghiệp.
[Chèn hình: Giao diện Trang Chủ tổng quan (Storefront)]

**2. Giao diện Danh sách và Bộ lọc Kỹ thuật**
Hỗ trợ tìm kiếm theo nhiều tiêu chí mà URL giữ nguyên trạng thái giúp người dùng dễ dàng chia sẻ bộ lọc.
[Chèn hình: Giao diện lọc sản phẩm bên phía khách hàng]

**3. Giao diện Chi tiết Sản phẩm**
Hiển thị Thư viện hình ảnh sắc nét. Bảng Specs tự động render linh hoạt dựa vào dữ liệu DB quy định. Tích hợp thanh chọn số lượng và nút "Add to Cart" có kích thước lớn tiện trải nghiệm UI.
[Chèn hình: Giao diện Chi tiết sản phẩm biểu thị bảng Spec động]

**4. Giao diện Bán hàng tại quầy (POS - Point of Sale) của Sales**
Màn hình thiết kế ngang tối ưu tốc độ, thanh tìm kiếm chọn sản phẩm nhanh, chốt hóa đơn và thực thi thao tác in biên lai trực tiếp.
[Chèn hình: Giao diện POS bán hàng tại quầy dành cho nhân viên Sales]
[Chèn hình: Giao diện bản In hóa đơn chuyên nghiệp]

**5. Giao diện Quản trị Dashboard và Phân quyền kho**
Bảng điều khiển trực quan hiển thị các biểu đồ (Charts) bằng hệ thống thống kê doanh thu đa chiều, trạng thái đơn hàng giúp Admin ra quyết định. Khu vực kho quản lý Audit Trail chống thất thoát lô hàng.
[Chèn hình: Giao diện Admin Dashboard biểu đồ doanh thu]
[Chèn hình: Giao diện xem lịch sử nhập kho và cảnh báo tồn (Warehouse)]

---

# Chương 4. KẾT LUẬN VÀ KIẾN NGHỊ

### 4.1 Kết quả đạt được

Hệ thống Website Cửa hàng Máy tính PowerTech đã hoàn thành 100% mục tiêu ban đầu đặt ra:
- **Xây dựng được hệ sinh thái công nghệ:** Từ Customer Shopping đến Admin Management, Sales POS, Warehouse Tracking đa luồng.
- **Giải quyết bài toán cơ sở dữ liệu chuyên biệt:** Kỹ thuật tách Specs tĩnh thành Specs động (`SpecificationDefinition`) giúp website bán từ cáp nối đơn giản đến PC phức tạp mà không phá vỡ mô hình kiến trúc.
- **Đảm bảo bảo mật đa vai trò:** Thể hiện rõ việc tách Area và Controller, ứng dụng Authorization Roles Identity khép kín. Người dùng không có Role tương ứng không bao giờ tiếp cận được URL nhạy cảm.
- **Giao diện Retail-Tech chuẩn:** Giao diện đẹp, hiệu năng ấn tượng, mượt mà trên Mobile lẫn Desktop.

### 4.2 Điểm Hạn chế

Dù phần quản lý đã khá hoàn thiện, vẫn tồn tại một số điểm nhỏ cần cái tiến trong tương lai:
- Các thao tác xuất báo cáo đa nền tảng (Excel, PDF) tại khu vực Admin còn ở mức cơ bản, cần đa dạng hóa các Chart chi tiết hơn.
- Trong tính năng POS, cần thiết kế nâng cao về phím tắt bàn phím vật lý để Sales thao tác "không cần chuột".
- Quản lý kho chưa có tính năng quy mô phân mảnh "Nhiều chi nhánh cửa hàng" (Multi-branches), chỉ đang vận hành như một kho tổng trung tâm cục bộ.

### 4.3 Định hướng phát triển tương lai

Nếu có cơ hội phát triển hệ thống trở thành bản thương mại độc lập, định hướng của sinh viên như sau:
- Tích hợp cổng thanh toán trực tuyến qua thẻ tín dụng và API của ví điện tử (ZaloPay, VNPay, Momo) trực tiếp thay vì chỉ Code logic tĩnh.
- Xây dựng Module "PC Builder" hiện đại, nơi hệ thống tự động kiểm tra xung đột phần cứng (Ví dụ: CPU Intel không thể lắp vào Mainboard Chipset AMD).
- Bổ sung cấu trúc đa chi nhánh, giúp theo dõi tồn kho theo từng cửa hàng địa lý cụ thể kết hợp tích hợp bên đối tác vận chuyển giao hàng như GHTK.

---

# TÀI LIỆU THAM KHẢO

[1] Microsoft (2024). *ASP.NET Core MVC Documentation*. Truy cập từ: https://learn.microsoft.com/en-us/aspnet/core/mvc/overview
[2] Microsoft (2024). *Entity Framework Core*. Truy cập từ: https://learn.microsoft.com/en-us/ef/core/
[3] Freeman, A. (2020). *Pro ASP.NET Core 3*. Nhà Xuất Bản Apress.
[4] Troelsen, A. & Japikse, P. (2022). *Pro C# 10 with .NET 6*. Nhà Xuất Bản Apress.
[5] Khoa Công Nghệ Thông Tin (2024). *Hướng dẫn viết Báo cáo đồ án cơ sở*. Tài liệu nội bộ.

---

# DANH SÁCH HÌNH ẢNH CẦN BỔ SUNG

Dưới đây là danh sách tổng hợp toàn bộ các hình ảnh bạn cần tiến hành chụp từ hệ thống và dán đè vào vị trí ghi [Chèn hình: ...] trong báo cáo:

1. **Hình 1:** Sơ đồ Use Case tổng quát chi tiết theo phân quyền hệ thống (Chèn tại tiểu mục 3.2.1)
2. **Hình 2:** Sơ đồ thực thể liên kết ERD của hệ thống PowerTech Database (Chèn tại tiểu mục 3.3.1)
3. **Hình 3:** Giao diện Trang Chủ tổng quan - Storefront (Chèn tại Phần 1 tiểu mục 3.4)
4. **Hình 4:** Giao diện lọc sản phẩm bên phía khách hàng (Chèn tại Phần 2 tiểu mục 3.4)
5. **Hình 5:** Giao diện Chi tiết sản phẩm biểu thị bảng Spec động (Chèn tại Phần 3 tiểu mục 3.4)
6. **Hình 6:** Giao diện POS bán hàng tại quầy dành cho nhân viên Sales (Chèn tại Phần 4 tiểu mục 3.4)
7. **Hình 7:** Giao diện bản In hóa đơn chuyên nghiệp (Chèn tại Phần 4 tiểu mục 3.4)
8. **Hình 8:** Giao diện Admin Dashboard biểu đồ doanh thu (Chèn tại Phần 5 tiểu mục 3.4)
9. **Hình 9:** Giao diện xem lịch sử nhập kho và cảnh báo tồn Warehouse (Chèn tại Phần 5 tiểu mục 3.4)
