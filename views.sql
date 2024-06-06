CREATE VIEW CustomerOrders AS
SELECT 
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

SELECT * FROM CustomerOrders;


CREATE VIEW ProductStockByCategory AS
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.StockQuantity
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID;

SELECT * FROM ProductStockByCategory;


CREATE VIEW OrderDetailsView AS
SELECT 
    od.OrderDetailID,
    o.OrderID,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    (od.Quantity * od.UnitPrice) AS TotalPrice
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

SELECT * FROM OrderDetailsView;
