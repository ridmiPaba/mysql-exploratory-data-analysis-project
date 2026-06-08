/*
-- Cumulative Analysis --

Aggregate the data progressively over time.
Helps to understand whether our business is growing or declining.

sigma[ Cumulative Measure] By [Date Dimension]
        Running Total Sales By Year
        Moving Average of Sales By Month
*/


-- Calculate the total sales per month
-- and the running total of sales over time
SELECT
order_date,
total_sales,
SUM(total_sales) OVER ( ORDER BY order_date) AS runnung_total_sales -- window function
FROM
(
SELECT                                         /*adding each row's value to the sum of all the previous rows' value */
DATE(order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATE(order_date)
ORDER BY DATE(order_date)
)t


SELECT
order_date,
total_sales,
SUM(total_sales) OVER ( PARTITION BY order_date ORDER BY order_date) AS runnung_total_sales -- window function
FROM
(
SELECT                                         /*adding each row's value to the sum of all the previous rows' value */
DATE(order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATE(order_date)
ORDER BY DATE(order_date)
)t

-- runnin total sales with cumulative metric over the year
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM 
(
  SELECT
    MAKEDATE(YEAR(order_date), 1) AS order_date,
    SUM(sales_amount) AS total_sales
  FROM gold.fact_sales
  WHERE order_date IS NOT NULL
  GROUP BY MAKEDATE(YEAR(order_date), 1)
) t


-- runnin total sales with cumulative metric over the year & moving average

SELECT
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM 
(
  SELECT
  MAKEDATE(YEAR(order_date), 1) AS order_date,
  SUM(sales_amount) AS total_sales,
  AVG(price) AS avg_price
  FROM gold.fact_sales
  WHERE order_date IS NOT NULL
  GROUP BY MAKEDATE(YEAR(order_date), 1)
) t