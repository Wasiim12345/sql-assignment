show databases;
use mysql;
select * from component;

CREATE TABLE EmployeeDetail (
  EmpId INT PRIMARY KEY,
  FullName VARCHAR(255),
  ManagerId INT,
  DateOfJoining DATE,
  City VARCHAR(255)
);

CREATE TABLE EmployeSalary (
  EmpId INT PRIMARY KEY,
  Project VARCHAR(255),
  Salary DECIMAL(10, 2),
  Variable DECIMAL(10, 2)
);

-- 1.) SQL Query to fetch records that are present in one table but not in another table 
SELECT EmployeeDetail.*
FROM EmployeeDetail
LEFT JOIN EmployeSalary ON EmployeeDetail.EmpId = EmployeSalary.EmpId
WHERE EmployeSalary.EmpId IS NULL;

-- 2.) SQL query to fetch all the employees who are not working on any project.
SELECT EmployeeDetail.*
FROM EmployeeDetail
LEFT JOIN EmployeSalary ON EmployeeDetail.EmpId = EmployeSalary.EmpId
WHERE EmployeSalary.Project IS NULL;

-- 3.)SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.
SELECT *
FROM EmployeeDetail
WHERE YEAR(DateOfJoining) = 2020;

-- 4.)Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
SELECT EmployeeDetail.*
FROM EmployeeDetail
INNER JOIN EmployeSalary ON EmployeeDetail.EmpId = EmployeSalary.EmpId;

-- 5.)Write an SQL query to fetch a project-wise count of employees.
SELECT Project, COUNT(*) AS EmployeeCount
FROM EmployeSalary
GROUP BY Project;

-- 6.)Fetch employee names and salaries even if the salary value is not present for the employee.
SELECT EmployeeDetail.FullName, EmployeSalary.Salary
FROM EmployeeDetail
LEFT JOIN EmployeSalary ON EmployeeDetail.EmpId = EmployeSalary.EmpId;

-- 7.)Write an SQL query to fetch all the Employees who are also managers.
SELECT E.*
FROM EmployeeDetail E
INNER JOIN EmployeeDetail M ON E.EmpId = M.ManagerId;

-- 8.)Write an SQL query to fetch duplicate records from EmployeeDetails.
SELECT EmpId, FullName, COUNT(*) AS DuplicateCount
FROM EmployeeDetail
GROUP BY EmpId, FullName
HAVING COUNT(*) > 1;

-- 9.)Write an SQL query to fetch only odd rows from the table.
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
  FROM EmployeeDetail
) AS Subquery
WHERE RowNum % 2 <> 0;

-- 10)Write a query to find the 3rd highest salary from a table without top or limit keyword.
SELECT Salary
FROM (
  SELECT Salary, ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
  FROM EmployeSalary
) AS Subquery
WHERE RowNum = 3;