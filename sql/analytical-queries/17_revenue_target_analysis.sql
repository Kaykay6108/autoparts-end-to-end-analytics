WITH ActualRevenue AS
(
    SELECT
        DATEFROMPARTS(OrderYear, OrderMonth, 1) AS YearMonth,
        Region,
        SUM(Revenue) AS TotalRevenue
    FROM dbo.vw_SalesDetails
    GROUP BY
        DATEFROMPARTS(OrderYear, OrderMonth, 1),
        Region
)
SELECT
    t.YearMonth,
    t.Region,
    COALESCE(a.TotalRevenue, 0) AS TotalRevenue,
    t.RevenueTarget,
    COALESCE(a.TotalRevenue, 0) - t.RevenueTarget AS RevenueVariance,
    CAST(
        100.0 * COALESCE(a.TotalRevenue, 0)
        / NULLIF(t.RevenueTarget, 0)
        AS DECIMAL(10, 1)
    ) AS AchievementPct
FROM dbo.MonthlyTargets AS t
LEFT JOIN ActualRevenue AS a
    ON t.YearMonth = a.YearMonth
   AND t.Region = a.Region
ORDER BY t.YearMonth, t.Region;
