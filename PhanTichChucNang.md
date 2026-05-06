# Phân Tích Chức Năng Hệ Thống PowerTech

Hệ thống PowerTech là một nền tảng thương mại điện tử chuyên sâu dành cho lĩnh vực bán sỉ & lẻ linh kiện máy tính, PC build và thiết bị công nghệ. Hệ thống được thiết kế theo mô hình kiến trúc phân hệ (Module-based Architecture) sử dụng ASP.NET Core MVC (Areas), phân chia rạch ròi các chức năng dựa trên vai trò (Role-based) của người dùng.

Dưới đây là phân tích chi tiết các chức năng chính của hệ thống, được chia theo từng phân hệ (Area).

---

## 1. Phân hệ Khách hàng & Cửa hàng (Storefront & Customer Area)
Đây là mặt tiền của hệ thống, phục vụ khách hàng vãng lai và khách hàng đã đăng nhập.

### 1.1. Mua sắm & Khám phá (Storefront)
*   **Danh Mục & Sản Phẩm**: Trưng bày sản phẩm theo danh mục (Laptop, PC, Linh kiện...) và thương hiệu. Hỗ trợ hiển thị biến thể sản phẩm, thông số kỹ thuật chi tiết và thư viện hình ảnh.
*   **Tìm kiếm & Lọc thông minh**: Tìm kiếm theo từ khóa (SKU, Tên sản phẩm). Lọc theo khoảng giá, danh mục, thương hiệu và sắp xếp (Mới nhất, Nổi bật, Giá tăng/giảm).
*   **Giỏ hàng (Shopping Cart)**: Thêm/sửa/xóa sản phẩm khỏi giỏ hàng. Hỗ trợ tính năng chọn từng sản phẩm cụ thể trong giỏ để thanh toán (Partial Checkout).
*   **Thanh Toán (Checkout)**: Nhập thông tin giao hàng, áp dụng mã giảm giá (Coupon). Hỗ trợ thanh toán tiền mặt khi nhận hàng (COD) hoặc thanh toán trực tuyến qua thẻ bảo mật.
*   **Thu cũ đổi mới (Trade-In)**: Khách hàng có thể gửi yêu cầu định giá thiết bị cũ (chọn danh mục, hãng, tình trạng, upload hình ảnh thực tế) để nhận trợ giá khi mua máy mới.

### 1.2. Quản lý Tài khoản (Customer)
*   **Hồ sơ & Sổ địa chỉ**: Quản lý thông tin cá nhân và lưu trữ nhiều địa chỉ giao hàng để thanh toán nhanh chóng.
*   **Quản lý Đơn hàng (Order Tracking)**: Theo dõi trạng thái đơn hàng theo thời gian thực (Chờ xử lý -> Đang giao -> Hoàn tất). Xem lại chi tiết cấu hình sản phẩm tại thời điểm mua (Snapshot logic).
*   **Trung tâm Hỗ trợ (Support Ticket)**: Gửi yêu cầu hỗ trợ (bảo hành, khiếu nại, kỹ thuật) trực tiếp cho đội ngũ CSKH. Theo dõi tiến độ giải quyết ticket.
*   **Đánh giá Sản phẩm (Review)**: Viết nhận xét, xếp hạng sao và tải ảnh thực tế cho các sản phẩm đã mua để nhận được huy hiệu "Đã mua hàng".

---

## 2. Phân hệ Bán Hàng tại Quầy (Sales Area / POS)
Dành cho nhân viên bán hàng (Sales Staff). Tập trung vào tốc độ xử lý và hỗ trợ bán hàng đa kênh (O2O - Online to Offline).

*   **Bán hàng tại quầy (POS)**: Giao diện tối ưu để tạo đơn hàng nhanh. Hỗ trợ quét mã SKU, tìm kiếm sản phẩm realtime, thêm khách hàng mới hoặc chọn khách hàng cũ và thanh toán tại chỗ.
*   **Xử lý Đơn hàng Online**: Tiếp nhận đơn đặt hàng từ website. Xác nhận đơn, chuyển trạng thái từ "Chờ xử lý" sang "Đang giao hàng" và phân phối cho Shipper. Không cho phép nhân viên Sales "Hoàn tất" đơn hàng nếu quy trình giao hàng chưa kết thúc.
*   **Quản lý Mã giảm giá (Coupons)**: Tạo, chỉnh sửa và theo dõi các chương trình khuyến mãi (giảm theo % hoặc số tiền cố định), thiết lập số lượng giới hạn và thời gian áp dụng.
*   **Thống kê Doanh thu (Sales Dashboard)**: Xem báo cáo doanh thu trong ngày, thống kê hình thức thanh toán và số lượng đơn hàng do chính nhân viên/quầy đó thực hiện.

---

## 3. Phân hệ Quản lý Kho (Warehouse Area)
Dành cho Thủ kho (Warehouse Staff). Đảm bảo tính toàn vẹn và chính xác tuyệt đối của lượng hàng tồn kho.

*   **Quản lý Tồn kho Tức thời (Real-time Inventory)**: Xem danh sách sản phẩm và số lượng tồn hiện tại của từng mặt hàng. Cảnh báo các sản phẩm sắp hết hàng (< 10 items).
*   **Nhập Kho (Stock Entry)**: Tạo phiếu nhập hàng từ nhà cung cấp. Mỗi lần nhập kho sẽ tự động tính toán lại mức tồn kho an toàn và lưu lại chi phí nhập.
*   **Sổ kho (Stock Transactions)**: Theo dõi lịch sử biến động kho siêu chi tiết. Mọi hành động (Nhập hàng, Bán hàng, Trả hàng, Cập nhật thủ công) đều được ghi log lại (Trigger-based hoặc Code-based) bao gồm Số lượng trước -> Mức thay đổi -> Số lượng sau.

---

## 4. Phân hệ Chăm sóc Khách hàng (Support Area)
Dành cho chuyên viên CSKH. Xử lý các vấn đề hậu mãi và tương tác với người dùng.

*   **Quản lý Ticket Hỗ trợ**: Tiếp nhận, phân loại (Kỹ thuật, Thanh toán, Bảo hành), phản hồi và đóng các yêu cầu hỗ trợ từ khách hàng.
*   **Duyệt Đánh giá (Review Moderation)**: Đọc và duyệt/ẩn các đánh giá sản phẩm từ người dùng đảm bảo tính minh bạch, lọc nội dung rác hoặc hình ảnh không phù hợp.
*   **Xử lý Yêu cầu Thu cũ (Trade-In)**: Thẩm định hình ảnh, thông tin thiết bị cũ do khách gửi, liên hệ khách hàng để báo giá thu mua và chốt deal.
*   **Hồ sơ Khách hàng (Customer 360)**: Tra cứu lịch sử mua hàng, lịch sử khiếu nại của một khách hàng bất kỳ để đưa ra hướng giải quyết phù hợp nhất.

---

## 5. Phân hệ Giao hàng (Shipper Area)
Dành riêng cho Đội ngũ giao vận nội bộ.

*   **Danh sách Đơn Nhận Giao**: Hiển thị các đơn hàng đang ở trạng thái "Đang giao" (Shipping).
*   **Chốt Đơn & Xác thực**: Xác nhận hoàn tất giao hàng tận tay khách. Bắt buộc Shipper xác nhận thu tiền (đối với giao hàng COD) trước khi chuyển trạng thái đơn thành "Hoàn tất". Điều này đảm bảo dòng tiền được đối soát chính xác với kế toán.
*   **Báo cáo Giao hàng**: Thống kê số lượng đơn đã giao thành công và tổng số tiền mặt (COD) cần nộp lại cho cửa hàng cuối ca.

---

## 6. Phân hệ Quản Trị Hệ Thống (Admin Area)
Dành cho Quản lý cấp cao / Owner. Có toàn quyền can thiệp vào mọi luồng dữ liệu.

*   **Dashboard Tổng Quan**: Báo cáo đa chiều với biểu đồ trực quan (Chart.js) về Doanh thu (hàng ngày/tuần/tháng), Tỉ lệ chuyển đổi đơn hàng, và phân bổ phương thức thanh toán.
*   **Quản lý Danh mục & Thương hiệu (Catalog)**: Xây dựng cấu trúc cây danh mục (Category Tree), thêm mới các thương hiệu đối tác.
*   **Quản lý Sản phẩm Master**: Thêm mới sản phẩm, up ảnh, khai báo cấu hình (Specifications), gán danh mục và định giá bản lẻ.
*   **Quản trị Tài khoản & Phân quyền (Users & Roles)**: Tạo tài khoản cho nhân viên mới, phân bổ vai trò (Admin, Sales, Shipper, Support, Warehouse) và quản lý việc khoá/mở khoá người dùng vi phạm.

---

## Tổng kết Điểm nổi bật về Hệ thống

*   **Quy trình khép kín chặt chẽ**: Từ khi Khách hàng đặt đơn -> Sales xác nhận -> Kho tự động trừ số lượng -> Shipper đi giao -> Kế toán/Hệ thống ghi nhận doanh thu. Các vai trò không được phép vượt quyền nhau (VD: Sales không được tự hoàn tất đơn giao hàng).
*   **Dấu vết kiểm toán (Audit Trail)**: Mọi thay đổi về hàng hóa (StockTransactions) hoặc thay đổi giá bán đều được ghi lại. Đơn hàng lưu trữ "Snapshot" của hình ảnh và mã SKU để đề phòng trường hợp sản phẩm bị đổi tên trong tương lai, nhưng hóa đơn cũ của khách vẫn hiển thị đúng.
*   **Time-to-Value nhanh (POS)**: Giao diện POS được làm tiệm cận với ứng dụng Desktop, giúp thu ngân gõ và lên đơn chỉ trong vài giây.
