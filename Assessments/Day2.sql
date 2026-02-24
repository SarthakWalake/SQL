
CREATE TABLE Department
(
Depid int PRIMARY KEY,
DepName varchar(10)
)

CREATE TABLE Employees
(
Empid int PRIMARY KEY,
EmpName varchar(20),
Salary int,
Depid int FOREIGN KEY REFERENCES Department(Depid)
)

INSERT INTO Department VALUES(1 , 'HR')
INSERT INTO Department VALUES(2 , 'ADIM');
INSERT INTO Department VALUES(3 , 'SOFTWARE');
INSERT INTO Department VALUES(4 , 'TESTER');

INSERT INTO Employees VALUES(1 , 'SARTHAK' , 50000 , 3);
INSERT INTO Employees VALUES(2 , 'NAYAN' , 55000 , 3);
INSERT INTO Employees VALUES(3 , 'VINU' , 40000 , 1);
INSERT INTO Employees VALUES(4 , 'OM' , 30000 , 4);
INSERT INTO Employees VALUES(5 , 'RUDRA' , 20000 , 1);
INSERT INTO Employees VALUES(6 , 'SAURABH' , 25000 , 2);
INSERT INTO Employees VALUES(7 , 'LOKESH' , 27000 , 3);
INSERT INTO Employees VALUES(8 , 'SAINKA' , 10000 , NULL);
INSERT INTO Employees VALUES(9 , 'OMKAR' , 5000 , 4);



-- INNER JOIN
SELECT e.Empid , e.EmpName , e.Salary , d.DepName FROM Employees e
JOIN Department d ON d.Depid = e.Depid; 


-- INNER JOIN WITH CONDITION
SELECT e.Empid , e.EmpName , e.Salary , d.DepName FROM Employees e
JOIN Department d ON d.Depid = e.Depid
WHERE d.Depid = 1; 


-- JOIN AND GROUP BY
SELECT d.DepName, COUNT(e.Empid) AS Employee_Count
FROM Employees e
JOIN Department d ON e.Depid = d.Depid
GROUP BY d.DepName;


-- DEPARTMENT WISE SALARY REPORT
SELECT d.DepName,
    COUNT(e.Empid) AS Employee_Count,
    SUM(e.Salary) AS Total_Salary,
    AVG(e.Salary) AS Average_Salary 
FROM Employees e JOIN Department d ON e.Depid = d.Depid
GROUP BY d.DepName;



-- FULL OUTER JOIN
SELECT e.Empid , e.EmpName , e.Salary , d.DepName FROM Employees e
FULL OUTER JOIN Department d ON d.Depid = e.Depid;


-- AVERAGE SALARY
SELECT d.DepName,
AVG(e.Salary) AS Average_Salary
FROM Employees e JOIN Department d ON e.Depid = d.Depid
GROUP BY d.DepName;

-- HIGHEST SALARY
SELECT e.EmpName , d.DepName
FROM Employees e JOIN Department d ON e.Depid = d.Depid
WHERE e.Salary = (SELECT MAX(Salary) FROM Employees);



-- LOWEST SALARY
SELECT e.EmpName
FROM Employees e JOIN Department d ON e.Depid = d.Depid
WHERE e.Salary = (SELECT MIN(Salary) FROM Employees);


-- HIGHEST SALARY PAID DEPARTMENT AND TOTAL SALARY PAID BY DEPARTMENT
SELECT d.DepName,
SUM(e.Salary) AS Total_Salary
FROM Employees e JOIN Department d ON e.DepID = d.Depid
WHERE e.Depid = (SELECT Depid FROM Employees
                 WHERE Salary = (SELECT MAX(Salary) FROM Employees) )
GROUP BY d.DepName;