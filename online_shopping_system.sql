CREATE DATABASE Onlineshoppingsystem;
USE Onlineshoppingsystem;

CREATE TABLE Products (
    Product_ID INT PRIMARY KEY AUTO_INCREMENT,
    Product_Name VARCHAR(255) NOT NULL,
    Category VARCHAR(100),
    Price DECIMAL(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Phone_Number VARCHAR(15),
    Address VARCHAR(200)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE NOT NULL,
    Customer_ID INT,
    Total_Amount DECIMAL(10, 2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

CREATE TABLE Order_Details (
    OrderDetail_ID INT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT,
    Payment_Date DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Payment_Method VARCHAR(50),
    Customer_ID INT,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

INSERT INTO Products (Product_Name, Category, Price, Stock)
VALUES 
('Laptop', 'Electronics', 1200.00, 100),
('Mobile','Electronics',1100.00,200),
('Fridge','Electronics',1500.00,200),
('Bluetooth Speaker', 'Electronics', 45.99, 75),
('Running Shoes', 'Footwear', 89.00, 120);

SELECT * FROM Products;

INSERT INTO Customers (First_Name, Last_Name, Email, Phone_Number, Address)
VALUES 
('John', 'Doe', 'john.doe@example.com', '1234056789', '123 Main St,banglore'),
('Shiyam', 'Ganesh', 'shiyam07@example.com', '2034569871', '456 Oak Avenue, Riverside'),
('Raghul', 'saravanan', 'raghulsa@example.com', '1298745630', '789 Pine Road, Hilltown'),
('Alice', 'Williams', 'alice.williams@example.com', '1231231234', '101 Elm Street,velacherry'),
('Shri', 'eniyan', 'eniyan25@example.com','1324567809', '257 nehru Street, porur');

SELECT * FROM Customers;

INSERT INTO Orders (Order_ID, Order_Date, Customer_ID, Total_Amount)
VALUES 
(1, '2024-08-19',1,1200.00),
(2, '2024-09-17',2,1900.00),
(3, '2023-09-07',3,2000.00),
(4, '2022-01-15',4,9278.00),
(5, '2020-01-15',5,80000.00);

SELECT * FROM Orders;

INSERT INTO Order_Details (OrderDetail_ID, Order_ID, Product_ID, Quantity, Price)
VALUES 
(1, 1, 1, 1, 1200.00),
(2, 2, 2, 2, 1300.00),
(3, 3, 3, 3, 1400.00),
(4, 4, 4, 4, 1500.00),
(5, 5, 5, 5, 1600.00);

SELECT * FROM Order_Details;

SELECT * FROM Payments;

INSERT INTO Payments (Payment_ID, Order_ID, Payment_Date, Amount, Payment_Method, Customer_ID)
VALUES 
(1, 1, '2024-08-19', 1200.00, 'Credit Card',1),
(2, 2, '2024-07-18', 1400.00, 'Cash',2),
(3, 3, '2023-08-19', 1600.00, 'Credit Card',3),
(4, 4, '2024-08-19', 1900.00, 'Cash',4),
(5, 5, '2024-02-23', 2450.00, 'Credit Card',5);

UPDATE Products 
SET Price = 1099.99 
WHERE Product_ID = 1;

DELETE FROM Payments 
WHERE Payment_ID = 1;

SELECT Product_Name, Category 
FROM Products;

TRUNCATE TABLE Customers;

ALTER TABLE Products 
ADD COLUMN number_of_products INT;

ALTER TABLE Products 
DROP COLUMN number_of_products;

ALTER TABLE Products 
MODIFY COLUMN Price DECIMAL(10,2);

ALTER TABLE Customers 
MODIFY COLUMN Phone_Number VARCHAR(15) UNIQUE;

DROP DATABASE Onlineshoppingsystem;

DROP TABLE Products;

SELECT DISTINCT Category 
FROM Products;

SELECT Product_Name 
FROM Products 
ORDER BY Product_Name;

SELECT Product_Name 
FROM Products 
WHERE Product_ID = 2;

SELECT CONCAT(First_Name,' ',Last_Name) AS full_name 
FROM Customers;

SELECT * 
FROM Customers 
WHERE First_Name LIKE '%_e%';

SELECT * 
FROM Payments 
WHERE Payment_Date BETWEEN '2024-08-19' AND '2024-09-19';

SELECT SUM(Total_Amount) FROM Orders;
SELECT MIN(Total_Amount) FROM Orders;
SELECT MAX(Total_Amount) FROM Orders;
SELECT AVG(Total_Amount) FROM Orders;

SELECT * 
FROM Products 
WHERE Category IN ('Electronics','footwear');

SELECT * 
FROM Products 
WHERE Category NOT IN ('Electronics');

SELECT * 
FROM Orders 
WHERE Customer_ID = (
    SELECT Customer_ID 
    FROM Customers 
    WHERE Email = 'john.doe@example.com'
);

SELECT CONCAT(
    UPPER(SUBSTRING(First_Name,1,1)),
    LOWER(SUBSTRING(First_Name,2,LENGTH(First_Name)))
) AS Name 
FROM Customers;

SELECT CONCAT(
    UPPER(SUBSTRING(First_Name,1,1)),
    LOWER(SUBSTRING(Last_Name,2,LENGTH(Last_Name)))
) AS Name
FROM Customers;

SELECT 
    c.First_Name,
    c.Last_Name,
    c.Phone_Number,
    CASE 
        WHEN LENGTH(c.Phone_Number) = 10 THEN 'Valid' 
        ELSE 'Invalid'
    END AS Phone_Number_Status 
FROM Customers c;

SELECT 
    o.Order_ID,
    o.Order_Date,
    c.First_Name,
    c.Last_Name,
    c.Email,
    o.Total_Amount
FROM Orders AS o 
INNER JOIN Customers AS c 
ON o.Customer_ID = c.Customer_ID;

SELECT 
    o.Order_ID,
    o.Order_Date,
    c.First_Name,
    c.Last_Name,
    c.Email,
    o.Total_Amount
FROM Orders AS o 
LEFT JOIN Customers AS c 
ON o.Customer_ID = c.Customer_ID;

SELECT 
    o.Order_ID,
    o.Order_Date,
    c.First_Name,
    c.Last_Name,
    c.Email,
    o.Total_Amount
FROM Orders AS o 
RIGHT JOIN Customers AS c 
ON o.Customer_ID = c.Customer_ID;

SELECT 
    o.Order_ID,
    o.Order_Date,
    c.First_Name,
    c.Last_Name,
    c.Email,
    o.Total_Amount
FROM Orders AS o 
LEFT JOIN Customers AS c 
ON o.Customer_ID = c.Customer_ID
UNION
SELECT 
    o.Order_ID,
    o.Order_Date,
    c.First_Name,
    c.Last_Name,
    c.Email,
    o.Total_Amount
FROM Orders AS o 
RIGHT JOIN Customers AS c 
ON o.Customer_ID = c.Customer_ID;
