-- 1. Verify Overall Business KPIs
SELECT 
    ROUND(SUM(od.Amount), 2) AS Total_Revenue,
    ROUND(SUM(od.Profit), 2) AS Total_Profit,
    ROUND((SUM(od.Profit) / SUM(od.Amount)) * 100, 2) AS Profit_Margin_Pct
FROM OrderDetails od;

-- 2. Target vs Actual Revenue Comparison by Category
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