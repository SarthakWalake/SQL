CREATE DATABASE BankDB;
USE BankDB;


CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10,2)
);

-- Insert two sample accounts
INSERT INTO accounts (account_id, name, balance) VALUES (1, 'Ravi', 50000);
INSERT INTO accounts (account_id, name, balance) VALUES (2, 'Tejas', 30000);

SELECT * FROM Accounts;

-- Start a transaction
BEGIN TRANSACTION;

-- Step 1: Deduct from Ravi
UPDATE accounts SET balance = balance - 10000 WHERE account_id = 1;

-- Step 2: Add to Tejas
UPDATE accounts SET balance = balance + 10000 WHERE account_id = 2;

-- Commit the transaction
COMMIT;


BEGIN TRANSACTION
DECLARE @balance DECIMAL(10,2);

SELECT @balance = balance
FROM Accounts
WHERE account_id = 1;

IF @balance < 10000
  BEGIN
    PRINT 'Insufficient balance!';
    ROLLBACK TRANSACTION;
    RETURN;
 END

UPDATE accounts 
SET balance = balance - 10000 
WHERE account_id = 1;

UPDATE accounts 
SET balance = balance + 10000 
WHERE account_id = 2;

COMMIT TRANSACTION;
    PRINT 'Transaction Successful';
