create database PayRollService
use PayRollService
create table employee_payroll(ID int identity(1,1) primary key,Name varchar(100),Salary int,Start_Date date)
INSERT into employee_payroll values ('Vishnu',10000,'2022-10-04'),('Shravanthi',20000,'2022-01-04'),('Roshni',30000,'2022-05-04')
SELECT salary FROM employee_payroll
WHERE name = 'Vishnu'
select * from employee_payroll
WHERE Start_Date BETWEEN CAST('2022-01-01'AS DATE) AND GETDATE();