USE [TechZoneStoreDb]
GO

-- Thêm cột WalletBalance vào bảng AspNetUsers nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND name = 'WalletBalance')
BEGIN
    ALTER TABLE [dbo].[AspNetUsers] ADD [WalletBalance] DECIMAL(18, 2) NOT NULL DEFAULT 0;
    PRINT 'Đã thêm cột WalletBalance vào bảng AspNetUsers.';
END
ELSE
BEGIN
    PRINT 'Cột WalletBalance đã tồn tại.';
END
GO

-- Cập nhật số dư giả lập cho shipper nếu muốn (tùy chọn)
-- UPDATE [dbo].[AspNetUsers] SET WalletBalance = 2150000 WHERE Email LIKE '%shipper%';
GO
