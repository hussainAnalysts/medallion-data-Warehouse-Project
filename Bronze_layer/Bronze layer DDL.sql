CREATE TABLE bronze.crm_cus_info (
    cst_id VARCHAR(50),
    cst_key VARCHAR(50),
    cst_firstname TEXT,
    cst_lastname TEXT,
    cst_marital_status VARCHAR(20),
    cst_gndr VARCHAR(10),
    cst_create_date DATE
);

CREATE TABLE bronze.crm_prd_info (
    prd_id VARCHAR(50),
    prd_key VARCHAR(50),
    prd_nm TEXT,
    prd_cost NUMERIC(12,2),
    prd_line TEXT,
    prd_start_dt DATE,
    prd_end_dt DATE
);

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num     VARCHAR(50),
    sls_prd_key     VARCHAR(50),
    sls_cust_id     VARCHAR(50),
    sls_order_dt    TEXT,
    sls_ship_dt     TEXT,
    sls_due_dt      TEXT,
    sls_sales       NUMERIC(12,2),
    sls_quantity    INT,
    sls_price       NUMERIC(12,2)
);

CREATE TABLE bronze.erp_cust_az12 (
    cid VARCHAR(50),
    bdate DATE,
    gen VARCHAR(10)
);

CREATE TABLE bronze.erp_loc_a101 (
    cid VARCHAR(50),
    cntry VARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id VARCHAR(50),
    cat TEXT,
    subcat TEXT,
    maintenance TEXT
);
