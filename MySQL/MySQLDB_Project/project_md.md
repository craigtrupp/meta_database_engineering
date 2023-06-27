## MySQL database project
### **Lab Instructions**
Scenario
Based in Chicago, Illinois, `Little Lemon` is a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist. The chefs draw inspiration from Italian, Greek, and Turkish culture and have a menu of 12–15 items that they rotate seasonally. The restaurant has a rustic and relaxed atmosphere with moderate prices, making it a popular place for a meal any time of the day.

Little Lemon is owned by two Italian brothers, Mario and Adrian, who moved to the United States to pursue their shared dream of owning a restaurant. To craft the menu, Mario relies on family recipes and his experience as a chef in Italy. Adrian does all the marketing for the restaurant and led the effort to expand the menu beyond classic Italian to incorporate additional cuisines from the Mediterranean region.

<br>

### `Prerequisites`
In order to complete this lab, you must first have created the Little Lemon database in MySQL. You must also have the Customers, Bookings and Courses tables created and populated with relevant data as shown below.

**1.** Create DB
```sql
CREATE DATABASE IF NOT EXISTS Little_Lemon;
```
**2.** Use DB
```sql
USE Little_Lemon;
```
**3.** Create Customers
```sql
CREATE TABLE Customers(CustomerID INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE);
```
**4.** Insert INTO Customers
```sql
INSERT INTO Customers(CustomerID, FullName, PhoneNumber) VALUES 
(1, "Vanessa McCarthy", 0757536378), 
(2, "Marcos Romero", 0757536379), 
(3, "Hiroki Yamane", 0757536376), 
(4, "Anna Iversen", 0757536375), 
(5, "Diana Pinto", 0757536374),     
(6, "Altay Ayhan", 0757636378),      
(7, "Jane Murphy", 0753536379),      
(8, "Laurina Delgado", 0754536376),      
(9, "Mike Edwards", 0757236375),     
(10, "Karl Pederson", 0757936374);
```
**5.** Create Bookings
```sql
CREATE TABLE Bookings (BookingID INT, BookingDate DATE,TableNumber INT, NumberOfGuests INT,CustomerID INT); 
```
**6.** Populate Bookings
```sql
INSERT INTO Bookings 
(BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) 
VALUES 
(10, '2021-11-10', 7, 5, 1),  
(11, '2021-11-10', 5, 2, 2),  
(12, '2021-11-10', 3, 2, 4), 
(13, '2021-11-11', 2, 5, 5),  
(14, '2021-11-11', 5, 2, 6),  
(15, '2021-11-11', 3, 2, 7), 
(16, '2021-11-11', 3, 5, 1),  
(17, '2021-11-12', 5, 2, 2),  
(18, '2021-11-12', 3, 2, 4), 
(19, '2021-11-13', 7, 5, 6),  
(20, '2021-11-14', 5, 2, 3),  
(21, '2021-11-14', 3, 2, 4);
```
**7.** Create Courses Table
```sql
CREATE TABLE Courses (CourseName VARCHAR(255) PRIMARY KEY, Cost Decimal(4,2));
```
**8.** Poplulate courses
```sql
INSERT INTO Courses (CourseName, Cost) VALUES 
("Greek salad", 15.50), 
("Bean soup", 12.25), 
("Pizza", 15.00), 
("Carbonara", 12.50), 
("Kabasa", 17.00), 
("Shwarma", 11.30);
```

<br>

#### **Tables**
* `Bookings` - 12 rows

| BookingID | BookingDate | TableNumber | NumberOfGuests | CustomerID |
|-----------|-------------|-------------|----------------|------------|
|        10 | 2021-11-10  |           7 |              5 |          1 |
|        11 | 2021-11-10  |           5 |              2 |          2 |
|        12 | 2021-11-10  |           3 |              2 |          4 |
|        13 | 2021-11-11  |           2 |              5 |          5 |
|        14 | 2021-11-11  |           5 |              2 |          6 |
|        15 | 2021-11-11  |           3 |              2 |          7 |
|        16 | 2021-11-11  |           3 |              5 |          1 |
|        17 | 2021-11-12  |           5 |              2 |          2 |
|        18 | 2021-11-12  |           3 |              2 |          4 |
|        19 | 2021-11-13  |           7 |              5 |          6 |
|        20 | 2021-11-14  |           5 |              2 |          3 |
|        21 | 2021-11-14  |           3 |              2 |          4 |

<br>

* `Courses` - 6 rows

| CourseName  | Cost  |
|-------------|-------|
| Bean soup   | 12.25 |
| Carbonara   | 12.50 |
| Greek salad | 15.50 |
| Kabasa      | 17.00 |
| Pizza       | 15.00 |
| Shwarma     | 11.30 |

<br>

* `Customers` - 10 rows

| CustomerID | FullName         | PhoneNumber |
|------------|------------------|-------------|
|          1 | Vanessa McCarthy |   757536378 |
|          2 | Marcos Romero    |   757536379 |
|          3 | Hiroki Yamane    |   757536376 |
|          4 | Anna Iversen     |   757536375 |
|          5 | Diana Pinto      |   757536374 |
|          6 | Altay Ayhan      |   757636378 |
|          7 | Jane Murphy      |   753536379 |
|          8 | Laurina Delgado  |   754536376 |
|          9 | Mike Edwards     |   757236375 |
|         10 | Karl Pederson    |   757936374 |

---

<br>

### **Task Instructions**
Please attempt the following tasks.

Note that there might be several ways to complete the same task

**1.** Create SQL statement to print all records from `Bookings` table for the following bookings dates using the BETWEEN operator: 2021-11-11, 2021-11-12 and 2021-11-13. 

```sql
SELECT * FROM BOOKINGS WHERE BookingDate BETWEEN '2021-11-11' AND '2021-11-13' ORDER BY BookingDate;
```
| BookingID | BookingDate | TableNumber | NumberOfGuests | CustomerID |
|-----------|-------------|-------------|----------------|------------|
|        13 | 2021-11-11  |           2 |              5 |          5 |
|        14 | 2021-11-11  |           5 |              2 |          6 |
|        15 | 2021-11-11  |           3 |              2 |          7 |
|        16 | 2021-11-11  |           3 |              5 |          1 |
|        17 | 2021-11-12  |           5 |              2 |          2 |
|        18 | 2021-11-12  |           3 |              2 |          4 |
|        19 | 2021-11-13  |           7 |              5 |          6 |

<br>

**2.** Create a JOIN SQL statement on the Customers and Bookings tables. The statement must print the customers full names and related bookings IDs from the date 2021-11-11.
```sql
SELECT 
    cstmrs.FullName,
    bks.BookingID
FROM Bookings AS bks
INNER JOIN Customers AS cstmrs
    ON bks.CustomerID = cstmrs.CustomerID
WHERE bks.BookingDate = '2021-11-11';
```
| FullName         | BookingID |
|------------------|-----------|
| Diana Pinto      |        13 |
| Altay Ayhan      |        14 |
| Jane Murphy      |        15 |
| Vanessa McCarthy |        16 |

<br>

**3.** Create a SQL statement to print the bookings dates from Bookings table. The statement must show the **total number of bookings** placed on each of the printed dates.
* Being a little more explicit and only counting distinct (unique) bookings ids found on the date for any potentialy duplicate bookings on the same date
```sql
SELECT
    BookingDate,
    COUNT(DISTINCT BookingID) AS total_unique_bookings
FROM Bookings
GROUP BY BookingDate
ORDER BY BookingDate;
```
| BookingDate | total_unique_bookings |
|-------------|-----------------------|
| 2021-11-10  |                     3 |
| 2021-11-11  |                     4 |
| 2021-11-12  |                     2 |
| 2021-11-13  |                     1 |
| 2021-11-14  |                     2 |

<br>

**4.** Create a SQL REPLACE statement that updates the cost of the Kabsa course from $17.00 to $20.00.
* The `REPLACE` statement makes sense to be used only with tables that have a notion of the PRIMARY or UNIQUE key since that’s the only mechanism it uses to find out if there’s an existing row with the same primary key.
    * If there’s no Unique key defined for a table, all REPLACE statements would end up inserting new records in the table.

```sql
SHOW COLUMNS FROM Courses;
```
| Field      | Type         | Null | Key | Default | Extra |
|------------|--------------|------|-----|---------|-------|
| CourseName | varchar(255) | NO   | PRI | NULL    |       |
| Cost       | decimal(4,2) | YES  |     | NULL    |       |

* CourseName is primary thus it just update the found row with this primary KEY

<br>

```sql
REPLACE INTO Courses SET CourseName = 'Kabasa', Cost = 20.00;
-- Validate Change Occurred
SELECT * FROM Courses;
```
| CourseName  | Cost  |
|-------------|-------|
| Bean soup   | 12.25 |
| Carbonara   | 12.50 |
| Greek salad | 15.50 |
| Kabasa      | 20.00 |
| Pizza       | 15.00 |
| Shwarma     | 11.30 |

* Note the value has changes for the found **Primary Key** value and thus set the new the Cost

<br>

**5.** Create a new table called "DeliveryAddress" in the Little Lemon database with the following columns and constraints:
* `ID`: INT PRIMARY KEY
* `Address`: VARCHAR(255) NOT NULL
* `Type`: NOT NULL DEFAULT "Private"
* `CustomerID`: INT NOT NULL FOREIGN KEY referencing CustomerID in the Customers table
```sql
CREATE TABLE DeliveryAddress (ID INT PRIMARY KEY, Address VARCHAR(255) NOT NULL, Type VARCHAR(50) NOT NULL DEFAULT 'Private', CustomerID INT NOT NULL ,FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID));
```
* Matches expected output

| Field      | Type         | Null | Key | Default | Extra |
|------------|--------------|------|-----|---------|-------|
| ID         | int          | NO   | PRI | NULL    |       |
| Address    | varchar(255) | NO   |     | NULL    |       |
| Type       | varchar(50)  | NO   |     | Private |       |
| CustomerID | int          | NO   | MUL | NULL    |       |

<br>

**6.** Alter table structure
* Create a SQL statement that adds a new column called **'Ingredients'** to the Courses table.
* Ingredients: VARCHAR(255)
```sql
ALTER TABLE Courses ADD Ingredients VARCHAR(255);

-- VALIDATE Column Output to Match SS from Task
SHOW COLUMNS FROM Courses;
```
| Field       | Type         | Null | Key | Default | Extra |
|-------------|--------------|------|-----|---------|-------|
| CourseName  | varchar(255) | NO   | PRI | NULL    |       |
| Cost        | decimal(4,2) | YES  |     | NULL    |       |
| Ingredients | varchar(255) | YES  |     | NULL    |       |

<br>

**7.** Create a subquery
* Create a SQL statement with a subquery that prints the full names of all customers who made bookings in the restaurant on the following date: 2021-11-11.
```sql
-- Need to join the Customers and Bookings (in subquery)
-- Remember the Syntax and Contingency to use the WHERE EXISTS
-- It's quirky but needed as the query inside won't run without the outer customers contingency
SELECT FullName
FROM Customers
WHERE EXISTS (
    SELECT * -- Or something just one column works
    FROM Bookings AS bks
    WHERE Customers.CustomerID = bks.CustomerID
    AND bks.BookingDate = '2021-11-11'
)
ORDER BY FullName;
```
| FullName         |
|------------------|
| Altay Ayhan      |
| Diana Pinto      |
| Jane Murphy      |
| Vanessa McCarthy |

<br>

**8.** Create a virtual table
* Create the "BookingsView" virtual table to print all 
    * bookings IDs
    * bookings dates
    * number of guests 
* for bookings made in the restaurant before `2021-11-13` and where the number of guests is larger than **3**.
```sql
CREATE VIEW BookingsView AS 
    SELECT 
        BookingID,
        BookingDate,
        NumberOfGuests
    FROM Bookings
    WHERE BookingDate < '2021-11-13' AND NumberOfGuests > 3;

-- Confirm Output
SELECT * FROM BookingsView;
```
| BookingID | BookingDate | NumberOfGuests |
|-----------|-------------|----------------|
|        10 | 2021-11-10  |              5 |
|        13 | 2021-11-11  |              5 |
|        16 | 2021-11-11  |              5 |

<br>

**9.** Create a stored procedure
* Create a stored procedure called `'GetBookingsData'`. 
    * The procedure must contain one date parameter called `"InputDate"`. 
    * This parameter retrieves all data from the Bookings table based on the user input of the date.
* After executing the query, call the "GetBookingsData" with '2021-11-13' as the input date passed to the stored procedure to show all bookings made on that date.
```sql
CREATE PROCEDURE GetBookingsData(InputDate DATE)
SELECT * FROM Bookings WHERE BookingDate = InputDate;

-- Now call
CALL GetBookingsData('2021-11-13');
```
| BookingID | BookingDate | TableNumber | NumberOfGuests | CustomerID |
|-----------|-------------|-------------|----------------|------------|
|        19 | 2021-11-13  |           7 |              5 |          6 |

<br>

**10.**  Use the String function
* Create a SQL SELECT query using appropriate MySQL string function to list "Booking Details" including booking ID, booking date and number of guests. The data must be listed in the same format as the following example:
    * ID: 10, 
    * Date: 2021-11-10, 
    * Number of guests: 5
```sql
SELECT
    CONCAT('ID: ', BookingId, ', ', 'Date: ', BookingDate, ', ', 
    'Number of guests: ', NumberOfGuests) AS BookingDetails
FROM Bookings;
```
| BookingDetails                                |
|-----------------------------------------------|
| ID: 10, Date: 2021-11-10, Number of guests: 5 |
| ID: 11, Date: 2021-11-10, Number of guests: 2 |
| ID: 12, Date: 2021-11-10, Number of guests: 2 |
| ID: 13, Date: 2021-11-11, Number of guests: 5 |
| ID: 14, Date: 2021-11-11, Number of guests: 2 |
| ID: 15, Date: 2021-11-11, Number of guests: 2 |
| ID: 16, Date: 2021-11-11, Number of guests: 5 |
| ID: 17, Date: 2021-11-12, Number of guests: 2 |
| ID: 18, Date: 2021-11-12, Number of guests: 2 |
| ID: 19, Date: 2021-11-13, Number of guests: 5 |
| ID: 20, Date: 2021-11-14, Number of guests: 2 |
| ID: 21, Date: 2021-11-14, Number of guests: 2 |