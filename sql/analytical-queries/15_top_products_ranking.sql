WITH ProductRevenue AS
(
    SELECT
        ProductID,
        ProductName,
        Category,
        SUM(Revenue) AS TotalRevenue
    FROM dbo.vw_SalesDetails
    GROUP BY ProductID, ProductName, Category
)
SELECT
    ProductID,
    ProductName,
    Category,
    TotalRevenue,
    DENSE_RANK() OVER (
        ORDER BY TotalRevenue DESC
    ) AS RevenueRank
FROM ProductRevenue
ORDER BY RevenueRank, ProductName;
