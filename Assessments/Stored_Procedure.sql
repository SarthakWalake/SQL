USE Spektra

-- STORED PROCEDURE.

CREATE PROCEDURE sp_EmpProcedure
@Salary INT
AS
BEGIN
UPDATE Employees SET Salary = @Salary
WHERE Salary > @Salary
END


-- CALLING STORED PROCEDURE. 
EXECUTE sp_EmpProcedure 10000



-- CREATING STORED PROCEDURE.
CREATE PROCEDURE sp_MidPoint @LowerNumber INT , @HigherNumber INT
AS
  BEGIN
    DECLARE @Mid INT
    IF @LowerNumber > @HigherNumber
      RAISERROR('YOU HAVE ENTERED ',16,1)
       SET @Mid = ((@HigherNumber - @LowerNumber) / 2) + @LowerNumber
       SELECT @Mid
   END



-- CALLING STORED PROCEDURE.
EXECUTE sp_MidPoint 20 , 30



-- DROPING STORED PROCEDURE.
DROP PROCEDURE sp_MidPoint




-- CREATING STORED PROCEDURE WITH OUTPUT PARAMETER.
CREATE PROCEDURE sp_MathTutor
 @m1 SMALLINT,
 @m2 SMALLINT,
 @result INT OUTPUT
AS
  SET @result = @m1 * @m2
GO


--EXECUTING STORED PROCEDURE.
DECLARE @answer SMALLINT
EXECUTE sp_MathTutor 5 , 6 , @answer OUTPUT
SELECT CONCAT('THE RESULT IS  ',@answer)



USE Northwind

-- CURD OPERATIONS USING STORED PROCEDURE.
-- CREATING NEW PROCEDURE FOR INSERT.
CREATE PROCEDURE sp_NewEmployee
@LastName NVARCHAR(20),
@FirstName NVARCHAR(20) 
AS
 BEGIN 
   INSERT INTO Employees(LastName , FirstName)
   VALUES (@LastName , @FirstName)
   RETURN SCOPE_IDENTITY()
  END

   
   
  
  -- CREATING ANOTHER NEW PROCEDURE THAT CALL PREVIOUS STORED PROCEDURE
 CREATE PROCEDURE sp_CallNewEmployee @lastname VARCHAR(10) , @firstname VARCHAR(10)
  AS
   BEGIN
    DECLARE @NewEmployeeId INT 
    EXECUTE @NewEmployeeId = sp_NewEmployee
    @LastName = @lastname , @FirstName = @firstname
    SELECT e.EmployeeID , e.LastName , e.FirstName
    FROM Employees e
    WHERE EmployeeID = @NewEmployeeId
   END



-- CALLING PROCEDURE
 EXECUTE sp_CallNewEmployee 'Vinu' , 'naik'



 -- CREATING STORED PROCEDURE FOR UPDATE
 CREATE PROCEDURE sp_UpdateEmployee
 @employeeId INT,
 @address VARCHAR(20)
 AS
   BEGIN
      UPDATE Employees SET Address = @address
      WHERE EmployeeID = @employeeId;

      SELECT * FROM Employees
  END


-- Calling procedure    
EXECUTE sp_UpdateEmployee 10,'pune'




-- CREATING STORED PROCEDURE FOR DELETE 
CREATE PROCEDURE sp_DeleteEmployee
@employeeId INT
AS
 BEGIN
   DELETE FROM Employees 
   WHERE EmployeeID = @employeeId

   SELECT * FROM Employees
  END


-- Calling Stored procedure for delete
EXECUTE sp_DeleteEmployee 11


      



