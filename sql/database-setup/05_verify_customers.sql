SELECT COUNT(*) AS CustomerRows
FROM dbo.Customers;

SELECT TOP (10) *
FROM dbo.Customers
ORDER BY CustomerID;
