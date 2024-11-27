--MS SQL SERVER

WITH COUNT_CHALLENGES AS
(SELECT HACKERS.HACKER_ID,
        NAME,
        COUNT(CHALLENGE_ID) AS CHALLENGES_CREATED
FROM CHALLENGES
INNER JOIN HACKERS
ON HACKERS.HACKER_ID = CHALLENGES.HACKER_ID
GROUP BY
HACKERS.HACKER_ID,
NAME),
 
COUNT_HACKERS AS
(SELECT CHALLENGES_CREATED,
        COUNT(CHALLENGES_CREATED) AS COUNT_CHALLENGES_CREATED
FROM COUNT_CHALLENGES
GROUP BY
CHALLENGES_CREATED)

SELECT HACKER_ID,
       NAME,
       COUNT_CHALLENGES.CHALLENGES_CREATED
FROM COUNT_CHALLENGES
INNER JOIN COUNT_HACKERS
ON COUNT_CHALLENGES.CHALLENGES_CREATED = COUNT_HACKERS.CHALLENGES_CREATED
WHERE
COUNT_CHALLENGES.CHALLENGES_CREATED = (SELECT MAX(COUNT_CHALLENGES.CHALLENGES_CREATED) FROM COUNT_CHALLENGES)
OR
COUNT_CHALLENGES_CREATED = 1
ORDER BY
COUNT_CHALLENGES.CHALLENGES_CREATED DESC,
HACKER_ID ASC
