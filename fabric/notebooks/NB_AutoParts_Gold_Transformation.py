# Fabric notebook export: NB_AutoParts_Gold_Transformation
# Language: PySpark (Python)

from pyspark.sql import functions as F

# 1. Read Delta tables
orders_df = spark.table("dbo.orders")
customers_df = spark.table("dbo.customers")
products_df = spark.table("dbo.products")
monthly_targets_df = spark.table("dbo.monthly_targets")

print(f"Orders row count: {orders_df.count():,}")
print(f"Customers row count: {customers_df.count():,}")
print(f"Products row count: {products_df.count():,}")
print(f"Monthly targets row count: {monthly_targets_df.count():,}")

# 2. Reusable business expressions
gross_sales_expr = F.col("o.Quantity") * F.col("o.UnitPrice")
discount_amount_expr = gross_sales_expr * F.col("o.DiscountPct")
net_sales_expr = gross_sales_expr * (F.lit(1.0) - F.col("o.DiscountPct"))
estimated_cost_expr = F.col("o.Quantity") * F.col("p.StandardCost")

# 3. Join source tables
joined_df = (
    orders_df.alias("o")
    .join(
        customers_df.alias("c"),
        F.col("o.CustomerID") == F.col("c.CustomerID"),
        "left",
    )
    .join(
        products_df.alias("p"),
        F.col("o.ProductID") == F.col("p.ProductID"),
        "left",
    )
)

# 4. Build business-ready Gold DataFrame
gold_sales_df = joined_df.select(
    F.col("o.OrderID").alias("OrderID"),
    F.col("o.OrderDate").alias("OrderDate"),
    F.year(F.col("o.OrderDate")).alias("OrderYear"),
    F.month(F.col("o.OrderDate")).alias("OrderMonth"),

    F.col("o.CustomerID").alias("CustomerID"),
    F.col("c.CustomerName").alias("CustomerName"),
    F.col("c.CustomerSegment").alias("CustomerSegment"),
    F.col("c.Country").alias("Country"),
    F.col("o.Region").alias("Region"),

    F.col("o.ProductID").alias("ProductID"),
    F.col("p.ProductName").alias("ProductName"),
    F.col("p.Category").alias("Category"),
    F.col("p.Brand").alias("Brand"),

    F.col("o.Quantity").alias("Quantity"),
    F.col("o.UnitPrice").alias("UnitPrice"),
    F.col("o.DiscountPct").alias("DiscountPct"),
    F.col("p.StandardCost").alias("StandardCost"),
    F.col("o.DeliveryDays").alias("DeliveryDays"),
    F.col("o.OrderStatus").alias("OrderStatus"),

    gross_sales_expr.cast("decimal(18,2)").alias("GrossSales"),
    discount_amount_expr.cast("decimal(18,2)").alias("DiscountAmount"),
    net_sales_expr.cast("decimal(18,2)").alias("NetSalesBeforeStatus"),

    F.when(
        F.col("o.OrderStatus") == "Completed",
        net_sales_expr,
    )
    .otherwise(F.lit(0))
    .cast("decimal(18,2)")
    .alias("Revenue"),

    F.when(
        F.col("o.OrderStatus") == "Completed",
        estimated_cost_expr,
    )
    .otherwise(F.lit(0))
    .cast("decimal(18,2)")
    .alias("EstimatedCost"),

    F.when(
        F.col("o.OrderStatus") == "Completed",
        net_sales_expr - estimated_cost_expr,
    )
    .otherwise(F.lit(0))
    .cast("decimal(18,2)")
    .alias("GrossProfit"),

    F.when(
        F.col("o.OrderStatus") != "Completed",
        F.lit(None).cast("int"),
    )
    .when(
        F.col("o.DeliveryDays") <= 4,
        F.lit(1),
    )
    .otherwise(F.lit(0))
    .alias("IsOnTime"),
)

# 5. Data-quality validation
quality_summary = gold_sales_df.agg(
    F.count("*").alias("TotalRows"),
    F.countDistinct("OrderID").alias("DistinctOrderIDs"),
    F.sum(
        F.when(F.col("CustomerName").isNull(), 1).otherwise(0)
    ).alias("MissingCustomerMatches"),
    F.sum(
        F.when(F.col("ProductName").isNull(), 1).otherwise(0)
    ).alias("MissingProductMatches"),
    F.sum(
        F.when(
            (F.col("OrderStatus") == "Completed")
            & F.col("DeliveryDays").isNull(),
            1,
        ).otherwise(0)
    ).alias("CompletedOrdersMissingDeliveryDays"),
)

display(quality_summary)

# 6. Save managed Delta table
target_table = "dbo.gold_sales_details"

(
    gold_sales_df.write
    .format("delta")
    .mode("overwrite")
    .option("overwriteSchema", "true")
    .saveAsTable(target_table)
)

saved_gold_df = spark.table(target_table)
print("Gold table saved successfully.")
print(f"Table name: {target_table}")
print(f"Row count: {saved_gold_df.count():,}")
print(f"Column count: {len(saved_gold_df.columns)}")
display(saved_gold_df.limit(10))
