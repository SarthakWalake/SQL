USE Spektra

-- STORED PROCEDURE

CREATE PROCEDURE SpEmpProcedure
@Salary INT
AS
BEGIN
UPDATE Employees SET Salary = @Salary
WHERE Salary > @Salary
END

EXECUTE SpEmpProcedure 10000