INSERT INTO silver.erp_loc_a101 (

		cid,
		cntry,
		loaded_at 

)

SELECT 
	REPLACE(cid, '-', '') AS cid -- Data standardation,
    CASE 
        WHEN UPPER(TRIM(cntry)) IN ('US', 'USA') THEN 'United States'  -- Fixed your typo 'sates' -> 'States'
        WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
		WHEN UPPER(TRIM(cntry)) IS NULL THEN 'N/A'
		WHEN (TRIM(cntry))= '' THEN 'N/A'
        ELSE INITCAP(TRIM(cntry))  -- Title case for all others (e.g., 'france' -> 'France')
    	END as cnty,
		CURRENT_DATE AS loaded_at
	FROM bronze.erp_loc_a101

 