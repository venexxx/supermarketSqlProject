CREATE INDEX idx_email ON Customers(Email);

CREATE INDEX idx_order_product ON OrderDetails(OrderID, ProductID);

CREATE INDEX idx_productname_prefix ON Products(ProductName(10));
