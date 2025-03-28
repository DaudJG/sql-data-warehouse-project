
/*
===============================================================================
Purpose: Identify any broken joins between fact and dimension views in Gold layer
Expected Output:
  - Each query returns 0 rows.
  - Any rows returned indicate broken joins (i.e., missing dimension records).
===============================================================================
*/

-- Orders with missing customer reference
SELECT fs.order_number
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_customers AS cu ON fs.customer_key = cu.customer_key
WHERE cu.customer_key IS NULL;

-- Orders with missing product reference
SELECT fs.order_number
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_products AS pr ON fs.product_key = pr.product_key
WHERE pr.product_key IS NULL;
