/*
 * VYTVOŘENÍ POMOCNÉ TABULKY -> pro dodatečná data o dalších evropských státech
 */

CREATE TABLE IF NOT EXISTS t_radomil_faksa_project_SQL_secondary_final AS
	SELECT
		e.*,
		c.abbreviation,
		c.avg_height,
		c.calling_code,
		c.capital_city,
		c.continent,
		c.currency_name,
		c.religion,
		c.currency_code,
		c.domain_tld,
		c.elevation,
		c.north,
		c.south,
		c.west,
		c.east,
		c.government_type,
		c.independence_date,
		c.iso_numeric,
		c.landlocked,
		c.national_symbol,
		c.national_dish,
		c.region_in_world,
		c.surface_area,
		c.median_age_2018,
		c.iso2,
		c.iso3
	FROM economies e
	LEFT JOIN countries c ON c.country = e.country
	WHERE 1=1
		AND e.year IN (2016, 2017, 2018)
;
