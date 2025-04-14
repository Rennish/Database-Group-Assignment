-- Create the database
CREATE DATABASE book_store;
USE book_store;

-- 1. book_language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50)
);
-- 2. publisher table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255),
    contact_info TEXT
);
-- 3. author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    bio TEXT
);
-- 4. book table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    isbn VARCHAR(20) UNIQUE,
    language_id INT,
    publisher_id INT,
    publication_year YEAR,
    price DECIMAL(10, 2),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);
-- 5. book_author table (Many-to-Many)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 6. country table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);
-- 7. address table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);
-- 8. address_status table
CREATE TABLE address_status (
    address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);
-- 9. customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20)
);
-- 10. customer_address table (Multiple addresses per customer)
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    address_status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);
-- 11. shipping_method table
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(10, 2)
);
-- 12. order_status table
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);
-- 13. cust_order table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);
-- 14. order_line table
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
-- 15. order_history table
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);

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


use book_store;
-- Insert into book_language
INSERT INTO book_language (language_name)
VALUES ('English'), ('Spanish'), ('French');

-- Insert into publisher
INSERT INTO publisher (publisher_name, contact_info)
VALUES ('Penguin Random House', 'info@penguin.com'),
       ('HarperCollins', 'contact@harpercollins.com');

-- Insert into author
INSERT INTO author (first_name, last_name, bio)
VALUES ('George', 'Orwell', 'Author of 1984 and Animal Farm.'),
       ('J.K.', 'Rowling', 'Author of Harry Potter series');

-- Insert into book
INSERT INTO book (title, isbn, language_id, publisher_id, publication_year, price)
VALUES ('1984', '1234567890123', 1, 1, 1949, 15.99),
       ('Harry Potter and the Philosopher\'s Stone', '9780747532743', 1, 2, 1997, 25.50);

-- Insert into book_author
INSERT INTO book_author (book_id, author_id)
VALUES (1, 1), (2, 2);

-- Insert into country
INSERT INTO country (country_name)
VALUES ('United States'), ('United Kingdom');

-- Insert into address
INSERT INTO address (street, city, state, postal_code, country_id)
VALUES ('221B Baker Street', 'London', '', 'NW1 6XE', 2),
       ('742 Evergreen Terrace', 'Springfield', 'Illinois', '62704', 1);

-- Insert into address_status
INSERT INTO address_status (status_name)
VALUES ('Current'), ('Old');

-- Insert into customer
INSERT INTO customer (first_name, last_name, email, phone_number)
VALUES ('Alice', 'Smith', 'alice@example.com', '123-456-7890'),
       ('Bob', 'Johnson', 'bob@example.com', '098-765-4321');

-- Insert into customer_address
INSERT INTO customer_address (customer_id, address_id, address_status_id)
VALUES (1, 1, 1),
       (2, 2, 1);

-- Insert into shipping_method
INSERT INTO shipping_method (method_name, cost)
VALUES ('Standard Shipping', 5.00),
       ('Express Shipping', 10.00);

-- Insert into order_status
INSERT INTO order_status (status_name)
VALUES ('Pending'), ('Shipped'), ('Delivered'), ('Cancelled');

-- Insert into cust_order
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, order_status_id)
VALUES (1, NOW(), 1, 1),
       (2, NOW(), 2, 2);

-- Insert into order_line
INSERT INTO order_line (order_id, book_id, quantity, price)
VALUES (1, 1, 2, 15.99),
       (2, 2, 1, 25.50);

-- Insert into order_history
INSERT INTO order_history (order_id, status_id, change_date)
VALUES (1, 1, NOW()),
       (2, 2, NOW());
       
select * from publisher;


