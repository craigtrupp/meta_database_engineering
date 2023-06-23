## Lab Joins
Little Lemon is a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist. The Little Lemon database contains many tables of data including Customers and Bookings.

* The Customers table contains the following data about each customer: 

|CustomerID|fullName|PhoneNumber|
|----|-----|-----|
|1|Vanessa McCarthy|757536378|
|2|Marcos Romero|757536379|
|3|Hroki Yamane|757536376|
|4|Anna Iversen|757536375|
|5|Diana Pinto|757536374|

<br>

* The Bookings table contains the following data on each booking: 

|BookingID|BookingDate|TableNumber|NumberofGuestts|CustomerID|
|----|-----|------|-----|-----|
|10|2021-11-11|7|5|1|
|11|2021-11-10|5|2|2|
|12|2021-11-10|3|2|4|

<br>

### **PreReqs**

1. Create Database
```sql
CREATE DATABASE IF NOT EXISTS little_lemon;
```
2. Use Database
```sql
USE little_lemon;
```
3. Create Customers Table
```sql
CREATE TABLE Customers(CustomerID INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE);
```
4. Insert Data into Table
```sql
INSERT INTO Customers(CustomerID, FullName, PhoneNumber) VALUES (1, "Vanessa McCarthy", 0757536378), (2, "Marcos Romero", 0757536379), (3, "Hiroki Yamane", 0757536376), (4, "Anna Iversen", 0757536375), (5, "Diana Pinto", 0757536374);
```
5. Create Bookings
```sql
CREATE TABLE Bookings (BookingID INT NOT NULL PRIMARY KEY,  BookingDate DATE NOT NULL,  TableNumber INT NOT NULL, NumberOfGuests INT NOT NULL CHECK (NumberOfGuests <= 8), CustomerID INT NOT NULL, FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE); 
```
* `ON DELETE CASCADE` constraint is used in MySQL to delete the rows from the child table automatically, when the rows from the parent table are deleted. For example when a student registers in an online learning platform, then all the details of the student are recorded with their unique number/id. All the courses in these online learning platforms had their own code, title, and name. Students can enroll in any course according to their wishes. Suppose you delete a row from the “Student” table, now you will also want to delete all rows in the “Enroll” table that references the row in the “Student” table. For that, we need ON DELETE CASCADE. 
6. Insert Data into Bookings
```sql
INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) VALUES (10, '2021-11-11', 7, 5, 1), (11, '2021-11-10', 5, 2, 2), (12, '2021-11-10', 3, 2, 4);
```

---

<br>

### **Task Instructions**
1. Little Lemon want a list of all customers who have made bookings. Write an INNER JOIN SQL statement to combine the full name and the phone number of each customer from the Customers table with the related booking date and 'number of guests' from the Bookings table. 
```sql
SELECT c.FullName, c.PhoneNumber, b.BookingDate,b.NumberofGuests
FROM Customers AS c
INNER JOIN bookings AS b
ON c.CustomerID = b.CustomerID;
```
2. Little Lemon want to view information about all existing customers with bookings that have been made so far. This data must include customers who haven’t made any booking yet. 
```sql
SELECT c.CustomerID, b.BookingID
FROM Customers AS c
LEFT JOIN bookings AS b
ON c.CustomerID = b.CustomerID;
```