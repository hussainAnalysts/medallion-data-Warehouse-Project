INSERT INTO silver.crm_sales_details (
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sales_price,
    sales_qty,
    total_sales,
    loaded_at
)
SELECT
    TRIM(sls_ord_num) AS sls_ord_num,
    TRIM(sls_prd_key) AS sls_prd_key,
    TRIM(sls_cust_id) AS sls_cust_id,

    /* --------------------------- DATE CLEANING --------------------------- */
        CASE
        WHEN NULLIF(TRIM(sls_order_dt), '') IS NULL THEN NULL
        
        WHEN TRIM(sls_order_dt) ~ '^\d{4}-\d{2}-\d{2}$' THEN TRIM(sls_order_dt)::DATE
        
        WHEN TRIM(sls_order_dt) ~ '^\d{8}$' THEN TO_DATE(TRIM(sls_order_dt), 'YYYYMMDD')
        
        WHEN REGEXP_REPLACE(TRIM(sls_order_dt), '[^0-9/]', '', 'g') ~ '^\d{1,2}/\d{1,2}/\d{4}$'
            THEN TO_DATE(REGEXP_REPLACE(TRIM(sls_order_dt), '[^0-9/]', '', 'g'), 'MM/DD/YYYY')
        
        ELSE NULL  
    END AS sls_order_dt,

    CASE
        WHEN NULLIF(TRIM(sls_ship_dt), '') IS NULL THEN NULL
        WHEN TRIM(sls_ship_dt) ~ '^\d{4}-\d{2}-\d{2}$' THEN TRIM(sls_ship_dt)::DATE
        WHEN TRIM(sls_ship_dt) ~ '^\d{8}$' THEN TO_DATE(TRIM(sls_ship_dt), 'YYYYMMDD')
        WHEN REGEXP_REPLACE(TRIM(sls_ship_dt), '[^0-9/]', '', 'g') ~ '^\d{1,2}/\d{1,2}/\d{4}$'
            THEN TO_DATE(REGEXP_REPLACE(TRIM(sls_ship_dt), '[^0-9/]', '', 'g'), 'MM/DD/YYYY')
        ELSE NULL
    END AS sls_ship_dt,

    CASE
        WHEN NULLIF(TRIM(sls_due_dt), '') IS NULL THEN NULL
        WHEN TRIM(sls_due_dt) ~ '^\d{4}-\d{2}-\d{2}$' THEN TRIM(sls_due_dt)::DATE
        WHEN TRIM(sls_due_dt) ~ '^\d{8}$' THEN TO_DATE(TRIM(sls_due_dt), 'YYYYMMDD')
        WHEN REGEXP_REPLACE(TRIM(sls_due_dt), '[^0-9/]', '', 'g') ~ '^\d{1,2}/\d{1,2}/\d{4}$'
            THEN TO_DATE(REGEXP_REPLACE(TRIM(sls_due_dt), '[^0-9/]', '', 'g'), 'MM/DD/YYYY')
        ELSE NULL
    END AS sls_due_dt,

    /* --------------------------- CLEAN PRICE --------------------------- */
    CASE
        WHEN sls_price IS NOT NULL THEN ABS(sls_price)
        WHEN sls_price IS NULL AND sls_sales IS NOT NULL AND sls_quantity > 0
            THEN ABS(sls_sales) / ABS(sls_quantity)
        ELSE 0
    END AS sales_price,

    /* --------------------------- CLEAN QUANTITY ------------------------- */
    CASE
        WHEN sls_quantity IS NOT NULL THEN ABS(sls_quantity)
        WHEN sls_quantity IS NULL AND sls_price IS NOT NULL AND sls_price > 0
            THEN ABS(sls_sales) / ABS(sls_price)
        ELSE 0
    END AS sales_qty,

    /* --------------------------- CLEAN SALES ---------------------------- */
    (
        CASE
            WHEN sls_price IS NOT NULL AND sls_quantity IS NOT NULL
                THEN ABS(sls_price) * ABS(sls_quantity)
            WHEN sls_sales IS NOT NULL
                THEN ABS(sls_sales)
            ELSE
                COALESCE(
                    ABS(sls_price) * ABS(sls_quantity),
                    0
                )
        END
    ) AS total_sales,

    /* META column */
    CURRENT_TIMESTAMP AS loaded_at

FROM bronze.crm_sales_details;
