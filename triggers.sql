CREATE TRIGGER BeforeInsertOrder
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    IF NEW.TotalAmount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Total amount must be greater than zero';
    END IF;
END;

CREATE TRIGGER AfterInsertOrder
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    UPDATE Customers
    SET TotalOrders = (SELECT COUNT(*) FROM Orders WHERE CustomerID = NEW.CustomerID)
    WHERE CustomerID = NEW.CustomerID;
END;


CREATE TRIGGER BeforeUpdateProduct
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.Price <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price must be greater than zero';
    END IF;
END;


CREATE TRIGGER AfterUpdateProduct
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductLogs (ProductID, OldPrice, NewPrice, UpdateDate)
    VALUES (OLD.ProductID, OLD.Price, NEW.Price, NOW());
END;


CREATE TRIGGER BeforeInsertOrderDetail
BEFORE INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;
    SELECT StockQuantity INTO current_stock FROM Products WHERE ProductID = NEW.ProductID;
    IF NEW.Quantity > current_stock THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock quantity';
    END IF;
END;


CREATE TRIGGER AfterInsertOrderDetail
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Products
    SET StockQuantity = StockQuantity - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END;
