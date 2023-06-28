## Working with triggers
Lucky Shrub need to impose business rules for inserting, updating and deleting product data in their database. You can help them by implementing triggers on the Products table.

The Products table contains the following information about each product:
* ProductID  
* ProductName  
* BuyPrice  
* SellPrice
* NumberOfItems

The following table shows the Products table in the Lucky Shrub database:

|ProductID|ProductName|BuyPrice|SellPrice|NumberOfItems|
|------|-----|-----|-----|------|
|P1|Artificial grass bags |40|50|100|
|P2|Wood panels|15|20|250|
|P3|Patio slates|35|40|60|
|P4|Sycamore trees|7|10|50|
|P5|Trees and Shrubs|35|50|75|
|P6|Water fountain|65|80|15|

### Create PreReqs
* Create DB
```sql
CREATE DATABASE Lucky_Shrub
```
* Use
```sql
USE Lucky_Shrub;
```
* Create Products
```sql
CREATE TABLE Products (ProductID VARCHAR(10), ProductName VARCHAR(100),BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT);
```
* Insert Into Products
```sql
INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfITems)
VALUES ("P1", "Artificial grass bags ", 40, 50, 100),  
("P2", "Wood panels", 15, 20, 250),  
("P3", "Patio slates",35, 40, 60),  
("P4", "Sycamore trees ", 7, 10, 50),  
("P5", "Trees and Shrubs", 35, 50, 75),  
("P6", "Water fountain", 65, 80, 15);
```
* Create Notifications Table 
```sql
CREATE TABLE Notifications (NotificationID INT AUTO_INCREMENT, Notification VARCHAR(255), DateTime TIMESTAMP NOT NULL, PRIMARY KEY(NotificationID));
```

---

<br>

### Tasks & Objectives
The main objective of this activity:
* Develop INSERT, UPDATE and DELETE triggers.

**1.** Create an `INSERT` trigger called `ProductSellPriceInsertCheck`. 
* This trigger must check if the `SellPrice` of the product is less than the `BuyPrice` after a new product is inserted in the Products table. 
* If this occurs, then a notification must be added to the Notifications table to inform the sales department. 
* The sales department can then ensure that the incorrect values were not inserted by mistake.

The notification message should be in the following format: 
* A SellPrice less than the BuyPrice was inserted for ProductID + ProductID

```sql
DELIMITER //
 CREATE TRIGGER IF NOT EXISTS ProductSellPriceInsertCheck
    AFTER INSERT
    ON Products FOR EACH ROW
    BEGIN
        IF NEW.SellPrice <= NEW.BuyPrice 
        THEN
            INSERT INTO Notifications (Notification, DateTime) -- Clarify column(non-auto incrementing)
            VALUES(CONCAT('A SellPrice less than the BuyPrice was inserted for ProductID ', NEW.ProductID), CURRENT_TIME());
        END IF;
    END;//
DELIMITER ;
```

* No value greater so let's insert a trial case and see
```sql
INSERT INTO Products VALUES ('P7', 'Product p7', 40.00, 39.45, 100);
-- Query OK, 1 row affected (0.01 sec)
```
* Ok now let's look at Notifications
```sql
SELECT * FROM Notifications;
```
* Remember it's an auto incrementing so the `BEGIN-END` just need clear column detailing in the statement

| NotificationID|Notification|DateTime|
|----|-----|-----|
|1|A SellPrice less than the BuyPrice was inserted for ProductID P7 | 2023-06-28 17:42:30 |

<br>

**2.** Create an `UPDATE` trigger called `ProductSellPriceUpdateCheck`. 
* This trigger must check that products are not updated with a `SellPrice` that is less than or equal to the `BuyPrice`. 
* If this occurs, add a notification to the Notifications table for the sales department so they can ensure that product prices were not updated with the incorrect values. 
* This trigger sends a notification to the Notifications table that warns the sales department of the issue.

The notification message should be in the following format: ProductID + was updated with a SellPrice of  + SellPrice + which is the same or less than the BuyPrice

#### **Well We Need to Update Products First for the Row they want to see captured as no condition fit the described trigger** 
```sql
UPDATE Product SET BuyPrice = 64.50 WHERE ProductID = 'P6';

-- Now Can check Products Again
SELECT * FROM Products;
```
| ProductID | ProductName            | BuyPrice | SellPrice | NumberOfItems |
|-----------|------------------------|----------|-----------|---------------|
| P1        | Artificial grass bags  |    40.00 |     50.00 |           100 |
| P2        | Wood panels            |    15.00 |     20.00 |           250 |
| P3        | Patio slates           |    35.00 |     40.00 |            60 |
| P4        | Sycamore trees         |     7.00 |     10.00 |            50 |
| P5        | Trees and Shrubs       |    35.00 |     50.00 |            75 |
| P6        | Water fountain         |    64.50 |     60.00 |            15 |

* Now we want to see if a sell price is less than or equal to the buy price (in such case populate the notifications that the product has been undepriced)

```sql
DELIMITER //
 CREATE TRIGGER IF NOT EXISTS ProductSellPriceUpdateCheck
    AFTER UPDATE
    ON Products FOR EACH ROW
    BEGIN
        IF NEW.SellPrice <= NEW.BuyPrice 
        THEN
            INSERT INTO Notifications (Notification, DateTime) -- Clarify column(non-auto incrementing) - Also will use new for the updated change
            VALUES(CONCAT(NEW.ProductID, ' was updated with a SellPrice of : ', NEW.SellPrice, ' which is the same or less than the BuyPrice : ', NEW.BuyPrice), CURRENT_TIME());
        END IF;
    END;//
DELIMITER ;

-- Now check Notifications
SELECT * FROM Notifications;
```
| NotificationID|Notification|DateTime|
|----|-----|-----|
|1|A SellPrice less than the BuyPrice was inserted for ProductID P7 | 2023-06-28 17:42:30 |
|2|P6 was updated with a SellPrice of : 60.00 which is the same or less than the BuyPrice : 64.50| 2023-06-28 18:03:33 |

<br>


