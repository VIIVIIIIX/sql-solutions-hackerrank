--MS SQL SERVER

DECLARE @VAR INT
SET @VAR = 1

WHILE @VAR <= 20
    BEGIN
    PRINT(REPLICATE("* ", @VAR)) -- The REPLICATE() function repeats a string a specified number of times.
    SET @VAR = @VAR + 1
    END
