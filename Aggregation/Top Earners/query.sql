--MS SQL SERVER

SELECT MAX(MONTHS * SALARY),
       COUNT(MONTHS * SALARY)
FROM EMPLOYEE
WHERE
MONTHS * SALARY = (SELECT MAX(MONTHS * SALARY) FROM EMPLOYEE)
