SELECT
    DATEFROMPARTS(OrderYear, OrderMonth, 1) AS MonthStart,
    Region,
    SUM(Revenue) AS TotalRevenue,
    SUM(GrossProfit) AS TotalGrossProfit,
    COUNT(DISTINCT CASE
        WHEN OrderStatus = 'Completed' THEN OrderID
    END) AS CompletedOrders
FROM dbo.vw_SalesDetails
GROUP BY
    DATEFROMPARTS(OrderYear, OrderMonth, 1),
    Region
ORDER BY MonthStart, Region;
