/*
 Identifying the unique values (or categories) in each dimension. Recognizing how data might 
 be grouped or segmented,which is useful for later analysis.

DISTINCT [Dimension]
DISTINCT Country
DISTINCT Category
DISTINCT Product

   */

-- Explore All Countries our customers come from

SELECT DISTINCT country FROM gold.dim_customers

-- Explore ALL Categories "The major Divisions"

SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3

/*
1 represents category 
2 represents subcategory 
3 represents product_name 

How the Sorting Works

MySQL will sort the final result hierarchically:

1. It first sorts everything alphabetically by category.
2. For products sharing the same category, it sorts them by subcategory.
3. For products sharing both the same category and subcategory, it sorts them by product_name.

*/