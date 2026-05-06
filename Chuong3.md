# CHƯƠNG 3: KẾT QUẢ THỰC NGHIỆM VÀ PHÂN TÍCH THIẾT KẾ

### 3.1. Kết quả Thực nghiệm Đạt được

Sau quá trình triển khai và thử nghiệm thực tế trên môi trường giả lập, hệ thống **PowerTech** đã đạt được các kết quả quan trọng sau:
- **Độ ổn định cao:** Hệ thống vận hành trơn tru trên nền tảng .NET Core, xử lý tốt các luồng dữ liệu phức tạp giữa các phân hệ (Areas).
- **Tính toàn vẹn dữ liệu:** Toàn bộ lịch sử giao dịch, nhập kho và thay đổi trạng thái đơn hàng được lưu vết chính xác trong cơ sở dữ liệu SQL Server.
- **Tối ưu hóa hiệu năng:** Tốc độ tải trang và xử lý bộ lọc sản phẩm đạt mức dưới 1 giây, đáp ứng tốt trải nghiệm người dùng Retail công nghệ.
- **Khả năng mở rộng:** Kiến trúc phần mềm cho phép dễ dàng thêm mới các chủng loại linh kiện máy tính với bộ thông số đặc thù mà không cần can thiệp sâu vào mã nguồn.

### 3.2. Thiết kế Giao diện

#### 3.2.1. Giao diện Quản trị (Admin Interface)
Giao diện quản trị được thiết kế theo phong cách Dashboard hiện đại, ưu tiên sự trực quan và hiệu quả quản lý:
- **Dashboard Tổng quan:** Hiển thị biểu đồ doanh thu theo thời gian, thống kê nhanh số lượng đơn hàng mới, khách hàng tiềm năng và trạng thái kho.
- **Quản lý Master Data:** Các form nhập liệu được thiết kế đồng bộ, hỗ trợ upload nhiều hình ảnh đồng thời và trình soạn thảo văn bản phong phú cho mô tả sản phẩm.
- **Phân hệ POS:** Giao diện chuyên dụng nằm ngang (Horizontal Layout) giúp nhân viên Sales quét mã/chọn sản phẩm nhanh chóng, chốt đơn và in hóa đơn thanh toán tại quầy.

#### 3.2.2. Giao diện Người dùng (User Interface)
Hướng đến đối tượng là các tín đồ công nghệ (Gamer, Modders, Tech Enthusiasts):
- **Trang chủ (Storefront):** Sử dụng các Banner động mạnh mẽ, khối danh mục sản phẩm được phân cấp rõ ràng với megamenu hỗ trợ lọc nhanh theo thương hiệu.
- **Trang Chi tiết Sản phẩm:** Bảng thông số kỹ thuật (Specs) được hiển thị chuyên nghiệp, tích hợp thư viện ảnh sản phẩm sắc nét và hệ thống Đánh giá (Review) từ người dùng.
- **Portal Cá nhân (Customer Profile):** Thiết kế dạng sidebar hiện đại, tách biệt rõ ràng các khu vực: Thông tin cá nhân, Lịch sử đơn hàng, Đổi mật khẩu và Trung tâm thông báo.

### 3.3. Các Chức năng Chính

Dưới đây là các chức năng cốt lõi và độc đáo tạo nên sự khác biệt của hệ thống PowerTech:

**1. Quản lý Thuộc tính Sản phẩm Động (Dynamic Specs System):** 
Đây là chức năng quan trọng nhất, cho phép định nghĩa các bộ thông số kỹ thuật khác nhau cho từng danh mục sản phẩm (Ví dụ: CPU có số nhân/luồng, RAM có bus/dung lượng). Hệ thống tự động render giao diện nhập liệu cho Admin và bảng Specs cho khách hàng dựa trên dữ liệu động.

**2. Phân hệ Bán hàng POS và In hóa đơn (POS & Invoice):**
Cho phép nhân viên kinh doanh thực hiện bán lẻ trực tiếp tại cửa hàng. Chức năng in hóa đơn (Print Invoice) tự động xuất định dạng chuẩn để in ra máy in nhiệt, hỗ trợ quy trình bán hàng chuyên nghiệp.

**3. Hệ thống Thông báo Đa luồng (Contextual Notifications):**
Hệ thống tự động gửi thông báo đến người dùng khi có các sự kiện quan trọng: 
- Thay đổi trạng thái đơn hàng (Đã xác nhận, Đang giao, Đã giao). 
- Phản hồi từ nhân viên hỗ trợ (Support Ticket). 
- Các thông báo bảo mật hệ thống (Đổi mật khẩu thành công).

**4. Trung tâm Hỗ trợ khách hàng (Support Ticketing Center):**
Chức năng cho phép khách hàng gửi các yêu cầu bảo hành hoặc tư vấn kỹ thuật. Hệ thống quản lý theo dạng luồng (threads), hỗ trợ đính kèm hình ảnh và ghi chú nội bộ giữa nhân viên hỗ trợ và quản trị viên.

**5. Quản trị Kho vận và Nhật ký Vết (Warehouse & Audit Trail):**
Theo dõi sự biến động của tồn kho theo thời gian thực. Mỗi hành động thay đổi số tồn kho (Nhập kho, bán POS, bán Online) đều được ghi lại trong nhật ký (Audit Trail) để đối soát, tránh thất thoát hàng hóa.

**6. Bộ lọc Sản phẩm Đa tầng (Advanced Filtering):**
Cho phép khách hàng tìm kiếm sản phẩm theo mức giá, danh mục, thương hiệu và các thông số kỹ thuật đặc thù ngay cả khi đang ở trang danh sách chung.

**7. Hệ thống Khuyến mãi và Coupon (Voucher Engine):**
Quản lý các mã giảm giá với nhiều điều kiện áp dụng phức tạp như: ngày hết hạn, số lượng tối đa, giá trị đơn hàng tối thiểu, mức giảm tối đa cho phép.