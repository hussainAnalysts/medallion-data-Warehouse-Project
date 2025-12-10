-- Optional: clear Silver table
TRUNCATE TABLE silver.crm_prd_info;

-- Insert cleaned data
INSERT INTO silver.crm_prd_info (
    prd_id,
    prd_cat_id,
    prd_key,
    prd_nm,
    prd_line,
    prd_start_dt,
    prd_end_dt,
    prd_cost,
    loaded_at
)
SELECT
    -- Original bronze ID
    b.prd_id,

    -- Derived prd_cat_id (first 5 chars)
    UPPER(REPLACE(SUBSTRING(b.prd_key FROM 1 FOR 5), '-', '_')) AS prd_cat_id,

    -- Derived prd_key (remaining chars)
    CASE 
        WHEN RIGHT(REPLACE(SUBSTRING(b.prd_key FROM 6), '-', '_'), 1) = '_' 
            THEN LEFT(REPLACE(SUBSTRING(b.prd_key FROM 6), '-', '_'), 
                      LENGTH(REPLACE(SUBSTRING(b.prd_key FROM 6), '-', '_')) - 1)
        ELSE REPLACE(SUBSTRING(b.prd_key FROM 6), '-', '_')
    END AS prd_key,

    -- Clean product name
    INITCAP(TRIM(b.prd_nm)) AS prd_nm,

    -- Map product line
    CASE
        WHEN UPPER(TRIM(b.prd_line)) = 'M' THEN 'Mountain'
        WHEN UPPER(TRIM(b.prd_line)) = 'R' THEN 'Road'
        WHEN UPPER(TRIM(b.prd_line)) = 'S' THEN 'Sport'
        WHEN UPPER(TRIM(b.prd_line)) = 'T' THEN 'Touring'
        ELSE NULL
    END AS prd_line,

    -- Clean start date
    CASE
        WHEN b.prd_start_dt IS NOT NULL AND b.prd_start_dt::TEXT ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN TO_DATE(b.prd_start_dt::TEXT, 'MM/DD/YYYY')
        ELSE NULL
    END AS prd_start_dt,

    -- Clean end date
    CASE
        WHEN b.prd_end_dt IS NOT NULL AND b.prd_end_dt::TEXT LIKE '197%' THEN NULL
        WHEN b.prd_end_dt IS NOT NULL AND b.prd_end_dt::TEXT ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN TO_DATE(b.prd_end_dt::TEXT, 'MM/DD/YYYY')
        ELSE NULL
    END AS prd_end_dt,

    -- Clean cost, default to 0
    COALESCE(b.prd_cost, 0) AS prd_cost,

    -- Metadata timestamp
    NOW() AS loaded_at

FROM bronze.crm_prd_info b;
