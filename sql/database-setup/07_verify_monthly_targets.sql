SELECT COUNT(*) AS TargetRows
FROM dbo.MonthlyTargets;

SELECT TOP (12) *
FROM dbo.MonthlyTargets
ORDER BY YearMonth, Region;
