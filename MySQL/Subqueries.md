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
|     15 | Turkish Coffee    | Drinks       |    10 |
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
