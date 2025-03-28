# Data Quality Tests

This folder contains SQL scripts that perform data quality and validation checks on the **Silver** and **Gold** layers of the data warehouse.

These tests are meant to:
- Validate data transformations
- Ensure referential integrity
- Identify inconsistencies, missing values, or unexpected records
- Improve trust in downstream analytics and reporting

---

## Folder Structure

### Gold Layer Tests

| File                        | Purpose |
|-----------------------------|---------|
| `gold_null_checks.sql`      | Checks for nulls in critical fields like `customer_key`, `product_key`, `order_date`, and `sales_amount` |
| `gold_unmatched_joins.sql`  | Ensures all `fact_sales` rows reference valid customers and products in dimension views |

---

### Silver Layer Tests

| File                         | Purpose |
|------------------------------|---------|
| `silver_null_checks.sql`     | Validates completeness of key fields (e.g., `cst_id`, `sls_prd_key`, `age`, `gender`) |
| `silver_quality_checks.sql`  | Checks business logic, data formatting, and standardization across Silver tables. Includes:
  - Duplicate key detection
  - Consistent values for gender, marital status, etc.
  - Validity of calculated fields (e.g., `sales = quantity * price`)
  - Reasonable date and age ranges

---

## How to Use

- Run each script individually after loading the Silver and Gold layers
- **Expected result**: Most queries should return zero rows
- Any non-zero results indicate potential issues that should be reviewed and resolved

---

## Notes

- These tests are meant to supplement your ETL validation process
- You can automate them or schedule them to run after pipeline jobs
- Consider extending them to include thresholds or exception reporting
