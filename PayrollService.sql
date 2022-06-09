create database PayRollService
use PayRollService
create table employee_payroll(ID int identity(1,1) primary key,Name varchar(100),Salary int,Start_Date date)
INSERT into employee_payroll values ('Vishnu',10000,'2022-10-04'),('Shravanthi',20000,'2022-01-04'),('Roshni',30000,'2022-05-04')
INSERT into employee_payroll values ('Krishna',10000,'2022-03-04','male')
INSERT into employee_payroll values ('Shiva',10000,'2022-03-04','')
SELECT salary FROM employee_payroll
WHERE name = 'Vishnu'
select * from employee_payroll
WHERE Start_Date BETWEEN CAST('2022-01-01'AS DATE) AND GETDATE();
Alter table employee_payroll add Gender varchar(10) 
update employee_payroll set Gender = 'male' where name = 'vishnu' or name = 'Shiva'
update employee_payroll set Gender = 'Female' where name = 'shravanthi' 
SELECT SUM(salary) FROM employee_payroll
WHERE Gender = 'Female' GROUP BY Gender;

SELECT Avg(salary) FROM employee_payroll
WHERE Gender = 'Male' GROUP BY Gender;

SELECT min(salary) FROM employee_payroll
WHERE Gender = 'Female' GROUP BY Gender;

SELECT max(salary) FROM employee_payroll
WHERE Gender = 'Female' GROUP BY Gender;

SELECT count(salary) FROM employee_payroll
WHERE Gender = 'Female' GROUP BY Gender;


----UC8 --- Extend by adding PhoneNumber, Address, Department -----------

alter table employee_payroll add phonenumber varchar(50),address varchar(200) not null default 'ABC Colony',department varchar(50);

update employee_payroll set phonenumber='9000000001', department='Production' where name='Vishnu';
update employee_payroll set phonenumber='9000000002', department='Tester' where name='Roshni';
update employee_payroll set phonenumber='9000000003', department='Developer' where name='Shravanthi';
update employee_payroll set phonenumber='9000000004', department='Production' where name='Krishna';
update employee_payroll set phonenumber='9000000005, 1234567890', department='Tester' where name='Shiva';


-----UC9--Extend employee_payroll to have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay---

alter table employee_payroll add BasicPay decimal, Deductions decimal, TaxablePay decimal, IncomeTax decimal, NetPay decimal;

update employee_payroll set BasicPay=Salary;
alter table employee_payroll drop column Salary;

update employee_payroll set Deductions=1000 where department = 'Production';
update employee_payroll set Deductions=2000 where department = 'Tester';
update employee_payroll set Deductions=500 where department = 'Developer';

update employee_payroll set IncomeTax=250;
update employee_payroll set TaxablePay=500;

update employee_payroll set NetPay = (BasicPay-Deductions);

select * from employee_payroll;

-------uc_10 Adding New Employee in Sales and Marketing Department-------------------
INSERT into employee_payroll values ('Terissa','2022-03-04','Female', '1234567890', 'XYZ colony','Sales','25000','1000','500','1500','24000')
INSERT into employee_payroll values ('Terissa','2022-03-04','Female', '1234567890', 'XYZ colony','Marketing','30000','1000','500','1500','29000')


-------------UC_11 entities and relationships-------------------

create table Company (compId INT PRIMARY KEY, 
					  compName varchar(20)  );
SELECT* from Company

create table employee(empId int PRIMARY KEY,
					  Name varchar(20),
					  compId INT REFERENCES Company(compId),
					  Phone varchar(20),
					  Address varchar(200),
					  Gender char  );
select* from employee


create Table payroll(empId INT REFERENCES employee(empId),
					 BasicPay decimal,
					 Deduction decimal, 
					 TaxablePay decimal,
					 IncomeTax decimal,
					 NetPay decimal  );
select* from payroll


CREATE TABLE DEPARTMENT(DeptName VARCHAR(10),
						empId INT REFERENCES employee(empId),
						deptId int PRIMARY KEY  );
select* from DEPARTMENT;