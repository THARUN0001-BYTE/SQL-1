/*
1: Explain the fundamental differences between DDL, DML, and DQL commands in SQL. Provide one example for each type of command.
*/


CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2)
);


INSERT INTO Employees (emp_id, emp_name, salary)
VALUES (101, 'Ravi Kumar', 45000);


SELECT emp_name, salary
FROM Employees;



/*
2 : What is the purpose of SQL constraints? Name and describe three common types of constraints, providing a simple scenario where each would be useful
*/

/*SQL constraints are rules applied to table columns to ensure the accuracy, reliability, and integrity of the data stored in a database.
They prevent invalid data from being inserted and maintain consistency.*/

 /*
 1. PRIMARY KEY Constraint
Description:

Ensures that each row in the table has a unique and non-NULL identifier.

Scenario:

In an Employees table, each employee must have a unique ID.
 */
 
 /*
 2. UNIQUE Constraint
Description:

Ensures that values in a column are unique across all rows.
Unlike PRIMARY KEY, a UNIQUE column can contain one NULL (depends on DBMS).

Scenario:

In a Users table, each user must have a different email address.
 */
 
 /*
 Description:

Ensures that the value entered in a column satisfies a specific condition.

Scenario:

In a Students table, age must always be 18 or above.
 */



/*
3 : Explain the difference between LIMIT and OFFSET clauses in SQL. How would you use them together to retrieve the third page of results, assuming each page has 10 records?
*/

/*
LIMIT

Specifies how many rows you want to return from the query.
Example:
*/

/*LIMIT 10   -- returns only 10 rows*/


/*OFFSET

Specifies from which row to start returning data.

It skips a number of rows before beginning to return results.

Example:
OFFSET 5   -- skips first 5 rows
*/

SELECT *
FROM table_name
LIMIT 10
OFFSET 20;


/*
4 : What is a Common Table Expression (CTE) in SQL, and what are its main benefits? Provide a simple SQL example demonstrating its usage. including SQL codes
*/

/*
A Common Table Expression (CTE) is a temporary, named result set created using the WITH clause.
It exists only for the duration of a single SQL statement and helps break complex queries into simpler, readable parts.

It works like a temporary view that improves the clarity of queries.
*/

/*
Main Benefits of CTEs
1. Improved Readability

CTEs make long and complex SQL queries easier to understand by splitting them into logical parts.

2. Reusability Within the Same Query

You can reference a CTE multiple times within a single statement, reducing repetition.

3. Supports Recursive Queries

Useful for hierarchical data like:

Employee → Manager structure

Folder → Subfolder structure

Tree traversal

4. Avoids Creating Temporary Tables

No need for separate temporary tables—CTEs are lightweight and easier to maintain.
*/


WITH AvgSalary AS (
    SELECT AVG(salary) AS avg_salary
    FROM Employees
)
SELECT emp_name, salary
FROM Employees
WHERE salary > (SELECT avg_salary FROM AvgSalary);


/*
5 : Describe the concept of SQL Normalization and its primary goals. Briefly explain the first three normal forms (1NF, 2NF, 3NF).
*/

/*
Primary Goals of Normalization

Eliminate redundant data (avoid storing the same information in multiple places).

Ensure data integrity (keep data accurate and consistent).

Organize data into logical groups for easy management.

Minimize update, insert, and delete anomalies.
*/

/*
First Normal Form (1NF)
Definition:

A table is in 1NF if:

All values are atomic (no multiple values in one cell).

There are no repeating groups or arrays.

Each record can be uniquely identified.
*/

/*
Second Normal Form (2NF)
Definition:

A table is in 2NF if:

It is already in 1NF

No partial dependency exists

A non-key attribute must depend on the whole primary key, not part of it.

Used mainly when the primary key is composite.
Example (Problem):

Primary key: (student_id, subject)
*/

/*
Third Normal Form (3NF)
Definition:

A table is in 3NF if:

It is in 2NF

There are no transitive dependencies

A non-key attribute should not depend on another non-key attribute.
*/

/*
Question 6 : Create a database named ECommerceDB and perform the following
tasks:
1. Create the following tables with appropriate data types and constraints:
● Categories
○ CategoryID (INT, PRIMARY KEY)
○ CategoryName (VARCHAR(50), NOT NULL, UNIQUE)
● Products
○ ProductID (INT, PRIMARY KEY)
○ ProductName (VARCHAR(100), NOT NULL, UNIQUE)
○ CategoryID (INT, FOREIGN KEY → Categories)
○ Price (DECIMAL(10,2), NOT NULL)
○ StockQuantity (INT)
● Customers
○ CustomerID (INT, PRIMARY KEY)
○ CustomerName (VARCHAR(100), NOT NULL)
○ Email (VARCHAR(100), UNIQUE)
○ JoinDate (DATE)
● Orders
○ OrderID (INT, PRIMARY KEY)
○ CustomerID (INT, FOREIGN KEY → Customers)
○ OrderDate (DATE, NOT NULL)
○ TotalAmount (DECIMAL(10,2))
2. Insert the following records into each table
● Categories
CategoryID Category Name
1 Electronics
2 Books
3 Home Goods
4 Apparel
● Products
ProductID ProductName CategoryID Price StockQuantity
101 Laptop Pro 1 1200.00 50
102 SQL
Handbook
2 45.50 200
103 Smart Speaker 1 99.99 150
104 Coffee Maker 3 75.00 80
105 Novel : The
Great SQL
2 25.00 120
106 Wireless
Earbuds
1 150.00 100
107 Blender X 3 120.00 60
108 T-Shirt Casual 4 20.00 300
● Customers
CustomerID CustomerName Email Joining Date
1 Alice Wonderland alice@example.com 2023-01-10
2 Bob the Builder bob@example.com 2022-11-25
3 Charlie Chaplin charlie@example.com 2023-03-01
4 Diana Prince diana@example.com 2021-04-26
● Orders
OrderID CustomerID OrderDate TotalAmount
1001 1 2023-04-26 1245.50
1002 2 2023-10-12 99.99
1003 1 2023-07-01 145.00
1004 3 2023-01-14 150.00
1005 2 2023-09-24 120.00
1006 1 2023-06-19 20.
*/

CREATE DATABASE ECommerceDB;
USE ECommerceDB;


CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');


INSERT INTO Products (ProductID, ProductName, CategoryID, Price, StockQuantity) VALUES
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel : The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);


INSERT INTO Customers (CustomerID, CustomerName, Email, JoinDate) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);

/*
7 : Generate a report showing Customer Name, Email, and the Total Number of Orders for each customer. Include customers who have not placed any orders, in which case their Total Number of Orders should be 0. Order the results by Customer Name?
*/

SELECT 
    c.CustomerName,
    c.Email,
    COUNT(o.OrderID) AS TotalOrders
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CustomerName, c.Email
ORDER BY 
    c.CustomerName;
    
    
    
    /*
8 : Retrieve Product Information with Category: Write a SQL query to
display the ProductName, Price, StockQuantity, and CategoryName for all
products. Order the results by CategoryName and then ProductName alphabetically.
*/

SELECT 
    p.ProductName,
    p.Price,
    p.StockQuantity,
    c.CategoryName
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID
ORDER BY 
    c.CategoryName,
    p.ProductName;


/*
 9 : Write a SQL query that uses a Common Table Expression (CTE) and a  Window Function (specifically ROW_NUMBER() or RANK()) to display the  Category Name, ProductName, and Price for the top 2 most expensive products in  each Category Name?
*/
WITH ProductRanking AS (
    SELECT
        c.CategoryName,
        p.ProductName,
        p.Price,
        ROW_NUMBER() OVER (
            PARTITION BY c.CategoryName
            ORDER BY p.Price DESC
        ) AS RowNum
    FROM
        Products p
    JOIN
        Categories c ON p.CategoryID = c.CategoryID
)

SELECT
    CategoryName,
    ProductName,
    Price
FROM
    ProductRanking
WHERE
    RowNum <= 2
ORDER BY
    CategoryName,
    Price DESC;


/*
10 : You are hired as a data analyst by Sakila Video Rentals, a global movie rental company. The management team is looking to improve decision-making by analyzing existing customer, rental, and inventory data. Using the Sakila database, answer the following business questions to support key strategic initiatives. Tasks & Questions: 1. Identify the top 5 customers based on the total amount they’ve spent. Include customer name, email, and total amount spent. 2. Which 3 movie categories have the highest rental counts? Display the category name and number of times movies from that category were rented. 3. Calculate how many films are available at each store and how many of those have never been rented. 4. Show the total revenue per month for the year 2023 to analyze business seasonality. 5. Identify customers who have rented more than 10 times in the last 6 months.10 : You are hired as a data analyst by Sakila Video Rentals, a global movie rental company. The management team is looking to improve decision-making by analyzing existing customer, rental, and inventory data. Using the Sakila database, answer the following business questions to support key strategic initiatives. Tasks & Questions: 1. Identify the top 5 customers based on the total amount they’ve spent. Include customer name, email, and total amount spent. 2. Which 3 movie categories have the highest rental counts? Display the category name and number of times movies from that category were rented. 3. Calculate how many films are available at each store and how many of those have never been rented. 4. Show the total revenue per month for the year 2023 to analyze business seasonality. 5. Identify customers who have rented more than 10 times in the last 6 months.
*/

/*
1. Top 5 Customers by Total Amount Spent
*/
SELECT 
    c.first_name,
    c.last_name,
    c.email,
    SUM(p.amount) AS total_amount_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_amount_spent DESC
LIMIT 5;
/*
2. Top 3 Movie Categories by Rental Count
*/

SELECT 
    cat.name AS category_name,
    COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.category_id
ORDER BY rental_count DESC
LIMIT 3;

/*
3. Films Available at Each Store & How Many Were Never Rented
*/
SELECT 
    store_id,
    COUNT(inventory_id) AS total_films_available
FROM inventory
GROUP BY store_id;

/*
(b) Films never rented per store
*/
SELECT 
    i.store_id,
    COUNT(i.inventory_id) AS films_never_rented
FROM inventory i
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL
GROUP BY i.store_id;

/*
4. Total Revenue Per Month for the Year 2023
*/
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS total_revenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY month;


/*
5. Customers Who Rented More Than 10 Times in the Last 6
*/
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.customer_id
HAVING total_rentals > 10
ORDER BY total_rentals DESC;





























































































































