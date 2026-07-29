# Power BI DAX Measures

```dax
Total Revenue =
CALCULATE(
    SUMX(
        Orders,
        Orders[Quantity]
            * Orders[UnitPrice]
            * (1 - Orders[DiscountPct])
    ),
    Orders[OrderStatus] = "Completed"
)
```

```dax
Revenue Target =
SUM(MonthlyTargets[RevenueTarget])
```

```dax
Achievement % =
DIVIDE(
    [Total Revenue],
    [Revenue Target],
    0
)
```

```dax
Revenue Variance =
[Total Revenue] - [Revenue Target]
```

```dax
Total Estimated Cost =
CALCULATE(
    SUMX(
        Orders,
        Orders[Quantity]
            * RELATED(Products[StandardCost])
    ),
    Orders[OrderStatus] = "Completed"
)
```

```dax
Gross Profit =
[Total Revenue] - [Total Estimated Cost]
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
    DISTINCTCOUNT(Orders[OrderID]),
    Orders[OrderStatus] = "Completed"
)
```

```dax
Average Order Value =
DIVIDE(
    [Total Revenue],
    [Completed Orders],
    0
)
```

```dax
On-Time Deliveries =
CALCULATE(
    DISTINCTCOUNT(Orders[OrderID]),
    Orders[OrderStatus] = "Completed",
    Orders[DeliveryDays] <= 4
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

```dax
Average Delivery Days =
CALCULATE(
    AVERAGE(Orders[DeliveryDays]),
    Orders[OrderStatus] = "Completed"
)
```

```dax
Late Deliveries =
[Completed Orders] - [On-Time Deliveries]
```

```dax
Late Delivery Rate =
DIVIDE(
    [Late Deliveries],
    [Completed Orders],
    0
)
```
