# Silver Layer – Cleansed & Standardized Data

This folder contains scripts that define and load the Silver Layer of the SQL Data Warehouse using the Medallion Architecture.

---

## Purpose

The Silver Layer transforms raw source data from the Bronze Layer into a cleaned, standardized, and business-ready form.

It applies:
- Data cleansing
- Column normalization
- Enrichment and derived fields
- Schema reshaping
- Data validation

---

## Included Scripts

- `ddl_silver.sql` – Defines all Silver tables
- `proc_load_silver.sql` – Transforms and loads data from Bronze to Silver
- `silver_data_audit.sql` – Audits row counts across Silver tables (custom)

---

## Key Transformations (ETL Logic)

### CRM Tables
- `crm_cust_info`  
  - Latest customer record  
  - Gender & marital status normalization  
  - Trimmed name fields

- `crm_prd_info`  
  - Extracted `cat_id` from product key  
  - Standardized product line  
  - Calculated end date using `LEAD()` window function

- `crm_sales_details`  
  - Cleaned invalid dates  
  - Derived missing sales/price values  
  - Ensured valid quantity and revenue

---

### ERP Tables
- `erp_cust_az12`  
  - Stripped "NAS" from customer IDs  
  - Cleaned invalid birthdates  
  - Normalized gender values  
  - Added custom derived column: `age`

- `erp_loc_a101`  
  - Removed dashes from IDs  
  - Mapped country codes to full names

- `erp_px_cat_g1v2`  
  - Loaded directly (no transformation yet)

---

## Enhancements Added (Custom Work)

- Calculated `age` in `erp_cust_az12`
- Added `silver_data_audit.sql` to verify ETL loads
- Cleaned and standardized the procedure with detailed comments
- Aligned column order and naming conventions

---

## Notes

- All tables are truncated before each load, making the process **idempotent**.
> Idempotent = safe to run multiple times without changing the final result.  
> Each run clears the table first, so the outcome is always consistent.

- `dwh_create_date` column is auto-generated on insert for each table
