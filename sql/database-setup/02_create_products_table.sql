USE AutoPartsAnalytics;
GO

IF OBJECT_ID('dbo.Products', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Products
    (
        ProductID INT NOT NULL PRIMARY KEY,
        ProductName NVARCHAR(100) NOT NULL,
        Category NVARCHAR(50) NOT NULL,
        Brand NVARCHAR(50) NOT NULL,
        StandardCost DECIMAL(18, 2) NOT NULL,
        ListPrice DECIMAL(18, 2) NOT NULL
    );
END;
GO
