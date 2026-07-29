# Direct Lake Semantic Model

Model name: `SM_AutoParts_DirectLake`

Source table: `dbo.gold_sales_details`

## Measures

```dax
Total Revenue =
SUM(gold_sales_details[Revenue])
```

```dax
Gross Profit =
SUM(gold_sales_details[GrossProfit])
```

```dax
Gross Margin % =
DIVIDE(
    [Gross Profit],
    [Total Revenue],
    0
)
```

```dax
Completed Orders =
CALCULATE(
    DISTINCTCOUNT(gold_sales_details[OrderID]),
    gold_sales_details[OrderStatus] = "Completed"
)
```

```dax
On-Time Deliveries =
CALCULATE(
    DISTINCTCOUNT(gold_sales_details[OrderID]),
    gold_sales_details[IsOnTime] = 1
)
```

```dax
On-Time Delivery Rate =
DIVIDE(
    [On-Time Deliveries],
    [Completed Orders],
    0
)
```
