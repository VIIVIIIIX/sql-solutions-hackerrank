-- MS SQL SERVER

SELECT TOP 1 CITY,
       LEN(CITY)
FROM STATION
ORDER BY
LEN(CITY) ASC,
CITY ASC;
         
SELECT TOP 1 CITY,
       LEN(CITY)
FROM STATION
ORDER BY
LEN(CITY) DESC,
CITY DESC;
