## Changing Table Structure
Mangata and Gallo is a jewelry store that specializes in special occasions like engagements, weddings and anniversaries. The jewelry company primarily operates online and has a small storefront in Austin, Texas with an atelier attached for browsing. The company has asked you to 
* Create a table in their database called `'Staff'`. 
* This table must contain the records of all staff members.

<br>

### Environment Set-up
1. Create Database
```sql
CREATE DATABASE IF NOT EXISTS Mangata_Gallo;
```
2. Use Database
```sql
USE Mangata_Gallo;
```

<br>

#### **Objectives**
This activity has two main objectives:
* Create the 'Staff' table in Mangata and Gallo database.
* Make the necessary changes to the table structure.

---

<br>

### **Tasks**
**1.** Write a SQL statement that creates the Staff table with the following columns.
* StaffID: INT
* FullName: VARCHAR(100)
* PhoneNumber: VARCHAR(10)
```sql
CREATE TABLE Staff (StaffID INT, FullName VARCHAR(100), PhoneNumber VARCHAR(10));
```
| Field       | Type         | Null | Key | Default | Extra |
|-------------|--------------|------|-----|---------|-------|
| StaffID     | int          | YES  |     | NULL    |       |
| FullName    | varchar(100) | YES  |     | NULL    |       |
| PhoneNumber | varchar(10)  | YES  |     | NULL    |       |

**2.** Write a SQL statement to apply the following constraints to the Staff table.
* StaffID: INT NOT NULL and PRIMARY KEY
* FullName: VARCHAR(100) and NOT NULL
* PhoneNumber: INT NOT NULL
```sql
ALTER TABLE Staff MODIFY StaffID INT PRIMARY KEY, MODIFY FullName VARCHAR(100) NOT NULL, MODIFY PhoneNumber INT NOT NULL;
```
| Field       | Type         | Null | Key | Default | Extra |
|-------------|--------------|------|-----|---------|-------|
| StaffID     | int          | NO   | PRI | NULL    |       |
| FullName    | varchar(100) | NO   |     | NULL    |       |
| PhoneNumber | int          | NO   |     | NULL    |       |

**3.** Write a SQL statement that adds a new column called 'Role' to the Staff table with the following constraints
* Role: VARCHAR(50) and NOT NULL
```sql
ALTER TABLE Staff ADD Role VARCHAR(50) NOT NULL;
```
| Field       | Type         | Null | Key | Default | Extra |
|-------------|--------------|------|-----|---------|-------|
| StaffID     | int          | NO   | PRI | NULL    |       |
| FullName    | varchar(100) | NO   |     | NULL    |       |
| PhoneNumber | int          | NO   |     | NULL    |       |
| Role        | varchar(50)  | NO   |     | NULL    |       |

**4.** Write a SQL statement that drops the Phone Number column from the 'Staff' table.
```sql
ALTER TABLE Staff DROP COLUMN PhoneNumber;
```
| Field    | Type         | Null | Key | Default | Extra |
|-------------|-----------|------|-----|---------|-------|
| StaffID  | int          | NO   | PRI | NULL    |       |
| FullName | varchar(100) | NO   |     | NULL    |       |
| Role     | varchar(50)  | NO   |     | NULL    |       |

---

<br>

### `Secondary Lab`
Little Lemon is a family-owned Mediterranean restaurant focused on traditional recipes served with a modern twist. The Little Lemon database contains many data tables, including Customers and Bookings.

* The `Customers` table contains the following columns:
    * Customer ID 
    * Full name
    * phone number


* The `Bookings` table contains the following data on each booking: 
    * Booking ID 
    * Booking date 
    * Table number 
    * Number of guests
    * And the ID of the customer who made the booking

<br>

#### **Setup**
1. Create Lucky Lemon DB
```SQL
CREATE DATABASE IF NOT EXISTS little_lemon; 
```
2. Use Database
```sql
USE little_lemon;
```
3. Create a new table in the Little Lemon restaurant database to store information about customers' orders. The new “Food Orders” table includes three columns
* OrderID
* Quantity
* Cost
```sql
CREATE TABLE FoodOrders (OrderID INT, Quantity INT, Cost Decimal(4,2);
```
4. Verify Table Outlay
```sql
SHOW COLUMNS FROM FoodOrders;
```
| Field    | Type         | Null | Key | Default | Extra |
|----------|--------------|------|-----|---------|-------|
| OrderID  | int          | YES  |     | NULL    |       |
| Quantity | int          | YES  |     | NULL    |       |
| Cost     | decimal(4,2) | YES  |     | NULL    |       |

<br>

### **Tasks**
**1.** Use the ALTER TABLE statement with MODIFY command to make the OrderID the primary key of the 'FoodOrders' table
```sql
ALTER TABLE FoodOrders MODIFY OrderID INT PRIMARY KEY;
```
**2.** Apply the NOT NULL constraint to the quantity and cost columns.
```sql
ALTER TABLE FoodOrders MODIFY Quantity INT NOT NULL, MODIFY Cost Decimal(4,2) NOT NULL;
```
**3.** Create two new columns, 
* `OrderDate` with a DATE datatype  
* `CustomerID` with an INT datatype. 
* Declare both must as NOT NULL.
* Declare the CustomerID as a **foreign key** in the `FoodOrders` table to reference the CustomerID column existing in the Customers table.
```sql
ALTER TABLE FoodOrders ADD COLUMN OrderDate DATE NOT NULL, ADD COLUMN CustomerID INT NOT NULL, ADD FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID);
```
**4.**  Use the DROP command with ALTER statement to delete the OrderDate column from the 'FoodOrder' table
```sql
ALTER TABLE FoodOrders DROP COLUMN OrderDate;
```
**5.** Use the CHANGE command with ALTER statement to rename the column Order_Status in the OrderStatus table to DeliveryStatus. 
```sql
ALTER TABLE OrderStatus CHANGE Order_status DeliveryStatus VARCHAR(15);
```


