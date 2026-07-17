-- Revenue by Customer Segment
SELECT
    customer_segment,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(order_profit),2) AS profit,
    ROUND(SUM(order_profit)/SUM(sales)*100,2) AS profit_margin
FROM clean_supply_chain
GROUP BY customer_segment
ORDER BY revenue DESC;

-- Top 20 Customers by Revenue
SELECT
    `Customer Id`,
    ROUND(SUM(sales),2) AS revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM clean_supply_chain
GROUP BY `Customer Id`
ORDER BY revenue DESC
LIMIT 20;


-- Top Customers by Profit
SELECT
    `Customer Id`,
    ROUND(SUM(order_profit),2) AS profit
FROM clean_supply_chain
GROUP BY `Customer Id`
ORDER BY profit DESC
LIMIT 20;

-- Average Order Value by Customer Segment
SELECT
    customer_segment,
    ROUND(AVG(sales),2) AS avg_order_value
FROM clean_supply_chain
GROUP BY customer_segment;

-- Customer Distribution by Market
SELECT
    market,
    COUNT(DISTINCT `Customer Id`) AS total_customers
FROM clean_supply_chain
GROUP BY market
ORDER BY total_customers DESC;

-- Top Countries by Customers
SELECT
    order_country,
    COUNT(DISTINCT `Customer Id`) AS customers
FROM clean_supply_chain
GROUP BY order_country
ORDER BY customers DESC
LIMIT 20;

-- Repeat Customers
SELECT
    `Customer Id`,
    COUNT(DISTINCT order_id) AS orders
FROM clean_supply_chain
GROUP BY `Customer Id`
HAVING orders > 1
ORDER BY orders DESC;

-- Customer Segment Contribution (%)
SELECT
    customer_segment,
    ROUND(
        SUM(sales) * 100 /
        (SELECT SUM(sales) FROM clean_supply_chain),
        2
    ) AS revenue_percentage
FROM clean_supply_chain
GROUP BY customer_segment
ORDER BY revenue_percentage DESC;