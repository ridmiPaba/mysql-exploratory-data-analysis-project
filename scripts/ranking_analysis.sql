/*

Order the values of dimensions by measure.
Top N performers | Bottom N Performers

Rank [Dimension] By Z [Measure ]
Rank Countries By Total Sales
Top5 Products By Quantity
Bottom 3 Custamers By Total Orders

LIMIT RANK ()
DENSE_RANKS())
ROW_NUMBER()

  */

-- Which 5 products generate the highest revenue?
SELECT 
p.product_name,
SUM(f.sales_amount) total_reveue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_reveue DESC
LIMIT 5


SELECT *
FROM(
    SELECT
    p.product_name,
    SUM(f.sales_amount) total_reveue,
    ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
    GROUP BY p.product_name)t
WHERE rank_products <=5




-- What are the 5 worst-performing products in terms of sales?
SELECT 
p.product_name,
SUM(f.sales_amount) total_reveue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_reveue 
LIMIT 5



-- Find the top 10 customers who have generated the highest revenue
SELECT
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_reveue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_reveue DESC
LIMIT 10


-- The 3 customers with the fewest orders placed
SELECT
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_orders
LIMIT 3