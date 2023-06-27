## Lab Instructions

**Lucky Shrub** is a medium-sized garden design firm that sells indoor and outdoor plants, making them a one stop shop for clients. In this lab, you are going to complete the following tasks to make it easier for Lucky Shrub staff to print relevant order data on the screen.

The `Orders` table contains information about the following columns
* Order ID, Client ID, Product ID, Quantity and Cost as shown below.

![Filtering Lab Table](images/filter_lab_1.png)

<br>

### **PreReqs**

<br>

1. Create Database
```sql
CREATE DATABASE IF NOT EXISTS Lucky_Shrub
```
2. Use Database
```sql
USE Lucky_Shrub;
```
3. Create Orders Table
```sql
CREATE TABLE Orders (OrderID INT NOT NULL PRIMARY KEY, ClientID VARCHAR(10), ProductID VARCHAR(10), Quantity INT, Cost DECIMAL(6, 2))
```
4. Insert Data
```sql
INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost) VALUES (1, "Cl1", "P1", 10, 500), (2, "Cl2", "P2", 5, 100), (3, "Cl3", "P3", 20, 800), (4, "Cl4", "P4", 15, 150), (5, "Cl3", "P3", 10, 450), (6, "Cl2", "P2", 5, 800), (7, "Cl1", "P4", 22, 1200), (8, "Cl3", "P1", 15, 150), (9, "Cl1", "P1", 10, 500), (10, "Cl2", "P2", 5, 100);
```

<br>

### **Tasks Instructions**
Please attempt the following tasks:

**1.** Write a SQL statement to print all records of orders where the cost is $250 or less.
```sql
SELECT * FROM Orders WHERE Cost <= 250;
```
| OrderID | ClientID | ProductID | Quantity | Cost   |
|-----|-----|-----|-----|-----|
|       2 | Cl2      | P2        |        5 | 100.00 |
|       4 | Cl4      | P4        |       15 | 150.00 |
|       8 | Cl3      | P1        |       15 | 150.00 |
|      10 | Cl2      | P2        |        5 | 100.00 |

<br>

**2.** Write a SQL statement to print all records of orders where the cost is between $50 and $750. 
```sql
SELECT * FROM Orders WHERE Cost BETWEEN 50 AND 750 ORDER BY Cost;
```
| OrderID | ClientID | ProductID | Quantity | Cost   |
|---------|----------|-----------|----------|--------|
|       2 | Cl2      | P2        |        5 | 100.00 |
|      10 | Cl2      | P2        |        5 | 100.00 |
|       4 | Cl4      | P4        |       15 | 150.00 |
|       8 | Cl3      | P1        |       15 | 150.00 |
|       5 | Cl3      | P3        |       10 | 450.00 |
|       1 | Cl1      | P1        |       10 | 500.00 |
|       9 | Cl1      | P1        |       10 | 500.00 |

<br>

**3.** Write a SQL statement to print all records of orders that have been placed by the client with the id of Cl3 and where the cost of the order is more than $100.
```sql
SELECT * FROM Orders WHERE ClientID = 'Cl3' AND Cost > 100;
```

| OrderID | ClientID | ProductID | Quantity | Cost   |
|---------|----------|-----------|----------|--------|
|       3 | Cl3      | P3        |       20 | 800.00 |
|       5 | Cl3      | P3        |       10 | 450.00 |
|       8 | Cl3      | P1        |       15 | 150.00 |

<br>

**4.** Write a SQL statement to print all records of orders that have a product id of p1 or p2 and the order quantity is more than 2.
```sql
SELECT * FROM Orders WHERE ProductID IN ('P1', 'P2') AND Quantity >= 2;
```

| OrderID | ClientID | ProductID | Quantity | Cost   |
|---------|----------|-----------|----------|--------|
|       1 | Cl1      | P1        |       10 | 500.00 |
|       2 | Cl2      | P2        |        5 | 100.00 |
|       6 | Cl2      | P2        |        5 | 800.00 |
|       8 | Cl3      | P1        |       15 | 150.00 |
|       9 | Cl1      | P1        |       10 | 500.00 |
|      10 | Cl2      | P2        |        5 | 100.00 |


---

<br>

### **One More Filtering Exercise**
Based in Tuscon, Arizona, Lucky Shrub is a medium-sized company specializing in garden design, creation, maintenance and landscaping. The company also runs a small nursery that sells indoor and outdoor plants.

Lucky Shrub has seven employees who work in six different departments.

* Create sample SQL DB/Table
```sql
CREATE DATABASE luckyshrub_db; 

USE luckyshrub_db;

CREATE TABLE employees (
  EmployeeID int NOT NULL,
  EmployeeName varchar(150) DEFAULT NULL,
  Department varchar(150) DEFAULT NULL,
  ContactNo varchar(12) DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  AnnualSalary int DEFAULT NULL,
  PRIMARY KEY (EmployeeID)
);

INSERT INTO employees VALUES 
(1,'Seamus Hogan', 'Recruitment', '351478025', 'Seamus.h@luckyshrub.com',50000), 
(2,'Thomas Eriksson', 'Legal', '351475058', 'Thomas.e@ luckyshrub.com',75000), 
(3,'Simon Tolo', 'Marketing', '351930582','Simon.t@ luckyshrub.com',40000), 
(4,'Francesca Soffia', 'Finance', '351258569','Francesca.s@ luckyshrub.com',45000), 
(5,'Emily Sierra', 'Customer Service', '351083098','Emily.s@ luckyshrub.com',35000), 
(6,'Maria Carter', 'Human Resources', '351022508','Maria.c@ luckyshrub.com',55000),
(7,'Rick Griffin', 'Marketing', '351478458','Rick.G@luckyshrub.com',50000);
```
* Lucky Shrub management needs to generate reports based on this employee data by completing the following tasks:

**1.** Use the AND operator to find employees who earn an annual salary of $50,000 or more attached to the Marketing department.
```sql
SELECT * FROM employees WHERE Department = 'Marketing' AND AnnualSalary >= 50000;
```

**2.** Use the NOT operator to find employees not earning over $50,000 across all departments.
```sql
SELECT * FROM employees WHERE NOT AnnualSalary >= 50000;
```

Task 3: Use the IN operator to find Marketing, Finance, and Legal employees whose annual salary is below $50,000.
```sql
SELECT * FROM employees WHERE Department IN ('Finance', 'Marketing', 'Legal') AND AnnualSalary < 50000;
```

Task 4: Use the BETWEEN operator to find employees who earn annual salaries between $10,000 and $50,000.
```sql
SELECT * FROM employees WHERE AnnualSalary BETWEEN 10000 AND 50000;
```

Task 5: Use the LIKE operator to find employees whose names start with ‘S’ and are at least 4 characters in length.
* Ending of the name
```sql
SELECT * FROM employees WHERE EmployeeName LIKE '%S___';
```
* Start of the name
```sql
SELECT * FROM employees WHERE EmployeeName LIKE 'S___%';
```