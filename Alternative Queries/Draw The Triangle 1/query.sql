--MS SQL SERVER

DECLARE @VAR INT;
SET @VAR = 20;
WHILE @VAR > 0
    BEGIN
    PRINT(REPLICATE("* ", @VAR)); -- The REPLICATE() function repeats a string a specified number of times.
    SET @VAR = @VAR - 1;
    END
