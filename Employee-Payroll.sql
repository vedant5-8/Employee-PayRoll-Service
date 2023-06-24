-- UC 1: create a payroll service database

CREATE DATABASE Payroll_Service;

SELECT name FROM sys.databases;

use Payroll_Service;

-- UC 2: create employee payroll table

CREATE TABLE Employee_Payroll(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50),
	Salary FLOAT,
	Start_Date DATE
);
