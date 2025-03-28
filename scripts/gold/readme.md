# Gold Layer – Business-Facing Data Views

This folder contains SQL scripts that define the **Gold layer** of the data warehouse, representing clean, enriched, and business-ready datasets based on the Silver layer.

The Gold layer uses a **star schema design**, exposing fact and dimension views that are optimized for reporting, analytics, and dashboards.

---

## Purpose

The Gold layer serves as the final presentation layer in the Medallion architecture. It combines and reshapes the cleansed data from Silver into useful metrics and business entities.

---

## Included Views

- `gold.dim_customers`  
  Customer dimension that joins CRM and ERP data, including country, gender, birthdate and age.

- `gold.dim_products`  
  Product dimension enriched with category and subcategory from ERP data.

- `gold.fact_sales`  
  Fact view combining sales transactions with customer and product dimension keys.

- `gold.customer_sales_summary`  
  Custom summary view aggregating total sales and quantity per customer, including age and country.

---

## Key Features and Enhancements

- Star schema design (fact and dimension separation)
- Surrogate keys generated using `ROW_NUMBER()`
- Aggregated summary view: `customer_sales_summary`

---

## Notes

- All views are virtual and built from Silver-layer tables.
- Views can be refreshed by rerunning `ddl_gold.sql` or a stored procedure if added.
- Joins across dimensions ensure enriched business context for reporting.

