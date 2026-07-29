USE AutoPartsAnalytics;
GO

IF OBJECT_ID('dbo.MonthlyTargets', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.MonthlyTargets
    (
        YearMonth DATE NOT NULL,
        Region NVARCHAR(20) NOT NULL,
        RevenueTarget DECIMAL(18, 2) NOT NULL,
        CONSTRAINT PK_MonthlyTargets PRIMARY KEY (YearMonth, Region)
    );
END;
GO
