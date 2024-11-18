USE INVENTORY;

SELECT name 
FROM sys.tables;

SELECT OID, ODATE, CNAME, ADDRESS, PHONE, PDESC, PRICE, OQTY, PRICE*OQTY AS 'AMOUNT'
FROM ORDERS
JOIN CUST
ON ORDERS.CID = CUST.CID
JOIN PRODUCT
ON PRODUCT.PID = ORDERS.PID;


SELECT * FROM ORDERS;
SELECT * FROM PRODUCT;
SELECT * FROM CUST;



------------------------ INDEX ---------------------------

USE TEST;

SELECT * FROM EMPC;

SELECT * FROM EMPSC;

CREATE INDEX LB51I1 ON EMPC(CITY);

SELECT * FROM EMPC WHERE CITY = 'DELHI';

SELECT * FROM EMPC WHERE ADDR2 = 'DWARKA';

ALTER TABLE EMPC
ALTER COLUMN DOJ DATE;

----------- COMPOSITE INDEX ----------------

CREATE INDEX LB5IT2 ON EMPC(CITY, ADDR2);

------- CLUSTERED INDEX ----------

CREATE CLUSTERED INDEX LB1T3 ON EMPC(DOJ);

DROP INDEX LB5IT2 ON EMPC;

------------------ VIEWS -----------------------------
USE TEST;

SELECT * FROM EMPC WHERE CITY = 'DEHRADUN';

CREATE VIEW L51VDEMP 
AS
	SELECT * FROM EMPC
	WHERE CITY = 'DEHRADUN';

SELECT * FROM L51VDEMP;

DROP VIEW L51VDEMP;

CREATE VIEW L51VDEMP 
AS
	SELECT * FROM EMPC
	WHERE CITY = 'DEHRADUN'
	WITH CHECK OPTION;

INSERT INTO L51VDEMP
VALUES
('1997', 'ABDUL KASHIF', '58/78 MACCHI TALAO', 'BHANGURPUR', 'SIRSA', '154914999', 'XYX@GMAIL.COM', '1997-01-31', '2021-11-30');

CREATE VIEW L52VDEMP 
AS
	SELECT * FROM EMPC
	WHERE CITY = 'DEHRADUN'

INSERT INTO L52VDEMP
VALUES
('1997', 'ABDUL KASHIF', '58/78 MACCHI TALAO', 'BHANGURPUR', 'SIRSA', '154914999', 'XYX@GMAIL.COM', '1997-01-31', '2021-11-30');

SELECT * FROM L52VDEMP;

SELECT * FROM EMPC;

DELETE FROM EMPC WHERE EID = 1997;

----------------- SUMMARIZING DATA FROM DIFFERENT TABLES ---------------

CREATE VIEW L51VSAL

AS

	SELECT EMPC.EID, NAME, CITY, DOJ, DEPT, DESI, SALARY AS 'BASIC', SALARY * .15 AS 'HRA', SALARY * .09 AS 'PF'
	FROM EMPC
	INNER JOIN EMPSC
	ON EMPC.EID = EMPSC.EID;

SELECT * FROM L51VSAL;

------------------------------------------------- ASSIGNMENT 6 ---------------------------------------------------------------

CREATE VIEW EMP_SAL_DETAILS
AS

	SELECT EMPC.EID, NAME, DOJ, DEPT, DESI, SALARY AS 'BASIC', SALARY*0.15 AS 'HRA', SALARY*0.09 AS 'PF', SALARY + SALARY*0.15 + SALARY*0.09 AS 'NET', 
			SALARY + SALARY*0.15 + SALARY*0.09 - SALARY*0.09 AS 'GROSS'

	FROM EMPC
	INNER JOIN EMPSC
	ON EMPC.EID = EMPSC.EID;

SELECT * FROM EMP_SAL_DETAILS;

--------------------------------------------

CREATE VIEW MANAGERS

AS

	SELECT EMPC.EID, NAME, DOJ, DESI, DEPT
	FROM EMPC
	INNER JOIN EMPSC
	ON EMPC.EID = EMPSC.EID
	WHERE DESI LIKE '%MANAGER%' AND DOJ BETWEEN '01-JAN-2019' AND '31-DEC-2019';

SELECT * FROM MANAGERS;
-------------------------------------------------------------

CREATE VIEW TEAM

AS

	SELECT DEPT, CITY, COUNT(EMPC.EID) AS 'TEAM MEMBERS', SUM(SALARY) AS 'TOTAL SALARY', SUM(SALARY)/COUNT(EMPC.EID) AS 'AVERAGE SALARY'
	FROM EMPC
	INNER JOIN EMPSC
	ON EMPC.EID =  EMPSC.EID
	GROUP BY DEPT, CITY;

SELECT * FROM TEAM;

DROP VIEW TEAM;

----------------------------------------------

USE INVENTORY;


CREATE VIEW BILL

AS

	SELECT ORDERS.OID, ODATE, CNAME, ADDRESS, PHONE, PDESC, PRICE, OQTY, PRICE*OQTY AS 'AMOUNT'
	FROM ORDERS
	JOIN PRODUCT
	ON ORDERS.PID = PRODUCT.PID
	JOIN CUST
	ON CUST.CID = ORDERS.CID;


SELECT * FROM BILL;

---------------------------------------------------------------------------

-------------------------- SQL FUNCTIONS ------------------------
USE TEST;

SELECT COUNT(*) FROM EMPC;

SELECT MAX(SALARY), MIN(SALARY), AVG(SALARY), SUM(SALARY)
FROM EMPSC;

SELECT RAND();

SELECT CONCAT('HELLO', ' ' + 'WORLD');

SELECT EID, DEPT, DESI, SALARY,
RANK() OVER (ORDER BY SALARY DESC) AS 'POSI'
FROM EMPSC;

SELECT EID, DEPT, DESI, SALARY,
DENSE_RANK() OVER (ORDER BY SALARY DESC) AS 'POSI'
FROM EMPSC;

SELECT EID, DEPT, DESI, SALARY,
ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS 'POSI'
FROM EMPSC;


SELECT ASCII('A');
SELECT CHAR(65);

SELECT CHARINDEX('L', 'WELCOME');

SELECT GETDATE();