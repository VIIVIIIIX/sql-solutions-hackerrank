-- MS SQL SERVER

SELECT CAST(SUM(LAT_N) AS DECIMAL(10, 2)),
       CAST(SUM(LONG_W) AS DECIMAL(10, 2))
FROM STATION
