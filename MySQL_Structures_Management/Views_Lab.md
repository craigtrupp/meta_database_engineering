## Lab Instructions
Lucky Shrub is a medium-sized garden design firm that sells indoor and outdoor plants, making them a one stop shop for clients. In this lab, you must complete the following tasks to make it easier for Lucky Shrub staff to insert and update data in the Orders table using the MySQL REPLACE statement.

<br>

### **Prerequisites**
To complete this lab, you must have Lucky Shrub database created in MySQL. You must also have created and populated the Orders table with relevant data in the Lucky Shrub database.

**1.** Create DB
```sql
CREATE DATABASE Lucky_Shrub;
```
**2.** Use DB
```sql
USE Lucky_Shrub;
```
**3.** Create Orders Table
```sql
CREATE TABLE Orders (OrderID INT NOT NULL PRIMARY KEY, ClientID VARCHAR(15) NOT NULL, ProductID VARCHAR(10) NOT NULL, Quantity INT, Cost Decimal(6,2));
```
**4.** Populate Table
```sql
INSERT INTO Orders (OrderID, ClientID, ProductID, Quantity, Cost) VALUES (1, "Cl1", "P1", 10, 500), (2, "Cl2", "P2", 5, 100), (3, "Cl3", "P3", 20, 800), (4, "Cl4", "P4", 15, 150), (5, "Cl3", "P3", 10, 450), (6, "Cl2", "P2", 5, 800), (7, "Cl1", "P4", 22, 1200), (8, "Cl1", "P1", 15, 150);
```

---

<br>

### `Objectives`
The main objectives of this activity are as follows:
* Create a virtual table.
* Update the base table using the virtual table.
* Rename the virtual table.
* Drop the virtual table.

### **Tasks**
**1.** Write a SQL statement to create the OrdersView Virtual table based on the Orders table. The table must include the following columns: Order ID, Quantity and Cost
```sql
CREATE VIEW OrdersView AS SELECT OrderID, Quantity, Cost FROM Orders;
```
| OrderID | Quantity | Cost    |
|---------|----------|---------|
|       1 |       10 |  500.00 |
|       2 |        5 |  100.00 |
|       3 |       20 |  800.00 |
|       4 |       15 |  150.00 |
|       5 |       10 |  450.00 |
|       6 |        5 |  800.00 |
|       7 |       22 | 1200.00 |
|       8 |       15 |  150.00 |

<br>

**2.** Write a SQL statement that utilizes the `‘OrdersView’` virtual table to **Update** the base Orders table. In the UPDATE TABLE statement, change the cost to 200 where the order id equals 2
```sql
UPDATE OrdersView SET Cost = 200 WHERE OrderID = 2; 
```
* This updates the base table `Orders` as well as the View. So OrderID has been changed in two areas for the `Cost` Column

| OrderID | ClientID | ProductID | Quantity | Cost    |
|---------|----------|-----------|----------|---------|
|       1 | Cl1      | P1        |       10 |  500.00 |
|       2 | Cl2      | P2        |        5 |  200.00 |
|       3 | Cl3      | P3        |       20 |  800.00 |
|       4 | Cl4      | P4        |       15 |  150.00 |
|       5 | Cl3      | P3        |       10 |  450.00 |
|       6 | Cl2      | P2        |        5 |  800.00 |
|       7 | Cl1      | P4        |       22 | 1200.00 |
|       8 | Cl1      | P1        |       15 |  150.00 |

<br>

**3.** Write a SQL statement that changes the name of the ‘OrdersView’ virtual table to ClientsOrdersView
```sql
RENAME TABLE OrdersView TO ClientsOrdersView;
```
* Query OK, 0 rows affected (0.02 sec)

<br>

**4.** Write a SQL statement to delete the Orders virtual table.
```sql
DROP VIEW ClientsOrdersView;
```
* Query OK, 0 rows affected (0.00 sec)