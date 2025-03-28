# 🟫 Bronze Layer – Raw Data Staging

This folder contains the scripts that define and load the **Bronze layer** of the SQL Data Warehouse using the Medallion Architecture.

##  Purpose

The Bronze layer stores **raw, unprocessed data** from the CRM and ERP source systems. It acts as the first stop in the ETL pipeline, helping maintain source traceability and historical snapshots.

##  Included Scripts

- `ddl_bronze.sql` — Creates all raw staging tables
- `proc_load_bronze.sql` — Loads CSV files into the Bronze tables using BULK INSERT
- `bronze.load_log` — Custom table to track file loads (added manually)

##  Enhancements Added (Custom)

- ✔️ Introduced `bronze.load_log` table to track each file loaded
- ✔️ Automatically logs file name, table name, row count, timestamp, and user
- ✔️ Improved documentation and SQL formatting
- ✔️ Added custom comments to clarify each step

##  Notes

- All tables are truncated before each load to avoid duplicates
- Files are assumed to be in `.csv` format with a header row
