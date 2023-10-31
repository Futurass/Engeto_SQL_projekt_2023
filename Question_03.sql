/*
 * VÝZKUMNÁ OTÁZKA Č. 3 - Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 */

CREATE VIEW IF NOT EXISTS v_radomil_faksa_project_SQL_prices AS 
WITH commodity_prices AS (
	SELECT
		t.`year`,
		t.commodity_name,
		t.average_price_CZK
	FROM t_radomil_faksa_project_SQL_primary_final t
	WHERE t.commodity_name IS NOT NULL
	ORDER BY t.commodity_name, t.`year`
)
SELECT
	a.commodity_name,
	a.`year` AS year_A,
	a.average_price_CZK AS average_price_CZK_A,
	b.`year` AS year_B,
	b.average_price_CZK AS average_price_CZK_B,
	((1 - (a.average_price_CZK/b.average_price_CZK)) * 100) AS price_percentil_difference
FROM commodity_prices a, commodity_prices b
WHERE 1=1
	AND a.commodity_name = b.commodity_name
	AND a.`year` = b.`year` - 1
;

SELECT -- SELECT pro celkový procentuální rozdíl cen za pozorované období 2006 - 2018
	v.commodity_name,
	sum(v.price_percentil_difference) AS price_percentil_difference_between_2006_2018
FROM v_radomil_faksa_project_SQL_prices v
GROUP BY v.commodity_name
ORDER BY price_percentil_difference_between_2006_2018
;


SELECT -- SELECT pro meziroční percentil za jeden rok
	v.commodity_name,
	sum(v.price_percentil_difference) AS price_percentil_difference_per_year
FROM v_radomil_faksa_project_SQL_prices v
WHERE 1=1
	AND v.year_A = 2006 -- uvést požadovaný rok (příklad: s uvedením roku 2006 se porovnává rozdíl oproti roku 2007)
GROUP BY v.commodity_name
ORDER BY price_percentil_difference_per_year
;