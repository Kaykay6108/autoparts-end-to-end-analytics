USE AutoPartsAnalytics;
GO

INSERT INTO dbo.Orders
(
    OrderID,
    OrderDate,
    CustomerID,
    ProductID,
    Quantity,
    UnitPrice,
    DiscountPct,
    Region,
    DeliveryDays,
    OrderStatus
)
SELECT
    TRY_CONVERT(INT, NULLIF(OrderID, '')),
    TRY_CONVERT(DATE, NULLIF(OrderDate, '')),
    TRY_CONVERT(INT, NULLIF(CustomerID, '')),
    TRY_CONVERT(INT, NULLIF(ProductID, '')),
    TRY_CONVERT(INT, NULLIF(Quantity, '')),
    TRY_CONVERT(DECIMAL(18, 2), NULLIF(UnitPrice, '')),
    TRY_CONVERT(DECIMAL(9, 4), NULLIF(DiscountPct, '')),
    NULLIF(Region, ''),
    TRY_CONVERT(INT, NULLIF(DeliveryDays, '')),
    NULLIF(OrderStatus, '')
FROM dbo.Orders_Staging
WHERE TRY_CONVERT(INT, NULLIF(OrderID, '')) IS NOT NULL;
GO
