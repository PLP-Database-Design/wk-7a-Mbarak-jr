-- Question 1: Transforming table into 1NF (First Normal Form)
-- Create the original ProductDetail table with non-1NF data
CREATE TABLE IF NOT EXISTS ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Insert the sample data
INSERT INTO ProductDetail VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Transform to 1NF by creating a new table with atomic values
-- First, create the new 1NF-compliant table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- The following INSERT statements would populate the 1NF table
-- In a real environment, you might use a stored procedure or programming language
-- to split the comma-separated values
INSERT INTO ProductDetail_1NF VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2: Transforming table into 2NF (Second Normal Form)
-- Create the OrderDetails table already in 1NF
CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Insert the sample data
INSERT INTO OrderDetails VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Transform to 2NF by creating separate tables for Orders and OrderProducts
-- Create Orders table to store order information
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderProducts table to store product details for each order
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate the Orders table with unique order information
INSERT INTO Orders
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Populate the OrderProducts table with product details
INSERT INTO OrderProducts
SELECT OrderID, Product, Quantity
FROM OrderDetails;
