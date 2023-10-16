/*
 * VÝZKUMNÁ OTÁZKA Č. 5 - Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
 */

WITH czechia_GDP AS (
	SELECT
		t2.country,
		t2.`year`,
		t2.GDP
	FROM t_radomil_faksa_project_SQL_secondary_final t2
	WHERE t2.country = 'Czech Republic'
	ORDER BY t2.`year`
)
SELECT
	a.country,
	a.`year` AS year_A,
	a.GDP AS GDP_A,
	b.`year` AS year_B,
	b.GDP AS GDP_B,
	(b.GDP / (a.GDP / 100)) - 100 AS GDP_year_on_year_percentil_difference
FROM czechia_GDP a, czechia_GDP b
WHERE a.country = b.country
	AND a.`year` = b.`year` - 1
ORDER BY a.`year`;
-- výstupem je:
	-- růst 5.168724304130777 % z roku 2016 na 2017
	-- růst 3.19865610131437 % z roku 2017 na 2018

SELECT * -- přelom 2016/2017
FROM v_radomil_faksa_project_SQL v
WHERE v.year_A = 2016
ORDER BY v.price_percentil_difference DESC
; -- výstupem je růst až o cca 25 % (Máslo); oproti tomu naopak zachycen i pokles o cca 23 % (Mrkev)

SELECT * -- přelom 2017/2018
FROM v_radomil_faksa_project_SQL v
WHERE v.year_A = 2017
ORDER BY v.price_percentil_difference DESC
; -- výstupem je růst až o cca 33 % (Mrkev); oproti tomu naopak zachycen i pokles o cca 27 % (Cukr krystalový)



WITH average_payrolls AS ( -- mzdy období 2016/2017
SELECT
	t.`year`,
	t.industry_branch_name,
	t.average_payroll_CZK
FROM t_radomil_faksa_project_SQL_primary_final t
)
SELECT 
	a.industry_branch_name,
	a.`year` AS year_A,
	a.average_payroll_CZK AS average_payroll_CZK_A,
	b.`year` AS year_B,
	b.average_payroll_CZK AS average_payroll_CZK_B,
	((1 - (b.average_payroll_CZK/a.average_payroll_CZK)) * 100) AS year_on_year_payroll_increment
FROM average_payrolls a, average_payrolls b
WHERE 1=1
	AND a.industry_branch_name = b.industry_branch_name
	AND a.`year` = b.`year` + 1
	AND a.`year` = 2017
ORDER BY year_on_year_payroll_increment DESC
; 
-- největší růst "Ubytování, stravování a pohostinství" = cca 10 %
-- nejmenší růst "Peněžnictví a pojišťovnictví" = 4 %



WITH average_payrolls AS ( -- mzdy období 2017/2018
SELECT
	t.`year`,
	t.industry_branch_name,
	t.average_payroll_CZK
FROM t_radomil_faksa_project_SQL_primary_final t
)
SELECT 
	a.industry_branch_name,
	a.`year` AS year_A,
	a.average_payroll_CZK AS average_payroll_CZK_A,
	b.`year` AS year_B,
	b.average_payroll_CZK AS average_payroll_CZK_B,
	((1 - (b.average_payroll_CZK/a.average_payroll_CZK)) * 100) AS year_on_year_payroll_increment
FROM average_payrolls a, average_payrolls b
WHERE 1=1
	AND a.industry_branch_name = b.industry_branch_name
	AND a.`year` = b.`year` + 1
	AND a.`year` = 2018
ORDER BY year_on_year_payroll_increment DESC
; 
-- největší růst "Kulturní, zábavní a rekreační činnosti" = cca 10 %
-- nejmenší růst "Peněžnictví a pojišťovnictví" = cca 5 %
