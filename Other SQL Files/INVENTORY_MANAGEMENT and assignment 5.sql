--------- ASSIGNMENT 5 -------

SELECT * FROM EMPC;
SELECT * FROM EMPSC;

SELECT E1.EID, E1.NAME, E1.CITY, E1.DOJ, E2.DEPT, E2.DESI, E2.SALARY
FROM EMPC E1
INNER JOIN EMPSC E2
ON E1.EID = E2.EID
WHERE E1.CITY = 'DELHI';

-----------------------------------------

SELECT * FROM EMPC, EMPSC
WHERE NOT SALARY IS NOT NULL;


SELECT EMPC.EID, NAME, ADDR1, ADDR2, CITY, PHONE, EMAIL, DOB, DOJ, DEPT, DESI, SALARY
FROM EMPC
LEFT JOIN EMPSC
ON EMPC.EID = EMPSC.EID
WHERE NOT SALARY IS NOT NULL;
----------------------------------------

-----------------------------------------INVENTORY STRUCTURE-----------------------------------------------
CREATE DATABASE INVENTORY;

USE INVENTORY;

CREATE TABLE SUPPLIER
(
SID CHAR (5),
SNAME VARCHAR(20),
SADD VARCHAR(30),
SCITY VARCHAR(20),
SPHONE VARCHAR(15),
EMAIL VARCHAR(30)
)

CREATE TABLE PRODUCT
(
PID CHAR(5),
PDESC VARCHAR(40),
PRICE INT,
CATEGORY VARCHAR(15),
SID CHAR(5)
)

CREATE TABLE STOCK
(
PID CHAR(5),
SQTY INT,
ROL INT,
MOQ INT
)

CREATE TABLE ORDERS
(
OID CHAR(5),
ODATE DATE,
PID CHAR(5),
CID CHAR(5),
OQTY INT
)

CREATE TABLE CUST
(
CID CHAR(5),
CNAME VARCHAR(20),
ADDRESS VARCHAR(30),
CITY VARCHAR(20),
PHONE CHAR(15),
CEMAIL VARCHAR(30),
DOB DATE
)


ALTER TABLE SUPPLIER
ALTER COLUMN SNAME VARCHAR(20) NOT NULL;

ALTER TABLE SUPPLIER
ALTER COLUMN SID CHAR(5) NOT NULL;

ALTER TABLE SUPPLIER
ADD CONSTRAINT PKSID PRIMARY KEY(SID);

ALTER TABLE SUPPLIER
ADD CONSTRAINT DEF DEFAULT 'DELHI' FOR SCITY;

ALTER TABLE SUPPLIER
ALTER COLUMN SADD VARCHAR(30) NOT NULL;

ALTER TABLE SUPPLIER
ADD CONSTRAINT UNI UNIQUE(SPHONE);

-----------------------------------------------------------

ALTER TABLE PRODUCT
ALTER COLUMN PID CHAR(5) NOT NULL;

ALTER TABLE PRODUCT
ADD CONSTRAINT PKPID PRIMARY KEY(PID);

ALTER TABLE PRODUCT
ALTER COLUMN PDESC VARCHAR(40) NOT NULL;

ALTER TABLE PRODUCT
ADD CONSTRAINT CHKPRICE CHECK (PRICE>0);

ALTER TABLE PRODUCT
ADD CONSTRAINT CHKCAT CHECK (CATEGORY IN (IT, HA, HC));

ALTER TABLE PRODUCT
ADD CONSTRAINT FKSID FOREIGN KEY (SID) REFERENCES SUPPLIER(SID);

-----------------------------------------------------

ALTER TABLE STOCK
ADD CONSTRAINT FKPID FOREIGN KEY (PID) REFERENCES PRODUCT(PID);

ALTER TABLE STOCK
ADD CONSTRAINT CHKSQTY CHECK (SQTY >=0);

ALTER TABLE STOCK
ADD CONSTRAINT CHKROL CHECK (ROL >0);

ALTER TABLE STOCK
ADD CONSTRAINT CHKMOQ CHECK (MOQ>=5);

------------------------------------------------

ALTER TABLE ORDERS 
ALTER COLUMN OID CHAR(5) NOT NULL;

ALTER TABLE ORDERS
ADD CONSTRAINT OFKPID FOREIGN KEY(PID) REFERENCES PRODUCT(PID);

ALTER TABLE ORDERS
ADD CONSTRAINT OCFKPID FOREIGN KEY(CID) REFERENCES CUST(CID);

ALTER TABLE ORDERS
ADD CONSTRAINT CHKOQTY CHECK (OQTY>=1);

----------------------------------------------------
ALTER TABLE CUST
ALTER COLUMN CID CHAR(5) NOT NULL;

ALTER TABLE CUST
ADD CONSTRAINT PKCID PRIMARY KEY (CID);

ALTER TABLE CUST
ALTER COLUMN CNAME VARCHAR(20) NOT NULL;

ALTER TABLE CUST
ALTER COLUMN ADDRESS VARCHAR(30) NOT NULL;

ALTER TABLE CUST
ALTER COLUMN CITY VARCHAR(20) NOT NULL;

ALTER TABLE CUST
ALTER COLUMN PHONE CHAR(15) NOT NULL;

ALTER TABLE CUST
ALTER COLUMN CEMAIL VARCHAR(30) NOT NULL;

ALTER TABLE CUST
ADD CONSTRAINT CHKDATE CHECK (DOB<'01-JAN-2000');

-------------------------------------------------------------

INSERT INTO SUPPLIER (SID, SNAME, SADD, SCITY, SPHONE, EMAIL) VALUES
('S0001', 'Rajesh Traders', 'Sector-2, DLF Phase, Gurugram', 'Gurugram', '9876543210', 'rajesh.traders@gmail.com'),
('S0002', 'Mohit Distributors', '23 Madan Nagar, Mathura', 'Mathura', '8765432109', 'mohit.dist@yahoo.com'),
('S0003', 'Vikram Enterprises', 'Banjara Hills, Hyderabad', 'Hyderabad', '7654321098', 'vikram.ent@outlook.com'),
('S0004', 'Suresh Supplies', 'MG Road, Bengaluru', 'Bengaluru', '6543210987', 'suresh.supplies@gmail.com'),
('S0005', 'Neha Exporters', 'Connaught Place, New Delhi', 'Delhi', '5432109876', 'neha.exporters@yahoo.com'),
('S0006', 'Priya Agencies', 'Park Street, Kolkata', 'Kolkata', '4321098765', 'priya.agencies@outlook.com'),
('S0007', 'Kiran Suppliers', 'Camp Area, Pune', 'Pune', '3210987654', 'kiran.suppliers@gmail.com'),
('S0008', 'Anita Goods', 'Indiranagar, Bengaluru', 'Bengaluru', '2109876543', 'anita.goods@yahoo.com'),
('S0009', 'Sunil Markets', 'Charminar, Hyderabad', 'Hyderabad', '1098765432', 'sunil.markets@outlook.com'),
('S0010', 'Manish Imports', 'Civil Lines, Jaipur', 'Jaipur', '0987654321', 'manish.imports@gmail.com');

----------------------------------

INSERT INTO PRODUCT (PID, PDESC, PRICE, CATEGORY, SID) VALUES
('P0001', 'Laptop', 45000, 'IT', 'S0001'),
('P0002', 'Refrigerator', 25000, 'HA', 'S0002'),
('P0003', 'Microwave Oven', 10000, 'HC', 'S0003'),
('P0004', 'Smartphone', 15000, 'IT', 'S0004'),
('P0005', 'Air Conditioner', 35000, 'HA', 'S0005'),
('P0006', 'Water Purifier', 8000, 'HC', 'S0006'),
('P0007', 'Tablet', 12000, 'IT', 'S0007'),
('P0008', 'Washing Machine', 20000, 'HA', 'S0008'),
('P0009', 'Toaster', 1500, 'HC', 'S0009'),
('P0010', 'Gaming Console', 30000, 'IT', 'S0010'),
('P0011', 'Mixer Grinder', 5000, 'HA', 'S0001'),
('P0012', 'Television', 40000, 'HC', 'S0002'),
('P0013', 'Camera', 25000, 'IT', 'S0003'),
('P0014', 'Water Heater', 7000, 'HA', 'S0004'),
('P0015', 'Air Purifier', 15000, 'HC', 'S0005'),
('P0016', 'Desktop Computer', 60000, 'IT', 'S0006'),
('P0017', 'Electric Kettle', 2000, 'HA', 'S0007'),
('P0018', 'Blender', 3000, 'HC', 'S0008'),
('P0019', 'Sound System', 20000, 'IT', 'S0009'),
('P0020', 'Hair Dryer', 1000, 'HA', 'S0010');

-------------------------------------------------------

INSERT INTO STOCK (PID, SQTY, ROL, MOQ) VALUES
('P0001', 50, 10, 9),
('P0002', 60, 15, 5),
('P0003', 70, 20, 12),
('P0004', 80, 25, 6),
('P0005', 90, 30, 10),
('P0006', 100, 35, 8),
('P0007', 110, 40, 9),
('P0008', 120, 45, 14),
('P0009', 130, 50, 7),
('P0010', 140, 55, 8);

-------------------------------------------------------

INSERT INTO ORDERS (OID, ODATE, PID, CID, OQTY) VALUES
('O0001', '2024-01-01', 'P0001', 'C0001', 5),
('O0002', '2024-01-02', 'P0002', 'C0002', 10),
('O0003', '2024-01-03', 'P0003', 'C0003', 15),
('O0004', '2024-01-04', 'P0004', 'C0004', 20),
('O0005', '2024-01-05', 'P0005', 'C0005', 25);

------------------------------------------------------------

INSERT INTO CUST (CID, CNAME, ADDRESS, CITY, PHONE, CEMAIL, DOB) VALUES
('C0001', 'Rajesh Kumar', '10 MG Road, Mumbai', 'Mumbai', '9999999991', 'rajesh.kumar@gmail.com', '1980-12-01'),
('C0002', 'Mohit Sharma', '22 Park Street, Delhi', 'Delhi', '9999999992', 'mohit.sharma@yahoo.com', '1985-11-02'),
('C0003', 'Vikram Singh', '5 Nehru Place, Jaipur', 'Jaipur', '9999999993', 'vikram.singh@outlook.com', '1990-10-03'),
('C0004', 'Anita Desai', '17 Main Road, Bhopal', 'Bhopal', '9999999994', 'anita.desai@gmail.com', '1995-09-04'),
('C0005', 'Suresh Patel', '45 Residency Road, Surat', 'Surat', '9999999995', 'suresh.patel@yahoo.com', '1970-08-05'),
('C0006', 'Nidhi Verma', '30 Patel Nagar, Lucknow', 'Lucknow', '9999999996', 'nidhi.verma@outlook.com', '1975-07-06'),
('C0007', 'Amit Bhatt', '19 Gandhi Chowk, Pune', 'Pune', '9999999997', 'amit.bhatt@gmail.com', '1965-06-07'),
('C0008', 'Sunil Joshi', '9 Brigade Road, Bengaluru', 'Bengaluru', '9999999998', 'sunil.joshi@yahoo.com', '1960-05-08'),
('C0009', 'Pooja Mehta', '4 Mission Road, Chennai', 'Chennai', '9999999999', 'pooja.mehta@outlook.com', '1955-04-09'),
('C0010', 'Ramesh Yadav', '14 Cantonment, Kolkata', 'Kolkata', '9999999990', 'ramesh.yadav@gmail.com', '1950-03-10');

---------------------------------------------------------------------------------------------------------

SELECT * FROM SUPPLIER;
SELECT * FROM PRODUCT;
SELECT * FROM STOCK;
SELECT * FROM ORDERS;
SELECT * FROM CUST;

-----------------------------------------
SELECT E1.PID, E1.PDESC, E1.CATEGORY, E2.SNAME, E2.SCITY
FROM PRODUCT E1
FULL JOIN SUPPLIER E2
ON E1.SID = E2.SID;

------------------------------------

----QUESTION 2-----

SELECT OID, ODATE, CNAME, ADDRESS, PHONE, PDESC, PRICE, OQTY, PRICE*OQTY AS 'AMOUNT'
FROM ORDERS
JOIN CUST
ON ORDERS.CID = CUST.CID
JOIN PRODUCT
ON PRODUCT.PID = ORDERS.PID;
