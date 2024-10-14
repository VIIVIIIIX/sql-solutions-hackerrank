--MS SQL SERVER

SELECT ID,
       AGE,
       COINS_NEEDED,
       POWER
FROM WANDS W
INNER JOIN WANDS_PROPERTY WP
ON WP.CODE = W.CODE
WHERE IS_EVIL = 0
AND
COINS_NEEDED = (SELECT MIN(COINS_NEEDED)
                FROM WANDS X
                INNER JOIN WANDS_PROPERTY Y
                ON X.CODE = Y.CODE
                WHERE X.POWER = W.POWER
                AND Y.AGE = WP.AGE)
ORDER BY POWER DESC,
         AGE DESC