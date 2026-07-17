CREATE DATABASE supply_chain_analytics;
USE supply_chain_analytics;

SELECT *
FROM clean_supply_chain
LIMIT 10;

-- Q1. Total Revenue

SELECT
    ROUND(SUM(sales),2) AS Total_Revenue
FROM clean_supply_chain;

-- Q2. Total Profit
SELECT
    ROUND(SUM(order_profit),2) AS Total_Profit
FROM clean_supply_chain;


-- Q3. Profit Margin
SELECT
    ROUND(
        SUM(order_profit) / SUM(sales) * 100,
        2
    ) AS Profit_Margin
FROM clean_supply_chain;
    
-- Q4. Total Orders
SELECT
    COUNT(DISTINCT order_id) AS Total_Orders
FROM clean_supply_chain;

-- Q5. Total Customers
SELECT
    COUNT(DISTINCT `Customer Id`) AS Total_Customers
FROM clean_supply_chain;

-- Q6. Average Order Value
SELECT
    ROUND(AVG(sales),2) AS Average_Order_Value
FROM clean_supply_chain;

CREATE TABLE supply_chain_clean AS
SELECT
    `Customer Id` AS customer_id,
    `Order Id` AS order_id,
    Sales AS sales,
    order_profit,
    `Product Name` AS product_name,
    `Category Name` AS category_name,
    `Customer Segment` AS customer_segment,
    `Order Country` AS order_country,
    market,
    shipping_mode,
    delivery_status,
    quantity
FROM clean_supply_chain;

SHOW COLUMNS FROM clean_supply_chain;
