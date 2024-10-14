--MS SQL SERVER

SELECT DISTINCT E.COMPANY_CODE,
       C.FOUNDER,
       COUNT(DISTINCT E.LEAD_MANAGER_CODE),
       COUNT(DISTINCT E.SENIOR_MANAGER_CODE),
       COUNT(DISTINCT E.MANAGER_CODE),
       COUNT(DISTINCT E.EMPLOYEE_CODE)
FROM EMPLOYEE E
INNER JOIN COMPANY C
ON C.COMPANY_CODE = E.COMPANY_CODE
GROUP BY E.COMPANY_CODE,
         C.FOUNDER
ORDER BY E.COMPANY_CODE ASC