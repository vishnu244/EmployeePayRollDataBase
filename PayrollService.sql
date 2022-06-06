create database PayRollService
use PayRollService
create table employee_payroll(ID int identity(1,1) primary key,Name varchar(100),Salary int,Start_Date date)
INSERT into employee_payroll values ('Vishnu',10000,'2022-10-04'),('Shravanthi',20000,'2022-01-04'),('Roshni',30000,'2022-05-04')
