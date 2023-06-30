## SELECT statement optimization in MySQL

<br>


### **Lab Instructions**
_Lucky Shrub_ need to 
* execute a series of SELECT queries against their database to retrieve information on their employees and client orders.

However, they need to `optimize` these queries first to make sure that they execute quickly and efficiently. They can make these queries more efficient using MySQL database **optimization techniques**.

<br>

In this lab, you must complete a series of tasks to help Lucky Shrub optimize their SQL SELECT statements.
* The SELECT statements are to be executed against the database’s `Employees` and `Orders` tables.

Let's take a quick look at these tables and the information they contain.

<br>


#### `Table Detail`
The `Orders` table contains information about the 
* OrderID, ClientID, Product ID, Quantity, Cost and Date of each order.
```sql
SELECT * FROM Orders LIMIT 10; -- 29 rows 
```
| OrderID | ClientID | ProductID | Quantity | Cost    | Date       |
|---------|----------|-----------|----------|---------|------------|
|       1 | Cl1      | P1        |       10 |  500.00 | 2020-09-01 |
|       2 | Cl2      | P2        |        5 |  100.00 | 2020-09-05 |
|       3 | Cl3      | P3        |       20 |  800.00 | 2020-09-03 |
|       4 | Cl4      | P4        |       15 |  150.00 | 2020-09-07 |
|       5 | Cl3      | P3        |       10 |  450.00 | 2020-09-08 |
|       6 | Cl2      | P2        |        5 |  800.00 | 2020-09-09 |
|       7 | Cl1      | P4        |       22 | 1200.00 | 2020-09-10 |
|       8 | Cl3      | P1        |       15 |  150.00 | 2020-09-10 |
|       9 | Cl1      | P1        |       10 |  500.00 | 2020-09-12 |
|      10 | Cl2      | P2        |        5 |  100.00 | 2020-09-13 |

<br>

The `Employees` table contains information about the 
* EmployeeID, FullName, Role, Department of each employee as shown below.
```sql
SELECT * FROM Employees;
```
| EmployeeID | FullName         | Role        | Department      |
|------------|------------------|-------------|-----------------|
|          1 | Seamus Hogan     | Manager     | Management      |
|          2 | Thomas Eriksson  | Assistant   | Sales           |
|          3 | Simon Tolo       | Executive   | Management      |
|          4 | Francesca Soffia | Assistant   | Human Resources |
|          5 | Emily Sierra     | Accountant  | Finance         |
|          6 | Greta Galkina    | Accountant  | Finance         |
|          7 | Maria Carter     | Executive   | Human Resources |
|          8 | Rick Griffin     | Manager     | Marketing       |


<br><br>


#### `Environment Creation`
```sql
-- DROP DB
DROP DATABASE IF EXISTS Lucky_Shrub;

-- Create DB 
CREATE DATABASE IF NOT EXISTS Lucky_Shrub;

-- Use DB
USE Lucky_Shrub;

-- Create Orders
CREATE TABLE Orders(OrderID INT NOT NULL, ClientID VARCHAR(10) DEFAULT NULL, ProductID VARCHAR(10) DEFAULT NULL, Quantity INT DEFAULT NULL, Cost DECIMAL(6,2) DEFAULT NULL, Date DATE DEFAULT NULL, PRIMARY KEY (OrderID)); 

-- Create Employees
CREATE TABLE Employees(EmployeeID INT DEFAULT NULL, FullName VARCHAR(100) DEFAULT NULL, Role VARCHAR(50) DEFAULT NULL, Department VARCHAR(255) DEFAULT NULL); 

-- Insert into Orders
INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost, Date)  
VALUES  
(1, "Cl1", "P1", 10, 500, "2020-09-01"), 
(2, "Cl2", "P2", 5, 100, "2020-09-05"),  
(3, "Cl3", "P3", 20, 800, "2020-09-03"),  
(4, "Cl4", "P4", 15, 150, "2020-09-07"),  
(5, "Cl3", "P3", 10, 450, "2020-09-08"),  
(6, "Cl2", "P2", 5, 800, "2020-09-09"),  
(7, "Cl1", "P4", 22, 1200, "2020-09-10"),  
(8, "Cl3", "P1", 15, 150, "2020-09-10"),  
(9, "Cl1", "P1", 10, 500, "2020-09-12"),  
(10, "Cl2", "P2", 5, 100, "2020-09-13"),  
(11, "Cl1", "P2", 15, 80, "2020-09-12"), 
(12, "Cl1", "P1", 10, 500, "2022-09-01"),  
(13, "Cl2", "P2", 5, 100, "2022-09-05"),  
(14, "Cl3", "P3", 20, 800, "2022-09-03"),  
(15, "Cl4", "P4", 15, 150, "2022-09-07"),  
(16, "Cl3", "P3", 10, 450, "2022-09-08"),  
(17, "Cl2", "P2", 5, 800, "2022-09-09"),  
(18, "Cl1", "P4", 22, 1200, "2022-09-10"),  
(19, "Cl3", "P1", 15, 150, "2022-09-10"),  
(20, "Cl1", "P1", 10, 500, "2022-09-12"),  
(21, "Cl2", "P2", 5, 100, "2022-09-13"),   
(22, "Cl2", "P1", 10, 500, "2021-09-01"),  
(23, "Cl2", "P2", 5, 100, "2021-09-05"),  
(24, "Cl3", "P3", 20, 800, "2021-09-03"),  
(25, "Cl4", "P4", 15, 150, "2021-09-07"),  
(26, "Cl1", "P3", 10, 450, "2021-09-08"),  
(27, "Cl2", "P1", 20, 1000, "2022-09-01"),  
(28, "Cl2", "P2", 10, 200, "2022-09-05"),  
(29, "Cl3", "P3", 20, 800, "2021-09-03"); 

-- Insert into Employees
INSERT INTO Employees (EmployeeID, FullName,  Role, Department)  
VALUES    
(1, "Seamus Hogan", "Manager", "Management"),    
(2, "Thomas Eriksson", "Assistant ", "Sales"),   
(3, "Simon Tolo", "Executive", "Management"),   
(4, "Francesca Soffia", "Assistant  ", "Human Resources"),   
(5, "Emily Sierra", "Accountant", "Finance"),    
(6, "Greta Galkina", "Accountant", "Finance"), 
(7, "Maria Carter", "Executive", "Human Resources"), 
(8, "Rick Griffin", "Manager", "Marketing"); 
```

---

<br>

### Objectives
This activity aims to achieve the following objectives:
* Apply MySQL SELECT query optimization techniques
* Use indexes on a table column to enhance query performance

<br>

### **Tasks**
**1.** Simple ... but restrict column return can help more than you think!
    - Only `OrderId`, `ProductID`, `Quantity`, `Date` 
```sql
SELECT
    OrderId, ProductID, Quantity, Date
FROM Orders
LIMIT 10;
```
| OrderId | ProductID | Quantity | Date       |
|---------|-----------|----------|------------|
|       1 | P1        |       10 | 2020-09-01 |
|       2 | P2        |        5 | 2020-09-05 |
|       3 | P3        |       20 | 2020-09-03 |
|       4 | P4        |       15 | 2020-09-07 |
|       5 | P3        |       10 | 2020-09-08 |
|       6 | P2        |        5 | 2020-09-09 |
|       7 | P4        |       22 | 2020-09-10 |
|       8 | P1        |       15 | 2020-09-10 |
|       9 | P1        |       10 | 2020-09-12 |
|      10 | P2        |        5 | 2020-09-13 |

<br>

**2.** Lucky Shrub need to find the order placed by the client Cl1. They have written the following query to complete this task:
```sql
SELECT * FROM Orders WHERE ClientID ='Cl1'; 

-- Execution Plan
EXPLAIN SELECT * FROM Orders WHERE ClientID ='Cl1'; 
```
* However, this query's execution plan shows that it does not use an index to perform this search, as indicated by the NULL values in possible_keys and keys columns.  

| id | select_type | table  | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
|----|-------------|--------|------------|------|---------------|------|---------|------|------|----------|-------------|
|  1 | SIMPLE      | Orders | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   29 |    10.00 | Using where |

* **all** 29 rows used in search and **type** is indicative here

`To the Task`
* Help Lucky Shrub to optimize this query by `creating an index` named `IdxClientID` on the required column of the Orders table. Once you have created the index, run the same SELECT statement as above with the EXPLAIN statement.

```sql
CREATE INDEX ClientID_Idx ON Orders(ClientId);
-- Query OK, 0 rows affected (0.12 sec)

-- Check the same statement
EXPLAIN SELECT * FROM Orders WHERE ClientID ='Cl1'; 
```
| id | select_type | table  | partitions | type | possible_keys | key          | key_len | ref   | rows | filtered | Extra |
|----|-------------|--------|------------|------|---------------|------|---------|------|------|----------|-------------|
|  1 | SIMPLE      | Orders | NULL       | ref  | ClientID_Idx  | ClientID_Idx | 43      | const |    8 |   100.00 | NULL  |

<br>

**3.** Lucky Shrub have written the following SELECT query to find the details of the employee whose last name is `'Tolo'`
```sql
SELECT * FROM Employees WHERE FullName LIKE '%Tolo'; 
```
* However, there’s an **index** on the FullName column which the query cannot use because it contains `a leading wildcard (%) in the WHERE clause` condition.

#### **After that Wildcard**
The following steps can be taken to eliminate the leading wildcard:
1. Step 1: Add a new column to the Employees table called ReverseFullName.
2. Step 2: Populate the ReverseFullName column with the name of each employee as its values, but in reverse.
3. Step 3: Finally, create an index named IdxReverseFullName on the ReverseFullName column.

* Follow these steps first and then rewrite the SELECT query and improve its performance so that it uses a `trailing wildcard` instead of the leading wild card.

* Little Exploration here first We Would Want like : **Tolo Simon** for a value in our new index field
```sql
SELECT FullName, CHARACTER_LENGTH(FullName), POSITION(' ' in FullName) FROM Employees;
```
| FullName         | CHARACTER_LENGTH(FullName) | POSITION(' ' in FullName) |
|------------------|----------------------------|---------------------------|
| Seamus Hogan     |                         12 |                         7 |
| Thomas Eriksson  |                         15 |                         7 |
| Simon Tolo       |                         10 |                         6 |
| Francesca Soffia |                         16 |                        10 |
| Emily Sierra     |                         12 |                         6 |
| Greta Galkina    |                         13 |                         6 |
| Maria Carter     |                         12 |                         6 |
| Rick Griffin     |                         12 |                         5 |

* Now `SUBSTRING` should allow us to pluck this out in terms of 
```sql
SELECT SUBSTRING('Simon Tolo', POSITION(' ' in 'Simon Tolo'), CHARACTER_LENGTH('Simon Tolo') - POSITION(' ' in 'Simon Tolo') + 1)

SELECT 
    Fullname,
    CONCAT(SUBSTRING(FullName, POSITION(' ' in FullName), CHARACTER_LENGTH(FullName) 
    - POSITION(' ' in FullName) + 1), ' ', SUBSTRING(FullName, 1, POSITION(' ' in FullName))
    ) AS ReverseFullName
FROM Employees;
```
| Fullname         | ReverseFullName    |
|------------------|--------------------|
| Seamus Hogan     |  Hogan Seamus      |
| Thomas Eriksson  |  Eriksson Thomas   |
| Simon Tolo       |  Tolo Simon        |
| Francesca Soffia |  Soffia Francesca  |
| Emily Sierra     |  Sierra Emily      |
| Greta Galkina    |  Galkina Greta     |
| Maria Carter     |  Carter Maria      |
| Rick Griffin     |  Griffin Rick      |


* Let's see about the columns as we'll need to add a new one for this field
```sql
SHOW COLUMNS FROM Employees;
```
| Field      | Type         | Null | Key | Default | Extra |
|------------|--------------|------|-----|---------|-------|
| EmployeeID | int          | YES  |     | NULL    |       |
| FullName   | varchar(100) | YES  |     | NULL    |       |
| Role       | varchar(50)  | YES  |     | NULL    |       |
| Department | varchar(255) | YES  |     | NULL    |       |

<br>

* Back to the steps

```sql
-- 1 - Add
ALTER TABLE Employees ADD COLUMN ReverseFullName VARCHAR(100);

-- 2 Populate the ReverseFullName column with the name of each employee as its values, but in reverse
--- Red Alert (The Below just created a lot of null values with one column)
INSERT INTO Employees(ReverseFullName)
SELECT
    CONCAT(SUBSTRING(FullName, POSITION(' ' in FullName), CHARACTER_LENGTH(FullName) 
    - POSITION(' ' in FullName) + 1), ' ', SUBSTRING(FullName, 1, POSITION(' ' in FullName))
    )
FROM Employees
WHERE EmployeeID IN (1,2,3,4,5,6,7,8);


-- SOLUTION! : You can simply use a column value and set the new column value after being populated with null after the table's creation
-- 2 (For Real) - Make sure to not have any white space and start the postion (second argument) one space after the found delimiter (empty space)
UPDATE Employees SET ReverseFullName = CONCAT(SUBSTRING(FullName, POSITION(' ' in FullName)+1, CHARACTER_LENGTH(FullName) - POSITION(' ' in FullName) + 1), ' ', SUBSTRING(FullName, 1, POSITION(' ' in FullName)));

-- What what! See below for how we got a good return from this UPDATE w/existing data
-- Query OK, 8 rows affected (0.00 sec)
-- Rows matched: 8  Changed: 8  Warnings: 0
```
* Quick look at table after update

| EmployeeID | FullName         | Role        | Department      | ReverseFullName    |
|------------|------------------|-------------|-----------------|--------------------|
|          1 | Seamus Hogan     | Manager     | Management      |  Hogan Seamus      |
|          2 | Thomas Eriksson  | Assistant   | Sales           |  Eriksson Thomas   |
|          3 | Simon Tolo       | Executive   | Management      |  Tolo Simon        |
|          4 | Francesca Soffia | Assistant   | Human Resources |  Soffia Francesca  |
|          5 | Emily Sierra     | Accountant  | Finance         |  Sierra Emily      |
|          6 | Greta Galkina    | Accountant  | Finance         |  Galkina Greta     |
|          7 | Maria Carter     | Executive   | Human Resources |  Carter Maria      |
|          8 | Rick Griffin     | Manager     | Marketing       |  Griffin Rick      |


* Now to finish the steps
```sql
-- Create the Index on the new employee column value
CREATE INDEX IdxReverseFullName ON Employees(ReverseFullName);

-- Let's Make sure it works then look at the EXPLAIN Output
SELECT * 
FROM Employees 
WHERE ReverseFullName LIKE 'Tolo%';
```
| EmployeeID | FullName   | Role      | Department | ReverseFullName |
|------------|------------|-----------|------------|-----------------|
|          3 | Simon Tolo | Executive | Management | Tolo Simon      |

* It came back!
* This is now `true` 
    - SELECT query and improve its performance so that it uses a trailing wildcard instead of the leading wild card.

```sql
-- What about performance
EXPLAIN
SELECT * 
FROM Employees 
WHERE ReverseFullName LIKE 'Tolo%';
```
| id | select_type | table     | partitions | type  | possible_keys      | key                | key_len | ref  | rows | filtered | Extra                 |
|----|-------------|--------|------------|------|---------------|------|---------|------|------|----------|-------------|
|  1 | SIMPLE      | Employees | NULL       | range | IdxReverseFullName | IdxReverseFullName | 403     | NULL |    1 |   100.00 | Using index condition |