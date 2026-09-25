-- query 1 Overall business Performance
SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM superstore_sales;

-- Query 2 category wise sales and profit
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

--
show columns from superstore_sales;

--
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'retail_intelligence'
  AND TABLE_NAME = 'superstore_sales';
  
  --
  SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'retail_intelligence'
  AND TABLE_NAME = 'superstore_sales'
  AND COLUMN_NAME LIKE '%sub%';
  
  -- Query 3 Subcategory Performance
  SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    SUM(quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY sub_category
ORDER BY Total_Sales DESC;

-- qyery 4 Region wise Sales and Profit
SELECT
    region,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    SUM(quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY region
ORDER BY Total_Sales DESC;

-- Query 5 Market wise sales and Profit
SELECT
    market,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    SUM(quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY market
ORDER BY Total_Sales DESC;

-- query 6 top 10 Product by sales
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    SUM(quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10; 

-- Query 7 Low Performing Products
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    SUM(quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY product_name
ORDER BY Total_Profit ASC
LIMIT 10;

-- Query 8 Year wise sales and profit analysis
SELECT
    year,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    SUM(quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY year
ORDER BY year;

-- Query 9 Monthly sales trend analysis
SELECT
    year,
    MONTH(order_date) AS Month_Number,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM superstore_sales
GROUP BY year, MONTH(order_date)
ORDER BY year, Month_Number;
-- Query 10 Discount vs Profit Analysis
SELECT
    discount,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM superstore_sales
GROUP BY discount
ORDER BY discount;
-- Query 11 Shipping mode analysis
SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS Total_Orders,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM superstore_sales
GROUP BY ship_mode
ORDER BY Total_Sales DESC;
-- query 12 Segemnet wise sales and Profit analysis
SELECT
    segment,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    SUM(quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY segment
ORDER BY Total_Sales DESC;
-- Query 13 Customer wise sales and Profit Analysis
SELECT
    customer_name,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    SUM(quantity) AS Total_Quantity
FROM superstore_sales
GROUP BY customer_name
ORDER BY Total_Sales DESC;
-- Query 14 Top 10 Customers by sales
SELECT
    customer_name,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM superstore_sales
GROUP BY customer_name
ORDER BY Total_Sales DESC
LIMIT 10;
-- Query 15 Profit Margin Analysis
SELECT
    category,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS Profit_Margin_Percentage
FROM superstore_sales
GROUP BY category
ORDER BY Profit_Margin_Percentage DESC;
-- Query 16 Category Performnace Ranking
SELECT
    category,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS Profit_Margin_Percentage
FROM superstore_sales
GROUP BY category
ORDER BY Profit_Margin_Percentage DESC;
-- Query 17 windows function - Regional Sales Ranking
SELECT
    region,
    ROUND(SUM(sales), 2) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS Sales_Rank
FROM superstore_sales
GROUP BY region;
-- Query 18 Year-over-Year Sales Growth 
WITH yearly_sales AS (
    SELECT
        year,
        SUM(sales) AS Total_Sales
    FROM superstore_sales
    GROUP BY year
)
SELECT
    year,
    ROUND(Total_Sales, 2) AS Total_Sales,
    ROUND(
        ((Total_Sales - LAG(Total_Sales) OVER (ORDER BY year))
        / LAG(Total_Sales) OVER (ORDER BY year)) * 100,
        2
    ) AS YoY_Growth_Percentage
FROM yearly_sales
ORDER BY year;