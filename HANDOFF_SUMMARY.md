# PowerTech - Final Handoff Summary

Xin chào! Dự án đồ án Website thương mại điện tử linh kiện máy tính (PowerTech) đã được hoàn thiện hệ thống phân quyền đa người dùng và xử lý nghiệp vụ cực kỳ đầy đủ theo yêu cầu đồ án.

Dưới đây là tài liệu tổng hợp những thông tin và nghiệp vụ cốt lõi đang hoạt động trong hệ thống nhằm hỗ trợ bạn chuẩn bị tốt nhất cho buổi bảo vệ đồ án hoặc kiểm tra lại một lượt các luồng tính năng:

## 1. Hệ thống Phân quyền (Role-Based Access Control)

Hệ thống được thiết kế theo 7 vai trò riêng biệt, quản lý triệt để mức độ truy cập bằng `ASP.NET Core Identity`.
Tài khoản Quản trị cấp cao (Toàn quyền điều hành - Có Seed sẵn trong DB):
- **Email:** `admin@powertech.com`
- **Mật khẩu:** `Admin@123` *(Để ý chữ "A" viết hoa)*

Bạn có thể dùng tài khoản Admin này để tạo lập và gán quyền cho các nhân viên khác trong hệ thống theo cơ cấu phân hệ như sau:
- **Admin:** Phân hệ tối cao. Quản lý phân quyền tài khoản (Users/Roles), Nhập liệu cốt lõi (Category, Brand, Thông số kỹ thuật động - Dynamic Specs, Product) và Thống kê biểu đồ Doanh thu (Dashboard).
- **Sales (Kinh doanh):** Chống thất thoát luồng đặt hàng. Quản lý Đơn hàng trực tuyến (Duyệt Pending $\rightarrow$ Confirmed), Bán hàng tức thời tại quầy thông qua mô-đun **POS**, xuất/in Hóa đơn, và mới nhất là luồng **Quản lý Mã giảm giá (Coupons/Discount)**.
- **Warehouse (Thủ kho):** Quản trị kho phần cứng vật lý. Nhập lô hàng mới (Stock Entry), theo dõi sát lượng tồn kho (Low Stock Alerts/Sản phẩm sắp hết), đảm bảo ghi nhận mọi lịch sử xuất/nhập/điều chỉnh kho không thể thay đổi thông qua biến động kho (Audit Trail).
- **Shipper (Giao hàng):** Khâu chuyển phát chốt đơn. Tiếp nhận danh sách đơn hàng đã bàn giao, thực thi nghiệp vụ cập nhật sang trạng thái Đang giao (Shipping), Thành công (Completed) hoặc Thất bại.
- **Support (CSKH):** Là trạm hỗ trợ tín nhiệm. Tiếp nhận giải quyết khiếu nại bảo hành (Tickets), xét duyệt/kiểm duyệt các bài đánh giá để được hiển thị công khai (Reviews), tra cứu toàn bộ hồ sơ khách hàng.
- **Customer (Khách hàng):** Cấp account tiêu chuẩn khi người dùng tự tạo mới. Kế thừa quyền Guest và bổ sung: Thanh toán rổ hàng tùy biến (Partial Checkout), theo dõi định vị trạng thái đơn, lưu địa chỉ giao hàng và gửi yều cầu.
- **Guest (Khách vãng lai):** Trải nghiệm danh mục và bộ lọc chuẩn xác. Chỉ được tìm và thêm sản phẩm vào giỏ, chưa thanh toán được.

## 2. Các Luồng Nghiệp vụ Chính (Khuyến nghị Demo/Bảo vệ)

Khi thuyết trình và demo trước giảng viên, bạn nên vận hành mượt mà các luồng sau:

### 2.1. Luồng Trải nghiệm Khách hàng (Customer Journey)
1. **Tìm kiếm & Lọc Sản Phẩm:** Sử dụng khách vãng lai (Guest) dạo qua các danh mục phần cứng linh kiện. Thử bộ lọc giá hoặc thương hiệu để minh họa tính hiệu quả (đặc biệt khi filter thì URL thay đổi mà màn hình reload nhạy).
2. **Chi tiết & Giỏ hàng:** Click xem Specs cấu hình và thêm sản phẩm vào Giỏ Hàng. Xong tạo một tài khoản mới để đăng nhập/chuyển vai Customer.
3. **Thanh toán phần (Partial Checkout):** Trong Giỏ Hàng, giả lập tích chọn MỘT SỐ mặt hàng muốn mua ở nhịp này. Hệ thống Tạm tính cập nhật tiền thật tức thời mà không xóa bỏ mặt hàng không được check (tính năng khó so với checkout 1 phát hết giỏ thông thường).
4. **Checkout:** Nhập Mã Giảm Giá nếu có. Đặt hàng và ra màn hình thông báo Mã `ORD-...` cực xịn.

### 2.2. Luồng Xử lý Đơn Hàng Phức Hợp (Sales $\rightarrow$ Shipper)
1. **Sales duyệt đơn:** Login tài khoản có role `Sales`. Vào Quản lý luồng Đơn Hàng -> Cập nhật trạng thái "Chờ xác nhận" thành "Đã xác nhận". Nhân viên Sales có thể click xem Hóa đơn (In Invoice rõ nét cho khách). Chuyển trạng thái sang "Giao cho Shipper".
2. **Shipper giao đơn:** Chuyển tài khoản mang quyền `Shipper`. Tìm tên mã hoặc trạng thái đơn tương ứng. Giả lập đơn thất bại hoặc cập nhật về "Đã giao thành công" (hệ thống sẽ tự động đối soát thanh toán).
3. **Mã giảm giá:** Thử Demo tính năng Sales thiết lập mã ưu đãi ví dụ: Coupon `GIAM50K` cho các đơn hàng mùa sale.

### 2.3. Bán hàng tại Quầy Tức Thì (POS Interface)
1. Sales chọn menu "Bán hàng POS".
2. Diễn giải thiết kế màn hình giao diện tập trung một khối, gõ nhanh 1 phần mã/tên linh kiện $\rightarrow$ Click điền thông tin (chỉ reset dòng chọn SP, giữ nguyên layout) $\rightarrow$ Chốt thanh toán ngay và xuất file In. Rất thực tế cho bán lẻ.

### 2.4. Chuỗi Cung Ứng Kho (Warehouse Audit Trail)
1. Thủ kho `Warehouse` truy cập màn hình Cảnh báo "Sắp hết hàng".
2. Sinh tác vụ "Nhập Kho" số lượng lớn với một phụ kiện (chẳng hạn bàn phím XYZ).
3. Trình diễn màn hình "Lịch sử biến động": Chứng minh nguyên lý kế toán lưu giữ toàn bộ dữ liệu nhập xuất, chống gian lận.

### 2.5. Luồng Chăm sóc (Support & CRM)
1. Customer gửi một Ticket hỏng VGA hoặc thắc mắc.
2. `Support` login, tra danh sách Ticket, điền phản hồi rồi Đóng Ticket. Support hoàn toàn check được biểu đồ chi tiết vị khách đó mua gì ở Tab khách hàng.

### 2.6. Điểm Đột Phá Đáng Báo Cáo: Đặc tả DB Cấu Hình Động (Dynamic Specification Model)
Đây là "bài tủ" lấy điểm kỹ thuật khi bảo vệ đồ án nếu bị hỏi khó:
- Cấu trúc hệ thống KHÔNG TẠO ra các cột lỏng lẻo chung chung vào bảng `Product` kiểu (`So_VGA`, `Loai_Ram`, `Bus`). Nó phá hoại hệ quản trị dữ liệu lớn.
- Dự án giải được cấu trúc EAV chuyên sâu: `Product` liên kết n-n qua `ProductSpecification` tới bảng lõi `SpecificationDefinition`. Điều này linh động tuyệt đối: Màn hình sẽ render Tần số quét, trong khi Nguồn (PSU) lại hiển thị chuẩn công suất (Watt) thông qua thao tác điền của Admin mà DB không hẹp lại một chút nào!

## 3. Checklist cuối cùng
- Đã khắc phục ổn định warning null trên module Support liên quan đến dữ liệu trả về null trên một vài bảng.
- Dọn dẹp sạch mã lỗi thừa trong SQL và fix trọn vẹn luồng Database Seed (Mock Mockup).
- Thư mục Media/Images (`wwwroot/uploads`) vận hành chuẩn Path cục bộ. Dữ liệu rác đã được clear hoàn toàn.

---
**Rất vui được đồng hành trong hành trình xây dựng PowerTech. Chúc bạn tự tin bảo vệ đồ án và đạt kết quả thật cao! 🔥**
