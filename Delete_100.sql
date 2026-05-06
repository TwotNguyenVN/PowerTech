USE [TechZoneStoreDb]
GO

-- ==================================================================================
-- SCRIPT: Delete_100.sql
-- MỤC TIÊU: Trừ bớt 100 đơn vị khỏi số lượng tồn kho (StockQuantity) cho tất cả sản phẩm.
--           Nếu số lượng hiện tại nhỏ hơn 100, quy về 0.
-- ==================================================================================

PRINT 'Bắt đầu cập nhật trừ số lượng tồn kho cho toàn bộ sản phẩm...';

UPDATE [dbo].[Products]
SET [StockQuantity] = CASE 
    WHEN [StockQuantity] >= 100 THEN [StockQuantity] - 100 
    ELSE 0 
END;

PRINT 'Thành công: Đã trừ 100 (hoặc đưa về 0) cho StockQuantity của tất cả sản phẩm.';

-- Kiểm tra lại 5 sản phẩm đầu tiên
SELECT TOP 5 Id, Name, SKU, StockQuantity FROM [dbo].[Products];
GO
