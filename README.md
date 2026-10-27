<img width="574" height="323" alt="Final_Dashboard_View" src="Final Dashboard View.png" />
# 🛒 E-Commerce Sales & Profitability Performance Dashboard

An end-to-end Business Intelligence project analyzing $432K+ in e-commerce transactions across product categories, geographic regions, and monthly target benchmarks. Built using **MySQL**, **Power Query**, **DAX**, and **Power BI Desktop**.

![Dashboard Overview](Screenshots/Final_Dashboard_View.png)

---

## 📌 Business Overview & Objective
An growing e-commerce business required an executive-level performance dashboard to track revenue generation, profitability metrics, and target realization across multiple product segments and geographic locations.

The objective of this project is to:
1. Reconcile raw transactional order data against monthly category targets.
2. Provide interactive state and category-level dynamic filtering.
3. Identify top revenue-generating markets and evaluate low-margin product categories.

---

## 📊 Key Business Performance Indicators (KPIs)
* **Total Revenue:** $432,000
* **Total Profit:** $24,000
* **Overall Profit Margin:** 5.55%
* **Sales Target Goal:** $436,000
* **Target Realization Rate:** 99.08% (-$4K variance against annual target)

---

## 🛠️ Data Architecture & Tech Stack
* **Database Engine:** MySQL (Data extraction, transformation, and validation queries)
* **ETL & Data Cleaning:** Power Query (M Language)
* **Data Modeling:** Relational Star-Schema
* **Analytical Calculations:** DAX (Data Analysis Expressions)
* **Visualization:** Power BI Desktop (Custom dark theme visual UI/UX)

---

## 🗄️ Data Model & Relationships
The dashboard is built upon a relational model connecting three core tables:
* **`Orders`** (Primary Key: `Order ID`): Contains transaction dates, customer details, city, and state.
* **`OrderDetails`** (Foreign Key: `Order ID`): Contains order amounts, quantity, profit, and product category.
* **`SalesTargets`** (Foreign Key: `Category`): Contains monthly revenue goals per product category.

---

## 🧮 Dynamic DAX Measures
Key calculated metrics implemented in Power BI:

```dax
// Total Revenue Calculation
Total Revenue = SUM('OrderDetails'[Amount])

// Total Profit Calculation
Total Profit = SUM('OrderDetails'[Profit])

// Profit Margin Percentage (Error-Safe Division)
Profit Margin = 
DIVIDE(
    [Total Profit], 
    [Total Revenue], 
    0
)

// Target Achievement Realization Rate
Target Achievement % = 
DIVIDE(
    [Total Revenue], 
    [Total Target], 
    0
)

// Variance Against Goal
Target Variance = [Total Revenue] - [Total Target]
```

---

## 🛢️ SQL Verification Queries
SQL scripts used to explore and validate the underlying dataset before visualization:

```sql
-- 1. Validate Overall KPIs (Revenue, Profit, Margin %)
SELECT 
    ROUND(SUM(od.Amount), 2) AS Total_Revenue,
    ROUND(SUM(od.Profit), 2) AS Total_Profit,
    ROUND((SUM(od.Profit) / SUM(od.Amount)) * 100, 2) AS Profit_Margin_Pct
FROM OrderDetails od;

-- 2. Target Realization by Category
SELECT 
    od.Category,
    SUM(od.Amount) AS Actual_Revenue,
    st.Target_Amount AS Target_Revenue,
    ROUND((SUM(od.Amount) / st.Target_Amount) * 100, 2) AS Target_Achievement_Pct,
    ROUND(SUM(od.Amount) - st.Target_Amount, 2) AS Revenue_Variance
FROM OrderDetails od
JOIN SalesTargets st ON od.Category = st.Category
GROUP BY od.Category, st.Target_Amount
ORDER BY Actual_Revenue DESC;

-- 3. Top 5 Revenue-Generating Cities
SELECT 
    o.City,
    ROUND(SUM(od.Amount), 2) AS City_Revenue,
    ROUND(SUM(od.Profit), 2) AS City_Profit
FROM Orders o
JOIN OrderDetails od ON o.Order_ID = od.Order_ID
GROUP BY o.City
ORDER BY City_Revenue DESC
LIMIT 5;
```

---

## 💡 Data-Driven Business Recommendations

1. **Optimize High-Volume, Low-Margin Product Categories:**
   * **Insight:** Electronics generates the highest overall revenue share (~$166K), but Furniture lags significantly in both sales targets and profit margins.
   * **Recommendation:** Review procurement costs, shipping fees, and pricing strategies for Furniture items to boost profitability closer to the 5.55% baseline.

2. **Capitalize on Regional Concentration:**
   * **Insight:** Key metro areas like **Indore** (~$80K) and **Mumbai** (~$61K) drive the vast majority of regional sales volume.
   * **Recommendation:** Focus marketing spends and localized fulfillment operations in top-tier cities to improve delivery efficiency and sales conversion.

3. **Smooth Out Mid-Quarter Revenue Fluctuations:**
   * **Insight:** Monthly revenue trend lines reveal recurring dips across mid-year months, directly impacting profit realization.
   * **Recommendation:** Schedule targeted promotional campaigns and cross-category product bundles during off-peak months to maintain steady cash flow.

---

## 📂 Repository Structure
```text
├── README.md                            <-- Project documentation
├── Ecommerce_Sales_Dashboard.pbix       <-- Power BI report file
├── ecommerce_analysis.sql               <-- SQL query scripts
├── Data/
│   ├── Orders.csv                       <-- Raw orders table
│   ├── OrderDetails.csv                 <-- Order line details
│   └── SalesTargets.csv                 <-- Monthly sales targets
└── Screenshots/
    └── Final_Dashboard_View.png          <-- High-res dashboard visual
```

---

## 🚀 How to Open and View
1. Clone this repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Ecommerce-Sales-PowerBI-Dashboard.git
   ```
2. Open `Ecommerce_Sales_Dashboard.pbix` using **Power BI Desktop**.
