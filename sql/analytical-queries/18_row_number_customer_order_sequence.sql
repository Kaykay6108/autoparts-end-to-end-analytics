SELECT
    CustomerID,
    CustomerName,
    OrderID,
    OrderDate,
    ROW_NUMBER() OVER (
        PARTITION BY CustomerID
        ORDER BY OrderDate, OrderID
    ) AS CustomerOrderSequence
FROM dbo.vw_SalesDetails
ORDER BY CustomerID, CustomerOrderSequence;
