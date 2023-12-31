/*
 * VYTVOŘENÍ tabulky MEZD a CEN -> pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky
 */

CREATE TABLE IF NOT EXISTS t_radomil_faksa_project_SQL_primary_final AS
	SELECT
		cp.payroll_year AS 'year',
		cp.industry_branch_code,
		cpib.name AS industry_branch_name,
		AVG(cp.value) AS average_payroll_CZK
	FROM czechia_payroll cp
	LEFT JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
	WHERE 1=1
		AND cp.value IS NOT NULL
		AND cp.industry_branch_code IS NOT NULL
		AND cp.payroll_year IN (2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018)
		AND cp.value_type_code = 5958
		AND cp.calculation_code = 200
	GROUP BY cp.industry_branch_code, cp.payroll_year
;

ALTER TABLE	t_radomil_faksa_project_SQL_primary_final ADD COLUMN commodity_name VARCHAR(255);
ALTER TABLE	t_radomil_faksa_project_SQL_primary_final ADD COLUMN average_price_CZK DECIMAL(14, 4);
ALTER TABLE	t_radomil_faksa_project_SQL_primary_final ADD COLUMN unit_value DOUBLE;
ALTER TABLE	t_radomil_faksa_project_SQL_primary_final ADD COLUMN unit VARCHAR(2);
ALTER TABLE	t_radomil_faksa_project_SQL_primary_final ALTER COLUMN industry_branch_name SET DEFAULT NULL;

INSERT INTO t_radomil_faksa_project_SQL_primary_final (year, commodity_name, average_price_CZK, unit_value, unit)
	SELECT
		YEAR(cp2.date_from) AS 'year',
		cpc.name AS commodity_name,
		AVG(cp2.value) AS average_price_CZK,
		cpc.price_value AS price_value,
		cpc.price_unit AS price_unit
	FROM czechia_price cp2
	LEFT JOIN czechia_price_category cpc ON cp2.category_code = cpc.code
	WHERE 1=1
		AND YEAR(cp2.date_from) IN (2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018)
		AND YEAR(cp2.date_from) = YEAR(cp2.date_to)
	GROUP BY cpc.name, YEAR(cp2.date_from) 
;