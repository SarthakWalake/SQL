CREATE TABLE Employee_Test(
Emp_ID INT IDENTITY,
Emp_name VARCHAR(100),
Emp_Sal DECIMAL(10,2)
)

INSERT INTO Employee_Test VALUES('Sarthak',1000);
INSERT INTO Employee_Test VALUES('Nayan',1200);
INSERT INTO Employee_Test VALUES('Vinu',1100);
INSERT INTO Employee_Test VALUES('Omkar',1300);
INSERT INTO Employee_Test VALUES('Rudra',1400);


CREATE TABLE Employee_Test_Audit(
Emp_ID INT,
Emp_name VARCHAR(100),
Emp_Sal DECIMAL(10 , 2),
Audit_Action VARCHAR(100),
Audit_Timestamp DATETIME
)

-- CREATING TRIGGER FOR INSERT
CREATE TRIGGER trgAfterInsert ON Employee_Test
FOR INSERT
AS 
	DECLARE @empid INT;
	DECLARE @empname VARCHAR(100);
	DECLARE @empsal DECIMAL(10,2);
	DECLARE @audit_action VARCHAR(100);

	SELECT @empid = i.Emp_ID FROM INSERTED i;
	SELECT @empname = i.Emp_name FROM INSERTED i;
	SELECT @empsal = i.Emp_Sal FROM INSERTED i;
	SET @audit_action='Inserted Record -- After Insert Trigger.';

	INSERT INTO Employee_Test_Audit
		(Emp_ID , Emp_name , Emp_Sal , Audit_Action , Audit_Timestamp)
		VALUES
		(@empid , @empname , @empsal , @audit_action , GETDATE());

		PRINT 'AFTER INSERT TRIGGER FIRED'
GO

--INSERTING VALUES
INSERT INTO Employee_Test VALUES ('SAURABH',1500);


-- CREATING TRIGGER FOR UPDATE 
CREATE TRIGGER trgAfterUpdate ON Employee_Test
FOR UPDATE 
AS 
	DECLARE @empid INT;
	DECLARE @empname VARCHAR(100);
	DECLARE @empsal DECIMAL(10,2);
	DECLARE @audit_action VARCHAR(100);

	SELECT @empid = i.Emp_ID FROM INSERTED i;
	SELECT @empname = i.Emp_name FROM INSERTED i;
	SELECT @empsal = i.Emp_Sal FROM INSERTED i;

	IF UPDATE(Emp_name)
		SET @audit_action = 'UPDATED RECORD -- AFTER UPDATE TRIGGER.';
	IF UPDATE(Emp_Sal)
		SET @audit_action = 'UPDATED RECORD -- AFTER UPDATE TRIGGER.';

INSERT INTO Employee_Test_Audit(Emp_ID , Emp_name , Emp_Sal , Audit_Action , Audit_Timestamp)
				VALUES
(@empid , @empname , @empsal , @audit_action , GETDATE());

	PRINT ' AFTER UPDATE TRIGGER FIRED'
GO

--UPDATING THE SALARY
UPDATE Employee_Test SET Emp_Sal = 1500 WHERE Emp_ID = 6
