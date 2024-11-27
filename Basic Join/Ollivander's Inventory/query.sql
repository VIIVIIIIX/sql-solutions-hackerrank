SELECT ID,
       AGE,
       COINS_NEEDED,
       POWER
FROM WANDS
INNER JOIN WANDS_PROPERTY
ON WANDS_PROPERTY.CODE = WANDS.CODE
WHERE
IS_EVIL = 0
AND
COINS_NEEDED = (SELECT MIN(COINS_NEEDED)
                FROM WANDS W
                INNER JOIN WANDS_PROPERTY AS WP
                ON WP.CODE = W.CODE
                WHERE
                W.POWER=WANDS.POWER
                AND
                WP.AGE = WANDS_PROPERTY.AGE)
ORDER BY
POWER DESC,
AGE DESC
