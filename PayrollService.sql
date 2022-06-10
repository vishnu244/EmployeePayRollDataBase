------------UC_1-Creating PayRoll_service dataBase------------------
create database PayRollService
use PayRollService

------------UC_2-Creating Employee_payroll Table in dataBase------------------
create table employee_payroll(ID int identity(1,1) primary key,Name varchar(100),Salary int,Start_Date date)

------------UC_3-Inserting Values into Employee_payroll Table in dataBase------------------

INSERT into employee_payroll values ('Vishnu',10000,'2022-10-04'),('Shravanthi',20000,'2022-01-04'),('Roshni',30000,'2022-05-04')
INSERT into employee_payroll values ('Krishna',10000,'2022-03-04','male')
INSERT into employee_payroll values ('Shiva',10000,'2022-03-04','')

------------UC_4-Ability to Retrive Values From Employee_payroll Table in dataBase------------------
select * from employee_payroll

------------UC_5-Ability to Retrive Salry of a Particular Employee From Employee_payroll Table in dataBase------------------
SELECT salary FROM employee_payroll
WHERE name = 'Vishnu'
select * from employee_payroll
WHERE Start_Date BETWEEN CAST('2022-01-01'AS DATE) AND GETDATE();

------------UC_6-Ability to Add Gender to Employee_payroll Table in dataBase------------------



Alter table employee_payroll add Gender varchar(10)
update employee_payroll set Gender = 'male' where name = 'vishnu' or name = 'Shiva'
update employee_payroll set Gender = 'Female' where name = 'shravanthi' 

------------UC_7-Ability to Find SUM,Avg,Min,Max,Count From Employee_payroll Table in dataBase------------------

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


-------------UC_11 & 12 entities and relationships-------------------

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

CREATE TABLE ADDRESS (empId INT REFERENCES employee(empId),
					  City varchar(50),
					  State varchar(50) );
select * from ADDRESS


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



-------------Inserting values into Company table---------------------------------
Insert Into Company Values (1,'BridgeLabs');
Insert Into Company Values (2,'Wipro');
Insert Into Company Values (3,'Infosys');
Insert Into Company Values (4,'Amazon');
SELECT* from Company

-------------Inserting values into employee table---------------------------------
Insert Into employee Values (19,'Shravanthi',1,'1234567891','Alwal,Secunderabad','F');
Insert Into employee Values (23,'Vishnu',1,'1234567890','Kanuru,Vijayawada','M');
Insert Into employee Values (20,'Tony',2,'1234567892','Alwal,Secunderabad','M');
Insert Into employee Values (24,'Vishnu',4,'1234567890','Kanuru,Vijayawada','M');
Insert Into employee Values (25,'Hema',3,'1234567898','Kanuru,Vijayawada','F');

select* from employee

-------------Inserting values into payroll table---------------------------------
Insert Into payroll Values (19,30000,1500,240,300,28500);
Insert Into payroll Values (23,20000,1000,180,200,19000);
Insert Into payroll Values (20,35000,1500,240,300,33500);
Insert Into payroll Values (25,40000,1500,240,300,38500);
Insert Into payroll Values (24,45000,1500,240,300,43500);


select* from payroll

-------------Inserting values into DEPARTMENT table---------------------------------
Insert Into DEPARTMENT Values ('Production',23,16);
Insert Into DEPARTMENT Values ('Developer',19,04);
Insert Into DEPARTMENT Values ('HR',22,08);
Insert Into DEPARTMENT Values ('Sales',25,19);
Insert Into DEPARTMENT Values ('Marketing',20,13)

select* from DEPARTMENT;
-------------Inserting values into ADDRESS table---------------------------------
Insert Into ADDRESS Values (22,'Vijayawada','Andhra Pradesh');
Insert Into ADDRESS Values (19,'Alwal','Secunderabad');
Insert Into ADDRESS Values (23,'pune','Maharashtra');
Insert Into ADDRESS Values (24,'Kochi','Kerala');
Insert Into ADDRESS Values (25,'Banglore','karnataka');

select* from ADDRESS;


-----------UC13-Ensuring All retrieve queries from UC6 to UC10 with new table---------
------------Retreive_UC_4-Ability to Retrive Values From Employee_payroll Table in dataBase------------------
select company.compId,company.compName,
	   Employee.empId,Employee.Name,Employee.Phone,Employee.Address,Employee.Gender,
	   Payroll.BasicPay,Payroll.Deduction,Payroll.TaxablePay,Payroll.IncomeTax,Payroll.NetPay,
	   department.DeptName,department.deptId,
	   Address.City,Address.State
from Company as company
left Join employee as Employee on company.compId = Employee.compId 
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
left Join ADDRESS as Address on Address.empID = Employee.empId  ;

------------Retreive_UC_5-Ability to Retrive Salry of a Particular Employee From Employee_payroll Table in dataBase------------------
select company.compId,company.compName,
	   Employee.empId,Employee.Name,Employee.Phone,Employee.Address,Employee.Gender,
	   Payroll.BasicPay,Payroll.Deduction,Payroll.TaxablePay,Payroll.IncomeTax,Payroll.NetPay,
	   department.DeptName,department.deptId,
	   Address.City,Address.State
from Company as company
left Join employee as Employee on company.compId = Employee.compId 
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
left Join ADDRESS as Address on Address.empID = Employee.empId  where (payroll.BasicPay=30000);

------------UC_7-Ability to Find SUM,Avg,Min,Max,Count From Employee_payroll Table in dataBase------------------


select sum(Payroll.BasicPay)as p 
from Company as company
left Join employee as Employee on company.compId = Employee.compId 
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
left Join ADDRESS as Address on Address.empID = Employee.empId ;

select Avg(Payroll.BasicPay)as p 
from Company as company
left Join employee as Employee on company.compId = Employee.compId 
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
left Join ADDRESS as Address on Address.empID = Employee.empId ;

select Min(Payroll.BasicPay)as p 
from Company as company
left Join employee as Employee on company.compId = Employee.compId 
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
left Join ADDRESS as Address on Address.empID = Employee.empId ;

select Max(Payroll.BasicPay)as p 
from Company as company
left Join employee as Employee on company.compId = Employee.compId 
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
left Join ADDRESS as Address on Address.empID = Employee.empId ;

select Count(*)as p 
from Company as company
left Join employee as Employee on company.compId = Employee.compId 
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
left Join ADDRESS as Address on Address.empID = Employee.empId ;
