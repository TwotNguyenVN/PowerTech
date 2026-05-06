Biểu đồ luồng xử lý Thu Cũ Đổi Mới (Trade-in Workflow)

```mermaid
flowchart TD
    A[Khách hàng điền Form Thu Cũ] --> B{Form hợp lệ?}
    
    B -- Không --> E1[Báo lỗi cho UI]
    
    B -- Có (Lưu db) --> C[Tạo mới TradeInRequest trạng thái Pending]
    C --> D[Hệ thống tự động sinh ra 1 SupportTicket Title: '[THU CŨ]...']
    D --> E[Trạng thái Ticket: Open]
    
    E --> F[Nhân viên Support tiếp nhận Ticket]
    F --> G[Trạng thái Ticket: In Progress / Gán AssignedToUserId]
    
    G --> H[Nhân viên Support trao đổi / Thẩm định qua Ticket]
    H --> I{Khách đồng ý mang máy tới?}
    
    I -- Không --> J[Trạng thái Ticket: Closed]
    I -- Có --> K[Khách mang đồ đến cửa hàng]
    K --> J
```

> **Mô tả quy trình xử lý Thu Cũ:**
> Bắt đầu tại phía ứng dụng giao diện (Storefront), khi khách hàng có nhu cầu đổi thiết bị, họ gửi yêu cầu bằng cách điền form (Tên Model, Tình trạng, Hình ảnh). Hệ thống sẽ xác thực form. Nếu thành công, một bản ghi `TradeInRequest` với trạng thái là `Pending` được tạo ra trong CSDL. Điểm mấu chốt là ngay lập tức, hệ thống tự động phát sinh một `SupportTicket` kết nối với yêu cầu này (với tiêu đề có tiền tố "[THU CŨ]") và chuyển nó thành trạng thái `Open`.
> Thay vì sử dụng một bảng quản trị chuyên trách riêng cho `TradeInRequest`, hệ thống tận dụng luồng Xử lý Hỗ trợ (Support Ticket). Nhân viên Support sẽ tiếp nhận thẻ này, nó tự động đổi sang trạng thái `In Progress` và gán tên nhân viên xử lý. Việc định giá máy cũ, thương lượng với khách hàng hiện được thực thi hoàn toàn thông qua cơ chế nhắn tin của `TicketResponse` có tích hợp SignalR báo theo thời gian thực (Notify). Cuối cùng, khi giao dịch thành công (khách chịu lên cửa hàng) hoặc thất bại (khách từ chối giá), Ticket sẽ được đổi trạng thái thành `Closed`.

**Ghi chú phân tích:**
- **Triển khai rõ trong code:** Tôi rút ra luồng trên từ file `Store/Controllers/HomeController.cs` hàm `TradeIn(TradeInRequest request)` đã code logic tự động map thẳng sang `SupportTicket` thay vì giữ luồng riêng. Quản lý Ticket đang chạy tốt trong `Support/Controllers/TicketController.cs`.
- **Chưa thấy triển khai trong code:** Mặc dù Model `TradeInRequest.cs` có chứa thuộc tính `QuotedPrice` (giá định mức) và `Status`, nhưng trong source code tại phân hệ Admin hay Support không có bất kỳ Controller nào `Update(QuotedPrice)` hay trực tiếp chuyển đổi trạng thái của bảng `TradeInRequests`. Các công đoạn định giá/chốt thu mua đều đang được giải quyết thủ công bằng "miệng" (thông qua tính năng chat của Ticket).
