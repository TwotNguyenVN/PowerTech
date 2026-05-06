# Biểu đồ luồng xử lý đơn hàng (Order Processing Flow)

```mermaid
flowchart TD
    A[Khách hàng tạo đơn hàng] --> B{Có thanh toán trước không?}

    B -- Có --> C[Thanh toán online thành công]
    C --> D[Trạng thái thanh toán: Đã thanh toán]
    D --> E[Kho xuất hàng / Đóng gói]
    E --> F[Giao cho Shipper]
    F --> G[Trạng thái đơn: Đang giao]

    B -- Không (COD) --> H[Trạng thái đơn: Chờ xác nhận]
    H --> I{Khách hàng hủy đơn?}
    I -- Có --> X[Đơn hàng bị hủy]
    I -- Không --> J[Nhân viên Sales xác nhận đơn]
    J --> E

    G --> K{Khách từ chối nhận?}
    K -- Có --> X

    K -- Không --> L{Giao thành công?}
    L -- Có --> M[Đã giao hàng]
    M --> N[Hoàn tất đơn hàng]

    L -- Không --> O[Nhân viên Shipper báo giao thất bại]
    O --> P{Số lần thất bại > 3?}
    P -- Có --> X
    P -- Không --> F
```

> **Mô tả quy trình chi tiết thiết lập trên hệ thống:**
> Sau khi khách hàng thiết lập đơn hàng trên Storefront (Web), hệ thống kiểm tra hình thức thanh toán. Thao tác tiếp theo sẽ trải qua sự phối hợp của ba Role (Phiên bản hệ thống chặt chẽ):
> 
> 1. **Khách hàng / Hệ thống**: Nếu thanh toán online thành công, đơn được đẩy thẳng xuống kho. Nếu là thanh toán khi nhận hàng (COD), đơn vào trạng thái chờ. Lúc này Khách hàng có thể tự do Hủy đơn.
> 2. **Nhân viên Bán hàng (Sales)**: Có nhiệm vụ xác nhận (Approve) đơn hàng đang chờ rỗng thành công, khóa quyền hủy đơn của Khách. Sau đó chuyển phiếu gửi Kho.
> 3. **Nhân viên / Đối tác Vận chuyển (Shipper)**: Chỉ có Shipper mới được quyền ấn cập nhật hoàn thành đối với đơn hàng. Trong quá trình giao, nếu đi vắng, Shipper được đánh dấu giao thất bại. Quá 3 lần sẽ Hủy khóa đơn. Khi giao được tới tay khách và nhận tiền COD, Shipper xác nhận "Hoàn tất". Hệ thống ngay lúc này mới Ghi nhận Doanh thu.