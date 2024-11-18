-------------------------------------------------------- ASSIGNMENT 10 ------------------------------------------
------------------------------------------------ TRANSACTIONS AND SEQUENCES -------------------------------------------------------

CREATE TABLE TEMP
(ID INT,
NAME VARCHAR(10));

INSERT INTO TEMP VALUES(1, 'A');
INSERT INTO TEMP VALUES(2, 'B');
INSERT INTO TEMP VALUES(3, 'C');
INSERT INTO TEMP VALUES(4, 'D');
INSERT INTO TEMP VALUES(5, 'E');
INSERT INTO TEMP VALUES(6, 'F');
INSERT INTO TEMP VALUES(7, 'G');
INSERT INTO TEMP VALUES(8, 'H');
INSERT INTO TEMP VALUES(9, 'I');
INSERT INTO TEMP VALUES(10, 'J');

SELECT * FROM TEMP;

DELETE FROM TEMP WHERE ID = 10;

BEGIN TRANSACTION
SET NOCOUNT ON;
DELETE FROM TEMP WHERE ID = 7;
DELETE FROM TEMP WHERE ID = 6;
ROLLBACK;

BEGIN TRANSACTION

DELETE FROM TEMP WHERE ID = 7;
DELETE FROM TEMP WHERE ID = 6;
DELETE FROM TEMP WHERE ID = 5;
DELETE FROM TEMP WHERE ID = 4;
DELETE FROM TEMP WHERE ID = 3;
DELETE FROM TEMP WHERE ID = 2;

ROLLBACK;


BEGIN TRANSACTION

DELETE FROM TEMP WHERE ID = 7;
DELETE FROM TEMP WHERE ID = 6;

SAVE TRANSACTION T1  ------ SAVE POINT ------------
DELETE FROM TEMP WHERE ID = 5;

SAVE TRANSACTION T2 ---------- SAVE POINT ------------
DELETE FROM TEMP WHERE ID = 4;
DELETE FROM TEMP WHERE ID = 3;

SAVE TRANSACTION T3  ------------ SAVE POINT --------------
DELETE FROM TEMP WHERE ID = 2;
DELETE FROM TEMP WHERE ID = 10;


ROLLBACK TRANSACTION T1;

SELECT * FROM TEMP;



BEGIN TRANSACTION

DELETE FROM TEMP WHERE ID = 7;
DELETE FROM TEMP WHERE ID = 6;

SAVE TRANSACTION T1  ------ SAVE POINT ------------
DELETE FROM TEMP WHERE ID = 5;

SAVE TRANSACTION T2 ---------- SAVE POINT ------------
DELETE FROM TEMP WHERE ID = 4;
DELETE FROM TEMP WHERE ID = 3;


DELETE FROM TEMP WHERE ID = 2;
DELETE FROM TEMP WHERE ID = 10;
COMMIT;


ROLLBACK TRANSACTION T1;

----------------------------------------------------

--------- AUTO - INCREMENT---------

CREATE TABLE EMP_2
(
ID INT IDENTITY(1,1),  ---- (START, INCREMENT)
NAME VARCHAR(20),
AGE INT
);

INSERT INTO EMP_2 VALUES
(
'VISHAL', 30);

SELECT * FROM EMP_2;

CREATE PROCEDURE EMP_2D @N AS VARCHAR(20), @A AS INT
AS
BEGIN
	INSERT INTO EMP_2 VALUES(@N, @A);
	SELECT * FROM EMP_2;
END;

DROP PROCEDURE EMP_2D;

EMP_2D 'NITIN', 26;

EMP_2D 'RAHUL', 31;

DELETE FROM EMP_2 WHERE ID = 2;


----- SEQUENCES -------

CREATE SEQUENCE MYSEQ
AS INT
START WITH 1
INCREMENT BY 1;

SELECT NEXT VALUE FOR MYSEQ;

---------------------------

DROP SEQUENCE MYSEQ;

CREATE SEQUENCE MYSEQ
AS INT
START WITH 1
INCREMENT BY 1
MAXVALUE 10;

SELECT NEXT VALUE FOR MYSEQ;

--------------------

----------- REPEATED SEQUENCE ------------

CREATE SEQUENCE MYSEQ
AS INT
START WITH 1
INCREMENT BY 1
MAXVALUE 10
CYCLE;

SELECT NEXT VALUE FOR MYSEQ;

CREATE SEQUENCE MYSEQ
AS INT
START WITH 1
INCREMENT BY 1
MAXVALUE 10
MINVALUE 1
CYCLE;


CREATE SEQUENCE MYSEQ
AS
INT
START WITH 1
INCREMENT BY 1
MAXVALUE 10
MINVALUE 1
CYCLE
CACHE 5;        ---------- TO KEEP TE NEXT 5 NUMBERS TO BE GENERATED BY THE SEQUENCE IN THE CACHE MEMORY ---------------

SELECT NEXT VALUE FOR MYSEQ;

---------------------------------------------

CREATE SEQUENCE MYSEQ
AS INT
START WITH 1
INCREMENT BY 1;

CREATE TABLE EMP_3
(
ID INT,
NAME VARCHAR(20),
AGE INT
);

INSERT INTO EMP_3 VALUES
(NEXT VALUE FOR MYSEQ, 'NITIN', 30);

INSERT INTO EMP_3 VALUES
(NEXT VALUE FOR MYSEQ, 'VISHAL', 32);

SELECT * FROM EMP_3;

CREATE PROCEDURE EMP_3D @N AS VARCHAR(20), @A AS INT
AS
BEGIN
	
	INSERT INTO EMP_3 VALUES(NEXT VALUE FOR MYSEQ, @N, @A);
	SELECT * FROM EMP_3;

END;

EMP_3D 'RAM', 28;

EMP_3D 'RAGHU', 50;

EMP_3D 'VIJAY', 26;

DROP PROCEDURE EMP_3D;

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

CREATE TABLE EMP_3
(
ID CHAR(5),
NAME VARCHAR(20),
AGE INT
);

CREATE SEQUENCE MYSEQ_1
AS
INT
START WITH 1
INCREMENT BY 1;


CREATE PROCEDURE EMP_3D @N AS VARCHAR(20), @A AS INT
AS
BEGIN

	DECLARE @I AS INT;
	DECLARE @ID AS CHAR(5);
	SET @I = NEXT VALUE FOR MYSEQ_1;
	IF @I <10
		SET @ID = CONCAT('E000', @I)
		ELSE IF @I <100
		SET @ID = CONCAT('E00', @I)
		ELSE IF @I <1000
		SET @ID = CONCAT('E0', @I)
		ELSE IF @ID < 10000
		SET @ID = CONCAT('E', @I)
		ELSE
		SET @ID = 'NA'

		INSERT INTO EMP_3 VALUES(@ID, @N, @A)
		SELECT * FROM EMP_3

END;


EMP_3D 'RAM', 28;

EMP_3D 'RAGHU', 50;

EMP_3D 'VIJAY', 26;

SELECT * FROM EMP_3;	



CREATE FUNCTION GET_ID(@C AS CHAR(1), @I AS INT)
RETURNS CHAR(5)
AS
BEGIN
	DECLARE @ID AS CHAR(5);
	
	IF @I <10
	SET @ID = CONCAT(@C, '000', @I);

	ELSE IF @I <100
	SET @ID = CONCAT(@C, '00', @I);

	ELSE IF @I <1000
	SET @ID = CONCAT(@C, '0', @I);

	ELSE IF @I < 10000
	SET @ID = CONCAT(@C, @I);

	ELSE
		SET @ID = 'NA';

	RETURN @ID;

END;


SELECT DBO.GET_ID('C', 9);
SELECT DBO.GET_ID('C', 1700);
SELECT DBO.GET_ID('O', 3257);

DROP PROCEDURE EMP_3D;

CREATE PROCEDURE EMP_3D @N AS VARCHAR(20), @A AS INT
AS 
BEGIN
	DECLARE @I AS INT
	DECLARE @ID AS CHAR(5)

	SET @I = NEXT VALUE FOR MYSEQ_1
	SET @ID = DBO.GET_ID('C', @I)

	INSERT INTO EMP_3 VALUES(@ID, @N, @A)
	SELECT * FROM EMP_3

END;


EMP_3D 'VISHAL', 30;

DROP FUNCTION GET_ID;
------------------------------------------------------ ASSIGNMENT 10 --------------------------------------------------

USE INVENTORY;

DROP PROCEDURE ADDSUPPLIER;
DROP PROCEDURE ADDPRO;
DROP PROCEDURE ADDCUST;
DROP PROCEDURE ADDORDER;

SELECT * FROM SUPPLIER;

CREATE SEQUENCE INV1
AS
INT
START WITH 11
INCREMENT BY 1;


CREATE FUNCTION GET_ID(@C AS CHAR(1), @I AS INT)
RETURNS CHAR(5)
AS
BEGIN

	DECLARE @ID AS CHAR(5);
	
	IF @I < 100
	SET @ID = CONCAT(@C, '00', @I)

	ELSE IF @I <1000
	SET @ID = CONCAT(@C, '0', @I)

	ELSE IF @I < 10000
	SET @ID = CONCAT(@C, @I)

	ELSE
	SET @ID = 'NA'

	RETURN @ID

END;


CREATE PROCEDURE ADDSUPPLIER @N AS VARCHAR(20), @A AS VARCHAR(40), @C AS VARCHAR(20), @P AS CHAR(15), @E AS VARCHAR(30)
AS
BEGIN

	DECLARE @I AS INT;
	DECLARE @S AS CHAR(5)
	SET @I = NEXT VALUE FOR INV1;
	SET @S = DBO.GET_ID('S', @I);

	INSERT INTO SUPPLIER VALUES(@S, @N, @A, @C, @P, @E);
	SELECT * FROM SUPPLIER;

END;


ADDSUPPLIER 'RAM TRADERS', 'SECTOR 9', 'HISAR', 8484846464, 'RAM.TRADE@YAHOO.COM';

ADDSUPPLIER 'NAYAN MARBLE', 'MADANGUNJ', 'AJMER', 59494989, 'MADAN584@GMAIL.COM';


--------------------------------------------------------------------------------------
SELECT * FROM PRODUCT;

CREATE SEQUENCE INV2
AS
INT
START WITH 21
INCREMENT BY 1;


CREATE PROCEDURE ADDPRO @PD AS VARCHAR(30), @P AS INT, @CAT AS CHAR(2), @S AS CHAR(5)
AS
BEGIN

	DECLARE @I AS INT
	DECLARE @PID AS CHAR(5)

	SET @I = NEXT VALUE FOR INV2;
	SET @PID = DBO.GET_ID('P', @I)

	INSERT INTO PRODUCT VALUES(@PID, @PD, @P, @CAT, @S);
	SELECT * FROM PRODUCT;

END;


ADDPRO 'SMARTPHONE', 120584, 'HA', 'S0001';

ADDPRO 'LAPTOP', 45542, 'IT', 'S0002';


---------------------------------------------------------------------------------

SELECT * FROM CUST;

CREATE SEQUENCE INV3
AS
INT
START WITH 11
INCREMENT BY 1;


CREATE PROCEDURE ADDCUST @N AS VARCHAR(20), @A AS VARCHAR(30), @C AS VARCHAR(20), @P AS CHAR(15), @EM AS VARCHAR(20), @DB AS DATE
AS
BEGIN

	DECLARE @I AS INT
	DECLARE @CID AS CHAR(5)

	SET @I = NEXT VALUE FOR INV3;
	SET @CID = DBO.GET_ID('C', @I)

	INSERT INTO CUST VALUES(@CID, @N, @A, @C, @P, @EM, @DB)
	SELECT * FROM CUST;

END;

ADDCUST 'VARMAN VIJ', '34 GREATER KAILASH', 'DELHI', 59494947, 'VARVI@GMAIL.COM', '15-APR-1994';

ADDCUST 'KARIM KHAN', 'MUSLIM GUNJ', 'SURAT', 649494654, 'KARIM.KHAN2@YAHOO.COM', '25-JUNE-1999';

-----------------------------------------------------------------------------------------------------------

SELECT * FROM ORDERS;

CREATE SEQUENCE INV4
AS
INT
START WITH 6
INCREMENT BY 1;

CREATE PROCEDURE ADDORDER @P AS CHAR(5), @C AS CHAR(5), @Q AS INT
AS
BEGIN
	
	DECLARE @OID AS CHAR(5)
	DECLARE @I AS INT
	DECLARE @D AS DATETIME

	SET @D = CONVERT(DATE, GETDATE())
	SET @I = NEXT VALUE FOR INV4;
	SET @OID = DBO.GET_ID('O', @I)

	INSERT INTO ORDERS VALUES(@OID, @D, @P, @C, @Q);
	SELECT * FROM ORDERS;

END;

ADDORDER 'P0006', 'C0006', 14;
