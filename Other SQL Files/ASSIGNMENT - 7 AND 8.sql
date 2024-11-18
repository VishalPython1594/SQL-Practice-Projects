-------------------------------------------- ASSIGNMENT 7 -----------------------------------------------

USE TEST;

SELECT DEPT, COUNT(EID) AS 'TEAM SIZE', AVG(SALARY) AS 'AVERAGE SALARY'
FROM EMPSC
GROUP BY DEPT;

------------------------------------------------------------

SELECT COUNT(EID) FROM EMPSC
WHERE DESI LIKE '%MANAGER%';

-------------------------------------------------------------

SELECT MAX(SALARY) AS 'MAXIMUM SALARY', MIN(SALARY) 'MINIMUM SALARY' FROM EMPSC;

-------------------------------------------------------------
SELECT DEPT, COUNT(EMPSC.EID) AS 'TEAM SIZE', AVG(SALARY) AS 'AVERAGE SALARY'
FROM EMPC
INNER JOIN EMPSC
ON EMPC.EID = EMPSC.EID
WHERE EMPC.CITY = 'DELHI'
GROUP BY DEPT;

------------------------------------------------------------------------

CREATE FUNCTION CORPMAIL_1(@I AS CHAR(4), @N AS VARCHAR(20))
RETURNS VARCHAR(30)
AS
BEGIN
	DECLARE @L AS INT;
	DECLARE @C AS INT;
	DECLARE @LN AS VARCHAR(20);
	DECLARE @EM AS VARCHAR(30);

	SET @L = LEN(@N);
	SET @C = CHARINDEX(' ', @N);
	SET @LN = RIGHT(@N, @L - @C);
	
	SET @EM = UPPER(CONCAT(LEFT(@N,1), '.',LEFT(@LN, 1), RIGHT(@I, 3), 'RCG.COM'))
	 
	RETURN @EM

END;

SELECT DBO.CORPMAIL_1(EID, NAME) FROM EMPC;

SELECT NAME, EID FROM EMPC;

-------------------------------------------------------------------------------

SELECT NAME, CITY, PHONE, EMAIL
FROM EMPC 
WHERE DATEDIFF(YY, DOB, GETDATE())>=40;

-----------------------------------------------------------------------------

SELECT EID, NAME, DOJ
FROM EMPC
WHERE DATEDIFF(YY, DOJ, GETDATE())>=5;

-----------------------------------------------------------------------------

SELECT EMPC.EID, NAME, ADDR1, ADDR2, CITY, PHONE, EMAIL, DOB, DOJ, DEPT,DESI, SALARY 
FROM EMPC
INNER JOIN EMPSC
ON EMPC.EID = EMPSC.EID
WHERE MONTH(DOB) = MONTH(GETDATE()) AND DESI LIKE '%MANAGER%';


----------------------------------------------------------------------------------

SELECT MAX(SALARY) FROM EMPSC;
SELECT * FROM EMPSC
WHERE SALARY = 598748;

----------------------------------------------------------------------

SELECT MAX(LEN(NAME)) FROM EMPC;

SELECT EID, NAME FROM EMPC
WHERE LEN(NAME) = 18;

---------------------------------------------------------------------------


--------------------------------------------------- ASSIGNMENT 8 ---------------------------------------------

CREATE FUNCTION CALC(@A AS INT, @B AS INT, @O AS CHAR(1))
RETURNS INT
AS
BEGIN
	
	DECLARE @C AS INT

	IF @O = '+'
	SET @C = @A + @B
	ELSE IF @O = '-'
	SET @C = @A - @B
	ELSE IF @O = '*'
	SET @C = @A * @B
	ELSE IF @O = '/'
	SET @O = @A / @B
	ELSE IF @O = '%'
	SET @O = @A % @B
	ELSE SET @C = 0

	RETURN @C

END;

SELECT DBO.CALC(8,9,'+');
SELECT DBO.CALC(8,9,'-');
SELECT DBO.CALC(8,9,'*');
SELECT DBO.CALC(8,9,'/');
SELECT DBO.CALC(8,9,'%');

-------------------------------------------------------------------------------------------------

SELECT UPPER(CONCAT(LEFT(NAME, 1), '.', RIGHT(NAME, LEN(NAME) - CHARINDEX(' ', NAME)), RIGHT(EID, 3), 'RCG.COM'))
FROM EMPC;

SELECT * FROM EMPC;

--------------------------------------------------------------------------------------------------

CREATE FUNCTION GET_DEPT(@D AS VARCHAR(20))
RETURNS TABLE
AS 

	RETURN(SELECT EMPC.EID, NAME, DESI, DEPT, SALARY
	FROM EMPC
	INNER JOIN EMPSC
	ON EMPC.EID = EMPSC.EID
	WHERE DEPT = @D);

SELECT * FROM DBO.GET_DEPT('HR');

--------------------------------------------------------------------------------------------
CREATE FUNCTION GET_BIRTH()
RETURNS TABLE
AS
	RETURN(SELECT NAME, DEPT, DESI, CITY
	FROM EMPC
	INNER JOIN EMPSC
	ON EMPC.EID = EMPSC.EID
	WHERE MONTH(GETDATE()) = MONTH(DOB));

SELECT * FROM DBO.GET_BIRTH();

--------------------------------------------------------------------------------------------

-------------------------------------------------------- ASSIGNMENT 9 ------------------------------------------------------

SELECT EID, NAME, CITY
FROM EMPC
WHERE EID IN (SELECT EID FROM EMPC WHERE CITY = 'GURGAON');

-------------------------------------------------------------------------------

SELECT EMPC.EID, NAME, DOJ, DEPT, DESI, SALARY
FROM EMPC
INNER JOIN EMPSC
ON EMPC.EID = EMPSC.EID
WHERE EMPC.EID IN (SELECT EID FROM EMPSC WHERE DESI LIKE '%MANAGER%');

------------------------------------------------------------------------------

UPDATE EMPSC
SET SALARY = SALARY - SALARY * 0.1
WHERE EID IN (SELECT EID FROM EMPC WHERE CITY = 'DELHI');

---------------------------------------------------------------------------------

SELECT EMPC.EID, NAME, CITY, DOJ, DEPT, DESI, SALARY
FROM EMPC
INNER JOIN EMPSC
ON EMPC.EID = EMPSC.EID
WHERE EMPC.EID IN (SELECT EID FROM EMPC WHERE NAME LIKE '%DAVID%' OR NAME LIKE '%RAMESH%');

-----------------------------------------------------------------------------------

CREATE TABLE TRAINING
(
EID CHAR(5),
NAME VARCHAR(20),
DEPT VARCHAR(20),
)

INSERT INTO TRAINING(EID, NAME, DEPT)
SELECT EMPC.EID, NAME, DEPT
FROM EMPC
INNER JOIN EMPSC
ON EMPC.EID = EMPSC.EID
WHERE DEPT =  'OPS';

-----------------------------------------------------

DELETE FROM TRAINING
WHERE EID IN (SELECT EID FROM EMPSC WHERE DESI LIKE '%DIRECTOR%');
SELECT * FROM TRAINING;

--------------------------------------------------------
SELECT * FROM EMPSC;

SELECT SALARY FROM EMPSC
WHERE EXISTS(SELECT EID FROM EMPSC WHERE SALARY>=200000);

--------------------------------------------------------------




