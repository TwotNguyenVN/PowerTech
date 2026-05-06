USE [TechZoneStoreDb]
GO

-- ==================================================================================
-- SCRIPT: DeleteOder.sql
-- MỤC TIÊU: Xoá sạch toàn bộ dữ liệu liên quan đến đơn hàng, thanh toán và lịch sử kho
--           để đưa hệ thống về trạng thái chưa có giao dịch.
-- ==================================================================================

PRINT 'Bắt đầu quá trình xoá dữ liệu đơn hàng...';

-- 1. Xoá các bảng con (kiểm tra ràng buộc khoá ngoại)
-- --------------------------------------------------

-- Xoá chi tiết hoá đơn
DELETE FROM [dbo].[OrderItems];
PRINT '- Đã xoá dữ liệu bảng OrderItems';

-- Xoá thông tin thanh toán
DELETE FROM [dbo].[Payments];
PRINT '- Đã xoá dữ liệu bảng Payments';

-- Xoá/Cập nhật các Ticket hỗ trợ có liên quan đến đơn hàng
DELETE FROM [dbo].[SupportTickets] WHERE [OrderId] IS NOT NULL;
PRINT '- Đã xoá các SupportTickets liên quan đến Order';

-- Xoá lịch sử giao dịch kho liên quan đến bán hàng (Export)
DELETE FROM [dbo].[StockTransactions] WHERE [ReferenceType] = N'ORDER' OR [ReferenceType] = N'SALE';
PRINT '- Đã xoá lịch sử StockTransactions loại ORDER/SALE';

-- 2. Xoá bảng chính
-- --------------------------------------------------
DELETE FROM [dbo].[Orders];
PRINT '- Đã xoá toàn bộ dữ liệu bảng Orders';

-- 3. Reset các chỉ số liên quan trong bảng Sản phẩm
-- --------------------------------------------------
UPDATE [dbo].[Products] SET [SoldQuantity] = 0;
PRINT '- Đã reset số lượng đã bán (SoldQuantity) về 0 cho tất cả sản phẩm';

-- 4. Đặt lại chỉ số tự tăng (Identity) về 0
-- --------------------------------------------------
DBCC CHECKIDENT ('[dbo].[Orders]', RESEED, 0);
DBCC CHECKIDENT ('[dbo].[OrderItems]', RESEED, 0);
DBCC CHECKIDENT ('[dbo].[Payments]', RESEED, 0);
PRINT '- Đã reset Identity cho các bảng Orders, OrderItems và Payments';

PRINT '=======================================================';
PRINT 'HOÀN TẤT: Toàn bộ dữ liệu đơn hàng đã được dọn dẹp sạch.';
PRINT '=======================================================';
GO
