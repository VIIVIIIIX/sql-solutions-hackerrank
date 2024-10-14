--MS SQL SERVER

SELECT CAST(
            (MAX(LONG_W) - MIN(LONG_W)) +
            (MAX(LAT_N) - MIN(LAT_N))
            AS DECIMAL(10, 4)
           )
FROM STATION
