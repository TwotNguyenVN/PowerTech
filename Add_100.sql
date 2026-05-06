USE [TechZoneStoreDb]
GO

-- ==================================================================================
-- SCRIPT: Add_100.sql
-- MỤC TIÊU: Cộng thêm 100 đơn vị vào số lượng tồn kho (StockQuantity) cho tất cả sản phẩm.
-- ==================================================================================

PRINT 'Bắt đầu cập nhật số lượng tồn kho cho toàn bộ sản phẩm...';

UPDATE [dbo].[Products]
SET [StockQuantity] = [StockQuantity] + 100;

PRINT 'Thành công: Đã cộng thêm 100 vào StockQuantity cho tất cả các bản ghi trong bảng Products.';

-- Kiểm tra lại 5 sản phẩm đầu tiên
SELECT TOP 5 Id, Name, SKU, StockQuantity FROM [dbo].[Products];
GO
