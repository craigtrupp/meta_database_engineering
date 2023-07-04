-- Please see contextual detail for queries in the markdown file also within this folder

-- 1) Lucky Shrub need to find out what their `average sale price`, or cost was for a product in 2022. 
-- You can help them with this task by creating a **FindAverageCost() function**
CREATE FUNCTION IF NOT EXISTS FindAverageCost(input_year INT)
RETURNS DECIMAL(10,2) DETERMINISTIC 
RETURN (
    SELECT 
        ROUND(AVG(Cost), 2)
    FROM Orders
    WHERE YEAR(Date) = input_year
);

SELECT FindAverageCost(2022);

-- 2) Procedure for product by year (note the declaration of IN variables and OUT variables)
-- the out variabls can be selected later in the process
DELIMITER //
-- Declare which of the procedure parameters are input against output
CREATE PROCEDURE EvaluateProduct(IN product_ID VARCHAR(10), OUT sold_items2020 INT, OUT sold_items2021 INT, OUT sold_items2022 INT)
    BEGIN
    SELECT SUM(Quantity) INTO sold_items2020 FROM Orders WHERE YEAR(Date) = 2020 AND ProductID = product_ID;
    SELECT SUM(Quantity) INTO sold_items2021 FROM Orders WHERE YEAR(Date) = 2021 AND ProductID = product_ID;
    SELECT SUM(Quantity) INTO sold_items2022 FROM Orders WHERE YEAR(Date) = 2022 AND ProductID = product_ID;
END //
DELIMITER ; -- Change to default delimiters

-- Now We Want to call and assign the output to variables using the : @syntax (binds in a sense) and then we can select those variables
CALL EvaluateProduct('P1', @sold_items2020, @sold_itmes2021, @sold_items2022);

-- Now Select new variables holding output from called procedure
SELECT @sold_items2020, @sold_itmes2021, @sold_items2022;



-- 3) Trigger that adds audit trails following insertion of data into another table (similar to Salesforce SOQL usage for Opportunity Triggers)
CREATE TRIGGER IF NOT EXISTS UpdateAudit
    AFTER INSERT
    ON Orders FOR EACH ROW
    INSERT INTO Audit (OrderDateTime)
    -- VALUES(Current_timestamp)
    VALUES(CURRENT_TIME());
//
-- CHANGE BACK
DELIMITER ;

-- Demo Insert into orders then check audit
INSERT INTO Orders VALUES
(31, "Cl1", "P1", 10, 500, "2022-09-01" );

-- Audit
 SELECT * FROM Audit;


 -- 4) Union and Join Optimization for Client Data
 -- Let's use a union (left join for all employees and clients and any found addresses)
SELECT e.FullName, adr.Street, adr.County
FROM Employees AS e
LEFT JOIN Addresses AS adr
USING(AddressID)
UNION
SELECT c.FullName, adr.Street, adr.County
FROM Clients AS c
LEFT JOIN Addresses AS adr
USING(AddressID)
ORDER BY Street;


-- 5) Aggregate and Concatenation for UNION joined statement for SUM Aggregate w/o Groupby clause
SELECT CONCAT(SUM(Cost), ' for the year : 2020') AS 'Total sum of P2 Product'
FROM Orders WHERE YEAR(Date) = 2020 AND ProductID = 'P2'
UNION
SELECT CONCAT(SUM(Cost), ' for the year : 2021')
FROM Orders WHERE YEAR(Date) = 2021 AND ProductID = 'P2'
UNION
SELECT CONCAT(SUM(Cost), ' for the year : 2022')
FROM Orders WHERE YEAR(Date) = 2022 AND ProductID = 'P2';


-- 6) JSON property accessing and return types for different syntax usage (quotes around returned values) (See Markdown for file Output)
SELECT 
    a.Properties->'$.ClientID' AS ClientID,
    a.Properties ->> '$.ProductID' AS ProductID,
    c.FullName, c.ContactNumber 
FROM Clients as c RIGHT JOIN Activity as a
ON c.ClientID = a.properties ->>'$.ClientID';

-- Another way (Second)
SELECT Activity.Properties ->>'$.ClientID' 
AS ClientID, Activity.Properties ->>'$.ProductID' 
AS ProductID, Clients.FullName, Clients.ContactNumber 
FROM Clients RIGHT JOIN Activity 
ON Clients.ClientID = Activity.Properties ->>'$.ClientID';



-- 7) Procedure that takes in multiple arguments, and returns a declared variable in the procedure
-- Initial CTE for reviewing results from procedure calls
WITH 2020_Orders AS (
SELECT
    p.ProductID as product,
    YEAR(o.Date) AS sale_year,
    SUM(o.Quantity) as quantity_sold
FROM Products AS p
INNER JOIN Orders AS o
    USING(ProductID)
WHERE YEAR(o.Date) = 2020
GROUP BY product, sale_year
ORDER BY product
),
product_profits AS (
    SELECT
        first_cte.product,
        first_cte.sale_year,
        (first_cte.quantity_sold * p.SellPrice) - (first_cte.quantity_sold * p.BuyPrice) AS 2020_product_profit
    FROM 2020_Orders AS first_cte
    INNER JOIN Products AS p
        ON first_cte.product = p.ProductID
)
SELECT * 
FROM product_profits;

-- Now the Procedure
DELIMITER //
CREATE PROCEDURE GetProfit(IN product_id VARCHAR(5), IN input_year INT)
BEGIN
-- declare variables
DECLARE year_profit DECIMAL(6,2) DEFAULT 0.0;
-- We can also declare multiple values at once with the same data type and set a default of 0 
DECLARE buy_price, sell_price, sold_quantity INT DEFAULT 0;
SELECT BuyPrice INTO buy_price FROM Products WHERE ProductID = product_id;
SELECT SellPrice INTO sell_price FROM Products WHERE ProductID = product_id;
SELECT SUM(Quantity) INTO sold_quantity FROM Orders WHERE ProductID = product_id AND YEAR(Date) = input_year;
SET year_profit = (sell_price * sold_quantity) - (buy_price * sold_quantity);
SELECT year_profit;
END //
DELIMITER ;

-- Call
CALL GetProfit('P1', 2020);
CALL GetProfit('P2', 2021);
CALL GetProfit('P5', 2020);
CALL GetProfit('P3', 2020);



-- 8) Virtual Table (View) for Summarized Database Table View
CREATE VIEW DataSummary AS 
SELECT
    clts.FullName, clts.ContactNumber,
    adrs.County,
    prdcts.ProductName,
    ords.ProductID, ords.Cost, ords.Date
FROM Clients AS clts
INNER JOIN Addresses AS adrs
    ON clts.AddressID = adrs.AddressID
INNER JOIN Orders AS ords
    ON clts.ClientID = ords.ClientID
INNER JOIN Products AS prdcts
    ON ords.ProductID = prdcts.ProductID
WHERE YEAR(ords.Date) = 2022
ORDER BY ords.Cost DESC;

-- Now a Basic Select
SELECT * FROM DataSummary;


