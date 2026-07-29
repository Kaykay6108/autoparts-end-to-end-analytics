CREATE OR ALTER VIEW dbo.vw_SalesDetails
AS
SELECT
    o.OrderID,
    o.OrderDate,
    YEAR(o.OrderDate) AS OrderYear,
    MONTH(o.OrderDate) AS OrderMonth,

    o.CustomerID,
    c.CustomerName,
    c.CustomerSegment,
    c.Country,
    o.Region,

    o.ProductID,
    p.ProductName,
    p.Category,
    p.Brand,

    o.Quantity,
    o.UnitPrice,
    o.DiscountPct,
    p.StandardCost,
    o.DeliveryDays,
    o.OrderStatus,

    CAST(o.Quantity * o.UnitPrice AS DECIMAL(18, 2)) AS GrossSales,

    CAST(
        o.Quantity * o.UnitPrice * o.DiscountPct
        AS DECIMAL(18, 2)
    ) AS DiscountAmount,

    CAST(
        o.Quantity * o.UnitPrice * (1.0 - o.DiscountPct)
        AS DECIMAL(18, 2)
    ) AS NetSalesBeforeStatus,

    CASE
        WHEN o.OrderStatus = 'Completed'
        THEN CAST(
            o.Quantity * o.UnitPrice * (1.0 - o.DiscountPct)
            AS DECIMAL(18, 2)
        )
        ELSE CAST(0 AS DECIMAL(18, 2))
    END AS Revenue,

    CASE
        WHEN o.OrderStatus = 'Completed'
        THEN CAST(
            o.Quantity * p.StandardCost
            AS DECIMAL(18, 2)
        )
        ELSE CAST(0 AS DECIMAL(18, 2))
    END AS EstimatedCost,

    CASE
        WHEN o.OrderStatus = 'Completed'
        THEN CAST(
            (
                o.Quantity * o.UnitPrice * (1.0 - o.DiscountPct)
            )
            -
            (
                o.Quantity * p.StandardCost
            )
            AS DECIMAL(18, 2)
        )
        ELSE CAST(0 AS DECIMAL(18, 2))
    END AS GrossProfit,

    CASE
        WHEN o.OrderStatus <> 'Completed' THEN NULL
        WHEN o.DeliveryDays <= 4 THEN 1
        ELSE 0
    END AS IsOnTime

FROM dbo.Orders AS o
LEFT JOIN dbo.Customers AS c
    ON o.CustomerID = c.CustomerID
LEFT JOIN dbo.Products AS p
    ON o.ProductID = p.ProductID;
GO
