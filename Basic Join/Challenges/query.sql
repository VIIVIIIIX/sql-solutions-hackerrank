--MS SQL SERVER

WITH COUNT_CHALLENGES AS
(
    SELECT HACKERS.HACKER_ID,
           HACKERS.NAME,
           COUNT(CHALLENGES.CHALLENGE_ID) AS CNT
    FROM CHALLENGES
    INNER JOIN HACKERS
    ON HACKERS.HACKER_ID = CHALLENGES.HACKER_ID
    GROUP BY HACKERS.HACKER_ID,
             HACKERS.NAME
),

COUNT_HACKERS AS
(
    SELECT CNT,
           COUNT(CNT) AS CCNT
    FROM COUNT_CHALLENGES
    GROUP BY CNT
)

SELECT COUNT_CHALLENGES.HACKER_ID,
       COUNT_CHALLENGES.NAME,
       COUNT_CHALLENGES.CNT
FROM COUNT_CHALLENGES
INNER JOIN COUNT_HACKERS
ON COUNT_HACKERS.CNT = COUNT_CHALLENGES.CNT
WHERE COUNT_HACKERS.CCNT = 1
OR
COUNT_CHALLENGES.CNT = (SELECT MAX(CNT) FROM COUNT_CHALLENGES)
ORDER BY COUNT_CHALLENGES.CNT DESC,
         COUNT_CHALLENGES.HACKER_ID ASC
