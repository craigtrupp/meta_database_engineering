## Working w/Subqueries
Little Lemon is a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist. In this lab, you must complete the following tasks to make it easier for Little Lemon restaurant to print relevant booking and menu details with the help of subqueries.

<br>

### **Setup**
1. Create database
```sql
CREATE DATABASE IF NOT EXISTS littlelemon_db;
```
2. Use Database
```sql
USE littlelemond_db;
```
3. Create the MenuItems table
```sql
CREATE TABLE MenuItems ( 
  ItemID INT, 
  Name VARCHAR(200), 
  Type VARCHAR(100), 
  Price INT, 
  PRIMARY KEY (ItemID) 
); 
```
4. Create the Menus table
```sql
CREATE TABLE Menus ( 
  MenuID INT, 
  ItemID INT, 
  Cuisine VARCHAR(100), 
  PRIMARY KEY (MenuID,ItemID)
); 
```
5. Create Bookings Table
```sql
CREATE TABLE Bookings ( 
  BookingID INT, 
  TableNo INT, 
  GuestFirstName VARCHAR(100), 
  GuestLastName VARCHAR(100), 
  BookingSlot TIME, 
  EmployeeID INT, 
  PRIMARY KEY (BookingID) 
);  
```
6. Create TableOrders Table
```sql
CREATE TABLE TableOrders ( 
  OrderID INT, 
  TableNo INT, 
  MenuID INT, 
  BookingID INT, 
  BillAmount INT, 
  Quantity INT, 
  PRIMARY KEY (OrderID,TableNo) 
);  
```
7. Insert Data
```sql
-- Menu Items Insertion
INSERT INTO MenuItems VALUES(1,'Olives','Starters', 5), 
(2,'Flatbread','Starters', 5),
(3, 'Minestrone', 'Starters', 8), 
(4, 'Tomato bread','Starters', 8), 
(5, 'Falafel', 'Starters', 7), 
(6, 'Hummus', 'Starters', 5), 
(7, 'Greek salad', 'Main Courses', 15), 
(8, 'Bean soup', 'Main Courses', 12), 
(9, 'Pizza', 'Main Courses', 15), 
(10,'Greek yoghurt','Desserts', 7), 
(11, 'Ice cream', 'Desserts', 6),
(12, 'Cheesecake', 'Desserts', 4), 
(13, 'Athens White wine', 'Drinks', 25), 
(14, 'Corfu Red Wine', 'Drinks', 30), 
(15, 'Turkish Coffee', 'Drinks', 10), 
(16, 'Turkish Coffee', 'Drinks', 10), 
(17, 'Kabasa', 'Main Courses', 17);

-- Menus Insertion
INSERT INTO Menus VALUES(1, 1, 'Greek'), (1, 7, 'Greek'), (1, 10, 'Greek'), (1, 13, 'Greek'), (2, 3, 'Italian'), (2, 9, 'Italian'), (2, 12, 'Italian'), (2, 15, 'Italian'), (3, 5, 'Turkish'), (3, 17, 'Turkish'), (3, 11, 'Turkish'), (3, 16, 'Turkish');

-- Bookings
INSERT INTO Bookings VALUES(1,12,'Anna','Iversen','19:00:00',1),  
(2, 12, 'Joakim', 'Iversen', '19:00:00', 1), (3, 19, 'Vanessa', 'McCarthy', '15:00:00', 3), 
(4, 15, 'Marcos', 'Romero', '17:30:00', 4), (5, 5, 'Hiroki', 'Yamane', '18:30:00', 2),
(6, 8, 'Diana', 'Pinto', '20:00:00', 5); 

-- Table Orders
INSERT INTO TableOrders VALUES(1, 12, 1, 1, 2, 86), (2, 19, 2, 2, 1, 37), (3, 15, 2, 3, 1, 37), (4, 5, 3, 4, 1, 40), (5, 8, 1, 5, 1, 43);
```
---

<br>

### `Objectives`
There are two main objectives in this activity:
* Working with single row, multiple row and correlated subqueries.
* Using the comparison operators and the `ALL` and `NOT EXISTS` operators with subqueries.

**1.** Write a SQL SELECT query to find all bookings that are due after the booking of the guest ‘Vanessa McCarthy’.
```sql
SELECT * FROM Bookings WHERE BookingSlot > (SELECT BookingSlot FROM Bookings WHERE GuestFirstName = 'Vanessa' AND GuestLastName = 'McCarthy');
```
| BookingID | TableNo | GuestFirstName | GuestLastName | BookingSlot | EmployeeID |
|-----------|---------|----------------|---------------|-------------|------------|
|         1 |      12 | Anna           | Iversen       | 19:00:00    |          1 |
|         2 |      12 | Joakim         | Iversen       | 19:00:00    |          1 |
|         4 |      15 | Marcos         | Romero        | 17:30:00    |          4 |
|         5 |       5 | Hiroki         | Yamane        | 18:30:00    |          2 |
|         6 |       8 | Diana          | Pinto         | 20:00:00    |          5 |

<br>

**2.**  Write a SQL SELECT query to find the menu items that are more expensive than all the 'Starters' and 'Desserts' menu item types.
```sql
SELECT * FROM MenuItems WHERE Price > ALL(SELECT Price FROM MenuItems WHERE Type in ('Starters', 'Desserts'));
```
| ItemID | Name              | Type         | Price |
|--------|-------------------|--------------|-------|
|      7 | Greek salad       | Main Courses |    15 |
|      8 | Bean soup         | Main Courses |    12 |
|      9 | Pizza             | Main Courses |    15 |
|     13 | Athens White wine | Drinks       |    25 |
|     14 | Corfu Red Wine    | Drinks       |    30 |
|     15 | Italian Coffee    | Drinks       |    10 |
|     16 | Turkish Coffee    | Drinks       |    10 |
|     17 | Kabasa            | Main Courses |    17 |

**3.**  Write a SQL SELECT query to find the menu items that costs the same as the starter menu items that are Italian cuisine. Need to join menus (cuisine type) to menuitems (price)
```sql
SELECT * FROM MenuItems WHERE Price = (
    SELECT mtms.price
    FROM Menus AS mn
    INNER JOIN MenuItems AS mtms
        ON mn.ItemID = mtms.ItemID
    WHERE mn.Cuisine = 'Italian' AND mtms.Type = 'Starters'
    )
```
| ItemID | Name         | Type     | Price |
|--------|--------------|----------|-------|
|      3 | Minestrone   | Starters |     8 |
|      4 | Tomato bread | Starters |     8 |

<br>

**4.** Write a SQL SELECT query to find the menu items that were not ordered by the guests who placed bookings.
* Let's break this one down a bit and start with the Subquery
```sql
-- Need to Join these three tables to get to the ItemID we're ultimately after 
SELECT *
FROM TableOrders AS todrs
INNER JOIN Menus AS mnu
    ON todrs.MenuID = mnu.MenuID
INNER JOIN MenuItems as mnitms
    ON mnu.ItemID = mnitms.ItemID;
```
| OrderID | TableNo | MenuID | BookingID | BillAmount | Quantity | MenuID | ItemID | Cuisine | ItemID | Name              | Type         | Price |
|---------|---------|--------|-----------|------------|----------|--------|--------|---------|--------|-------------------|--------------|-------|
|       1 |      12 |      1 |         1 |          2 |       86 |      1 |      1 | Greek   |      1 | Olives            | Starters     |     5 |
|       1 |      12 |      1 |         1 |          2 |       86 |      1 |      7 | Greek   |      7 | Greek salad       | Main Courses |    15 |
|       1 |      12 |      1 |         1 |          2 |       86 |      1 |     10 | Greek   |     10 | Greek yoghurt     | Desserts     |     7 |
|       1 |      12 |      1 |         1 |          2 |       86 |      1 |     13 | Greek   |     13 | Athens White wine | Drinks       |    25 |
|       2 |      19 |      2 |         2 |          1 |       37 |      2 |      3 | Italian |      3 | Minestrone        | Starters     |     8 |
|       2 |      19 |      2 |         2 |          1 |       37 |      2 |      9 | Italian |      9 | Pizza             | Main Courses |    15 |
|       2 |      19 |      2 |         2 |          1 |       37 |      2 |     12 | Italian |     12 | Cheesecake        | Desserts     |     4 |
|       2 |      19 |      2 |         2 |          1 |       37 |      2 |     15 | Italian |     15 | Turkish Coffee    | Drinks       |    10 |
|       3 |      15 |      2 |         3 |          1 |       37 |      2 |      3 | Italian |      3 | Minestrone        | Starters     |     8 |
|       3 |      15 |      2 |         3 |          1 |       37 |      2 |      9 | Italian |      9 | Pizza             | Main Courses |    15 |
|       3 |      15 |      2 |         3 |          1 |       37 |      2 |     12 | Italian |     12 | Cheesecake        | Desserts     |     4 |
|       3 |      15 |      2 |         3 |          1 |       37 |      2 |     15 | Italian |     15 | Turkish Coffee    | Drinks       |    10 |
|       4 |       5 |      3 |         4 |          1 |       40 |      3 |      5 | Turkish |      5 | Falafel           | Starters     |     7 |
|       4 |       5 |      3 |         4 |          1 |       40 |      3 |     11 | Turkish |     11 | Ice cream         | Desserts     |     6 |
|       4 |       5 |      3 |         4 |          1 |       40 |      3 |     16 | Turkish |     16 | Turkish Coffee    | Drinks       |    10 |
|       4 |       5 |      3 |         4 |          1 |       40 |      3 |     17 | Turkish |     17 | Kabasa            | Main Courses |    17 |
|       5 |       8 |      1 |         5 |          1 |       43 |      1 |      1 | Greek   |      1 | Olives            | Starters     |     5 |
|       5 |       8 |      1 |         5 |          1 |       43 |      1 |      7 | Greek   |      7 | Greek salad       | Main Courses |    15 |
|       5 |       8 |      1 |         5 |          1 |       43 |      1 |     10 | Greek   |     10 | Greek yoghurt     | Desserts     |     7 |
|       5 |       8 |      1 |         5 |          1 |       43 |      1 |     13 | Greek   |     13 | Athens White wine | Drinks       |    25 |

* So essentially this would be based on the design all that was ordered for any booking by linking the menu id to the menu id in booking and then the itemID in menu to menu_itmes
    * There is **17** unique MenuItems.ItemID in the dataset
```sql
SELECT DISTINCT(mnitms.ItemID)
FROM TableOrders AS todrs
INNER JOIN Menus AS mnu
    ON todrs.MenuID = mnu.MenuID
INNER JOIN MenuItems as mnitms
    ON mnu.ItemID = mnitms.ItemID
ORDER BY mnitms.ItemID;
```
| ItemID |
|--------|
|      1 |
|      3 |
|      5 |
|      7 |
|      9 |
|     10 |
|     11 |
|     12 |
|     13 |
|     15 |
|     16 |
|     17 |

* We essentially want any menu item not in this join but ... have to write the subquery a bit differently (unsure why)
* The subquery in the following query can not be run separately because it depends on the outer query.
    * The subquery depends on, or uses data from the outer query. That is, it refers to MenuItems.ItemID. 
    * The MenuItems table is a table used in the outer query. Therefore, it cannot be executed independently (the subquery).


```sql
SELECT * 
FROM MenuItems 
WHERE NOT EXISTS (
    SELECT * FROM TableOrders, Menus WHERE TableOrders.MenuID = Menus.MenuID AND Menus.ItemID = MenuItems.ItemID
) 
ORDER BY ItemID; 
```
| ItemID | Name           | Type         | Price |
|--------|----------------|--------------|-------|
|      2 | Flatbread      | Starters     |     5 |
|      4 | Tomato bread   | Starters     |     8 |
|      6 | Hummus         | Starters     |     5 |
|      8 | Bean soup      | Main Courses |    12 |
|     14 | Corfu Red Wine | Drinks       |    30 |


---

<br>


### `Bonus Exercise`
* Need to Create a New Table
```sql
CREATE TABLE LowCostMenuItems
(ItemID INT, Name VARCHAR(200), Price INT, PRIMARY KEY(ItemID));

-- Let's look at the tables
SHOW TABLES;
```
| Tables_in_littlelemon_db |
|--------------------------|
| Bookings                 |
| LowCostMenuItems         |
| MenuItems                |
| Menus                    |
| TableOrders              |

<br>

#### **Tasks**
**1.** Find the minimum and the maximum average prices at which the customers can purchase food and drinks. (I guess this equates to Type?)
* Subquery
```sql
SELECT 
    Type,
    ROUND(AVG(Price), 2) AS Avg_Price_Per_type
FROM MenuItems
GROUP BY Type
ORDER BY Type, Avg_Price_Per_type;
```
| Type         | Avg_Price_Per_type |
|--------------|--------------------|
| Desserts     |               5.67 |
| Drinks       |              18.75 |
| Main Courses |              14.75 |
| Starters     |               6.33 |

```sql
-- Subquery AS alias required or a syntax error is returned
-- ERROR 1248 (42000): Every derived table must have its own alias
SELECT
    MIN(avg_type_price) AS min_avg_type_price,
    MAX(avg_type_price) AS max_avg_type_price
FROM (
    SELECT
        Type,
        ROUND(AVG(Price), 2) AS avg_type_price
    FROM MenuItems
    GROUP BY Type
) AS avg_prices;
```
| min_avg_type_price | max_avg_type_price |
|--------------------|--------------------|
|               5.67 |              18.75 |

<br>

**2.** Insert data of menu items with a minimum price based on the 'Type' into the `LowCostMenuItems` table.
* We'll be wanting to **INSERT INTO** the following table
```sql
SHOW COLUMNS FROM LowCostMenuItems;
```
| Field  | Type         | Null | Key | Default | Extra |
|--------|--------------|------|-----|---------|-------|
| ItemID | int          | NO   | PRI | NULL    |       |
| Name   | varchar(200) | YES  |     | NULL    |       |
| Price  | int          | YES  |     | NULL    |       |

```sql
INSERT INTO LowCostMenuItems 
SELECT ItemID, Name, Price
FROM MenuItems
WHERE Price = ANY(
    -- We want to include the min(price) but not the type in our select output
    SELECT 
        MIN(Price)
    FROM MenuItems
    GROUP BY Type
    ); 
```
* Check the output table
```sql
SELECT * FROM LowCostMenuItems;
```
| ItemID | Name           | Price |
|--------|----------------|-------|
|      1 | Olives         |     5 |
|      2 | Flatbread      |     5 |
|      6 | Hummus         |     5 |
|      8 | Bean soup      |    12 |
|     12 | Cheesecake     |     4 |
|     15 | Italian Coffee |    10 |
|     16 | Turkish Coffee |    10 |

* Now What about the MenuItems Table Subquery
```sql
SELECT
    Type,
    MIN(Price) AS min_type_price
FROM MenuItems
GROUP BY Type
ORDER BY min_type_price;
```
| Type         | min_type_price |
|--------------|----------------|
| Desserts     |              4 |
| Starters     |              5 |
| Drinks       |             10 |
| Main Courses |             12 |

#### `Quick Review for #2`
* We found the minimum Value per type and returned the price (second column of output above) in our subquery.
* Next, we looked to insert into our newly created table for any item in MenuItems that matches this price.
    * Hence the repeating price values for **5** and **10**
    * Should any Price in MenuItem equal the min prices we've found, then we select those items from the same table and takte the attributes to add in 

<br>

**3.**  Delete all the low-cost menu items whose price is more than the minimum price of menu items that have a price between $5 and $10.
```sql
DELETE FROM LowCostMenuItems
WHERE Price > ALL(
    SELECT
        MIN(Price) AS min_price
    FROM MenuItems
    GROUP BY Type
    HAVING min_price BETWEEN 5 AND 10
);
```
* Query OK, 1 row affected (0.01 sec)
```sql
SELECT Type, MIN(Price) FROM MenuItems GROUP BY Type HAVING MIN(Price) BETWEEN 5 AND 10;
```
| Type     | MIN(Price) |
|----------|------------|
| Starters |          5 |
| Drinks   |         10 |
