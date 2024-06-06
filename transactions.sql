START TRANSACTION;

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) 
VALUES (1, '2024-06-05', 45.00);

SET @NewOrderID = LAST_INSERT_ID();

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) 
VALUES (@NewOrderID, 1, 5, 1.20),
       (@NewOrderID, 2, 10, 0.80),
       (@NewOrderID, 3, 2, 5.50);

UPDATE Products 
SET StockQuantity = StockQuantity - 5 
WHERE ProductID = 1;

UPDATE Products 
SET StockQuantity = StockQuantity - 10 
WHERE ProductID = 2;

UPDATE Products 
SET StockQuantity = StockQuantity - 2 
WHERE ProductID = 3;

SELECT StockQuantity INTO @StockQty1 FROM Products WHERE ProductID = 1;
IF @StockQty1 < 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for ProductID 1';
END IF;

SELECT StockQuantity INTO @StockQty2 FROM Products WHERE ProductID = 2;
IF @StockQty2 < 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for ProductID 2';
END IF;

SELECT StockQuantity INTO @StockQty3 FROM Products WHERE ProductID = 3;
IF @StockQty3 < 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for ProductID 3';
END IF;

COMMIT;
