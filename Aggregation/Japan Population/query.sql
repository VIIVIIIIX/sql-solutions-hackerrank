--MS SQL SERVER

SELECT SUM(POPULATION) AS TOTAL_POPULATION_JPN
FROM CITY
WHERE COUNTRYCODE LIKE "JPN"
