-- Top 3 Products in Each Category (ROW_NUMBER)
WITH ranked_products AS (
    SELECT
        category_name,
        product_name,
        SUM(sales) AS revenue,
        ROW_NUMBER() OVER (
            PARTITION BY category_name
            ORDER BY SUM(sales) DESC
        ) AS rn
    FROM clean_supply_chain
    GROUP BY category_name, product_name
)

SELECT *
FROM ranked_products
WHERE rn <= 3;



-- Rank Markets by Revenue (RANK)
SELECT
    market,
    SUM(sales) AS revenue,
    RANK() OVER(
        ORDER BY SUM(sales) DESC
    ) AS revenue_rank
FROM clean_supply_chain
GROUP BY market;

-- Dense Rank Customer Segments
SELECT

customer_segment,

SUM(order_profit) profit,

DENSE_RANK()

OVER(

ORDER BY SUM(order_profit) DESC

)

AS ranking

FROM clean_supply_chain

GROUP BY customer_segment;


-- Customer Revenue Quartiles (NTILE())
WITH customer_sales AS (

SELECT

`Customer Id`,

SUM(sales) revenue

FROM clean_supply_chain

GROUP BY `Customer Id`

)

SELECT

*,

NTILE(4)

OVER(

ORDER BY revenue DESC

)

AS revenue_quartile

FROM customer_sales;



-- Products Above Average Revenue (Subquery)
SELECT

product_name,

SUM(sales) revenue

FROM clean_supply_chain

GROUP BY product_name

HAVING SUM(sales) >

(

SELECT

AVG(product_revenue)

FROM

(

SELECT

SUM(sales) product_revenue

FROM clean_supply_chain

GROUP BY product_name

)t

);



-- Highest Revenue Product per Market (CTE)
WITH market_products AS (

SELECT

market,

product_name,

SUM(sales) revenue,

ROW_NUMBER()

OVER(

PARTITION BY market

ORDER BY SUM(sales) DESC

)

rn

FROM clean_supply_chain

GROUP BY market, product_name

)

SELECT *

FROM market_products

WHERE rn=1;



-- Revenue Category using CASE
select
product_name,

SUM(sales) revenue,

CASE

WHEN SUM(sales)>=1000000 THEN 'High'

WHEN SUM(sales)>=500000 THEN 'Medium'

ELSE 'Low'

END AS revenue_category

FROM clean_supply_chain

GROUP BY product_name;



-- Markets Above Overall Average Profit
SELECT

market,

SUM(order_profit) profit

FROM clean_supply_chain

GROUP BY market

HAVING SUM(order_profit) >

(

SELECT

AVG(total_profit)

FROM

(

SELECT

SUM(order_profit) total_profit

FROM clean_supply_chain

GROUP BY market

)t

);


-- Rank Products Within Market
SELECT

market,

product_name,

SUM(sales) revenue,

RANK()

OVER(

PARTITION BY market

ORDER BY SUM(sales) DESC

)

market_rank

FROM clean_supply_chain

GROUP BY market, product_name;


-- Cumulative Revenue by Market
WITH market_sales AS (

SELECT

market,

SUM(sales) revenue

FROM clean_supply_chain

GROUP BY market

)

SELECT

market,

revenue,

SUM(revenue)

OVER(

ORDER BY revenue DESC

)

AS cumulative_revenue

FROM market_sales;