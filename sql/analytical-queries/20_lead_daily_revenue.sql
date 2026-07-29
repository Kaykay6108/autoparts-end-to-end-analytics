WITH DailyRevenue AS
(
    SELECT
        OrderDate,
        SUM(Revenue) AS TotalRevenue
    FROM dbo.vw_SalesDetails
    GROUP BY OrderDate
)
SELECT
    OrderDate,
    TotalRevenue,
    LEAD(TotalRevenue) OVER (
        ORDER BY OrderDate
    ) AS NextDayRevenue,
    LEAD(TotalRevenue) OVER (
        ORDER BY OrderDate
    ) - TotalRevenue AS ChangeToNextDay
FROM DailyRevenue
ORDER BY OrderDate;
