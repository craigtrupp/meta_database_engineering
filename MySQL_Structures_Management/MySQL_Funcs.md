## Working with MySQL Functions


### Lab Instructions: Working with MySQL Functions
Mangata and Gallo (also known as M&G) is a jewelry store that specializes in special occasions like engagements, weddings and anniversaries. In this lab, you are going to complete a series of tasks to make it easier for M&G staff to format and filter data using MySQL string, `Math, Date and Comparison` functions for their reports.

#### **Prerequisites**
To complete this lab, you must have created the M&G jewelry store database in MySQL. This includes the item and mg_orders tables, which must be populated with relevant data.

**1.** Create DB
```sql
CREATE DATABASE jewelrystore_db;
```
**2.** Use DB
```sql
USE jewelrystore_db;
```
**3.** Create the item table
```sql
CREATE TABLE item(ItemID INT, Name VARCHAR(150), Cost INT, PRIMARY KEY(ItemID));
```
**4.** Populate Item table
```sql
INSERT INTO item VALUES(1,'Engagement ring',2500),(2,'Silver brooch',400),(3,'Earrings',350),(4,'Luxury watch',1250),(5,'Golden bracelet',800), (6,'Gemstone',1500);
```
**5.** Create the mg_orders table
```sql
CREATE TABLE mg_orders(OrderID INT, ItemID INT, Quantity INT, Cost INT, OrderDate DATE, DeliveryDate DATE, OrderStatus VARCHAR(50), PRIMARY KEY(OrderID));
```
**6.** Insert data into mg_orders
```sql
INSERT INTO mg_orders VALUES(1,1,50,122000,'2022-04-05','2022-05-25', 'Delivered'),(2,2,75,28000,'2022-03-08',NULL, 'In progress'), (3,3,80,25000,'2022-05-19','2022-06-08', 'Delivered'), (4,4,45,100000,'2022-01-10',NULL, 'In progress'),(5,5,70,56000,'2022-05-19',NULL, 'In progress'),(6,6,60,90000,'2022-06-10','2022-06-18', 'Delivered');
```

---

<br>

### **Exercise Tasks/Instructions**
* **Objective** : Work with MySQL String, Math, Date and Comparison functions.

**1.** Write a SQL SELECT query using appropriate MySQL string functions to list items, quantities and order status in the following format
* Item name–quantity–order status
```sql
SELECT 
    CONCAT(LCASE(i.name), '-', mgo.Quantity, '-' , UCASE(mgo.OrderStatus)) AS combined_values
FROM item AS i
INNER JOIN mg_orders AS mgo
    USING(ItemID)
ORDER BY ItemID;
```
| combined_values                |
|--------------------------------|
| engagement ring-50-DELIVERED   |
| silver brooch-75-IN PROGRESS   |
| earrings-80-DELIVERED          |
| luxury watch-45-IN PROGRESS    |
| golden bracelet-70-IN PROGRESS |
| gemstone-60-DELIVERED          |

<br>

**2.** Write a SQL SELECT query using an appropriate date function and a format string to find the name of the weekday on which M&G’s orders are to be delivered.
```SQL
SELECT
-- Already a Date but can CAST to confirm as well
    DATE_FORMAT(CAST(DeliveryDate AS DATE), '%W') AS Day_Delivery
FROM mg_orders;
```
| Day_Delivery |
|--------------|
| Wednesday    |
| NULL         |
| Wednesday    |
| NULL         |
| NULL         |
| Saturday     |

<br>

**3.** Write a SQL SELECT query that calculates the cost of handling each order. This should be 5% of the total order cost. Use an appropriate math function to round that value to 2 decimal places.
```sql
SELECT
    Cost,
    ROUND(.05 * Cost, 2) AS handling_at_5_percent
FROM mg_orders;
```
| Cost   | handling_at_5_percent |
|--------|-----------------------|
| 122000 |               6100.00 |
|  28000 |               1400.00 |
|  25000 |               1250.00 |
| 100000 |               5000.00 |
|  56000 |               2800.00 |
|  90000 |               4500.00 |

<br>

**4.** Review the query that you wrote in the second task. Use an appropriate comparison function to filter out the records that do not have a NULL value in the delivery date column.
```sql
SELECT
-- Already a Date but can CAST to confirm as well
    DATE_FORMAT(CAST(DeliveryDate AS DATE), '%W') AS Day_Delivery
FROM mg_orders
WHERE DeliveryDate IS NOT NULL;
```
| Day_Delivery |
|--------------|
| Wednesday    |
| Wednesday    |
| Saturday     |

```sql
-- operator of ! works as well for inverse
SELECT DATE_FORMAT(DeliveryDate,'%W') FROM mg_orders WHERE !ISNULL(DeliveryDate)
```

---

<br>

### **Second Exercise**
Mangata and Gallo (also called M&G) is a jewelry store specializing in special occasions like engagements, weddings and anniversaries. 

They maintain all data about their jewelry store in a database named jewelrystore_db with 4 tables.

`Prerequisites`

Set up the database and the tables using the following SQL statements.
* Create database, use db &  create clients' table
```sql
CREATE DATABASE IF NOT EXISTS jewelrystore_db; 

USE jewelrystore_db; 

CREATE TABLE clients 
(ClientID int NOT NULL, 
ClientName varchar(255) DEFAULT NULL, 
Address varchar(255) DEFAULT NULL, 
ContactNo varchar(10) DEFAULT NULL, 
PRIMARY KEY (ClientID));
```
*  Create the client_orders table.
```sql
CREATE TABLE client_orders 
(OrderID INT NOT NULL, 
ClientID INT DEFAULT NULL, 
ItemID INT DEFAULT NULL, 
Cost INT DEFAULT NULL, 
PRIMARY KEY (OrderID));
```
* Create the item table.
```sql
CREATE TABLE item 
(ItemID INT NOT NULL, 
Name varchar(150) DEFAULT NULL, 
Cost INT DEFAULT NULL, 
PRIMARY KEY (ItemID));
```
* Create the mg_orders table
```sql
CREATE TABLE mg_orders 
(OrderID INT NOT NULL, 
ItemID INT DEFAULT NULL, 
Quantity INT DEFAULT NULL, 
Cost INT DEFAULT NULL, 
OrderDate DATE DEFAULT NULL, 
DeliveryDate DATE DEFAULT NULL, 
OrderStatus VARCHAR(50) DEFAULT NULL, 
PRIMARY KEY (OrderID));
```
* Populate `Clients`
```sql
INSERT INTO clients VALUES 
(1, 'Kishan Hughes','223 Golden Hills, North Austin, TX','387986345'), 
(2, 'Indira Moncada','119 Silver Street, Bouldin Creek, TX','334567243'), 
(3, 'Mosha Setsile','785 Bronze Lane, East Austin, TX','315642597'), 
(4, 'Laura Mills','908 Diamond Crescent, South Lamar, TX','300842509'), 
(5, 'Henrik Kreida','345, Golden Hills, North Austin, TX','358208983'), 
(6, 'Millicent Blou','812, Diamond Crescent, North Burnet, TX','347898755');
```
* Populate `item`
```sql
INSERT INTO item VALUES 
(1,'Engagement ring',2500), 
(2,'Silver brooch',400), 
(3,'Earrings',350), 
(4,'Luxury watch',1250), 
(5,'Golden bracelet',800), 
(6,'Gemstone',1500); 
```
* Populate `client_orders`
```sql
INSERT INTO client_orders VALUES 
(1,1,1,2500), 
(2,2,2,400), 
(3,3,3,350), 
(4,4,4,1250), 
(5,5,5,800), 
(6,6,6,1500), 
(7,2,4,400), 
(8,3,4,1250), 
(9,4,2,400), 
(10,1,3,350); 
```
* Populate `mg_orders`
```sql
INSERT INTO mg_orders VALUES 
(1,1,50,122000,'2022-04-05','2022-05-25', 'Delivered'), 
(2,2,75,28000,'2022-03-08',NULL, 'In progress'), 
(3,3,80,25000,'2022-05-19','2022-06-08', 'Delivered'), 
(4,4,45,100000,'2022-01-10',NULL, 'In progress'), 
(5,5,70,56000,'2022-05-19',NULL, 'In progress'), 
(6,6,60,90000,'2022-06-10','2022-06-18', 'Delivered'); 
```

<br>

### **Tasks**
**1.** Use the MySQL `CEIL` function to express the cost after the discount in the form of the smallest integer as follows:
* Give a 5% discount to the clients who have ordered luxury watches. Express the cost after the discount in the form of the smallest integer, which is not less than the value shown in the afterDiscount column in the result table given below. Use the MySQL CEIL function to do this.
```sql
SELECT 
    ClientID,
    OrderID,
    Cost,
    CEIL(Cost - (0.05 * Cost))AS five_percent_discount
FROM client_orders
WHERE ItemID = (SELECT DISTINCT ItemID FROM item WHERE Name LIKE '%Luxury%');
```
| ClientID | OrderID | Cost | five_percent_discount |
|----------|---------|------|-----------------------|
|        4 |       4 | 1250 |                  1188 |
|        2 |       7 |  400 |                   380 |
|        3 |       8 | 1250 |                  1188 |

<br>

**2.** Format the afterDiscount column value from the earlier result for 5% discount in '#,###,###.##' format rounded to 2 decimal places using the FORMAT function.
* https://www.w3schools.com/sql/func_mysql_format.asp - awesome resource
```sql
WITH discount_applied AS (
SELECT 
    ClientID,
    OrderID,
    Cost,
    CEIL(Cost - (0.05 * Cost))AS five_percent_discount
FROM client_orders
WHERE ItemID = (SELECT DISTINCT ItemID FROM item WHERE Name LIKE '%Luxury%')
)
SELECT 
    *,
    FORMAT(five_percent_discount, 2) AS watch_discount_string
FROM discount_applied;
```
| ClientID | OrderID | Cost | five_percent_discount | watch_discount_string |
|----------|---------|------|-----------------------|-----------------------|
|        4 |       4 | 1250 |                  1188 | 1,188.00              |
|        2 |       7 |  400 |                   380 | 380.00                |
|        3 |       8 | 1250 |                  1188 | 1,188.00              |

<br>

**3.** Find the expected delivery dates for their orders. The scheduled delivery date is 30 days after the order date. Use the `ADDDATE` function.
```sql
SELECT
    OrderDate,
    DeliveryDate,
    ADDDATE(OrderDate, INTERVAL 30 DAY) AS expected_delivery_date
FROM mg_orders;
```
| OrderDate  | DeliveryDate | expected_delivery_date |
|------------|--------------|------------------------|
| 2022-04-05 | 2022-05-25   | 2022-05-05             |
| 2022-03-08 | NULL         | 2022-04-07             |
| 2022-05-19 | 2022-06-08   | 2022-06-18             |
| 2022-01-10 | NULL         | 2022-02-09             |
| 2022-05-19 | NULL         | 2022-06-18             |
| 2022-06-10 | 2022-06-18   | 2022-07-10             |

<br>

**4.** Generate data required for a report with details of all orders that have not yet been delivered. 
* The DeliveryDate column has a NULL value for orders not yet delivered. 
* It would help if you showed a value of 'NOT DELIVERED' instead of showing NULL for orders that are not yet delivered. 
    * Use the `COALESCE` function to do this (will return first non NULL value)
```sql
SELECT 
    OrderId, ItemId, Quantity, Cost, OrderDate,
    COALESCE(DeliveryDate, 'NOT DELIVERED') AS Delivery_Status, OrderStatus
FROM mg_orders;
```
| OrderId | ItemId | Quantity | Cost   | OrderDate  | Delivery_Status | OrderStatus |
|---------|--------|----------|--------|------------|-----------------|-------------|
|       1 |      1 |       50 | 122000 | 2022-04-05 | 2022-05-25      | Delivered   |
|       2 |      2 |       75 |  28000 | 2022-03-08 | NOT DELIVERED   | In progress |
|       3 |      3 |       80 |  25000 | 2022-05-19 | 2022-06-08      | Delivered   |
|       4 |      4 |       45 | 100000 | 2022-01-10 | NOT DELIVERED   | In progress |
|       5 |      5 |       70 |  56000 | 2022-05-19 | NOT DELIVERED   | In progress |
|       6 |      6 |       60 |  90000 | 2022-06-10 | 2022-06-18      | Delivered   |

<br>

**5.**  Generate data required for the report by retrieving a list of M&G orders yet to be delivered. These orders have an 'In Progress' status using the `NULLIF` function.
* The NULLIF() function compares two expressions and returns NULL if they are equal. Otherwise, the first expression is returned.
```sql
SELECT
    OrderID,
    NULLIF(OrderStatus, 'In progress') AS Null_Progress_Check
FROM mg_orders;
```
| OrderID | Null_Progress_Check |
|---------|---------------------|
|       1 | Delivered           |
|       2 | NULL                |
|       3 | Delivered           |
|       4 | NULL                |
|       5 | NULL                |
|       6 | Delivered           |


---

<br>

#### **Functions / Unit Quiz Notes**
* Select the function name that changes the first-string value of column A with the second string value in the following SQL statement
```sql
-- Create Temp Table to work with
CREATE TEMPORARY TABLE IF NOT EXISTS SelectOrders AS (SELECT * FROM Orders LIMIT 5);
-- Query OK, 5 rows affected
SELECT * FROM SelectOrders;
```
| OrderID | ClientID | ProductID | Quantity | Cost   |
|---------|---------|-----------|----------|---------|
|       1 | Cl1      | P1        |       10 | 500.00 |
|       2 | Cl2      | P2        |        5 | 100.00 |
|       3 | Cl3      | P3        |       20 | 800.00 |
|       4 | Cl4      | P4        |       15 | 150.00 |
|       5 | Cl3      | P3        |       10 | 450.00 |

```sql
-- REPLACE Takes a Column, A Serach value, and replace value
SELECT REPLACE(ClientId, 'Cl', 'DRZ') FROM SelectOrders;
```
| REPLACE(ClientId, 'Cl', 'DRZ') |
|--------------------------------|
| DRZ1                           |
| DRZ2                           |
| DRZ3                           |
| DRZ4                           |
| DRZ3                           |

```sql
-- Replace does not alter the table however
SELECT * FROM SelectOrders;
```
| OrderID | ClientID | ProductID | Quantity | Cost   |
|---------|---------|-----------|----------|---------|
|       1 | Cl1      | P1        |       10 | 500.00 |
|       2 | Cl2      | P2        |        5 | 100.00 |
|       3 | Cl3      | P3        |       20 | 800.00 |
|       4 | Cl4      | P4        |       15 | 150.00 |
|       5 | Cl3      | P3        |       10 | 450.00 |
