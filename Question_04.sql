/*
 * VÝZKUMNÁ OTÁZKA Č. 4 - Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 */

-- meziroční procentuální růst potravin o více jak 10% (využití view z otázky č.3)

SELECT *
FROM v_radomil_faksa_project_SQL v
WHERE v.price_percentil_difference > 10
ORDER BY v.price_percentil_difference DESC
;


-- ověření mezd s meziročním růstem větším jak 10%
WITH average_payrolls AS (
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
	AND ((1 - (b.average_payroll_CZK/a.average_payroll_CZK)) * 100) > 10
	AND a.industry_branch_name = b.industry_branch_name
	AND a.`year` = b.`year` + 1
ORDER BY year_on_year_payroll_increment DESC
;