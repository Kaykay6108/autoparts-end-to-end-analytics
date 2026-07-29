WITH CustomerMonthlyRevenue AS
(
    SELECT
        CustomerID,
        CustomerName,
        DATEFROMPARTS(OrderYear, OrderMonth, 1) AS MonthStart,
        SUM(Revenue) AS MonthlyRevenue
    FROM dbo.vw_SalesDetails
    GROUP BY
        CustomerID,
        CustomerName,
        DATEFROMPARTS(OrderYear, OrderMonth, 1)
)
SELECT
    CustomerID,
    CustomerName,
    MonthStart,
    MonthlyRevenue,
    SUM(MonthlyRevenue) OVER (
        PARTITION BY CustomerID
        ORDER BY MonthStart
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningRevenue
FROM CustomerMonthlyRevenue
ORDER BY CustomerID, MonthStart;
