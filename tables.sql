create database supermarket;
use supermarket;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20)
);

INSERT INTO Customers (FirstName, LastName, Email, Phone) VALUES
('Ivan', 'Ivanov', 'ivan.ivanov@example.com', '0888123456'),
('Maria', 'Petrova', 'maria.petrova@example.com', '0888234567'),
('Georgi', 'Georgiev', 'georgi.georgiev@example.com', '0888345678');


CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL
);

INSERT INTO Categories (CategoryName) VALUES
('Fruits'),
('Personal Care'),
('Beverages');


CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity) VALUES
('Apple', 1, 1.20, 100),
('Banana', 1, 0.80, 150),
('Shampoo', 2, 5.50, 50);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-06-01', 20.00),
(2, '2024-06-02', 15.50),
(3, '2024-06-03', 8.20);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 10, 1.20),
(1, 2, 5, 0.80),
(2, 1, 8, 1.20);
