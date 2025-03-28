/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Logs each load event into bronze.load_log (custom enhancement)
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.
    - Handles errors with TRY/CATCH and prints clear messages

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME;

    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Starting Bronze Layer Load';
        PRINT '================================================';

        -----------------------------
        -- Load CRM Tables
        -----------------------------
        PRINT '--- Loading CRM Tables ---';

        -- crm_cust_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>> Inserting into bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\SAMSUNG\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        INSERT INTO bronze.load_log (file_name, table_name, records_loaded)
        SELECT 'cust_info.csv', 'bronze.crm_cust_info', COUNT(*) FROM bronze.crm_cust_info;

        -- crm_prd_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>> Inserting into bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\SAMSUNG\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        INSERT INTO bronze.load_log (file_name, table_name, records_loaded)
        SELECT 'prd_info.csv', 'bronze.crm_prd_info', COUNT(*) FROM bronze.crm_prd_info;

        -- crm_sales_details
        SET @start_time = GETDATE();
        PRINT '>> Truncating bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>> Inserting into bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\SAMSUNG\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        INSERT INTO bronze.load_log (file_name, table_name, records_loaded)
        SELECT 'sales_details.csv', 'bronze.crm_sales_details', COUNT(*) FROM bronze.crm_sales_details;

        -----------------------------
        -- Load ERP Tables
        -----------------------------
        PRINT '--- Loading ERP Tables ---';

        -- erp_loc_a101
        SET @start_time = GETDATE();
        PRINT '>> Truncating bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>> Inserting into bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\SAMSUNG\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        INSERT INTO bronze.load_log (file_name, table_name, records_loaded)
        SELECT 'loc_a101.csv', 'bronze.erp_loc_a101', COUNT(*) FROM bronze.erp_loc_a101;

        -- erp_cust_az12
        SET @start_time = GETDATE();
        PRINT '>> Truncating bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>> Inserting into bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\SAMSUNG\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        INSERT INTO bronze.load_log (file_name, table_name, records_loaded)
        SELECT 'cust_az12.csv', 'bronze.erp_cust_az12', COUNT(*) FROM bronze.erp_cust_az12;

        -- erp_px_cat_g1v2
        SET @start_time = GETDATE();
        PRINT '>> Truncating bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>> Inserting into bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\SAMSUNG\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        INSERT INTO bronze.load_log (file_name, table_name, records_loaded)
        SELECT 'px_cat_g1v2.csv', 'bronze.erp_px_cat_g1v2', COUNT(*) FROM bronze.erp_px_cat_g1v2;

        -----------------------------
        -- Complete
        -----------------------------
        SET @batch_end_time = GETDATE();
        PRINT '================================================';
        PRINT 'Bronze Layer Load Complete';
        PRINT '   Total Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '================================================';
    END TRY

    BEGIN CATCH
        PRINT '================================================';
        PRINT '❌ ERROR: Failed to Load Bronze Layer';
        PRINT 'Message   : ' + ERROR_MESSAGE();
        PRINT 'Number    : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Severity  : ' + CAST(ERROR_SEVERITY() AS NVARCHAR);
        PRINT 'State     : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '================================================';
    END CATCH
END;
