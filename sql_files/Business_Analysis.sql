-- Revenue by Payment Type
SELECT
    payment_type,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(order_profit),2) AS profit
FROM clean_supply_chain
GROUP BY payment_type
ORDER BY revenue DESC;

-- Revenue by Department
SELECT
    department_name,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(order_profit),2) AS profit
FROM clean_supply_chain
GROUP BY department_name
ORDER BY revenue DESC;

-- Average Discount by Category
SELECT
    category_name,
    ROUND(AVG(discount),2) AS avg_discount
FROM clean_supply_chain
GROUP BY category_name
ORDER BY avg_discount DESC;

-- Shipping Mode Performance
SELECT
    shipping_mode,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(order_profit),2) AS profit,
    ROUND(AVG(actual_shipping_days),2) AS avg_shipping_days
FROM clean_supply_chain
GROUP BY shipping_mode
ORDER BY revenue DESC;

-- Delivery Status Distribution
SELECT
    delivery_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*)*100/(SELECT COUNT(*) FROM clean_supply_chain),2) AS percentage
FROM clean_supply_chain
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- Top 10 States by Revenue
SELECT
    order_state,
    ROUND(SUM(sales),2) AS revenue
FROM clean_supply_chain
GROUP BY order_state
ORDER BY revenue DESC
LIMIT 10;

-- Top 10 States by Profit
SELECT
    order_state,
    ROUND(SUM(order_profit),2) AS profit
FROM clean_supply_chain
GROUP BY order_state
ORDER BY profit DESC
LIMIT 10;

-- Average Order Value by Market
SELECT
    market,
    ROUND(AVG(sales),2) AS average_order_value
FROM clean_supply_chain
GROUP BY market
ORDER BY average_order_value DESC;

-- Profit Margin by Shipping Mode
SELECT
    shipping_mode,
    ROUND(
        SUM(order_profit)/SUM(sales)*100,
        2
    ) AS profit_margin
FROM clean_supply_chain
GROUP BY shipping_mode
ORDER BY profit_margin DESC;

-- Average Quantity Ordered by Category
SELECT
    category_name,
    ROUND(AVG(quantity),2) AS avg_quantity
FROM clean_supply_chain
GROUP BY category_name
ORDER BY avg_quantity DESC;


-- markets with Highest Average Profit per Order
SELECT
    market,
    ROUND(AVG(order_profit),2) AS avg_profit_per_order
FROM clean_supply_chain
GROUP BY market
ORDER BY avg_profit_per_order DESC;

-- Revenue by Year and Month
SELECT
    Year,
    Month,
    ROUND(SUM(sales),2) AS revenue
FROM clean_supply_chain
GROUP BY Year, Month
ORDER BY Year, Month;