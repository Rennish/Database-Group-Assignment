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