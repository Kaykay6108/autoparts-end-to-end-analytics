USE AutoPartsAnalytics;
GO

IF OBJECT_ID('dbo.Customers', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Customers
    (
        CustomerID INT NOT NULL PRIMARY KEY,
        CustomerName NVARCHAR(100) NOT NULL,
        CustomerSegment NVARCHAR(50) NOT NULL,
        Country NVARCHAR(50) NOT NULL,
        Region NVARCHAR(20) NOT NULL,
        SignupDate DATE NOT NULL
    );
END;
GO
