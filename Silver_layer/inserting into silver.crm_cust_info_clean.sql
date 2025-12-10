-- CreatIing the Silver Table.crm_cus_info_clean
CREATE TABLE silver.crm_cus_info_clean (
    customer_id          VARCHAR(50),
    customer_key         VARCHAR(50),
    first_name           TEXT,
    last_name            TEXT,
    full_name            TEXT,
    gender_status        VARCHAR(10),
    marital_status       VARCHAR(10),
    create_date          DATE,
    record_loaded_dt     TIMESTAMP DEFAULT NOW()
);
-- inserting into the silver Table.crm_cus_info_clean

INSERT INTO silver.crm_cus_info_clean (
    customer_id,
    customer_key,
    first_name,
    last_name,
    full_name,
    gender_status,
    marital_status,
    create_date
)
SELECT
    cst_id AS customer_id,
    cst_key AS customer_key,
    INITCAP(TRIM(cst_firstname)) AS first_name,
    INITCAP(TRIM(cst_lastname)) AS last_name,
    INITCAP(CONCAT(TRIM(cst_firstname), ' ', TRIM(cst_lastname))) AS full_name,

-- Gender transformation
    CASE 
        WHEN LOWER(cst_gndr) = 'm' THEN 'Male'
        WHEN LOWER(cst_gndr) = 'f' THEN 'Female'
        ELSE 'N/A'
    END AS gender_status,

-- Marital status transformation
    CASE 
        WHEN UPPER(cst_marital_status) = 'M' THEN 'Married'
        WHEN UPPER(cst_marital_status) = 'S' THEN 'Single'
        ELSE 'N/A'
    END AS marital_status,

    CAST(cst_create_date AS DATE) AS create_date
-- droping duplictes based on cst_id 
FROM (
    SELECT DISTINCT ON (cst_id) *
    FROM bronze.crm_cus_info
    WHERE cst_id IS NOT NULL
    ORDER BY cst_id, cst_create_date DESC
) AS deduped;
