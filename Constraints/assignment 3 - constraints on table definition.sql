---assignment 3-----

CREATE DATABASE TEST;

USE TEST;

CREATE TABLE EMP_1
(EID CHAR(5) PRIMARY KEY,
NAME VARCHAR(20) NOT NULL,
ADDR VARCHAR(50) CHECK (ADDR NOT LIKE '%NAGAR%'),
CITY VARCHAR(20) CHECK (CITY IN ('GURUGRAM', 'NOIDA', 'GURGAON', 'DELHI', 'GHAZIABAD')),
DOB DATE CHECK (DOB >= '01-JAN-1985'),
PHONE CHAR(12) UNIQUE,
EMAIL VARCHAR(30) CHECK (EMAIL LIKE '%GMAIL%' OR EMAIL LIKE '%YAHOO%')
)

INSERT INTO EMP_1
VALUES('E0001', 'NULL', 'UTTAM NAGAR', 'JAIPUR', '25-NOV-1984', '354959599', 'NHJCBW@EXAMPLE.COM')


CREATE TABLE EMP_SAL_1
(
EID CHAR(5) FOREIGN KEY REFERENCES EMP_1(EID),
DEPT VARCHAR(20) DEFAULT 'IT' CHECK (DEPT IN ('HR', 'OPS', 'MIS', 'IT', 'ADMIN')),
DESI VARCHAR(20) CHECK (DESI IN ('ASSOCIATE', 'DIRECTOR')),
DOJ DATE,
SALARY INT CHECK (SALARY >= 10000)
)

