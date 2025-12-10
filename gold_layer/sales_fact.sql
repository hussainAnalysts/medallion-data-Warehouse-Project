-- ============================================================
--  View: gold.sales_fact
--  Purpose: Creates the Sales Fact table for the Gold Layer.
--  Integrates CRM sales transactions with customer and product
--  dimensions to produce an analytics-ready fact table.
-- ============================================================

CREATE VIEW gold.sales_fact AS
SELECT 
    -- Transaction-level identifier
    s.sls_ord_num AS order_number,

    -- Surrogate key from the Customer Dimension
    c.customer_key,

    -- Surrogate key from the Product Dimension
    p.product_key,

    -- Business product identifier from source system
    s.sls_prd_key AS product_number,

    -- Sales process dates as captured in CRM
    s.sls_order_dt AS order_date,
    s.sls_ship_dt AS shiping_date,
    s.sls_due_dt AS sales_due_date,

    -- Sales measures
    s.sales_price,
    s.sales_qty AS sales_quantity,
    s.total_sales

FROM silver.crm_sales_details AS s

    -- Customer dimension lookup based on CRM customer ID
    LEFT JOIN gold.customer_dim AS c
        ON s.sls_cust_id = c.customer_id

    -- Product dimension lookup based on product number
    LEFT JOIN gold.product_dim AS p
        ON p.product_number = s.sls_prd_key

-- Ensure referential integrity by excluding products 
-- that do not match any record in product_dim
WHERE p.product_key IS NOT NULL;
