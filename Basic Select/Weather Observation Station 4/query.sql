--MS SQL SERVER

SELECT COUNT(CITY) - COUNT(DISTINCT CITY) AS UNIQUE_CITIES
FROM STATION
