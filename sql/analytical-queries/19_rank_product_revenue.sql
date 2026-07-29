WITH ProductRevenue AS
(
    SELECT
        ProductName,
        Category,
        SUM(Revenue) AS TotalRevenue
    FROM dbo.vw_SalesDetails
    GROUP BY ProductName, Category
)
SELECT
    ProductName,
    Category,
    TotalRevenue,
    RANK() OVER (
        ORDER BY TotalRevenue DESC
    ) AS RevenueRank,
    DENSE_RANK() OVER (
        ORDER BY TotalRevenue DESC
    ) AS DenseRevenueRank
FROM ProductRevenue
ORDER BY RevenueRank, ProductName;
