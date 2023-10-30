/*
 * VÝZKUMNÁ OTÁZKA Č. 2 - Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 */

-- výpočet pro první období (2006)
WITH year_2006 AS (
	SELECT
		avg(a.average_payroll_CZK) AS avg_average_payroll,
		(SELECT
			b.average_price_CZK
		FROM t_radomil_faksa_project_SQL_primary_final b
		WHERE b.commodity_name LIKE '%mléko%'
			AND b.`year` = 2006) AS milk_price,
		(SELECT
			c.average_price_CZK
		FROM t_radomil_faksa_project_SQL_primary_final c
		WHERE c.commodity_name LIKE '%chléb%'
			AND c.`year` = 2006) AS bread_price
	FROM t_radomil_faksa_project_SQL_primary_final a
	WHERE a.`year` = 2006
)
SELECT
	(y.avg_average_payroll/y.milk_price) AS milk_liters,
	(y.avg_average_payroll/y.bread_price) AS bread_kilograms
FROM year_2006 y
;

-- výpočet pro poslední období (2018)
WITH year_2018 AS (
	SELECT
		avg(a.average_payroll_CZK) AS avg_average_payroll,
		(SELECT
			b.average_price_CZK
		FROM t_radomil_faksa_project_SQL_primary_final b
		WHERE b.commodity_name LIKE '%mléko%'
			AND b.`year` = 2018) AS milk_price,
		(SELECT
			c.average_price_CZK
		FROM t_radomil_faksa_project_SQL_primary_final c
		WHERE c.commodity_name LIKE '%chléb%'
			AND c.`year` = 2018) AS bread_price
	FROM t_radomil_faksa_project_SQL_primary_final a
	WHERE a.`year` = 2018
)
SELECT
	(y.avg_average_payroll/y.milk_price) AS milk_liters,
	(y.avg_average_payroll/y.bread_price) AS bread_kilograms
FROM year_2018 y
;