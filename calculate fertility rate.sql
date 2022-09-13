-- calculate the change in fertility rate by continent, from 2010 to 2015

WITH fert_rate2010 AS(
SELECT  co.continent, 
p.year, 
AVG(p.fertility_rate) AS avg_fertility2010
FROM countries AS co
LEFT JOIN populations AS p
ON co.code = p.country_code
WHERE p.year = 2010
GROUP BY co.continent, p.year),

fert_rate2015 AS(
SELECT  co.continent, 
p.year, 
AVG(p.fertility_rate) AS avg_fertility2015
FROM countries AS co
LEFT JOIN populations AS p
ON co.code = p.country_code
WHERE p.year = 2015
GROUP BY co.continent, p.year)

SELECT fert_rate2010.continent,
 ((avg_fertility2015 - avg_fertility2010)/avg_fertility2010) AS perc_dif
FROM fert_rate2010
INNER JOIN fert_rate2015
ON fert_rate2010.continent = fert_rate2015.continent
ORDER BY perc_dif
