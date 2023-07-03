-- UC 1: create a payroll service database

CREATE DATABASE Payroll_Service;

SELECT name FROM sys.databases;

USE Payroll_Service;

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

INSERT INTO Employee_Payroll (Name, Salary, Start_Date)
VALUES 
	('Chris Evans', 55000.23, '2022-04-01'),
	('Paul Rudd', 43789.70, '2018-06-04'),
	('Sebastian Stan', 67834.10, '2013-03-08');

INSERT INTO Employee_Payroll VALUES ('Brie Larson', 67234.67, '2020-08-15', 'F');
INSERT INTO Employee_Payroll VALUES ('Hayley Atwell', 89123.90, '2019-12-01', 'F');

-- UC 4: retrieve all the employee payroll table

SELECT * FROM Employee_Payroll;

-- UC 5: retrive salary data from particular employee

SELECT Salary FROM Employee_Payroll
WHERE Name = 'Paul Rudd';

SELECT * FROM Employee_Payroll 
WHERE Start_Date BETWEEN CAST('2018-01-01' AS DATE) AND GETDATE();

--UC 6: add Gender to EmployeePayroll Table and Update the Rows 

ALTER TABLE Employee_Payroll
ADD Gender CHAR(1) CHECK(Gender IN ('M', 'F'));

UPDATE Employee_Payroll SET Gender = 'M'
WHERE name = 'Chris Evans' or name = 'Paul Rudd' or name = 'Sebastian Stan';

--UC 7: find sum, average, min, max and number of male and female employees

SELECT SUM(Salary) AS Salary_Of_Females FROM Employee_Payroll
WHERE Gender = 'F'
GROUP BY Gender;

SELECT SUM(Salary) AS Salary_Of_Males FROM Employee_Payroll
WHERE Gender = 'M'
GROUP BY Gender;

SELECT AVG(Salary) AS Average_Salary FROM Employee_Payroll;

SELECT MIN(Salary) AS Minimum_Salary FROM Employee_Payroll;

SELECT MAX(Salary) AS Maximum_Salary FROM Employee_Payroll;

SELECT COUNT(Gender) AS Count_Males FROM Employee_Payroll
WHERE Gender = 'M'
GROUP BY Gender;

SELECT COUNT(Gender) AS Count_Females FROM Employee_Payroll
WHERE Gender = 'F'
GROUP BY Gender;

--UC 8: extend employee_payroll data to store employee information like employee phone, address and department

ALTER TABLE Employee_Payroll
ADD Phone VARCHAR(255);

ALTER TABLE Employee_Payroll
ADD Address VARCHAR(255);

ALTER TABLE Employee_Payroll
ADD Department VARCHAR(255);

UPDATE Employee_Payroll 
SET Phone = '9513578526', Address = 'Boston', Department = 'IT'
WHERE ID = 1;

UPDATE Employee_Payroll 
SET Phone = '8523579515', Address = 'New Jersey', Department = 'HR'
WHERE ID = 2;

UPDATE Employee_Payroll 
SET Phone = '9632587410', Address = 'Romania', Department = 'R&D'
WHERE ID = 3;

UPDATE Employee_Payroll 
SET Phone = '9842365402', Address = 'California', Department = 'Sales'
WHERE ID = 4;

UPDATE Employee_Payroll 
SET Phone = '8526547539', Address = 'London', Department = 'Production'
WHERE ID = 5;

--UC 9: extend employee_payroll data to store employee information like Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay

ALTER TABLE Employee_Payroll
ADD Basic_Pay FLOAT;

ALTER TABLE Employee_Payroll
ADD Deductions FLOAT;

ALTER TABLE Employee_Payroll
ADD Taxable_Pay FLOAT;

ALTER TABLE Employee_Payroll
ADD Income_Tax FLOAT;

ALTER TABLE Employee_Payroll
ADD Net_Pay FLOAT;

-- UC 10: Terissa as part of Sales and Marketing Department and insert other data

INSERT INTO Employee_Payroll VALUES 
('Terisa', 13000000, '2022-04-01', 'F', '8796453120', 'Adelaide', 'Marketing', 3000000.00, 1000000.00, 2000000.00, 500000.00, 15000000.00);

SELECT * FROM Employee_Payroll
WHERE Name = 'Terisa';

--ER Diagram

-- UC 11: Implement the ER Diagram into Payroll Service DB

CREATE TABLE Company (
	CompId INT IDENTITY(1,1) PRIMARY KEY,
	CompName VARCHAR(70)
);

INSERT INTO Company VALUES ('IBM');

SELECT * FROM Company;

CREATE TABLE Department (
	DeptId INT IDENTITY(1,1) PRIMARY KEY,
	DeptName VARCHAR(100),
	CompId INT FOREIGN KEY REFERENCES Company(CompId)
);

INSERT INTO Department VALUES
	('IT', 1),
	('HR', 1),
	('Admin', 1);

SELECT * FROM Department;

CREATE TABLE Employee (
	EmpId INT IDENTITY(1,1) PRIMARY KEY,
	EmpName VARCHAR(50),
	PhoneNumber BIGINT,
	Street VARCHAR(100),
	City VARCHAR(20),
	State VARCHAR(20),
	Gender CHAR(1) CHECK(Gender IN ('M', 'F')),
	DeptId INT FOREIGN KEY REFERENCES Department(DeptId)
);

INSERT INTO Employee VALUES
	('Jack', 8523697410, '220 Sixth St', 'Langley', 'Washington', 'M', 1),
	('Elizabeth', 8624761943, '5901 S Brawley Ave', 'Fresno', 'California', 'F', 2),
	('Mike', 9617394500, '66 Strickland St', 'Bay Head', 'New Jersey', 'M', 3),
	('James', 8392681203, '1204 E 91st St', 'Brooklyn', 'New York', 'M', 1);

--INSERT INTO Employee VALUES ('Cathy', 8852003070, );

SELECT * FROM Employee;

CREATE TABLE Payroll (
	EmpId INT FOREIGN KEY REFERENCES Employee(EmpId),
	BasicPay DECIMAL(10,2),
    Deduction DECIMAL(10,2),
    TaxablePay DECIMAL(10,2),
    IncomeTax DECIMAL(10,2),
    NetPay AS (BasicPay - Deduction - IncomeTax)
);

INSERT INTO Payroll VALUES
	(1, 50000.00, 5000.00, 45000.00, 5000.00),
	(2, 60000.00, 6000.00, 54000.00, 6000.00),
	(3, 55000.00, 5500.00, 49500.00, 5500.00),
	(4, 65000.00, 6500.00, 58500.00, 6500.00);

SELECT * FROM Payroll;

SELECT 
	e.EmpId, e.EmpName, p.BasicPay, 
	p.Deduction, p.TaxablePay, p.IncomeTax, p.NetPay 
FROM Employee e
INNER JOIN Payroll p
ON e.EmpId = p.EmpId;

