/*
===============================================================================
Purpose: Validate data quality in the Silver layer tables.
Expected Output:
  - Each query returns a single row with a count.
  - Ideally, all counts should be 0 (or minimal).
===============================================================================
*/

-- 1. Check for null customer IDs in silver.crm_cust_info
SELECT COUNT(*) AS null_cst_id
FROM silver.crm_cust_info
WHERE cst_id IS NULL;

-- 2. Check for null gender in silver.crm_cust_info
SELECT COUNT(*) AS null_gender
FROM silver.crm_cust_info
WHERE cst_gndr IS NULL;

-- 3. Check for unrealistic ages in silver.erp_cust_az12
SELECT COUNT(*) AS invalid_age
FROM silver.erp_cust_az12
WHERE age < 0 OR age > 120;

-- 4. Check for invalid sales data in silver.crm_sales_details
-- For instance, sales should be >= 0 if not null.
SELECT COUNT(*) AS invalid_sales
FROM silver.crm_sales_details
WHERE sls_sales < 0;

-- 5. Check for missing product keys in silver.crm_sales_details
SELECT COUNT(*) AS null_prd_key
FROM silver.crm_sales_details
WHERE sls_prd_key IS NULL OR sls_prd_key = '';

