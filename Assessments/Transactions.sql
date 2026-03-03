CREATE DATABASE BankDB;
USE BankDB;


CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10,2)
);

--Deleting values from table
TRUNCATE TABLE Accounts;
TRUNCATE TABLE TransactionLog;

-- Insert two sample accounts
INSERT INTO accounts (account_id, name, balance) VALUES (1, 'Ravi', 5000);
INSERT INTO accounts (account_id, name, balance) VALUES (2, 'Tejas', 3000);


CREATE TABLE TransactionLog
(
    LogID INT IDENTITY(1,1),
    AccountID INT,
    OldBalance DECIMAL(10,2),
    NewBalance DECIMAL(10,2),
    ChangeDate DATETIME
);

SELECT * FROM Accounts;
SELECT * FROM TransactionLog;

-- Start a transaction
BEGIN TRANSACTION;
-- Step 1: Deduct from Ravi
UPDATE accounts SET balance = balance - 10000 WHERE account_id = 1;
-- Step 2: Add to Tejas
UPDATE accounts SET balance = balance + 10000 WHERE account_id = 2;
-- Commit the transaction
COMMIT;

--Start Transaction
BEGIN TRANSACTION
DECLARE @balance DECIMAL(10,2);

SELECT @balance = balance
FROM Accounts
WHERE account_id = 1;

IF @balance < 1000
  BEGIN
    PRINT 'Insufficient balance!';
    ROLLBACK TRANSACTION;
    RETURN;
 END

UPDATE accounts 
SET balance = balance - 1000 
WHERE account_id = 1;

UPDATE accounts 
SET balance = balance + 1000
WHERE account_id = 2;

COMMIT TRANSACTION;
    PRINT 'Transaction Successful';

-- Creating Trigger
CREATE TRIGGER trg_LogBalanceChange
ON accounts
AFTER UPDATE
AS
BEGIN
    PRINT 'Trigger Fired: Balance Updated Successfully';

    INSERT INTO TransactionLog (AccountID, OldBalance, NewBalance, ChangeDate)
    SELECT 
        d.account_id,
        d.balance AS OldBalance,
        i.balance AS NewBalance,
        GETDATE()
    FROM deleted d
    JOIN inserted i 
        ON d.account_id = i.account_id;
END;

--Droping Trigger
DROP TRIGGER trg_LogBalanceChange;