USE Spektra

CREATE TABLE Products(
ProductId INT PRIMARY KEY,
ProductDesc VARCHAR(20),
Price MONEY,
Quantity INT
);

INSERT INTO Products VALUES (1 ,  'PEN' , 20 , 5);
INSERT INTO Products VALUES (2 ,  'BOOK' , 35 , 6);
INSERT INTO Products VALUES (3 ,  'PENCIL' , 15 , 10);
INSERT INTO Products VALUES (4 ,  'PAPER' , 25 , 9);
INSERT INTO Products VALUES (5 ,  'EARSER' , 18 , 15);


-- CREATING FUNCTION
CREATE FUNCTION ProductsCostingMoreThan(@cost MONEY)
RETURNS TABLE 
AS
RETURN
	SELECT p.ProductId , p.Price
	FROM Products p
	WHERE Price > @cost;


-- EXECUTING TABLE VALUED FUNCTIONS
SELECT * FROM dbo.ProductsCostingMoreThan(20);


-- EXECUTING TABLE VALUED FUNCTIONS AND USING RETURN TABLE FOR ANOTHER QUERY
SELECT p2.ProductDesc , p1.Price
FROM dbo.ProductsCostingMoreThan(20)
AS p1 JOIN Products AS p2 ON p1.ProductId = p2.ProductId;