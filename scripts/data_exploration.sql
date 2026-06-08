/* 
Identify the earliest and latest dates (boundaries).
Understand the scope of data and the timespan.

MIN/MAX [Date Dimension]
MIN Order-date
MAX Create-date
MIN Birthdate

*/

-- Find the date of first and last order
SELECT  
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date
FROM gold.fact_sales

-- How many years of sales are available
SELECT  
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
TIMESTAMPDIFF(YEAR,MIN(order_date),MAX(order_date)) AS order_range_years
FROM gold.fact_sales

-- How many months of sales are available
SELECT  
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
TIMESTAMPDIFF(MONTH,MIN(order_date),MAX(order_date)) AS order_range_months
FROM gold.fact_sales

-- Find the youngest and olderst customer
SELECT
MIN(birthdate) AS olderst_birthdaye,
MAX(birthdate) AS youngerst_birthdate
FROM gold.dim_customers

-- Find the youngest and olderst customer with age
SELECT
MIN(birthdate) AS olderst_birthdaye,
TIMESTAMPDIFF(YEAR,MIN(birthdate),CURRENT_DATE()) AS oldest_age,
MAX(birthdate) AS youngerst_birthdate,
TIMESTAMPDIFF(YEAR,MAX(birthdate),CURRENT_DATE()) AS youngest_age
FROM gold.dim_customers