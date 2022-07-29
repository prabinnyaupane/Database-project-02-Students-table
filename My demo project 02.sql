To add a foreign key reference using a query
Alter table tblPerson 
add constraint tblPerson_GenderId_FK FOREIGN KEY (GenderId) references tblGender(ID)


The general formula is here
Alter table ForeignKeyTable add constraint ForeignKeyTable_ForiegnKeyColumn_FK 
FOREIGN KEY (ForiegnKeyColumn) references PrimaryKeyTable (PrimaryKeyColumn)




Alter table tblPerson add constraint tblPerson_GenderID_FK
Foreign key (GenderId) references tblGender(ID)



Altering an existing column to add a default constraint:
ALTER TABLE { TABLE_NAME }
ADD CONSTRAINT { CONSTRAINT_NAME }
DEFAULT { DEFAULT_VALUE } FOR { EXISTING_COLUMN_NAME }


Adding a new column, with default value, to an existing table:
ALTER TABLE { TABLE_NAME } 
ADD { COLUMN_NAME } { DATA_TYPE } { NULL | NOT NULL } 
CONSTRAINT { CONSTRAINT_NAME } DEFAULT { DEFAULT_VALUE }


The following command will add a default constraint, DF_tblPerson_GenderId.
ALTER TABLE tblPerson
ADD CONSTRAINT DF_tblPerson_GenderId
DEFAULT 1 FOR GenderId

To drop a constraint
ALTER TABLE { TABLE_NAME } 
DROP CONSTRAINT { CONSTRAINT_NAME }

To delete any row:
delete from (Table name) where (Column Id =ID number)
......................................................................................................................


##Check constraints 
CHECK constraint is used to limit the range of the values, that can be entered for a column.

The following check constraint, limits the age between ZERO and 150.
ALTER TABLE tblPerson
ADD CONSTRAINT CK_tblPerson_Age CHECK (Age > 0 AND Age < 150)


The general formula for adding check constraint in SQL Server:
ALTER TABLE { TABLE_NAME }
ADD CONSTRAINT { CONSTRAINT_NAME } CHECK ( BOOLEAN_EXPRESSION )

To drop the CHECK constraint:
ALTER TABLE tblPerson
DROP CONSTRAINT CK_tblPerson_Age
......................................................................................................................

###Identity column in SQL Server
If a column is marked as an identity column, then the values for this column are automatically generated, when you insert a new row into the table. The following, create table statement marks PersonId as an identity column with seed = 1 and Identity Increment = 1. Seed and Increment values are optional. If you don't specify the identity and seed they both default to 1.


Create Table tblPerson
(
PersonId int Identity(1,1) Primary Key,
Name nvarchar(20)
)

In the following 2 insert statements, we only supply values for Name column and not for PersonId column. 
Insert into tblPerson values ('Sam')
Insert into tblPerson values ('Sara')

turn on identity insert ->>>>> SET Identity_Insert tblPerson ON
2. In the insert query specify the column list
    Insert into tblPerson(PersonId, Name) values(2, 'John')
......................................................................................................................


##How to get the last generated identity column value in SQL Server - Part 8

Example queries for getting the last generated identity value
Select SCOPE_IDENTITY()
Select @@IDENTITY
Select IDENT_CURRENT('tblPerson')

In brief:
SCOPE_IDENTITY() - returns the last identity value that is created in the same session and in the same scope.
@@IDENTITY - returns the last identity value that is created in the same session and across any scope.
IDENT_CURRENT('TableName') - returns the last identity value that is created for a specific table across any session and any scope.
......................................................................................................................

##Unique key constraint - Part 9
We use UNIQUE constraint to enforce uniqueness of a column i.e the column shouldn't allow any duplicate values. We can add a Unique constraint thru the designer or using a query.

To create the unique key using a query:
Alter Table Table_Name
Add Constraint Constraint_Name Unique(Column_Name)
......................................................................................................................


##To select the columns:

USE [Mysample##Name of the database]
GO

SELECT [PersonID]---1         1, 2 and 3 are the name of columns
      ,[PName]----2
      ,[Age]----3
  FROM [dbo #schema].[Tableperson1 #table name]

GO


---To selet particular column:(suppose i want to select Age column)
select age form Tableperson1

----If data is repeated and want it as distinct:
select distinct age form tableperson1
......................................................................................................................


##select statement - Part 10
Basic select statement syntax
SELECT Column_List
FROM Table_Name

If you want to select all the columns, you can also use *. For better performance use the column list, instead of using *.
SELECT *
FROM Table_Name
To Select distinct rows use DISTINCT keyword
SELECT DISTINCT Column_List
FROM Table_Name

Example: Select distinct city from tblPerson

Filtering rows with WHERE clause
SELECT Column_List
FROM Table_Name
WHERE Filter_Condition

Example: Select Name, Email from tblPerson where City = 'London'

create table employee
(SN int NOT NULL Primary key,
Name nvarchar(50) not null,
Gender nvarchar(50) not null,
Salary int not null,
City nvarchar(50) not null
)

Insert into employee values(7,'Lxme', 'F',2100, 'Butwal') 
select * from employee



Select  *  from employee Where Salary between 2050 and 2200


Select  *  from employee Where Salary between 2050 and 2200
......................................................................................................................

###Grouping
select * from employee

To calculate sum:
select sum(salary)from employee

To calculate minimum and maximum salary:
select max(salary) from employee
select min(salary) from employee

To calculate salary total by city
select city, sum(salary) as total_salary from employee

group by city

to calculate total by city and by gender with total employees
select city, gender, sum(salary) as total_salary, count(SN) as [Total Employees] from employee
group by city, gender
order by city

to calculate total by city and by gender with total employees just for males
select city, gender, sum(salary) as total_salary, count(SN) as [Total Employees] from employee
where gender='M'
group by city, gender
order by city

select city, gender, sum(salary) as total_salary, count(SN) as [Total Employees] from employee
group by city, gender
having sum(salary)>2000
order by city
......................................................................................................................

###JOINS

Create table tblDepartment
(
     ID int primary key,
     DepartmentName nvarchar(50),
     Location nvarchar(50),
     DepartmentHead nvarchar(50)
)
Go

Insert into tblDepartment values (1, 'IT', 'London', 'Rick')
Insert into tblDepartment values (2, 'Payroll', 'Delhi', 'Ron')
Insert into tblDepartment values (3, 'HR', 'New York', 'Christie')
Insert into tblDepartment values (4, 'Other Department', 'Sydney', 'Cindrella')
Go

Create table tblEmployee
(
     ID int primary key,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int foreign key references tblDepartment(Id)
)
Go

Insert into tblEmployee values (1, 'Tom', 'Male', 4000, 1)
Insert into tblEmployee values (2, 'Pam', 'Female', 3000, 3)
Insert into tblEmployee values (3, 'John', 'Male', 3500, 1)
Insert into tblEmployee values (4, 'Sam', 'Male', 4500, 2)
Insert into tblEmployee values (5, 'Todd', 'Male', 2800, 2)
Insert into tblEmployee values (6, 'Ben', 'Male', 7000, 1)
Insert into tblEmployee values (7, 'Sara', 'Female', 4800, 3)
Insert into tblEmployee values (8, 'Valarie', 'Female', 5500, 1)
Insert into tblEmployee values (9, 'James', 'Male', 6500, NULL)
Insert into tblEmployee values (10, 'Russell', 'Male', 8800, NULL)
Go
select * from [dbo].[tblDepartment]
select * from [dbo].[tblEmployee]
---Inner joint which prints all the matching rows only
select Name, Gender, Salary, DepartmentName
from tblEmployee
JOIN tblDepartment
on tblEmployee.DepartmentId =tblDepartment.ID

---Left Outer join of Left join which prints all the matching and non matching rows

select Name, Gender, Salary, DepartmentName
from tblEmployee
left JOIN tblDepartment
on tblEmployee.DepartmentId =tblDepartment.ID

---Right outer join or right join which prints all the matching records plus non matching rows from right table

select Name, Gender, Salary, DepartmentName
from tblEmployee
right JOIN tblDepartment
on tblEmployee.DepartmentId =tblDepartment.ID

---full outer join or full join which prints all the matching results from both right and left table
select Name, Gender, Salary, DepartmentName
from tblEmployee
full JOIN tblDepartment
on tblEmployee.DepartmentId =tblDepartment.ID

---cross join which prints cartician product of two tables means output will be multiplied
select Name, Gender, Salary, DepartmentName
from tblEmployee
cross JOIN tblDepartment

......................................................................................................................

###OTHER JOINS
---Advanced or intellent joins
---1. for non matching rows from first table only
select Name, Gender, Salary, DepartmentName
from tblEmployee
left join  tblDepartment
on tblEmployee.DepartmentId =tblDepartment.ID
where tblDepartment.ID is null

---2. for non matching rows from second table only
select Name, Gender, Salary, DepartmentName
from tblEmployee
right join  tblDepartment
on tblEmployee.DepartmentId =tblDepartment.ID
where tblEmployee.DepartmentId is null

---3 for non matching rows from both table
select Name, Gender, Salary, DepartmentName
from tblEmployee
full join  tblDepartment
on tblEmployee.DepartmentId =tblDepartment.ID
where tblEmployee.DepartmentId is null
or tblDepartment.ID is null
......................................................................................................................

###Different ways to replace NULL in sql server - Part 15
Create table manager1
(
     EmployeeID int primary key,
     Name nvarchar(50),
     Managerid int,
     
)
Go

Insert into manager1 values (1, 'Mike', 3)
Insert into manager1 values (2, 'Rob', 1)
Insert into manager1 values (3, 'Todd',null)
Insert into manager1 values (4, 'Ben', 1)
Insert into manager1 values (5, 'Sam', 1)
Go
---to replace the name of manager by employee id

select E.Name as Employee, M.Name as Manager
from   manager1 E
left join manager1 M
on	E.Managerid=M.EmployeeID

---to replace null, insted of (isnull), we can use (coalesce), the result will be same
select E.Name as Employee, isnull(M.Name, 'No manager') as Manager
from   manager1 E
left join manager1 M
on	E.Managerid=M.EmployeeID

---we can do it by creating a case too, result will be the same
select E.Name as Employee, case when M.Name is null then 'No manager' else M.name end  as Manager
from   manager1 E
left join manager1 M
on	E.Managerid=M.EmployeeID

..........................................................................................

###---Coalesce function in sql server Part 16,
 coalesce returns the first non null value
create table coalesce1
(ID int not null primary key,
FIrstName nvarchar(50),
MiddleName nvarchar(50),
LastName nvarchar(50)
)
insert into coalesce1 values (1, 'Sam',NULL,NULL)
insert into coalesce1 values (2, NULL,'Tod','Tarjan')
insert into coalesce1 values (3, NULL,NULL,'Sara')
insert into coalesce1 values (4, 'Ben','Parker',NULL)
insert into coalesce1 values (5, 'James','Nick','Nancy')

Select * from coalesce1

---if first name is null, middle name will be printed and if Middle name is also null, Last name will be printed,, means it prints first non null value
select ID, COALESCE (FirstName, MiddleName, LastName) as Name
from coalesce1

..........................................................................................................
####
---Creating store procedure, it stores a code into it

 create procedure SPGetcoalesce1
as
begin
select * from coalesce1
end

SPGetcoalesce1

---store procedure with passing parameters
create procedure SPGetcoalesce1byfirstandsecondname
@Firstname nvarchar(50),
@MiddleName nvarchar(50)
as
begin
select FIrstName, MiddleName, LastName from coalesce1 where FirstName=@Firstname and MiddleName=@MiddleName
end

SPGetcoalesce1byfirstandsecondname 'James','Nick'


--to view the code of store procedure
sp_helptext SPGetcoalesce1byfirstandsecondname

--to encrypt store procedure
alter procedure SPGetcoalesce1byfirstandsecondname
@Firstname nvarchar(50),
@MiddleName nvarchar(50)
with encryption
as
begin
select FIrstName, MiddleName, LastName from coalesce1 where FirstName=@Firstname and MiddleName=@MiddleName
end

..................................................................................................................................................


####
---Built in string functions in sql server
---1.ASCII
select ASCII('ABC')--returns the ASCII value of A only

--2. CHAR, prints the Charatcer of ASCII code
select char(65)
--to print all the values of 65(A) to 91(Z)
declare @start int
set @start=65
while(@start<=90)
begin
print char(@start)
set @start=@start+1
end


--LTRIM removes the white spaces on left hand side, RTRIM removes same in right hand side
select LTRIM('    Hello')
--to convert into uppercase
Example: Select LOWER('CONVERT This String Into Lower Case')
Output: convert this string into lower case

Example: Select UPPER('CONVERT This String Into upper Case')
Output: CONVERT THIS STRING INTO UPPER CASE

REVERSE('Any_String_Expression') - Reverses all the characters in the given string expression.
Example: Select REVERSE('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
Output: ZYXWVUTSRQPONMLKJIHGFEDCBA

LEN(String_Expression) - Returns the count of total characters, in the given string expression, excluding the blanks at the end of the expression.

Example: Select LEN('SQL Functions   ')
Output: 13
.......................................................................................................................


####Store procedures examples

create procedure spGetEmployeeccountbygender
@Gender nvarchar(20),
@Employeecount int output
as
begin
 select @Employeecount =COUNT(ID) from tblEmployee where Gender= @Gender
End

--to execute this store procedure
declare @employeetotal int
execute spGetEmployeeccountbygender 'Male', @employeetotal output
print  @employeetotal



##### Inline table valued functions in sql server Part 31

create function FN_employrrsbygender (@Gender nvarchar(10))
returns table
as 
return (select ID, Name, Gender, salary, departmentID 
from tblEmployee
where Gender=@Gender)
---to execute this query

select * from FN_employrrsbygender ('Female')


######
--multi statement table valued function
create function fn_Getemployees()
returns @Table table (ID int, Name nvarchar(20), Salary int)
as
Begin
insert into @Table 
select ID, Name, Salary from tblEmployee
return
end

--to execute this code
select * from fn_Getemployees()

...............................................................................................

####Pivot operator in sql server - Part 54

Pivot is a sql server operator that can be used to turn unique values from one column, into multiple columns in the output, there by effectively rotating a table.

.........................................................................................................................................................

###Random table generation.....

-- If Table exists drop the tables
If (Exists (select * 
            from information_schema.tables 
            where table_name = 'tblProductSales'))
Begin
 Drop Table tblProductSales
End

If (Exists (select * 
            from information_schema.tables 
            where table_name = 'tblProducts'))
Begin
 Drop Table tblProducts
End



-- Recreate tables
Create Table tblProducts
(
 [Id] int identity primary key,
 [Name] nvarchar(50),
 [Description] nvarchar(250)
)

Create Table tblProductSales
(
 Id int primary key identity,
 ProductId int foreign key references tblProducts(Id),
 UnitPrice int,
 QuantitySold int
)

--Insert Sample data into tblProducts table
Declare @Id int
Set @Id = 1

While(@Id <= 300000)
Begin
 Insert into tblProducts values('Product - ' + CAST(@Id as nvarchar(20)), 
 'Product - ' + CAST(@Id as nvarchar(20)) + ' Description')
 
 Print @Id
 Set @Id = @Id + 1
End

-- Declare variables to hold a random ProductId, 
-- UnitPrice and QuantitySold
declare @RandomProductId int
declare @RandomUnitPrice int
declare @RandomQuantitySold int

-- Declare and set variables to generate a 
-- random ProductId between 1 and 100000
declare @UpperLimitForProductId int
declare @LowerLimitForProductId int

set @LowerLimitForProductId = 1
set @UpperLimitForProductId = 100000

-- Declare and set variables to generate a 
-- random UnitPrice between 1 and 100
declare @UpperLimitForUnitPrice int
declare @LowerLimitForUnitPrice int

set @LowerLimitForUnitPrice = 1
set @UpperLimitForUnitPrice = 100

-- Declare and set variables to generate a 
-- random QuantitySold between 1 and 10
declare @UpperLimitForQuantitySold int
declare @LowerLimitForQuantitySold int

set @LowerLimitForQuantitySold = 1
set @UpperLimitForQuantitySold = 10

--Insert Sample data into tblProductSales table
Declare @Counter int
Set @Counter = 1

While(@Counter <= 45000)
Begin
 select @RandomProductId = Round(((@UpperLimitForProductId - @LowerLimitForProductId) * Rand() + @LowerLimitForProductId), 0)
 select @RandomUnitPrice = Round(((@UpperLimitForUnitPrice - @LowerLimitForUnitPrice) * Rand() + @LowerLimitForUnitPrice), 0)
 select @RandomQuantitySold = Round(((@UpperLimitForQuantitySold - @LowerLimitForQuantitySold) * Rand() + @LowerLimitForQuantitySold), 0)
 
 Insert into tblProductsales 
 values(@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

 Print @Counter
 Set @Counter = @Counter + 1
End


Select * from tblProducts
Select * from tblProductSales

.....................................................................................................................................................

---### list all the tables from sample database

select * from sysobjects where xtype='U' ---U stands for user table
select * from sysobjects where xtype='V' ---V stands for view
select * from sysobjects where xtype='S' ---s stands for system table
select * from sysobjects where xtype='FN' ---FN stands for functions

................................................................................................................................



---###re-runnable SQL server scripts
---no matter how many times you run it, it is re-runnable and it doesn't throw an error
use [Mysample]
if not exists (select * from INFORMATION_SCHEMA.tables where table_name='tblEmployee')
begin
create table tblemployee
(
Id int identity primary key,
Name nvarchar(100),
Gender nvarchar(10),
Dateofbirth DateTime
)
Print 'Table tblemployee has been created successfully'
end
else 
begin
Print'Table tblemployee already exists'
end
...................................................................................................................................



--- to change the data type of column, graphically it's so hard, here salary column datatype is nvarchar, if we want to change into int, we have the following query:

Alter table tblEmployee
Alter column Salary int

...........................................................................................


                             				###Deadlock

--transaction 1
begin transaction
update tableA set name= 'Not Prabin' 
where Id =1

update tableB set name=' Not Avii'
where id=1
commit transaction

--transaction 2
begin transaction
update tableB set name=' yes Avii'
where id=1


update tableA set name= 'yes Prabin' 
where Id =1

commit transaction

$$$$$$when we run the first transaction, first part, tableA will be blocked, at the same time when we run the first part of transaction 2, tableB will be blocked. Again when we run second part of the first transaction, the table was blocked by transaction 2 and again when we run the second part of transaction 2 which table was blocked by trans1, then deadlock occurs.

.......................................................................................................................................

###Create Table TableA
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableA values (1, 'Mark', 'Male')
Insert into TableA values (2, 'Mary', 'Female')
Insert into TableA values (3, 'Steve', 'Male')
Insert into TableA values (4, 'John', 'Male')
Insert into TableA values (5, 'Sara', 'Female')
Go

Create Table TableB
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableB values (4, 'John', 'Male')
Insert into TableB values (5, 'Sara', 'Female')
Insert into TableB values (6, 'Pam', 'Female')
Insert into TableB values (7, 'Rebeka', 'Female')
Insert into TableB values (8, 'Jordan', 'Male')
Go

select * from tableA
select * from tableB

----Except operator returns the non matching rows
select * from tableA
except
select * from tableB

---intersect prints all the matching rows from left and right query, innor join does the same
select * from tableA
intersect
select * from tableB

--creating ddl trigger
---1. for table creation trigger
create trigger createtabletrigger
on database
for create_table
as 
begin
print 'New table has been created'
end

create table test (Id int)

............................................................................................................................

###
---difference brtween having and where
----having will search for indivisual rows but where searches for particular product


Create table Sales
(
    Product nvarchar(50),
    SaleAmount int
)
Go

Insert into Sales values ('iPhone', 500)
Insert into Sales values ('Laptop', 800)
Insert into Sales values ('iPhone', 1000)
Insert into Sales values ('Speakers', 400)
Insert into Sales values ('Laptop', 600)
Go
select * from Sales

select Product, sum(Saleamount) as Totalsales
from Sales
where product in ('iphone', 'laptop')
group by Product

select Product, sum(Saleamount) as Totalsales
from Sales
group by Product
having product in ('iphone', 'laptop')

......................................................................................

###How to create table variable??

SQL Script to create the Employees table
Create Table Employees
(
 Id int primary key,
 Name nvarchar(50),
 Gender nvarchar(10)
)
Go

Step 1 : Create User-defined Table Type

CREATE TYPE EmpTableType AS TABLE
(
 Id INT PRIMARY KEY,
 Name NVARCHAR(50),
 Gender NVARCHAR(10)
)
Go

Step 2 : Use the User-defined Table Type as a parameter in the stored procedure. Table valued parameters must be passed as read-only to stored procedures, functions etc. This means you cannot perform DML operations like INSERT, UPDATE or DELETE on a table-valued parameter in the body of a function, stored procedure etc.

CREATE PROCEDURE spInsertEmployees
@EmpTableType EmpTableType READONLY
AS
BEGIN
 INSERT INTO Employees
 SELECT * FROM @EmpTableType
END

Step 3 : Declare a table variable, insert the data and then pass the table variable as a parameter to the stored procedure.

DECLARE @EmployeeTableType EmpTableType 

INSERT INTO @EmployeeTableType VALUES (1, 'Mark', 'Male')
INSERT INTO @EmployeeTableType VALUES (2, 'Mary', 'Female')
INSERT INTO @EmployeeTableType VALUES (3, 'John', 'Male')
INSERT INTO @EmployeeTableType VALUES (4, 'Sara', 'Female')
INSERT INTO @EmployeeTableType VALUES (5, 'Rob', 'Male')

EXECUTE spInsertEmployees @EmployeeTableType

That's it. Now select the data from Employees table and notice that all the rows of the table variable are inserted into the Employees table.


,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,





























































































