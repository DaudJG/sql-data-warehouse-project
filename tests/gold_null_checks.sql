/*
===============================================================================
Purpose: Check for NULLs in critical fields across Gold views
Expected Output:
  - Each query returns a single row with a count.
  - Ideally, all counts should be 0.
===============================================================================
*/

-- Check for missing customer references in fact_sales
SELECT COUNT(*) AS null_customer_keys
FROM gold.fact_sales
WHERE customer_key IS NULL;

-- Check for missing product references in fact_sales
SELECT COUNT(*) AS null_product_keys
FROM gold.fact_sales
WHERE product_key IS NULL;

-- Check for missing order dates in fact_sales
-- Some rows may have invalid or missing order dates set to NULL intentionally
SELECT COUNT(*) AS null_order_dates
FROM gold.fact_sales
WHERE order_date IS NULL;

-- Check for missing country values in dim_customers
SELECT COUNT(*) AS null_country
FROM gold.dim_customers
WHERE country IS NULL;

-- Check for null total_sales in customer_sales_summary
SELECT COUNT(*) AS null_sales
FROM gold.customer_sales_summary
WHERE total_sales IS NULL;
