INSERT INTO silver.crm_prd_info (
    prd_key,
    prd_cat_key,
    prd_id,
    prd_nm,
    prd_line,
    prd_start_dt,
    prd_end_dt,
    prd_cost
)
SELECT 
    prd_key,

    -- PRODUCT CATEGORY KEY (first two segments -> CO_RF)
    split_part(prd_key, '-', 1) || '_' || split_part(prd_key, '-', 2) AS prd_cat_key,

    -- PRODUCT ID (remaining segments -> FR_R92B_58)
    split_part(prd_key, '-', 3) || '_' || split_part(prd_key, '-', 4) || '_' || split_part(prd_key, '-', 5) AS prd_id,

    -- CLEANED PRODUCT NAME
    INITCAP(REGEXP_REPLACE(TRIM(prd_nm), '\s+', ' ', 'g')) AS prd_nm,

    -- PRODUCT LINE (clean + map)
    CASE 
        WHEN REGEXP_REPLACE(UPPER(TRIM(prd_line)), '[^A-Z]', '', 'g') = 'M' THEN 'Mountain'
        WHEN REGEXP_REPLACE(UPPER(TRIM(prd_line)), '[^A-Z]', '', 'g') = 'R' THEN 'Road'
        WHEN REGEXP_REPLACE(UPPER(TRIM(prd_line)), '[^A-Z]', '', 'g') = 'S' THEN 'Sport'
        WHEN REGEXP_REPLACE(UPPER(TRIM(prd_line)), '[^A-Z]', '', 'g') = 'T' THEN 'Touring'
        ELSE 'Unknown'
    END AS prd_line,

    -- CLEAN START DATE (try to cast to date, else NULL)
    CASE 
        WHEN prd_start_dt IS NOT NULL THEN prd_start_dt::DATE
        ELSE NULL 
    END AS prd_start_dt,

    -- CLEAN END DATE (treat obviously wrong values like 197 as NULL)
    CASE 
        WHEN prd_end_dt IS NOT NULL AND LENGTH(prd_end_dt::TEXT) >= 8
            THEN prd_end_dt::DATE
        ELSE NULL
    END AS prd_end_dt,

    -- REPLACE NULL COST WITH 0
    COALESCE(prd_cost, 0) AS prd_cost

FROM bronze.crm_prd_info;
