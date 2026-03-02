USE Spektra

CREATE TABLE Product(
ProductID INT PRIMARY KEY CLUSTERED,
ProductDesc VARCHAR(50) NOT NULL,
ManufacturingDate DATETIME,
ExpiryDate DATETIME,
IsSalable BIT,		-- 1 FOR SALABLE/ACTIVE 0 FOR NONSALABLE/PASSIVE PRODUCT.
Price MONEY NOT NULL
)

CREATE TABLE Customers(
CustID INT IDENTITY (1002,2) PRIMARY KEY CLUSTERED,
FName VARCHAR(20) NOT NULL,
LName VARCHAR(20) NOT NULL,
UserID VARCHAR(50) NOT NULL,
Pswd NVARCHAR(100) NOT NULL DEFAULT 'password123'
)

CREATE TABLE Booking(
BookingID INT IDENTITY(10,2) PRIMARY KEY CLUSTERED,
ProductID INT REFERENCES Product(ProductID),
CustID INT REFERENCES Customers(CustID),
DateOfBooking DATETIME NOT NULL,
QTY INT
)

INSERT INTO PRODUCT (ProductID, ProductDesc, ManufacturingDate, ExpiryDate,IsSalable, Price)
VALUES
(1, 'Biscuits', '2011-09-01', '2012-09-01', 1, 20),
(2, 'Butter',   '2010-09-01', '2011-09-01', 1, 30),
(3, 'Milk',     '2011-10-01', '2011-11-01', 1, 46);


INSERT INTO Customers (FName, LName, UserID, Pswd)
VALUES
('Sara',  'Verma', 'S.Verma@abc.com', 'S123'),
('Rick',  'Singh', 'G.Singh@xyz.com', 'G311'),
('Micky', 'Khera', 'M.Khera@mno.com', 'M222');


INSERT INTO BOOKING (ProductID, CustID, DateOfBooking, QTY)
VALUES
(1, 1002, '2011-11-01', 3),
(2, 1004, GETDATE(), 4),
(3, 1006, '2011-10-01', 2);


CREATE VIEW Bill_V
AS
SELECT c.FName,
c.LName , p.ProductDesc , b.DateOfBooking ,p.Price, b.QTY,
(b.QTY * p.Price) AS TotalAmountPayable
FROM Booking b
JOIN Product p
ON b.ProductID = p.ProductID
JOIN Customers c
ON b.CustID = c.CustID;

SELECT * FROM Bill_V;