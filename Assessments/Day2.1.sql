-- Create Dept table
CREATE TABLE Dept (
    Deptno INT,
    Deptname VARCHAR(20),
    Location VARCHAR(20)
);

-- Insert records
INSERT INTO Dept (Deptno, Deptname, Location) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO Dept (Deptno, Deptname, Location) VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO Dept (Deptno, Deptname, Location) VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO Dept (Deptno, Deptname, Location) VALUES (40, 'OPERATIONS', 'BOSTON');


-- Create Emp table
CREATE TABLE Emp (
    Empno INT,
    Ename VARCHAR(20),
    Job VARCHAR(9),
    Mgr INT,
    Hiredate DATE,
    Sal FLOAT,
    Comm FLOAT,
    Deptno INT
);

-- Insert records
INSERT INTO Emp VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO Emp VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);
INSERT INTO Emp VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);
INSERT INTO Emp VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);
INSERT INTO Emp VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);
INSERT INTO Emp VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
INSERT INTO Emp VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);

CREATE TABLE Student
(
 RollNo INT PRIMARY KEY,
 FirstName VARCHAR(20),
 LastName VARCHAR(20),
 DateofBirth Date,
 Gender VARCHAR(10),
 Email VARCHAR(20) UNIQUE
 )

 
SELECT e.Ename 
FROM Emp e 
where e.Ename LIKE 'N%N'


SELECT *
FROM Emp
WHERE Ename LIKE '%a%'
AND Ename LIKE '%i%'
AND Ename NOT LIKE '%e%';


SELECT *
FROM Emp
WHERE Job IN ('CLERK', 'MANAGER')
AND Deptno IN (10, 20);


SELECT *
FROM Emp
WHERE Comm IS NULL
AND Sal IS NOT NULL;


DELETE FROM Emp
WHERE Sal IS NULL;


SELECT *
FROM Emp
WHERE LEN(Ename) >= 5;


SELECT *
FROM Emp
WHERE Ename LIKE 'A%'
   OR Ename LIKE 'E%'
   OR Ename LIKE 'I%'
   OR Ename LIKE 'O%'
   OR Ename LIKE 'U%';


SELECT Ename
FROM Emp
WHERE Deptno IN (10, 20, 40)
   OR Job IN ('CLERK', 'SALESMAN', 'ANALYST');