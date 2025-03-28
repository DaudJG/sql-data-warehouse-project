/*
===============================================================================
Purpose:
    Perform logic-based and formatting quality checks for Silver-layer tables.
    These are not just null checks — they validate:
    - Primary key uniqueness
    - Field formatting (extra spaces)
    - Consistent standardized values
    - Valid value ranges (dates, age, cost, etc.)
    - Business rule consistency (e.g., derived sales = quantity * price)

Expected Output:
    - Most queries return 0 rows or clean distinct value lists
    - Any rows returned require review
===============================================================================
*/

-- ============================================================================
-- silver.crm_cust_info
-- ============================================================================

-- Check for duplicate or null customer IDs (should be unique per row)
SELECT cst_id, COUNT(*) AS count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for leading/trailing spaces in customer key
SELECT cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Review standardized gender values
SELECT DISTINCT cst_gndr FROM silver.crm_cust_info ORDER BY cst_gndr;

-- Review standardized marital status values
SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info ORDER BY cst_marital_status;

-- ============================================================================
-- silver.crm_prd_info
-- ============================================================================

-- Check for duplicate or null product IDs
SELECT prd_id, COUNT(*) AS count
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Negative or null product cost check
SELECT *
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0;

-- Validate product line standardization
SELECT DISTINCT prd_line FROM silver.crm_prd_info ORDER BY prd_line;

-- Invalid date range: start date after end date
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ============================================================================
-- silver.crm_sales_details
-- ============================================================================

-- Validate order date is not after shipping or due dates
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

-- Confirm sales = quantity * price (or derived appropriately)
SELECT *
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
    AND sls_quantity IS NOT NULL AND sls_price IS NOT NULL;

-- ============================================================================
-- silver.erp_cust_az12
-- ============================================================================

-- Validate age is in a realistic range
SELECT * 
FROM silver.erp_cust_az12
WHERE age < 0 OR age > 120;

-- Review standardized gender values
SELECT DISTINCT gen FROM silver.erp_cust_az12 ORDER BY gen;

-- Review birthdate range (e.g., not futuristic or too far in past)
SELECT bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE();

-- ============================================================================
-- silver.erp_loc_a101
-- ============================================================================

-- Review standardized country values
SELECT DISTINCT cntry FROM silver.erp_loc_a101 ORDER BY cntry;

-- ============================================================================
-- silver.erp_px_cat_g1v2
-- ============================================================================

-- Check for unwanted spaces in category fields
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
   OR subcat != TRIM(subcat)
   OR maintenance != TRIM(maintenance);

-- Review maintenance values
SELECT DISTINCT maintenance FROM silver.erp_px_cat_g1v2 ORDER BY maintenance;
