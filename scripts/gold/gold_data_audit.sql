/*
===============================================================================
Purpose: Provides a quick audit of row counts across all Gold views.
Run this script to verify successful Gold layer creation.
===============================================================================
*/

SELECT 'gold.dim_customers' AS view_name, COUNT(*) AS row_count FROM gold.dim_customers
UNION ALL
SELECT 'gold.dim_products', COUNT(*) FROM gold.dim_products
UNION ALL
SELECT 'gold.fact_sales', COUNT(*) FROM gold.fact_sales
UNION ALL
SELECT 'gold.customer_sales_summary', COUNT(*) FROM gold.customer_sales_summary;
