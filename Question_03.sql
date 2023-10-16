/*
 * VÝZKUMNÁ OTÁZKA Č. 3 - Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 */

CREATE VIEW IF NOT EXISTS v_radomil_faksa_project_SQL AS 
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

SELECT -- SELECT za pozorované období 2016 - 2018
	v.commodity_name,
	sum(v.price_percentil_difference) AS price_percentil_difference_between_2016_2018
FROM v_radomil_faksa_project_SQL v
GROUP BY v.commodity_name
ORDER BY price_percentil_difference_between_2016_2018
;


SELECT -- SELECT za pozorované období 2016 - 2017
	v.commodity_name,
	sum(v.price_percentil_difference) AS price_percentil_difference_between_2016_2017
FROM v_radomil_faksa_project_SQL v
WHERE 1=1
	AND v.year_A = 2016
GROUP BY v.commodity_name
ORDER BY price_percentil_difference_between_2016_2017
;

SELECT -- SELECT za pozorované období 2017 - 2018
	v.commodity_name,
	sum(v.price_percentil_difference) AS price_percentil_difference_between_2017_2018
FROM v_radomil_faksa_project_SQL v
WHERE 1=1
	AND v.year_A = 2017
GROUP BY v.commodity_name
ORDER BY price_percentil_difference_between_2017_2018
;