INSERT INTO silver.erp_cust_az12 (
			cid,
			bdate,
			gen,
			loaded_at

)

SELECT 
	CASE 
		WHEN TRIM(UPPER(cid)) LIKE 'NAS%' THEN SUBSTRING(cid,4)
		ELSE cid
		END  as cid,
    CASE 
        WHEN bdate IS NULL THEN NULL
        WHEN bdate > CURRENT_DATE THEN NULL  -- claning  future dates
        WHEN bdate < '1900-01-01'::DATE THEN NULL  -- cleaning too old dates
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, bdate)) > 120 THEN NULL  -- claaning too old age
        ELSE bdate
    	END AS bdate,
    CASE 
        WHEN UPPER(TRIM(COALESCE(gen, ''))) IN ('M', 'MALE')           THEN 'Male'
        WHEN UPPER(TRIM(COALESCE(gen, ''))) IN ('F', 'FEMALE')         THEN 'Female'
        WHEN TRIM(COALESCE(gen, '')) = '' OR gen IS NULL               THEN 'N/A'
        ELSE UPPER(TRIM(gen))                                          -- fallback: keep original if unexpected
   	 	END AS gen,
		CURRENT_TIMESTAMP AS loaded_at
FROM bronze.erp_cust_az12;
