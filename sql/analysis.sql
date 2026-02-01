-- ========================================
-- CRM CUSTOMER ANALYSIS PROJECT - SQL QUERIES
-- ========================================

-- 1) Create table 
CREATE TABLE IF NOT EXISTS sales_data (
    "Order ID" TEXT,
    "Date" DATE,
    "Status" TEXT,
    "Fulfilment" TEXT,
    "ship-service-level" TEXT,
    "Category" TEXT,
    "Size" TEXT,
    "Qty" INT,
    "Amount" FLOAT,
    "ship-city" TEXT,
    "ship-state" TEXT,
    "ship-postal-code" TEXT
);

-- 2) Total orders & revenue per customer 
SELECT 
    "ship-postal-code" AS customer_id,
    COUNT(DISTINCT "Order ID") AS total_orders,
    SUM("Amount") AS total_revenue,
    MAX("Date") AS last_order_date
FROM sales_data
GROUP BY "ship-postal-code"
ORDER BY total_orders DESC;

-- 3) Repeat vs One-Time Customers
SELECT 
    CASE 
        WHEN COUNT(DISTINCT "Order ID") > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT "ship-postal-code", "Order ID"
    FROM sales_data
    GROUP BY "ship-postal-code", "Order ID"
) t
GROUP BY customer_type;

-- 4) Identify potential churned customers (90-day rule)
SELECT 
    "ship-postal-code" AS customer_id,
    MAX("Date") AS last_order_date
FROM sales_data
GROUP BY "ship-postal-code"
HAVING MAX("Date") < CURRENT_DATE - INTERVAL '90 days';

-- 5) Revenue by City (CRM segmentation)
SELECT 
    "ship-city" AS city,
    COUNT(DISTINCT "Order ID") AS total_orders,
    SUM("Amount") AS total_revenue
FROM sales_data
GROUP BY "ship-city"
ORDER BY total_revenue DESC;

-- 6) Category-level customer behavior
SELECT 
    "Category",
    COUNT(DISTINCT "ship-postal-code") AS unique_customers,
    SUM("Amount") AS total_revenue
FROM sales_data
GROUP BY "Category"
ORDER BY total_revenue DESC;
