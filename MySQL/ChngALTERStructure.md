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
ALTER TABLE Staff DROP PhoneNumber;
```
| Field    | Type         | Null | Key | Default | Extra |
|-------------|-----------|------|-----|---------|-------|
| StaffID  | int          | NO   | PRI | NULL    |       |
| FullName | varchar(100) | NO   |     | NULL    |       |
| Role     | varchar(50)  | NO   |     | NULL    |       |


