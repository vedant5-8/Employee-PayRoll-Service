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