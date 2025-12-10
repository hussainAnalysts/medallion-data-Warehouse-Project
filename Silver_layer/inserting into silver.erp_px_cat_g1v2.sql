INSERT INTO silver.erp_px_cat_g1v2(

	id,
	cat,
	subcat,
	maintenance,
	loaded_at
)

SELECT
	id,
	cat,
	subcat,
	maintenance,
	CURRENT_DATE AS loaded_at
FROM bronze.erp_px_cat_g1v2;
