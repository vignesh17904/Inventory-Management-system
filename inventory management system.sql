CREATE DATABASE InventoryManagement17;
USE InventoryManagement17;

-- Categories
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

-- Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(255),
    Country VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255)
);

-- Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Address VARCHAR(255),
    City VARCHAR(255),
    Country VARCHAR(255)
);

-- Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT,
    SupplierID INT,
    UnitPrice DECIMAL(10, 2),
    QuantityInStock INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Transactions
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    TransactionType ENUM('Purchase', 'Sale'),
    Quantity INT,
    TransactionDate DATE,
    Notes TEXT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- StockLogs
CREATE TABLE StockLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    ChangeType ENUM('Addition', 'Removal') NOT NULL,
    QuantityChanged INT NOT NULL,
    ChangeDate DATE NOT NULL,
    Notes TEXT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Categories
INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home Appliances'),
(5, 'Toys'),
(6, 'Furniture'),
(7, 'Sports');

-- Insert Suppliers
INSERT INTO Suppliers (SupplierID, SupplierName, Address, City, Country, Phone, Email) VALUES
(1, 'Sonny Electronics', '123 Main Street', 'Mumbai', 'India', '123-456-7890', 'info@electronicsupplier.com'),
(2, 'Zaraa Fashions', '456 Broadway', 'Delhi', 'India', '987-654-3210', 'info@fashionhouse.com'),
(3, 'Book World', '789 Elm Street', 'Bangalore', 'India', '111-222-3333', 'info@bookemporium.com'),
(4, 'Home Appliances Co.', '321 Oak Avenue', 'Chennai', 'India', '444-555-6666', 'info@homeappliancesco.com'),
(5, 'Kids World', '555 Maple Drive', 'Kolkata', 'India', '777-888-9999', 'info@toyworld.com'),
(6, 'Ikea Furniture', '777 Pine Street', 'Hyderabad', 'India', '999-888-7777', 'info@furnituredepot.com'),
(7, 'ABC Sports', '888 Cedar Avenue', 'Pune', 'India', '222-333-4444', 'info@sportssupply.com');

-- Insert Customers
INSERT INTO Customers (CustomerID, CustomerName, Email, Phone, Address, City, Country) VALUES
(1, 'John Doe', 'john@example.com', '555-1111', 'Sector 21', 'Mumbai', 'India'),
(2, 'Jane Smith', 'jane@example.com', '555-2222', 'Main Road', 'Delhi', 'India'),
(3, 'Rahul Kumar', 'rahul@example.com', '555-3333', 'Lake View', 'Bangalore', 'India'),
(4, 'Aditi Mehra', 'aditi@example.com', '555-4444', 'Sunset Blvd', 'Chennai', 'India');

-- Insert Products
INSERT INTO Products (ProductID, ProductName, CategoryID, SupplierID, UnitPrice, QuantityInStock) VALUES
(1, 'Smartphone', 1, 1, 599.99, 50),
(2, 'Laptop', 1, 1, 999.99, 30),
(3, 'T-shirt', 2, 2, 19.99, 100),
(4, 'Jeans', 2, 2, 39.99, 80),
(5, 'Python Programming Book', 3, 3, 29.99, 20),
(6, 'Blender', 4, 4, 49.99, 50),
(7, 'LEGO Set', 5, 5, 59.99, 40),
(8, 'Dining Table', 6, 6, 299.99, 10);

-- Insert Transactions
INSERT INTO Transactions (TransactionID, ProductID, CustomerID, TransactionType, Quantity, TransactionDate, Notes) VALUES
(1, 1, NULL, 'Purchase', 10, '2024-05-01', 'Bulk order for smartphones'),
(2, 2, NULL, 'Purchase', 5, '2024-05-02', 'Order for laptops'),
(3, 3, 1, 'Sale', 25, '2024-05-03', 'Sold to John Doe'),
(4, 4, 2, 'Sale', 30, '2024-05-04', 'Sold to Jane Smith'),
(5, 5, NULL, 'Purchase', 10, '2024-05-05', 'Order for Python books'),
(6, 6, 3, 'Sale', 35, '2024-05-06', 'Sold to Rahul'),
(7, 7, NULL, 'Purchase', 25, '2024-05-07', 'Order for LEGO sets'),
(8, 8, 4, 'Sale', 5, '2024-05-08', 'Sold to Aditi');

-- Insert StockLogs
INSERT INTO StockLogs (ProductID, ChangeType, QuantityChanged, ChangeDate, Notes) VALUES
(1, 'Addition', 10, '2024-05-01', 'Restocked Smartphones'),
(2, 'Addition', 5, '2024-05-02', 'Restocked Laptops'),
(3, 'Removal', 25, '2024-05-03', 'Sold T-shirts to customer'),
(4, 'Removal', 30, '2024-05-04', 'Sold Jeans'),
(5, 'Addition', 10, '2024-05-05', 'Python books restocked'),
(6, 'Removal', 35, '2024-05-06', 'Sold Blenders'),
(7, 'Addition', 25, '2024-05-07', 'LEGO stock arrived'),
(8, 'Removal', 5, '2024-05-08', 'Dining Table sold');

-- QUERY 1: Products with Categories and Suppliers
SELECT p.ProductName, c.CategoryName, s.SupplierName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;

-- QUERY 2: Total Quantity by Category
SELECT c.CategoryName, SUM(p.QuantityInStock) AS TotalQuantity
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;

-- QUERY 3: Total Sales Amount by Transaction Type
SELECT TransactionType, SUM(Quantity * UnitPrice) AS TotalSalesAmount
FROM Transactions t
JOIN Products p ON t.ProductID = p.ProductID
GROUP BY TransactionType;

-- QUERY 4: Sales Transactions with Customer Info
SELECT t.TransactionID, p.ProductName, c.CustomerName, t.Quantity, t.TransactionDate
FROM Transactions t
JOIN Products p ON t.ProductID = p.ProductID
JOIN Customers c ON t.CustomerID = c.CustomerID
WHERE t.TransactionType = 'Sale';