--MS SQL SERVER

CREATE TABLE PRIMES(NUMBERS INT)

DECLARE @NUM INT
SET @NUM = 2

DECLARE @IS_PRIME BIT

DECLARE @DIV INT

WHILE @NUM <= 1000
    BEGIN
    SET @IS_PRIME = 1
    SET @DIV = @NUM - 1
    WHILE @DIV > 1
        BEGIN
        IF @NUM % @DIV = 0
            SET @IS_PRIME = 0
        SET @DIV = @DIV - 1
        END
    IF @IS_PRIME = 1
        INSERT INTO PRIMES(NUMBERS) VALUES(@NUM)
    SET @NUM = @NUM + 1
    END

SELECT STRING_AGG(NUMBERS, "&") FROM PRIMES
