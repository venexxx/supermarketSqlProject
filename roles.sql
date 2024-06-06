CREATE ROLE DBAdmin;

GRANT ALL PRIVILEGES ON supermarket.* TO DBAdmin;


CREATE ROLE ProductManager;

GRANT SELECT, INSERT, UPDATE, DELETE ON supermarket.Products TO ProductManager;


CREATE ROLE OrderViewer;

GRANT SELECT (OrderID, CustomerID, OrderDate, TotalAmount) ON supermarket.Orders TO OrderViewer;


CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'secure_password';

GRANT DBAdmin TO 'admin_user'@'localhost';

CREATE USER 'product_manager'@'localhost' IDENTIFIED BY 'secure_password';

GRANT ProductManager TO 'product_manager'@'localhost';


CREATE USER 'order_viewer'@'localhost' IDENTIFIED BY 'secure_password';

GRANT OrderViewer TO 'order_viewer'@'localhost';
