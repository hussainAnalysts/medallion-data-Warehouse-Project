-- ============================================================
--  View: gold.product_dim
--  Purpose: Builds the Product Dimension for the Gold Layer.
--  Combines CRM product master data with ERP product category
--  mappings and assigns a surrogate product key for analytics.
-- ============================================================

CREATE VIEW gold.product_dim AS
SELECT
    -- Surrogate key generated using deterministic row ordering
    ROW_NUMBER() OVER (ORDER BY c.prd_id) AS product_key,

    -- Source system identifiers
    c.prd_id AS product_id,
    c.prd_cat_id AS category_id,

    -- Business product key from CRM
    c.prd_key AS product_number,

    -- Descriptive product attributes
    c.prd_nm AS product_name,

    -- Standardized product line (fallback to 'N/A' for missing values)
    CASE 
        WHEN c.prd_line IS NULL THEN 'N/A'
        ELSE c.prd_line
    END AS product_line,

    -- Product categorization sourced from ERP product taxonomy
    p.cat AS category,
    p.subcat AS sub_category,
    p.maintenance AS maintenance,

    -- Additional product attributes
    c.prd_start_dt AS start_date,
    c.prd_cost AS cost

FROM silver.crm_prd_info AS c

    -- Join CRM products to ERP category table using category reference ID
    LEFT JOIN silver.erp_px_cat_g1v2 AS p
        ON c.prd_cat_id = p.id

-- Only return products that are still active (no end date recorded)
WHERE c.prd_end_dt IS NULL;
