WITH MonthlyRevenue AS
(
    SELECT
        DATEFROMPARTS(OrderYear, OrderMonth, 1) AS MonthStart,
        SUM(Revenue) AS TotalRevenue
    FROM dbo.vw_SalesDetails
    GROUP BY DATEFROMPARTS(OrderYear, OrderMonth, 1)
)
SELECT
    MonthStart,
    TotalRevenue,
    LAG(TotalRevenue) OVER (ORDER BY MonthStart) AS PreviousMonthRevenue,
    TotalRevenue
        - LAG(TotalRevenue) OVER (ORDER BY MonthStart)
        AS MonthOverMonthChange
FROM MonthlyRevenue
ORDER BY MonthStart;
