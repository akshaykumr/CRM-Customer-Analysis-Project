# CRM Customer Analysis Project

## 📌 Project Overview
This project analyzes transactional sales data to identify customer churn patterns, understand purchasing behavior, and propose retention strategies using SQL-based analysis.

## 📂 Dataset
- **File:** Amazon Sale Report.csv  
- Contains: Order details, fulfillment status, product category, amount, shipping location, and sales channel.

## 🎯 Objectives
- Identify repeat vs one-time customers  
- Detect potential customer churn  
- Analyze purchasing patterns across cities and categories  
- Provide data-driven retention strategies  

## 🛠️ Tools Used
- SQL (MySQL / PostgreSQL compatible)
- CSV dataset
- GitHub for version control

## 🔍 Key Analyses Performed
- Aggregated customer-level order history  
- Identified one-time vs repeat customers  
- Flagged customers likely to churn (90-day inactivity rule)  
- Examined revenue contribution by customer segment  

## 📊 SQL Queries (see analysis.sql for full scripts)

### 1. Total Orders per Customer
```sql
SELECT 
    "ship-postal-code" AS customer_id,
    COUNT(DISTINCT "Order ID") AS total_orders,
    SUM("Amount") AS total_revenue,
    MAX("Date") AS last_order_date
FROM sales_data
GROUP BY "ship-postal-code"
ORDER BY total_orders DESC;
```

### 2. Identify Repeat vs One-Time Customers
```sql
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
```

## 💡 Retention Recommendations
- Send personalized offers to one-time buyers  
- Implement loyalty rewards for repeat customers  
- Improve delivery experience for high-value customers  
- Offer category-based product recommendations  

## 🚀 How to Run the Project
1. Import `Amazon Sale Report.csv` into your SQL database as table **sales_data**.
2. Run all queries from `analysis.sql` in your SQL client.
3. Modify churn window (default = 90 days) if needed.

## 👤 Author
Your Name  
Aspiring Business Analyst / Data Analyst
