SELECT 'Products' AS TableName, COUNT(*) AS TotalRows FROM dbo.Products
UNION ALL
SELECT 'Customers', COUNT(*) FROM dbo.Customers
UNION ALL
SELECT 'MonthlyTargets', COUNT(*) FROM dbo.MonthlyTargets
UNION ALL
SELECT 'Orders', COUNT(*) FROM dbo.Orders
UNION ALL
SELECT 'Orders_Staging', COUNT(*) FROM dbo.Orders_Staging;
GO

SELECT TOP (20)
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    c.CustomerSegment,
    p.ProductName,
    p.Category,
    o.Quantity,
    o.UnitPrice,
    o.OrderStatus
FROM dbo.Orders AS o
INNER JOIN dbo.Customers AS c
    ON o.CustomerID = c.CustomerID
INNER JOIN dbo.Products AS p
    ON o.ProductID = p.ProductID
ORDER BY o.OrderDate, o.OrderID;
