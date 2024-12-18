--MS SQL SERVER

WITH COMBINED_HACKER_SUBMISSIONS AS
(SELECT SUBMISSIONS.HACKER_ID AS HACKER_ID,
        NAME,
        CHALLENGE_ID,
        MAX(SCORE) AS SCORE
FROM SUBMISSIONS
INNER JOIN HACKERS
ON HACKERS.HACKER_ID = SUBMISSIONS.HACKER_ID
GROUP BY
SUBMISSIONS.HACKER_ID,
NAME,
CHALLENGE_ID)

SELECT HACKER_ID,
       NAME,
       SUM(SCORE)
FROM COMBINED_HACKER_SUBMISSIONS
GROUP BY
HACKER_ID,
NAME
HAVING SUM(SCORE) > 0
ORDER BY
SUM(SCORE) DESC,
HACKER_ID ASC
