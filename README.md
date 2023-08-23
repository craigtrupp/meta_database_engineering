# Database Engineering 🗄️
This repository serves as a reference for all educational material learned throughout the [Meta Professional Database Engineer Certificate](https://www.coursera.org/professional-certificates/meta-database-engineer). The program paves the way to learning the skills and roles performed by Data/Database Engineers with a primay focus on the following subjects

## **Courses & Areas of Focus 🔦**
1. `Introduction to Databases`
    - Concepts and principles that underpin how databases work
    - DML & DDL SQL Command Categories
    - Data Types, Key Types, Constraints, CRUD Operations
    - Logical & Physical Database Structures/Diagrams
    - Operators, Handling/Identifying Nulls, DISTINCT
    - Schema Types / Levels
        - Ex - Physical, Conceptual/Logical, External
    - ERD
    - Intro to Normalization
2. `Version Control`
    - Idea Behind Softward Collaboration
    - Standard Software Development Workflow
    - Basic Command Line Navigation
    - Git
        * Pull, Push, Create (Init)
        * Branching, Merge Different Branches
        * Forking
        * Resolving Conflicts
        * Create/Accept Pull Requests
3. `Database Structures and Management w/MySQL`
    - Relationship Mapping w/Primary and Foreign Keys
    - Grouping, Filtering, Subqueries
    - Insert/Update w/**REPLACE**
    - MySQL Functions
        * String, Date, Integer Type Functions
        * **CAST'ing** and mutating types
        * COALESCE, NULLIF and more!
4. `Advanced MySQL Topics`
    - Automate SQL by writing **Stored Procedures**
    - Automate and Use Constraint Data Validation w/**Triggers**
    - Develop User-Defined Functions
    - Database Transactions
    - Database Optimization
        * Use **COMMIT** & **ROLLBACK** to manage transactions
        * CTE construction to construct chained complex queries
        * **Prepared** Statements for Faster Query Execution time and Greater Security
        * Index Creation and value of **EXPLAIN** statement for Query Execution
5. `Programming in Python`
    - Foundational programming skills w/basic Syntax
    - Objects, Classes, & Methods
    - Exception Handling, File Handling, Namespacing and Scoping
    - Procedural Programming, Algorithmic Complexity (Big-O), Functional Programming
    - OOP Principles, Comprehension (List, Set, & Dictionaries), Method Resolution Order
    - Modules, Packages, Libraries & Testing
6. `Database Clients`
    - Python application capable of administration of MySQL Database
    - Python code to create, populate, and manipulate MySQL databases & tables
    - Access and use (**MySQL functions & Stored Procedures**) w/Python
    - Threaded Connections & Connection Pools
7. `Data Modeling`
    - Types of Data Models
    - **MySQL Workbench**
        - Manipulate & Manage Data
        - Model a Database
        - Forward & Reverse Engineer Database Schema
        - Entity Relationship Diagram Tool Exploration
    - Overview of Data Warehousing
        * OLAP/OLTP database types for analytical analysis against real-time data processing
    - Create Dimensional Data Model 
        * Star & Snowflake Schemas
    - Data Ingestion & Visualization w/**Tableau**
        * Connect & Prepare data 
        * Create Interactive Dashboards
8. `Database Engineer Capstone`
    - Build End-to-End MySQL DB Solution
    - Separate Repository
        - [Database Engineer Capstone](https://github.com/craigtrupp/db-capstone-project/tree/main)
9. `Coding Interview Preparation`
    - Tips, Techniques and what to expect when encountering Technical Interviews

---

## **Repository Reference Materials** 📚
* Repository Items from referenced sections above

### **Database Structures & Management** 🏗️
* Grouping - [Grouping](/MySQL_Structures_Management/Grouping_data.md)
* Joins - [Joins](/MySQL_Structures_Management/Joins.md)
* Filtering - [Filtering](/MySQL_Structures_Management/Filtering_Data.md)
* Constraints - [Constraints](/MySQL_Structures_Management/Constraints.md)
* MySQL Functions - [Functions](/MySQL_Structures_Management/MySQL_Funcs.md)
* Views - [Views](/MySQL_Structures_Management/Views_Lab.md)
* Subqueries - [Subqueries](/MySQL_Structures_Management/Subqueries.md)
* Replace Statement - [REPLACE](/MySQL_Structures_Management/Replace_Lab.md)
* Operators & Clauses - [Operators & Clauses](/MySQL_Structures_Management/Operators_Clasuse_Endwk1.md)
* DML Intro - [DML](/MySQL_Structures_Management/ChngALTERStructure.md)
* Section Challenge - [Section Overview/Challenge](/MySQL_Structures_Management/MySQLDB_Project)
    - Markdown and Separate SQL File within brief Project Folder

### **Advanced MySQL Topics** 🎯
* User Defined Function & Stored Procedures - [UDF & Procedure](/AdvMySQL_Topics/Dev_Funcs.md)
* Prepared Statement, CTE, JSON Column Accessing - [Prep, CTE, & JSON](/AdvMySQL_Topics/Optimization_Techniques.md)
* Select & Query Optimization - [Optimization & Indexing](/AdvMySQL_Topics/Select_Optimization.md)
* Triggers & Events w/DELIMITER Syntax - [Triggers & Events](/AdvMySQL_Topics/Triggers.md)
* Data Analysis & Mocked Business Request - [Data Analysis](/AdvMySQL_Topics/Data_Analysis_MySQL.md)
* Client Persona Scenario / SQL Technique Combinations 
    - Scenario / Client Persona - [Scenario & Client Persona](/AdvMySQL_Topics/Closing_Course_Task/DAnalysis_Client_Persona.md)
    - SQL Queries - [Business Queries](/AdvMySQL_Topics/Closing_Course_Task/Client_Persona_Queries.sql)
        - User Defined Functions
        * Procedures
        * Triggers

### **Python Programming** 🐍
* **Early Section Items**
    - Scope : [Scope](/PythonProgramming/Wk1_Wk2_Items/ScopeReview.py)
    - Kwargs : [Kwargs_Args](/PythonProgramming/Wk1_Wk2_Items/kwargs_args.py)
    - File Handling : [File Handling](/PythonProgramming/Wk1_Wk2_Items/file_handling.py)
    - Ordering Assessment : [Section Review](/PythonProgramming/Wk1_Wk2_Items/ordering_assessment.py)
* **Procedural, Functional, OOP**
    - Object Refresher : 
        - [SimpleObject](/PythonProgramming/Procedural_Functional_OOP_Wk3/CustomObj.py)
        - [Inheritance](/PythonProgramming/Procedural_Functional_OOP_Wk3/More_Obj_passing.py)
    - Recursion Ex : [Recursion_Ex](/PythonProgramming/Procedural_Functional_OOP_Wk3/Reverse_Recurse.py)
    - Scoping : [Scoping](/PythonProgramming/Procedural_Functional_OOP_Wk3/Scoping.py)
    - Assessments
        * [Employee functions](/PythonProgramming/Procedural_Functional_OOP_Wk3/wk3_first_assessment.py)
        * [Classes](/PythonProgramming/Procedural_Functional_OOP_Wk3/abstract_pythassmnt.py)
* **Tests, Modules, Imports**
    * Test Functions 
        - [Assignment Details](/PythonProgramming/Import_Scope_Wk4/Write_Tests_Functions/README.md)
        - [Functions](/PythonProgramming/Import_Scope_Wk4/Write_Tests_Functions/spellcheck.py)
        - [Assetions](/PythonProgramming/Import_Scope_Wk4/Write_Tests_Functions/test_spellcheck.py)
    * Imports (Packagess & UDF)
        - [Assessment Details](/PythonProgramming/Import_Scope_Wk4/Assessment_I_S/README.md)
        - [Script](/PythonProgramming/Import_Scope_Wk4/Assessment_I_S/jsongenerator.py)

### **Database Clients** 🌉
* **Connection Cursors**
    * [Establishing Connection](/Database%20Clients/Wk1_Connction_Cursors/Making%20your%20MySQL_Python%20connection.ipynb)
    * [Create Cursor & Access MySQL Database](/Database%20Clients/Wk1_Connction_Cursors/Working%20with%20cursors.ipynb)
    * [Simple Python App & SQL Management](/Database%20Clients/Wk1_Connction_Cursors/Creating%20a%20table%20structure%20in%20a%20MySQL%20database%20using%20Python.ipynb)
* **Performing Queries**
    * [Create & Read Records](/Database%20Clients/Wk2_PerformingQueries/Creating%20and%20reading%20records%20in%20a%20MySQL%20database%20using%20Python.ipynb)
    * [Filtering & Sorting](/Database%20Clients/Wk2_PerformingQueries/Filtering%20and%20sorting%20data%20in%20a%20MySQL%20database%20using%20Python.ipynb)
    * [Joining](/Database%20Clients/Wk2_PerformingQueries/Performing%20different%20JOIN%20operations%20in%20MySQL%20databases%20using%20Python.ipynb)
    * [Updating & Deleting](/Database%20Clients/Wk2_PerformingQueries/Updating%20and%20deleting%20records%20in%20a%20MySQL%20database%20using%20Python.ipynb)
* **Accessing Procedures, Functions (date & time), Connection Pools**
    * [Access Stored Procedure](/Database%20Clients/Wk3_AdvDBClients/Accessing%20stored%20procedures%20in%20a%20MySQL%20database%20using%20Python.ipynb)
    * [MySQL Functions](/Database%20Clients/Wk3_AdvDBClients/Utilizing%20MySQL%20functions%20with%20Python.ipynb)
    * [Date & Time](/Database%20Clients/Wk3_AdvDBClients/Working%20with%20date%20and%20time%20functions%20in%20Python.ipynb)
    * [Connection Pools](/Database%20Clients/Wk3_AdvDBClients/Working%20with%20connection%20pools.ipynb)
    * [Section Overview/Brief Project](/Database%20Clients/Wk3_AdvDBClients/Little%20Lemon%20analysis%20and%20sales%20report.ipynb)
* **Final Section Projects**
    * [Set DB Environment](/Database%20Clients/Wk4_FinalProjects/Setting%20DB%20Environment.ipynb)
    * [Procedure Creation & Execution](/Database%20Clients/Wk4_FinalProjects/Implement%20and%20query%20stored%20procedures.ipynb)
    * [Analysis & Sales Report](/Database%20Clients/Wk4_FinalProjects/Little%20Lemon%20analysis%20and%20sales%20report.ipynb)

### **Data Modeling** 📸
* [Workbench SQL Generated File](/DataModeling/Wk1_WBench/mysqlwb_model.sql)
* [Table Insertion & View Generation](/DataModeling/Wk1_WBench/insert_n_view.sql)
* **Section Project Materials**
    * [Global Super Store DB ERD](/DataModeling/DataModelProject/GlobalSuperStoreSchemaERD.png)
    * [Global Store Schema SQL](/DataModeling/DataModelProject/GlobalStoreSchema.sql)
    * [Star Sales Schema](/DataModeling/DataModelProject/Star_Schema_Sales.png)
    * [Star Sales Schema SQL](/DataModeling/DataModelProject/star_schema.sql)

---

## **Certificate** 🧾
<object data="https://github.com/craigtrupp/meta_database_engineering/blob/main/images/Meta_DB_Engineering_1.pdf" type="application/pdf" width="700px" height="700px">
    <embed src="https://github.com/craigtrupp/meta_database_engineering/blob/main/images/Meta_DB_Engineering_1.pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="https://github.com/craigtrupp/meta_database_engineering/blob/main/images/Meta_DB_Engineering_1.pdf">Download PDF</a>.</p>
    </embed>
</object>

* [Verification Link](https://coursera.org/verify/professional-cert/JVKWU2TG5H9)