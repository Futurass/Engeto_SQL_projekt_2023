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
-- výstupem jsou meziroční procentuální rozdíly HDP ČR -> zpravidla většinou HDP roste, kromě období 2008/2009, 2011/2012 a 2012/2013, kdy klesl

/*
 * PŘEHLED CEN POTRAVIN PO ROCÍCH
 */																			

SELECT * -- SELECT pro sběr růstu/poklesu cen z jednotlivých roků
FROM v_radomil_faksa_project_SQL_prices v
WHERE v.year_A = 2006	-- uvést požadovaný rok dle potřeby (př.: 2006 je přelom 2016/2017)
ORDER BY v.price_percentil_difference DESC
;
-- VÝSTUP (největší růst/pokles v cenách):
--	2006/2007:	+ 49 % 	(Papriky) 						/ - 43 % (Rajská jablka červená kulatá)
--	2007/2008:	+ 30 % 	(Pšeničná mouka hladká) 		/ - 31 % (Konzumní brambory)
--	2008/2009:	+ 9 %	(Rýže loupaná dlouhozrnná)		/ - 40 % (Pečivo pšeničné bílé)
--	2009/2010:	+ 23 % 	(Konzumní brambory) 			/ - 16 % (Pečivo pšeničné bílé)
--	2010/2011:	+ 23 % 	(Pšeničná mouka hladká)			/ - 39 % (Rajská jablka červená kulatá)
--	2011/2012:	+ 35 % 	(Vejce slepičí čerstvá)			/ - 28 % (Konzumní brambory)
--	2012/2013:	+ 38 % 	(Konzumní brambory)				/ - 18 % (Vejce slepičí čerstvá)
--	2013/2014:	+ 10 % 	(Rajská jablka červená kulatá)	/ - 25 % (Konzumní brambory)
--	2014/2015:	+ 22 % 	(Mrkev) 						/ - 26 % (Eidamská cihla)
--	2015/2016:	+ 12 % 	(Konzumní brambory)				/ - 14 % (Pšeničná mouka hladká)
--	2016/2017:	+ 25 % 	(Máslo) 						/ - 23 % (Mrkev)
--	2017/2018:	+ 33 % 	(Mrkev) 						/ - 27 % (Cukr krystalový)


SELECT  -- SELECT pro zjištění průměrného procentuálního růstu za všechny potraviny	pro jednotlivé roky
	avg(v.price_percentil_difference) AS average_price_percentil_difference
FROM v_radomil_faksa_project_SQL_prices v
WHERE v.year_A = 2006	-- uvést požadovaný rok dle potřeby (př.: 2006 je přelom 2016/2017)
;
-- VÝSTUP (průměrný růst/pokles cen potravin):
--	2006/2007:	+ 6,03 %
--	2007/2008:	+ 6,62 %
--	2008/2009:	- 8,21 %
--	2009/2010:	+ 0,48 %
--	2010/2011:	+ 3,17 %
--	2011/2012:	+ 5,90 %
--	2012/2013:	+ 4,65 %
--	2013/2014:	- 1,14 %
--	2014/2015:	- 1,43 %
--	2015/2016:	- 1,72 %
--	2016/2017:	+ 5,75 %
--	2017/2018:	+ 1,45 %


/*
 * PŘEHLED MEZD PO ROCÍCH
 */


WITH average_payrolls AS ( -- SELECT pro sběr růstu/poklesu mezd z jednotlivých roků
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
	AND a.`year` = 2007		-- uvést požadovaný rok dle potřeby (př.: 2007 je přelom 2006/2007)
ORDER BY year_on_year_payroll_increment DESC
; 
-- VÝSTUP (největší/nejnižší růst mezd):
--	2006/2007:	+ 8,46 % 	(Zemědělství, lesnictví, rybářství)								/ + 5,08 % (Zásobování vodou; činnosti související s odpady a sanacemi)
--	2007/2008:	+ 12,1 % 	(Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu) 	/ + 0,40 % (Činnosti v oblasti nemovitostí)
--	2008/2009:	+ 10,22 %	(Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu)	/ - 3,22 % (Těžba a dobývání)
--	2009/2010:	+ 6,6 % 	(Ubytování, stravování a pohostinství) 							/ - 1,71 % (Vzdělávání)
--	2010/2011:	+ 4,5 % 	(Ostatní činnosti)												/ - 2,33 % (Veřejná správa a obrana; povinné sociální zabezpečení)
--	2011/2012:	+ 6,16 % 	(Peněžnictví a pojišťovnictví)									/ + 0,32 % (Stavebnictví)
--	2012/2013:	+ 3,48 % 	(Ubytování, stravování a pohostinství)							/ - 9,68 % (Peněžnictví a pojišťovnictví)
--	2013/2014:	+ 4,03 % 	(Peněžnictví a pojišťovnictví)									/ - 0,59 % (Těžba a dobývání)
--	2014/2015:	+ 5,88 % 	(Ubytování, stravování a pohostinství) 							/ - 1,59 % (Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu)
--	2015/2016:	+ 6,27 % 	(Kulturní, zábavní a rekreační činnosti)						/ - 0,58 % (Těžba a dobývání)
--	2016/2017:	+ 10,16 % 	(Ubytování, stravování a pohostinství) 							/ + 3,75 % (Peněžnictví a pojišťovnictví)
--	2017/2018:	+ 10,14 % 	(Kulturní, zábavní a rekreační činnosti)						/ + 5,15 % (Peněžnictví a pojišťovnictví)



CREATE VIEW IF NOT EXISTS v_radomil_faksa_project_SQL_payrolls AS 	-- vytvoření VIEW pro zjištění průměrných percentilů všech mezd
WITH average_payrolls AS (
	SELECT
		t.`year`,
		t.industry_branch_name,
		t.average_payroll_CZK
	FROM t_radomil_faksa_project_SQL_primary_final t
	WHERE t.industry_branch_name IS NOT NULL
	ORDER BY t.industry_branch_name, t.`year`
)
SELECT
	a.industry_branch_name,
	a.`year` AS year_A,
	a.average_payroll_CZK AS average_payroll_CZK_A,
	b.`year` AS year_B,
	b.average_payroll_CZK AS average_payroll_CZK_B,
	((1 - (a.average_payroll_CZK/b.average_payroll_CZK)) * 100) AS payroll_percentil_difference
FROM average_payrolls a, average_payrolls b
WHERE 1=1
	AND a.industry_branch_name = b.industry_branch_name
	AND a.`year` = b.`year` - 1
;

SELECT	-- SELECT pro zjištění průměrného procentuálního růstu všech mezd pro jednotlivé roky				
	avg(v.payroll_percentil_difference) AS average_payroll_percentil_per_year
FROM v_radomil_faksa_project_sql_payrolls v
WHERE v.year_A = 2006	-- uvést požadovaný rok dle potřeby (př.: 2006 je přelom 2006/2007)
ORDER BY v.payroll_percentil_difference DESC
;

-- VÝSTUP (průměrný růst/pokles mezd):
--	2006/2007:	+ 6,45 %
--	2007/2008:	+ 6,48 %
--	2008/2009:	+ 2,66 %
--	2009/2010:	+ 2,06 %
--	2010/2011:	+ 2,23 %
--	2011/2012:	+ 2,52 %
--	2012/2013:	- 0,87 %
--	2013/2014:	+ 2,47 %
--	2014/2015:	+ 2,79 %
--	2015/2016:	+ 3,76 %
--	2016/2017:	+ 5,99 %
--	2017/2018:	+ 7,28 %
