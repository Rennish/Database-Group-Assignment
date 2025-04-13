-- Create roles
CREATE ROLE 'admin';
CREATE ROLE 'sales';
CREATE ROLE 'inventory_mgr';
CREATE ROLE 'shipping';
CREATE ROLE 'readonly';

-- Admin role (full control)
GRANT ALL PRIVILEGES ON book_store.* TO 'admin';

-- Sales role
GRANT SELECT, INSERT, UPDATE ON book_store.customer TO 'sales';
GRANT SELECT, INSERT, UPDATE ON book_store.customer_address TO 'sales';
GRANT SELECT, INSERT, UPDATE ON book_store.cust_order TO 'sales';
GRANT SELECT, INSERT, UPDATE ON book_store.order_line TO 'sales';

-- Inventory Manager role
GRANT SELECT, INSERT, UPDATE ON book_store.book TO 'inventory_mgr';
GRANT SELECT, INSERT, UPDATE ON book_store.author TO 'inventory_mgr';
GRANT SELECT, INSERT, UPDATE ON book_store.book_author TO 'inventory_mgr';
GRANT SELECT, INSERT, UPDATE ON book_store.book_language TO 'inventory_mgr';
GRANT SELECT, INSERT, UPDATE ON book_store.publisher TO 'inventory_mgr';

-- Shipping role
GRANT SELECT, UPDATE ON book_store.cust_order TO 'shipping';
GRANT SELECT, UPDATE ON book_store.order_status TO 'shipping';
GRANT SELECT, UPDATE ON book_store.shipping_method TO 'shipping';
GRANT SELECT, INSERT ON book_store.order_history TO 'shipping';

-- Read-only role
GRANT SELECT ON book_store.* TO 'readonly';

-- Create users
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'secureAdminPass';
CREATE USER 'sales_user'@'localhost' IDENTIFIED BY 'secureSalesPass';
CREATE USER 'inventory_user'@'localhost' IDENTIFIED BY 'secureInventoryPass';
CREATE USER 'shipping_user'@'localhost' IDENTIFIED BY 'secureShippingPass';
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'secureReadOnlyPass';

-- Grant roles to users
GRANT 'admin' TO 'admin_user'@'localhost';
GRANT 'sales' TO 'sales_user'@'localhost';
GRANT 'inventory_mgr' TO 'inventory_user'@'localhost';
GRANT 'shipping' TO 'shipping_user'@'localhost';
GRANT 'readonly' TO 'readonly_user'@'localhost';