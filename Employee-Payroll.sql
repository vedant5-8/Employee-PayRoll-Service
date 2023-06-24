-- UC 1: create a payroll service database

CREATE DATABASE Payroll_Service;

SELECT name FROM sys.databases;

use Payroll_Service;

-- UC 2: create employee payroll table
/*
CREATE TABLE Employee_Payroll(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50),
	Salary FLOAT,
	Start_Date DATE
);
*/
--CRUD Operations
-- UC 3: Insert Records

INSERT INTO Employee_Payroll 
VALUES 
	('Chris Evans', 55000.23, '01-04-2022'),
	('Paul Rudd', 55000.23, '06-04-1969'),
	('Sebastian Stan', 55000.23, '13-08-1982');