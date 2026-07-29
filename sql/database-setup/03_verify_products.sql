SELECT COUNT(*) AS ProductRows
FROM dbo.Products;

SELECT TOP (10) *
FROM dbo.Products
ORDER BY ProductID;
