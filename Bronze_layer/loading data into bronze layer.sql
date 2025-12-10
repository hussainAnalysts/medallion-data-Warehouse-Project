-- CRM tables
\copy bronze.crm_cus_info       FROM 'C:\Users\user\Desktop\#\portfolio projects\SQL\Data Warehouse\datasets\source_crm\cust_info.csv'       DELIMITER ',' CSV HEADER;
\copy bronze.crm_prd_info       FROM 'C:\Users\user\Desktop\#\portfolio projects\SQL\Data Warehouse\datasets\source_crm\prd_info.csv'       DELIMITER ',' CSV HEADER;
\copy bronze.crm_sales_details  FROM 'C:\Users\user\Desktop\#\portfolio projects\SQL\Data Warehouse\datasets\source_crm\sales_details.csv'


-- ERP tables
\copy bronze.erp_cust_az12      FROM 'C:\Users\user\Desktop\#\portfolio projects\SQL\Data Warehouse\datasets\source_erp\CUST_AZ12.CSV'      DELIMITER ',' CSV HEADER;
\copy bronze.erp_loc_a101       FROM 'C:\Users\user\Desktop\#\portfolio projects\SQL\Data Warehouse\datasets\source_erp\LOC_A101.CSV'       DELIMITER ',' CSV HEADER;
\copy bronze.erp_px_cat_g1v2    FROM 'C:\Users\user\Desktop\#\portfolio projects\SQL\Data Warehouse\datasets\source_erp\PX_CAT_G1V2.CSV'    DELIMITER ',' CSV HEADER; DELIMITER ',' CSV HEADER;



