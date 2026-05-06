# Phân Tích Thiết Kế Cơ Sở Dữ Liệu - Hệ thống PowerTech

Hệ thống quản lý cơ sở dữ liệu của PowerTech được thiết kế bằng **Entity Framework Core (Code-First)** chạy trên nền tảng **Microsoft SQL Server**. Database được xây dựng đạt chuẩn hóa ở mức 3NF (Third Normal Form) nhằm hạn chế dư thừa dữ liệu, đồng thời áp dụng một số Pattern đặc thù cho thương mại điện tử để tối ưu hoá tốc độ truy vấn và bảo toàn vẹn dữ liệu kế toán.

Dưới đây là phân tích chi tiết các cụm bảng (Schema Clusters) trọng tâm trong hệ thống:

---

## 1. Cụm Identity & Người dùng (User Management)
Sử dụng bộ khung bảo mật ASP.NET Core Identity đã được tinh chỉnh.

*   **`AspNetUsers`**: Bảng trung tâm lưu trữ thông tin thực thể con người (Khách hàng, Nhân viên). Được mở rộng thêm các trường như `FullName`, `UserCode` (mã nhân viên).
*   **`AspNetRoles` / `AspNetUserRoles`**: Quản lý phân quyền Role-Based Access Control (RBAC). Các vai trò (Admin, Sales, Shipper, Warehouse, Support) được map vào user thông qua bảng trung gian này.
*   **`UserAddresses`**: Quản lý đa địa chỉ giao hàng của một User (1-N). Có trường cờ `IsDefault` để xác định địa chỉ ưu tiên khi thanh toán.

---

## 2. Cụm Danh mục & Hàng hóa (Catalog & Product Master)
Đóng vai trò là Master Data của toàn bộ hệ thống.

*   **`Categories`**: Bảng danh mục sản phẩm. Thiết kế theo dạng cây đệ quy (với `ParentCategoryId` tham chiếu chính nó) giúp tự do phân cấp danh mục (Ví dụ: Máy tính > Laptop > Laptop Gaming).
*   **`Brands`**: Quản lý thương hiệu đối tác (Logo, Tên).
*   **`Products`**: Bảng lõi linh kiện. Liên kết khoá ngoại (N-1) tới `Categories` và `Brands`. Quản lý `Price` (giá gốc) và `DiscountPrice` (giá đã giảm). Có cột `StockQuantity` đóng vai trò là "Cache" trạng thái tồn kho để truy vấn nhanh mà không cần cộng dồn log.
*   **`ProductImages`**: Bảng 1-N chứa danh sách đường link ảnh hiển thị theo dạng Gallery cho từng sản phẩm.
*   **`Specifications` & `ProductSpecifications` (EAV Pattern)**: Sử dụng mô hình Entity-Attribute-Value. Hệ thống viễn thông/công nghệ có thông số kĩ thuật rất dị biệt (CPU cần "Xung nhịp", nhưng Bàn phím lại cần "Switch Type"). Thiết kế này giúp gắn thông số động cho từng sản phẩm mà không cần tạo hàng chục cột `NULL` thừa thãi trong bảng Products.

---

## 3. Cụm Giao dịch & Bán hàng (Sales & Orders)
Được thiết kế theo nguyên tắc "Bất biến" (Immutability) đối với lịch sử giao dịch.

*   **`Orders`**: Chứa thông tin tổng quan của một hoá đơn (Trạng thái, Phí ship, Tổng tiền, Phương thức thanh toán, `CouponId` áp dụng, ...). Lưu trữ `UserId` mua hàng và `AssignedToUserId` (nhân viên xử lý/Shipper).
*   **`OrderItems` (Snapshot Pattern)**: Đây là một thiết kế rất quan trọng. Bảng chi tiết hóa đơn này không chỉ trỏ khoá ngoại về `ProductId`, mà nó còn copy lưu chết (Hardcopy) lại `UnitPrice`, `ProductName`, và `ProductSku` ngay tại giây phút khách đặt hàng. Giúp cho việc Admin sau này có đổi tên hoặc tăng giá sản phẩm, thì hóa đơn cũ của khách hàng vẫn hiển thị số liệu cũ lịch sử chính xác tuyệt đối.
*   **`Payments`**: Tách rời luồng thanh toán (COD, VNPay) khỏi bảng Order. Quản lý trạng thái giao dịch độc lập, lưu trữ mã `TraceId` hoặc `GatewayProvider` để đối soát ngân hàng.
*   **`Coupons`**: Bảng mã giảm giá. Quản lý % giảm, số tiền giảm tối đa, thời hạn sử dụng và đặc biệt là cột `UsedCount` so với `UsageLimit` để chốt số lượng người được áp dụng khuyến mãi.

---

## 4. Cụm Kho bãi (Inventory & Ledger)
Đảm bảo hàng hóa không bao giờ bị sai lệch dù có hàng trăm lượt mua bán cùng lúc (Concurrency).

*   **`StockTransactions` (Ledger Pattern)**: Hoạt động như một sổ cái kế toán. Mọi sự thay đổi về cột `StockQuantity` trong bảng Product ĐỀU PHẢI sinh ra 1 dòng log ở đây. 
    Bảng này ghi rõ: `ProductId`, Số lượng thay đổi (Quantity), Loại giao dịch (Import/Export/Sale/Return), Lý do, và ID Nhân viên thực hiện. Đặc biệt, nó lưu giữ `BeforeQuantity` và `AfterQuantity` giúp cho quá trình thanh tra, truy vết (Audit) cực kỳ minh bạch.

---

## 5. Cụm Tương tác & Hỗ trợ (Customer Interactions)

*   **`Reviews` & `ReviewImages`**: Lưu trữ đánh giá sản phẩm của người dùng (từ 1 đến 5 sao). Có trường cờ `IsApproved` để nhân viên Support duyệt bài, tránh spam/bot. Hỗ trợ 1-N ảnh upload đính kèm.
*   **`SupportTickets`**: Đóng vai trò là hệ thống thẻ khiếu nại/bảo hành. Cấu trúc gồm mã Ticket riêng biệt, Content, Status (Mở/Đang xử lý/Đóng), và cơ chế "Assign" cho nhân viên CSKH cụ thể. Có liên kết tùy chọn (Optional FK) với bảng `Orders` nếu lỗi liên quan tới đơn hàng.
*   **`TradeInRequests`**: Quản lý quy trình Thu cũ - Đổi mới. Lưu thông tin sơ bộ thiết bị cũ mà khách hàng muốn bán lại, các ảnh upload thẩm định giá, và trạng thái thương lượng với cửa hàng.

---

## 6. Điểm Đánh Giá Các Quyết Định Thiết Kế (Design Decisions)

1.  **Sử dụng Khoá ngoại xoá tầng (Cascade Delete) cẩn trọng**: Hệ thống chỉ dùng Cascade Delete cho các bảng cấp dưới phụ thuộc hoàn toàn (Ví dụ: xoá Product -> xoá ảnh ProductImages). Đối với các bảng dính dáng tới doanh thu tài chính (Order -> User), hệ thống dùng cơ chế `Restrict` hoặc `Set Null` để không bao giờ mất hóa đơn dù user có bị xóa bỏ.
2.  **Indexing tối ưu**: Các trường hay được dùng để LIKE tìm kiếm hoặc dùng trong cục Mệnh đề WHERE (`SKU`, `IsActive`, `Status`, `CategoryId`, `CreatedAt`) đã được thiết lập Index ở dưới DB để tăng tốc đáng kể các query phân trang nặng nề trên Storefront.
3.  **Concurrency Token**: Entity Framework được tận dụng để bắt các lỗi xung đột dữ liệu (Concurrency conflicts) - cực kỳ quan trọng trong lúc thanh toán đơn hàng POS hoặc khi 2 nhân viên kho cùng xuất/nhập một món hàng.
