USE AutoPartsAnalytics;
GO

IF OBJECT_ID('dbo.Orders', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Orders
    (
        OrderID INT NOT NULL PRIMARY KEY,
        OrderDate DATE NOT NULL,
        CustomerID INT NOT NULL,
        ProductID INT NOT NULL,
        Quantity INT NOT NULL,
        UnitPrice DECIMAL(18, 2) NOT NULL,
        DiscountPct DECIMAL(9, 4) NOT NULL,
        Region NVARCHAR(20) NOT NULL,
        DeliveryDays INT NULL,
        OrderStatus NVARCHAR(20) NOT NULL,

        CONSTRAINT FK_Orders_Customers
            FOREIGN KEY (CustomerID)
            REFERENCES dbo.Customers(CustomerID),

        CONSTRAINT FK_Orders_Products
            FOREIGN KEY (ProductID)
            REFERENCES dbo.Products(ProductID)
    );
END;
GO
