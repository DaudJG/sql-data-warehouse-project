/*
================================================================================
SQL Script: Create a Data Warehouse with Schemas (Bronze, Silver, Gold)
================================================================================

Purpose:
- This script creates a new database named 'DataWarehouse' and three schemas 
  within it: 'bronze', 'silver', and 'gold'. These schemas are typically used 
  in a layered data architecture to segregate raw, processed, and curated data.

Features:
- Includes safety checks (IF NOT EXISTS) to ensure the script can be run multiple
  times without errors.
- Comments are provided for each step to explain the purpose and function of the
  commands, making the script easy to understand and maintain.

Usage:
- Run this script in SQL Server Management Studio (SSMS).
- Ensure the server connection is configured correctly before executing the script.

Schema Overview:
- Bronze: Stores raw data as ingested from the source systems.
- Silver: Stores cleansed and transformed data for downstream processing.
- Gold: Stores curated, aggregated, and final data for reporting and analytics.

================================================================================
*/

-- Step 1: Switch to the master database.
-- Ensures the database creation command is executed in the correct context.
USE master;
GO

-- Step 2: Check if the 'DataWarehouse' database exists.
-- If it does not exist, create it.
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    CREATE DATABASE DataWarehouse;  -- Create the 'DataWarehouse' database.
END
GO

-- Step 3: Switch to the 'DataWarehouse' database.
-- All subsequent operations will occur within this database.
USE DataWarehouse; 
GO

-- Step 4: Check if the 'bronze' schema exists.
-- If it does not exist, create it. This schema is for raw data ingestion.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
BEGIN
    CREATE SCHEMA bronze;  -- Create the 'bronze' schema.
END
GO

-- Step 5: Check if the 'silver' schema exists.
-- If it does not exist, create it. This schema is for transformed and cleansed data.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
BEGIN
    CREATE SCHEMA silver;  -- Create the 'silver' schema.
END
GO

-- Step 6: Check if the 'gold' schema exists.
-- If it does not exist, create it. This schema is for curated and final data.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
BEGIN
    CREATE SCHEMA gold;  -- Create the 'gold' schema.
END
GO
