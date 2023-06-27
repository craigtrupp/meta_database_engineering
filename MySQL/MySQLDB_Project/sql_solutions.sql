-- See Markdown file for more detail on question and context
-- below will simply be the raw sql queries for the different tasks


-- 1
SELECT * 
FROM Bookings 
WHERE BookingDate BETWEEN '2021-11-11' AND '2021-11-13';

-- 2
SELECT 
    cstmrs.FullName,
    bks.BookingID
FROM Bookings AS bks
INNER JOIN Customers AS cstmrs
    ON bks.CustomerID = cstmrs.CustomerID
WHERE bks.BookingDate = '2021-11-11';

-- This works as well think we want each booking for a certain criteria than 
-- join the found matching customerID from customers
SELECT Customers.FullName, Bookings.BookingID 
FROM Customers RIGHT JOIN Bookings 
ON Customers.CustomerID = Bookings.CustomerID 
WHERE BookingDate = '2021-11-11';

-- 3 
-- Either Works 
SELECT
    BookingDate,
    COUNT(DISTINCT BookingID) AS total_unique_bookings
FROM Bookings
GROUP BY BookingDate
ORDER BY BookingDate;

-- Less specific (however no duplicates exist)
SELECT BookingDate, COUNT(BookingDate) 
FROM Bookings 
GROUP BY BookingDate;



-- 4 - Most important note is the presency of a PrimaryKey (CourseName) which Updates found
-- existing unique value and sets the new cost, can use a **SET** or **INSERT** style to replace
REPLACE INTO Courses SET CourseName = 'Kabasa', Cost = 20.00;
-- Validate Change Occurred
SELECT * FROM Courses;

-- Alternate way to replace
REPLACE INTO Courses (CourseName, Cost) VALUES ("Kabasa", 20.00);


-- 5 Constraints
CREATE TABLE DeliveryAddress (
    ID INT PRIMARY KEY, 
    Address VARCHAR(255) NOT NULL, 
    Type VARCHAR(50) NOT NULL DEFAULT 'Private', 
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- 6 ALTER (Add new Column) (Defaults to column but good practice to add)
ALTER TABLE Courses ADD Ingredients VARCHAR(255);


ALTER TABLE Courses ADD COLUMN Ingredients VARCHAR(255);


-- 7 Subquery (WHERE EXISTS) - InnerQuery Dependency (Can't Run on it's own)
SELECT FullName
FROM Customers
WHERE EXISTS (
    SELECT * -- Or something just one column works
    FROM Bookings AS bks
    WHERE Customers.CustomerID = bks.CustomerID
    AND bks.BookingDate = '2021-11-11'
)
ORDER BY FullName;


SELECT FullName 
FROM Customers 
WHERE (SELECT CustomerID FROM Bookings 
WHERE Customers.CustomerID = Bookings.CustomerID and BookingDate = "2021-11-11");


-- 8 Virtual Table
CREATE VIEW BookingsView AS 
SELECT BookingID, BookingDate, NumberOfGuests 
FROM Bookings 
WHERE NumberOfGuests > 3 AND BookingDate < "2021-11-13";


-- Little Cleaner look for indentation
CREATE VIEW BookingsView AS 
    SELECT 
        BookingID,
        BookingDate,
        NumberOfGuests
    FROM Bookings
    WHERE BookingDate < '2021-11-13' AND NumberOfGuests > 3;



-- 9 Stored Procedure
CREATE PROCEDURE GetBookingsData (InputDate DATE) 
SELECT * 
FROM Bookings 
WHERE BookingDate = InputDate;

-- Can be a bit more succinct here without more lines as a straight forward query
CREATE PROCEDURE GetBookingsData(InputDate DATE)
SELECT * FROM Bookings WHERE BookingDate = InputDate;

-- To Call
CALL GetBookingsData ("2021-11-13");



-- 10 Concat to form custom string return (Popular for Stored Procedures)
SELECT CONCAT("ID: ", BookingID,', Date: ', BookingDate,', Number of guests: ', NumberOfGuests) AS "Booking Details" FROM Bookings;

SELECT
    CONCAT('ID: ', BookingId, ', ', 'Date: ', BookingDate, ', ', 
    'Number of guests: ', NumberOfGuests) AS BookingDetails
FROM Bookings;