CREATE TABLE Sailors (
    sid INT PRIMARY KEY,
    sname VARCHAR(20),
    rating INT,
    age FLOAT
);


CREATE TABLE Boats (
    bid INT PRIMARY KEY,
    bname VARCHAR(20),
    color VARCHAR(10)
);

CREATE TABLE Reserves (
    sid INT,
    bid INT,
    day DATE,
    FOREIGN KEY (sid) REFERENCES Sailors(sid),
    FOREIGN KEY (bid) REFERENCES Boats(bid)
);

INSERT INTO Sailors VALUES (22, 'Dustin', 7, 45.0);
INSERT INTO Sailors VALUES (29, 'Brutus', 1, 33.0);
INSERT INTO Sailors VALUES (31, 'Lubber', 8, 55.5);
INSERT INTO Sailors VALUES (32, 'Andy', 8, 25.5);
INSERT INTO Sailors VALUES (58, 'Rusty', 10, 35.0);
INSERT INTO Sailors VALUES (64, 'Horatio', 7, 35.0);
INSERT INTO Sailors VALUES (71, 'Zorba', 10, 16.0);
INSERT INTO Sailors VALUES (74, 'Horatio', 9, 35.0);
INSERT INTO Sailors VALUES (85, 'Art', 3, 25.5);
INSERT INTO Sailors VALUES (95, 'Bob', 3, 63.5);

INSERT INTO Boats VALUES (101, 'Interlake', 'blue');
INSERT INTO Boats VALUES (102, 'Interlake', 'red');
INSERT INTO Boats VALUES (103, 'Clipper', 'green');
INSERT INTO Boats VALUES (104, 'Marine', 'red');


INSERT INTO Reserves VALUES (22, 101, '1998-10-10');
INSERT INTO Reserves VALUES (22, 102, '1998-10-10');
INSERT INTO Reserves VALUES (22, 103, '1998-10-08');
INSERT INTO Reserves VALUES (22, 104, '1998-10-07');
INSERT INTO Reserves VALUES (31, 102, '1998-11-10');
INSERT INTO Reserves VALUES (31, 103, '1998-11-06');
INSERT INTO Reserves VALUES (31, 104, '1998-11-12');
INSERT INTO Reserves VALUES (64, 101, '1998-09-05');
INSERT INTO Reserves VALUES (64, 102, '1998-09-08');
INSERT INTO Reserves VALUES (74, 103, '1998-09-08');


-- Find the names of sailors who have reserved boat number 103. 
SELECT s.sname
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
WHERE r.bid = 103;

-- Find the sids of sailors who have reserved a red boat
SELECT DISTINCT r.sid
FROM Reserves r
JOIN Boats b ON r.bid = b.bid
WHERE b.color = 'red';

--Find the colors of boats reserved by Lubber. 
SELECT DISTINCT b.color
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
JOIN Boats b ON r.bid = b.bid
WHERE s.sname = 'Lubber';

--Find the names of sailors who have reserved at least one boat.
SELECT DISTINCT s.sname
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid;

--Compute increments for the ratings of persons who have sailed two different boats on the same day. 
UPDATE Sailors
SET rating = rating + 1
WHERE sid IN (
    SELECT sid
    FROM Reserves
    GROUP BY sid, day
    HAVING COUNT(DISTINCT bid) >= 2
);

--Find the ages of sailors whose name begins and ends with B and has at least three characters. 
SELECT age
FROM Sailors
WHERE sname LIKE 'B%B'
  AND LEN(sname) >= 3;

--Find the names of sailors who have reserved a red or a green boat 
SELECT DISTINCT s.sname
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
JOIN Boats b ON r.bid = b.bid
WHERE b.color IN ('red', 'green');

--Find the names of sailors who have reserved both a red and a green boat 
SELECT s.sname
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
JOIN Boats b ON r.bid = b.bid
WHERE b.color IN ('red', 'green')
GROUP BY s.sid, s.sname
HAVING COUNT(DISTINCT b.color) = 2;

--Find the sids of all sailors who have reserved red boats but not green boats 
SELECT r.sid
FROM Reserves r
JOIN Boats b ON r.bid = b.bid
WHERE b.color IN ('red', 'green')
GROUP BY r.sid
HAVING 
    COUNT(DISTINCT CASE WHEN b.color = 'red' THEN b.color END) >= 1
    AND
    COUNT(DISTINCT CASE WHEN b.color = 'green' THEN b.color END) = 0;

--Find all sids of sailors who have a rating of 10 or have reserved boat 104.
SELECT sid
FROM Sailors
WHERE rating = 10
UNION
SELECT sid
FROM Reserves
WHERE bid = 104;