USE AutoPartsAnalytics;
GO

IF OBJECT_ID('dbo.Orders_Staging', 'U') IS NOT NULL
    DROP TABLE dbo.Orders_Staging;
GO

CREATE TABLE dbo.Orders_Staging
(
    OrderID NVARCHAR(100) NULL,
    OrderDate NVARCHAR(100) NULL,
    CustomerID NVARCHAR(100) NULL,
    ProductID NVARCHAR(100) NULL,
    Quantity NVARCHAR(100) NULL,
    UnitPrice NVARCHAR(100) NULL,
    DiscountPct NVARCHAR(100) NULL,
    Region NVARCHAR(100) NULL,
    DeliveryDays NVARCHAR(100) NULL,
    OrderStatus NVARCHAR(100) NULL
);
GO
