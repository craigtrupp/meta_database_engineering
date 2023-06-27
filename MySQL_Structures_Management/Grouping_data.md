## Lab Instructions
Lab Instructions
Lucky Shrub is a medium-sized garden design firm that sells indoor and outdoor plants, making them a one stop shop for clients. In this lab, you must complete the following tasks to help Lucky Shrub group and filter grouped data for their reports using the GROUP BY and HAVING clauses.

The Orders table used for this lab contains the following data: OrderID, Department, OrderDate, OrderQty and OrderTotal 

<br>

### `PreReqs`
1. Create Database
```sql
CREATE DATABASE luckyshrub_db;
```
2. Use Database
```sql
USE luckyshrub_db;
```
3. Create Orders Tables
```sql
CREATE TABLE Orders(OrderID INT, Department VARCHAR(100), OrderDate DATE, OrderQty INT, OrderTotal INT, PRIMARY KEY(OrderID));
```
4. Insert data
```sql
INSERT INTO Orders VALUES(1,'Lawn Care','2022-05-05',12,500),(2,'Decking','2022-05-22',150,1450),(3,'Compost and Stones','2022-05-27',20,780),(4,'Trees and Shrubs','2022-06-01',15,400),(5,'Garden Decor','2022-06-10',2,1250),(6,'Lawn Care','2022-06-10',12,500),(7,'Decking','2022-06-25',150,1450),(8,'Compost and Stones','2022-05-29',20,780),(9,'Trees and Shrubs','2022-06-10',15,400),(10,'Garden Decor','2022-06-10',2,1250),(11,'Lawn Care','2022-06-25',10,400), 
(12,'Decking','2022-06-25',100,1400),(13,'Compost and Stones','2022-05-30',15,700),(14,'Trees and Shrubs','2022-06-15',10,300),(15,'Garden Decor','2022-06-11',2,1250),(16,'Lawn Care','2022-06-10',12,500),(17,'Decking','2022-06-25',150,1450),(18,'Trees and Shrubs','2022-06-10',15,400),(19,'Lawn Care','2022-06-10',12,500),(20,'Decking','2022-06-25',150,1450),(21,'Decking','2022-06-25',150,1450);
```

---

<br>

### **Exercise Instructions**
* General Table Detail

| OrderID | Department         | OrderDate  | OrderQty | OrderTotal |
|---------|--------------------|------------|----------|------------|
|       1 | Lawn Care          | 2022-05-05 |       12 |        500 |
|       2 | Decking            | 2022-05-22 |      150 |       1450 |
|       3 | Compost and Stones | 2022-05-27 |       20 |        780 |
|       4 | Trees and Shrubs   | 2022-06-01 |       15 |        400 |
|       5 | Garden Decor       | 2022-06-10 |        2 |       1250 |
|       6 | Lawn Care          | 2022-06-10 |       12 |        500 |
|       7 | Decking            | 2022-06-25 |      150 |       1450 |
|       8 | Compost and Stones | 2022-05-29 |       20 |        780 |
|       9 | Trees and Shrubs   | 2022-06-10 |       15 |        400 |
|      10 | Garden Decor       | 2022-06-10 |        2 |       1250 |
|      11 | Lawn Care          | 2022-06-25 |       10 |        400 |
|      12 | Decking            | 2022-06-25 |      100 |       1400 |
|      13 | Compost and Stones | 2022-05-30 |       15 |        700 |
|      14 | Trees and Shrubs   | 2022-06-15 |       10 |        300 |
|      15 | Garden Decor       | 2022-06-11 |        2 |       1250 |
|      16 | Lawn Care          | 2022-06-10 |       12 |        500 |
|      17 | Decking            | 2022-06-25 |      150 |       1450 |
|      18 | Trees and Shrubs   | 2022-06-10 |       15 |        400 |
|      19 | Lawn Care          | 2022-06-10 |       12 |        500 |
|      20 | Decking            | 2022-06-25 |      150 |       1450 |
|      21 | Decking            | 2022-06-25 |      150 |       1450 |

<br>

1.  Write a SQL SELECT statement to group all records that have the same order date.
```sql
SELECT 
    OrderDate,
    COUNT(*) AS total_orders_on_date
FROM Orders
GROUP BY OrderDate
ORDER BY total_orders_on_date DESC;
```
| OrderDate  | total_orders_on_date |
|------------|----------------------|
| 2022-06-10 |                    7 |
| 2022-06-25 |                    6 |
| 2022-05-05 |                    1 |
| 2022-05-22 |                    1 |
| 2022-05-27 |                    1 |
| 2022-06-01 |                    1 |
| 2022-05-29 |                    1 |
| 2022-05-30 |                    1 |
| 2022-06-15 |                    1 |
| 2022-06-11 |                    1 |

<br>

2. Write a SQL SELECT statement to retrieve the total order quantities placed by each department.
```sql
SELECT 
    Department,
    SUM(OrderQty) AS DepartmentOrderTotal
FROM Orders
GROUP BY Department
ORDER BY DepartmentOrderTotal DESC;
```

| Department         | DepartmentOrderTotal |
|--------------------|----------------------|
| Decking            |                  850 |
| Lawn Care          |                   58 |
| Compost and Stones |                   55 |
| Trees and Shrubs   |                   55 |
| Garden Decor       |                    6 |


<br>

3. Write a SQL SELECT statement to retrieve the number of orders placed on the same day between the following dates: 1st June 2022 and 30th June 2022.
```sql
SELECT 
    OrderDate,
    COUNT(*) AS total_orders
FROM Orders
WHERE OrderDATE BETWEEN '2022-06-01' AND '2022-06-30'
GROUP BY OrderDate
ORDER BY OrderDate;
```

| OrderDate  | total_orders |
|------------|--------------|
| 2022-06-01 |            1 |
| 2022-06-10 |            7 |
| 2022-06-11 |            1 |
| 2022-06-15 |            1 |
| 2022-06-25 |            6 |


```sql
SELECT 
    OrderDate,
    COUNT(OrderID) AS total_orders
FROM Orders 
GROUP BY OrderDate 
HAVING OrderDate BETWEEN '2022-06-01' AND '2022-06-30';
```

| OrderDate  | total_orders |
|------------|----------------|
| 2022-06-01 |              1 |
| 2022-06-10 |              7 |
| 2022-06-25 |              6 |
| 2022-06-15 |              1 |
| 2022-06-11 |              1 |

