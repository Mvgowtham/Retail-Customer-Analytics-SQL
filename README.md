# 🛒 Retail & Customer Analytics (MS SQL Server)

## 📌 Project Overview
This project delivers a comprehensive **Retail & Customer Analytics** solution built using **MS SQL Server (SSMS)**. The primary objective is to evaluate customer purchasing behavior, analyze product performance, track sales growth over time, and provide actionable business insights through advanced SQL techniques.

---

## 🏗️ Database Architecture & Data Model
The database is structured as a **Star Schema** to enable efficient querying and aggregation.

### **Tables Included:**
1. **`Customers`** (Dimension Table): Customer demographics, segments, and geographic locations.
2. **`Products`** (Dimension Table): Product categories, sub-categories, and unit pricing.
3. **`SalesOrders`** (Fact Table): Transactional order details including quantities, sales amount, discounts, and profit margins.

---

## 💡 Key Business Questions & SQL Analytics Covered

The project implements **10 Advanced SQL Queries** covering real-world business scenarios:

1. **Customer Lifetime Value (CLV)**: Identifying top revenue-generating customers using `JOIN` and `GROUP BY`.
2. **Month-over-Month (MoM) Growth**: Tracking monthly revenue trajectory and percentage change using the `LAG()` window function.
3. **Category Profitability**: Analyzing sales vs. profit margins across product lines.
4. **Regional Customer Ranking**: Ranking customers by spend within each city using `DENSE_RANK()`.
5. **Cumulative Sales (Running Total)**: Computing lifetime accumulated revenue progression over time using `SUM() OVER (...)`.
6. **Top Selling Products per Category**: Extracting the #1 performing product per category using Common Table Expressions (CTEs) and `ROW_NUMBER()`.
7. **Average Order Value & Discount Analysis**: Evaluating how discounts impact overall profitability across customer segments.
8. **Customer Churn & Inactivity**: Identifying registered customers with zero transaction history using `LEFT JOIN`.
9. **Customer Segmentation (Repeat vs. One-Time)**: Classifying customer loyalty based on order frequency using conditional logic (`CASE`).
10. **Order Value Classification**: Categorizing transactions into High, Medium, and Low value tiers using conditional aggregation.

---

## 🚀 Tech Stack & SQL Concepts Applied
* **Database**: MS SQL Server (SSMS)
* **SQL Techniques**:
  * **Window Functions**: `LAG()`, `DENSE_RANK()`, `ROW_NUMBER()`, `SUM() OVER()`
  * **CTEs & Subqueries**: Modular query structuring for complex analytics
  * **Joins**: `INNER JOIN`, `LEFT JOIN`
  * **Conditional Logic**: `CASE WHEN` statements
  * **Aggregation & Grouping**: `GROUP BY`, `HAVING`, `SUM()`, `AVG()`, `COUNT()`

---

## 📁 Repository Structure

---

## 🎯 Key Insights & Takeaways
* **Top Customer Segment**: Corporate and Consumer segments drive the majority of high-value transactions.
* **Category Growth**: Technology products generate the highest total revenue and profit margin percentage.
* **Customer Retention**: Over 60% of buyers are repeat customers, showing strong loyalty and brand equity.

---

**Author**: Gowtham M  
**Role**: Data Analyst / SQL Developer
