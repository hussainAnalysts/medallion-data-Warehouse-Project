# 📦 Data Warehouse Project and Analytics Project (Medallion Architecture)

## 📘 Overview
This end-to-end data warehousing project implements a **Medallion Architecture (Bronze → Silver → Gold)** using **PostgreSQL, pgAdmin, VS Code, Notion, and Draw.io**. The goal is to integrate CRM and ERP source systems, resolve data quality issues, and deliver a clean, analytics‑ready **Sales Data Mart**. This project showcases modern data engineering and BI best practices, delivering dimensional models, documentation, and reusable SQL pipelines.



## 🧱 Layer Descriptions

### **Bronze Layer – Raw Ingestion**
The Bronze layer captures raw CRM and ERP data with zero transformations. It preserves the original fidelity of the source systems and establishes the foundation for traceability and reproducibility.

### **Silver Layer – Standardized & Cleaned Data**
The Silver layer applies business rules, data profiling, and standardization. At this stage:
- Nulls are treated
- Formats are aligned
- CRM and ERP datasets are conformed
- Surrogate keys begin to form logical relationships

This ensures datasets are analytically reliable and consistent for downstream use.

### **Gold Layer – Dimensional Modelling (Star Schema)**
The Gold layer contains finalized **Dimension** and **Fact** tables used by BI tools and analysts. It features:
- `customer_dim`
- `product_dim`
- `sales_fact`

These structures optimize analytical performance and support business‑driven reporting needs.


---

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### **Objective**
Construct a scalable and efficient data warehouse in PostgreSQL to consolidate sales-related data across systems and provide a foundation for business intelligence and analytics.

#### **Specifications**
- **Data Sources**: Load CRM and ERP datasets delivered as CSV files.
- **Data Quality**: Standardize, cleanse, and validate fields (e.g., gender, category, product codes).
- **Integration**: Merge data from both sources into a unified model optimized for analytical workflows.
- **Scope**: Use only the latest available records; no historization or SCD implementation required.
- **Documentation**: Deliver user-friendly, technical, and architectural documentation to support stakeholders and future enhancements.

---

## 📊 BI: Analytics & Reporting (Data Analysis)

#### **Objective**
Build analytical SQL views and metrics to uncover insights such as:
- Customer segment behavior
- Product performance and profitability
- Monthly, quarterly, and yearly sales trends

These outputs empower decision-makers with actionable intelligence derived from the curated Gold Layer.

---

## 🛠 Tech Stack
- **PostgreSQL** — Core data warehouse engine
- **pgAdmin** — Database administration, querying, and model inspection
- **VS Code** — Development environment for SQL scripts and documentation
- **Notion** — Project planning, task breakdowns, requirements tracking
- **Draw.io** — Architecture diagrams, data flow visuals, and star schema modeling
- **Github** - Repository hosting, version control, and project collaboration.

---

## 📁 Project Structure

Below is the root‑level folder and file structure designed for transparency and maintainability:

```
├── bronze_layer
│   ├── Bronze layer DDL.sql
│   ├── Creating Schemas.sql
│   └── loading data into bronze.sql
│
├── chart diagram and docs
│   ├── Data Architecture-Page-1.drawio.png
│   ├── Dataflow diagram(bronze).drawio.png
│   ├── Dataflow diagram(gold layer).drawio.png
│   ├── Dataflow diagram.drawio (silver).png
│   ├── Integration model.drawio.png
│   ├── Sales Data Mart Catalog.pdf
│   ├── sales_data_mart_catalog.md
│   └── Star Schema.drawio (1).png
│
├── datasets
│   ├── CRM source
│   │   ├── cust_info.csv
│   │   ├── prd_info.csv
│   │   └── sales_details.csv
│   └── ERP source
│       ├── CUST_AZ12.csv
│       ├── LOC_A101.csv
│       └── PX_CAT_G1V2.csv
│
├── gold_layer
│   ├── customer_dim.sql
│   ├── product_dim.sql
│   └── sales_fact.sql
│
├── silver_layer
│   ├── DDL for silver layer.sql
│   ├── inserting into erp_cust_az12.sql
│   ├── inserting into silver.crm_cust_info_clean.sql
│   ├── inserting into silver.crm_prd_info.sql
│   ├── inserting into silver.erp_loc_a101.sql
│   ├── inserting into silver.erp_px_cat_g1v2.sql
│   └── inserting into silver.crm_sales_details.sql
```

---

## 📧 Contact
**Author:** Hussaini Ismail Ahmad
**Email:** husainmacdon@gmail.com
**LinkedIn:**  https://www.linkedin.com/in/hussain-ismail-682876222




