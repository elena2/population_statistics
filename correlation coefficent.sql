-- The query below examines the relationship between life expectancy and fertility rate, in 2010 and 2015. 
-- The results show r < -0.90 for both 2010 and 2015, suggesting that as life expectancy increases, fertility rate decreases (and visa versa). 

WITH old AS(
SELECT  co.continent, 
p.year, 
AVG(p.fertility_rate) AS avg_fertility2010,
AVG(p.life_expectancy) AS avg_exp2010
FROM countries AS co
LEFT JOIN populations AS p
ON co.code = p.country_code
WHERE p.year = 2010
GROUP BY co.continent, p.year
),

new AS(
SELECT  co.continent,
p.year, 
AVG(p.fertility_rate) AS avg_fertility2015,
AVG(p.life_expectancy) AS avg_exp2015
FROM countries AS co
LEFT JOIN populations AS p
ON co.code = p.country_code
WHERE p.year = 2015
GROUP BY co.continent, p.year)


SELECT
corr("FERT_RATE_2010", "LIFE_EXP_2010") AS "Correlation_2010",
corr("FERT_RATE_2015", "LIFE_EXP_2015") AS "Correlation_2015"

FROM(

SELECT 
 o.avg_fertility2010 AS "FERT_RATE_2010" , o.avg_exp2010 AS "LIFE_EXP_2010",
  n.avg_fertility2015 AS "FERT_RATE_2015" , n.avg_exp2015 AS "LIFE_EXP_2015"
FROM new AS n
INNER JOIN old AS o
ON n.continent = o.continent

) as Correlation
