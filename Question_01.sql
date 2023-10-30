/*
 * VÝZKUMNÁ OTÁZKA Č. 1 - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 */


WITH average_payroll_CZK AS (
	SELECT
		t.`year`,
		t.industry_branch_name,
		t.average_payroll_CZK
	FROM t_radomil_faksa_project_SQL_primary_final t 
)
SELECT
	*,
	CASE
		WHEN cur.average_payroll_CZK > prev.average_payroll_CZK THEN 1
		ELSE 0
	END AS payroll_growth
FROM average_payroll_CZK cur, average_payroll_CZK prev
WHERE 1=1
	AND cur.industry_branch_name = prev.industry_branch_name
	AND cur.`year` = prev.`year` + 1
ORDER BY payroll_growth
;
