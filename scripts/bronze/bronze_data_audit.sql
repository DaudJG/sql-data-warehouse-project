/*
===============================================================================
Purpose: Provides a quick audit of row counts in all Bronze tables
===============================================================================
*/

SELECT 'bronze.crm_cust_info'        AS table_name, COUNT(*) AS row_count FROM bronze.crm_cust_info
UNION ALL
SELECT 'bronze.crm_prd_info',        COUNT(*) FROM bronze.crm_prd_info
UNION ALL
SELECT 'bronze.crm_sales_details',   COUNT(*) FROM bronze.crm_sales_details
UNION ALL
SELECT 'bronze.erp_loc_a101',        COUNT(*) FROM bronze.erp_loc_a101
UNION ALL
SELECT 'bronze.erp_cust_az12',       COUNT(*) FROM bronze.erp_cust_az12
UNION ALL
SELECT 'bronze.erp_px_cat_g1v2',     COUNT(*) FROM bronze.erp_px_cat_g1v2
UNION ALL
SELECT 'bronze.load_log',            COUNT(*) FROM bronze.load_log;
