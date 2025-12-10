# Data Dictionary for Gold Layer

## Overview
The Gold Layer represents the enterprise-standard, analytics-ready tier of the Sales Data Mart. All entities within this layer are fully conformed, quality-assured, enriched, and modeled to support strategic reporting, cross-functional insights, and scalable decision intelligence. This layer encapsulates harmonized business definitions, curated dimensional structures, and trusted fact tables optimized for BI consumption and enterprise governance.

## 1. CUSTOMER_DIM

### Purpose
Conformed customer dimension consolidating CRM and ERP sources.

### Primary Key
- **customer_key** — VARCHAR(50)

### Columns
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| customer_key | VARCHAR(50) | Surrogate key. |
| customer_id | VARCHAR(50) | Original CRM/ERP ID. |
| full_name | TEXT | Customer full name. |
| marital_status | VARCHAR(20) | Marital classification. |
| gender | VARCHAR(20) | Enriched gender attribute. |
| country | VARCHAR(50) | Country derived from ERP location data. |
| create_date | DATE | Customer creation date. |
| birth_date | DATE | Customer DOB from ERP. |

---

## 2. PRODUCT_DIM

### Purpose
Product details with category, lifecycle, and cost attributes.

### Primary Key
- **product_key** — VARCHAR(50)

### Columns
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| product_key | VARCHAR(50) | Conformed product key. |
| product_id | VARCHAR(50) | Source system product ID. |
| category_id | VARCHAR(50) | ERP category ID. |
| product_number | VARCHAR(50) | Vendor or manufacturer product number. |
| product_name | VARCHAR(150) | Descriptive product name. |
| product_line | VARCHAR(100) | High-level product line. |
| category | TEXT | Product category. |
| sub_category | TEXT | Product sub-category. |
| maintenance | TEXT | Maintenance or support classification. |
| start_date | DATE | Product introduction date. |
| cost | NUMERIC(12,2) | Standard product cost. |

---

## 3. SALES_FACT

### Purpose
Transactional fact table capturing sales order line details.

### Primary Key
Composite: **order_number**, **product_key**

### Columns
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| order_number | VARCHAR(50) | Sales order number. |
| customer_key | VARCHAR(50) | FK → customer_dim. |
| product_key | VARCHAR(50) | FK → product_dim. |
| customer_id | VARCHAR(50) | Customer operational ID. |
| order_date | DATE | Date the order was placed. |
| ship_date | DATE | Shipment execution date. |
| sales_due_date | DATE | Expected delivery due date. |
| sales_price | NUMERIC(12,2) | Unit sales price. |
| sales_quantity | INTEGER | Quantity sold. |
| total_sales | NUMERIC(14,2) | Total transaction value. |

---

## Notes
- All VARCHAR lengths chosen based on typical enterprise conventions.
- NUMERIC precision supports financial reporting accuracy.
- DATE fields standardize temporal analysis.
- Designed based on PostgreSQL best practices.

