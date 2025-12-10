-- ============================================================
--  View: gold.dim_customer
--  Purpose: Builds the Customer Dimension for the Gold Layer.
--  Harmonizes CRM and ERP customer data, applies gender
--  standardization logic, and assigns a surrogate customer key.
-- ============================================================

CREATE VIEW gold.dim_customer AS
SELECT
    -- Surrogate key generated deterministically using customer_id ordering
    ROW_NUMBER() OVER (ORDER BY c.customer_id) AS customer_key,

    -- Business identifiers from CRM
    c.customer_id,
    c.full_name,
    c.marital_status,

    -- Gender harmonization:
    -- Priority 1: ERP gender if valid and not 'N/A'
    -- Priority 2: CRM gender if present and not 'N/A'
    -- Fallback: CRM gender (may be null or 'N/A')
    CASE
        WHEN e.gen IS NOT NULL AND e.gen NOT IN ('N/A')
            THEN e.gen
        WHEN c.gender_status IS NOT NULL AND c.gender_status NOT IN ('N/A')
            THEN c.gender_status
        ELSE c.gender_status
    END AS gender,

    -- Country of customer sourced from ERP location table
    l.cntry AS country,

    -- Account creation date (CRM)
    c.create_date,

    -- Date of birth sourced from ERP
    e.bdate AS birth_date

FROM silver.crm_cus_info AS c

    -- ERP customer core data lookup (gender, birth date)
    LEFT JOIN silver.erp_cust_az12 AS e
        ON c.customer_key = e.cid

    -- ERP customer location data lookup (country)
    LEFT JOIN silver.erp_loc_a101 AS l
        ON c.customer_key = l.cid;
