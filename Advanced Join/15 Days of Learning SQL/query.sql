--MS SQL SERVER


-- PART 1

WITH A AS
(
SELECT ROW_NUMBER() OVER(PARTITION BY SUBMISSION_DATE ORDER BY COUNT(SUBMISSIONS.HACKER_ID) DESC, SUBMISSIONS.HACKER_ID ASC) AS ROW_NUM,
       SUBMISSION_DATE,
       COUNT(SUBMISSIONS.HACKER_ID) AS CNT,
       SUBMISSIONS.HACKER_ID,
       NAME
FROM SUBMISSIONS
INNER JOIN HACKERS
ON HACKERS.HACKER_ID = SUBMISSIONS.HACKER_ID
GROUP BY SUBMISSION_DATE,
         SUBMISSIONS.HACKER_ID,
         HACKERS.NAME
)

SELECT SUBMISSIONS.SUBMISSION_DATE,
       COUNT(DISTINCT SUBMISSIONS.HACKER_ID),
       A.HACKER_ID,
       A.NAME
FROM SUBMISSIONS
INNER JOIN A
ON A.SUBMISSION_DATE = SUBMISSIONS.SUBMISSION_DATE
AND ROW_NUM = 1
GROUP BY SUBMISSIONS.SUBMISSION_DATE,
         A.HACKER_ID,
         A.NAME
ORDER BY SUBMISSIONS.SUBMISSION_DATE


-- PART 2
DECLARE @CONSISTENT_HACKERS TABLE
(
    HACKER_ID INT,
    SUBMISSION_DATE DATE
);

INSERT INTO @CONSISTENT_HACKERS
SELECT HACKER_ID,
       SUBMISSION_DATE
FROM SUBMISSIONS
WHERE SUBMISSION_DATE LIKE "2016-03-01"

DECLARE @SUBMISSION_DATE DATE;
DECLARE @REMAINING_DATE DATE;

SET @SUBMISSION_DATE = "2016-03-01";
SET @REMAINING_DATE = "2016-03-01";

WHILE @SUBMISSION_DATE < "2016-03-15"
BEGIN

SET @SUBMISSION_DATE = DATEADD(DAY, 1, @SUBMISSION_DATE);
    
INSERT INTO @CONSISTENT_HACKERS
SELECT S.HACKER_ID,
       S.SUBMISSION_DATE
FROM SUBMISSIONS S
JOIN @CONSISTENT_HACKERS CH ON
CH.HACKER_ID = S.HACKER_ID
AND
CH.SUBMISSION_DATE LIKE @REMAINING_DATE
WHERE S.SUBMISSION_DATE LIKE @SUBMISSION_DATE

SET @REMAINING_DATE = DATEADD(DAY, 1, @REMAINING_DATE);
END

DECLARE @COUNT_HACKERS TABLE
(
    SUBMISSION_DATE DATE,
    HACKER_ID INT
    
)

INSERT INTO @COUNT_HACKERS
SELECT SUBMISSION_DATE,
       COUNT(DISTINCT HACKER_ID)
FROM @CONSISTENT_HACKERS
GROUP BY SUBMISSION_DATE

SELECT * FROM @COUNT_HACKERS


-- FULL SOLUTION

DECLARE @CONSISTENT_HACKERS TABLE
(
    HACKER_ID INT,
    SUBMISSION_DATE DATE
);

INSERT INTO @CONSISTENT_HACKERS
SELECT HACKER_ID,
       SUBMISSION_DATE
FROM SUBMISSIONS
WHERE SUBMISSION_DATE LIKE "2016-03-01";

DECLARE @SUBMISSION_DATE DATE;
DECLARE @REMAINING_DATE DATE;

SET @SUBMISSION_DATE = "2016-03-01";
SET @REMAINING_DATE = "2016-03-01";

WHILE @SUBMISSION_DATE < "2016-03-15"
BEGIN

SET @SUBMISSION_DATE = DATEADD(DAY, 1, @SUBMISSION_DATE);
    
INSERT INTO @CONSISTENT_HACKERS
SELECT S.HACKER_ID,
       S.SUBMISSION_DATE
FROM SUBMISSIONS S
JOIN @CONSISTENT_HACKERS CH ON
CH.HACKER_ID = S.HACKER_ID
AND
CH.SUBMISSION_DATE LIKE @REMAINING_DATE
WHERE S.SUBMISSION_DATE LIKE @SUBMISSION_DATE;

SET @REMAINING_DATE = DATEADD(DAY, 1, @REMAINING_DATE);
END

DECLARE @COUNT_HACKERS TABLE
(
    SUBMISSION_DATE DATE,
    HACKER_ID INT
    
);

INSERT INTO @COUNT_HACKERS
SELECT SUBMISSION_DATE,
       COUNT(DISTINCT HACKER_ID)
FROM @CONSISTENT_HACKERS
GROUP BY SUBMISSION_DATE;


WITH A AS
(
SELECT ROW_NUMBER() OVER(PARTITION BY SUBMISSION_DATE ORDER BY COUNT(SUBMISSIONS.HACKER_ID) DESC, SUBMISSIONS.HACKER_ID ASC) AS ROW_NUM,
       SUBMISSION_DATE,
       COUNT(SUBMISSIONS.HACKER_ID) AS CNT,
       SUBMISSIONS.HACKER_ID,
       NAME
FROM SUBMISSIONS
INNER JOIN HACKERS
ON HACKERS.HACKER_ID = SUBMISSIONS.HACKER_ID
GROUP BY SUBMISSION_DATE,
         SUBMISSIONS.HACKER_ID,
         HACKERS.NAME
)

SELECT SUBMISSIONS.SUBMISSION_DATE,
       CH.HACKER_ID,
       A.HACKER_ID,
       A.NAME
FROM SUBMISSIONS
INNER JOIN A
ON A.SUBMISSION_DATE = SUBMISSIONS.SUBMISSION_DATE
AND ROW_NUM = 1
INNER JOIN @COUNT_HACKERS AS CH
ON CH.SUBMISSION_DATE = SUBMISSIONS.SUBMISSION_DATE
GROUP BY SUBMISSIONS.SUBMISSION_DATE, CH.HACKER_ID, A.HACKER_ID, A.NAME
ORDER BY SUBMISSIONS.SUBMISSION_DATE;