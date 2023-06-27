## Stored Procedures
### **Lab Instructions**
Lucky Shrub is a medium-sized garden design firm that sells indoor and outdoor plants, making them a one stop shop for clients. In this lab, you must complete a series of tasks to help Lucky Shrub access relevant data from the Orders table in their database using `stored procedures`.

The Orders table contains information about the Order ID, Client ID, Product ID, Quantity and Cost as shown in the following screenshot.

<br>

#### **Prerequisites**
To complete this lab, you must have the Lucky Shrub database created in MySQL. You must also have created and populated the Orders table with relevant data in the Lucky Shrub database.

```sql
CREATE DATABASE Lucky_Shrub;
```
```sql
USE Lucky_Shrub;
```
```sql
CREATE TABLE Orders (OrderID INT, ClientID VARCHAR(10), ProductID VARCHAR(10), Quantity INT, Cost DECIMAL(6, 2));
```
```sql
INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost) VALUES (1, "Cl1", "P1", 10, 500), (2, "Cl2", "P2", 5, 100), (3, "Cl3", "P3", 20, 800), (4, "Cl4", "P4", 15, 150), (5, "Cl3", "P3", 10, 450), (6, "Cl2", "P2", 5, 800), (7, "Cl1", "P4", 22, 1200), (8, "Cl1", "P1", 15, 150);
```

<br>

#### **There are two main objectives in this activity:**
1. Create stored procedures with empty parameters.
2. Create stored procedures with two parameters.

---

<br>

### **Tasks Instructions**
Please complete the following tasks.

**1.** Write a SQL statement that creates a stored procedure called `'GetOrdersData'` which retrieves all data from the Orders table.
```sql
CREATE PROCEDURE GetOrdersData()
SELECT * FROM Orders;

CALL GetOrdersData();
```
| OrderID | ClientID | ProductID | Quantity | Cost    |
|---------|----------|-----------|----------|---------|
|       1 | Cl1      | P1        |       10 |  500.00 |
|       2 | Cl2      | P2        |        5 |  100.00 |
|       3 | Cl3      | P3        |       20 |  800.00 |
|       4 | Cl4      | P4        |       15 |  150.00 |
|       5 | Cl3      | P3        |       10 |  450.00 |
|       6 | Cl2      | P2        |        5 |  800.00 |
|       7 | Cl1      | P4        |       22 | 1200.00 |
|       8 | Cl1      | P1        |       15 |  150.00 |

<br>

**2.** Write a SQL statement that creates a stored procedure called `“GetListOfOrdersInRange”`. The procedure must contain two parameters that determine the range of retrieved data based on the user input of two cost values **“MinimumValue”** and **“MaximumValue”**.
* Once you have executed the query, call the “GetListOfOrdersInRange” to display the data of orders that cost between $150 and $600.
```sql
CREATE PROCEDURE GetListOfOrdersInRange(MinimumValue INT, MaximumValue INT)
SELECT * FROM Orders WHERE Cost BETWEEN MinimumValue AND MaximumValue;

CALL GetListOfOrdersInRange(150, 600)
```
| OrderID | ClientID | ProductID | Quantity | Cost   |
|---------|----------|-----------|----------|---------|
|       1 | Cl1      | P1        |       10 | 500.00 |
|       4 | Cl4      | P4        |       15 | 150.00 |
|       5 | Cl3      | P3        |       10 | 450.00 |
|       8 | Cl1      | P1        |       15 | 150.00 |

<br>

* Alternative type for Minimum and Maximum 
```sql
CREATE PROCEDURE GetListOfOrdersInRange (MinimumValue DECIMAL(5,2), MaximumValue DECIMAL(5,2)) SELECT * FROM Orders WHERE Cost >= MinimumValue AND Cost <= MaximumValue;

CALL GetListOfOrdersInRange(151.25, 599.85);
```
| OrderID | ClientID | ProductID | Quantity | Cost   |
|---------|----------|-----------|----------|---------|
|       1 | Cl1      | P1        |       10 | 500.00 |
|       5 | Cl3      | P3        |       10 | 450.00 |