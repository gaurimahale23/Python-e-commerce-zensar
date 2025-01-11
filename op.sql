-- Create Database
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- 1. Create Tables
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    role VARCHAR(50) DEFAULT 'customer'
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(50) DEFAULT 'Pending',
    total DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    payment_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 2. Insert Values
INSERT INTO users (first_name, last_name, email, password, phone_number, address, role)
VALUES 
('John', 'Doe', 'john.doe@example.com', 'hashedpassword1', '123-456-7890', '123 Elm St, Springfield, IL', 'customer'),
('Jane', 'Smith', 'jane.smith@example.com', 'hashedpassword2', '987-654-3210', '456 Oak St, Springfield, IL', 'customer'),
('Alice', 'Johnson', 'alice.johnson@example.com', 'hashedpassword3', '555-123-4567', '789 Pine St, Springfield, IL', 'admin'),
('Bob', 'Williams', 'bob.williams@example.com', 'hashedpassword4', '555-234-5678', '101 Maple St, Springfield, IL', 'customer');

INSERT INTO categories (name) VALUES
('Clothing'), ('Books'), ('Home Appliances'), ('Sports Equipment');

INSERT INTO products (name, description, price, stock_quantity, category_id)
VALUES
('iPhone 13', 'Latest model with A15 chip and 5G support', 999.99, 50, 1),
('T-shirt', 'Cotton T-shirt with cool design', 19.99, 200, 2),
('The Great Gatsby', 'A classic novel by F. Scott Fitzgerald', 10.99, 100, 3),
('Microwave Oven', 'Compact microwave for quick heating', 79.99, 30, 4),
('Football', 'Standard size 5 football for outdoor games', 25.99, 50, 5);

INSERT INTO orders (user_id, order_date, status, total)
VALUES
(1, '2025-01-01', 'Pending', 1099.98),
(2, '2025-01-02', 'Shipped', 39.98),
(3, '2025-01-03', 'Delivered', 25.99),
(4, '2025-01-04', 'Pending', 79.99);

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 499.99),
(2, 2, 1, 39.99),
(3, 3, 3, 8.99),
(4, 4, 1, 79.99);

INSERT INTO payments (order_id, payment_method, payment_status, payment_date, amount)
VALUES
(1, 'Credit Card', 'Completed', '2025-01-01', 1999.98),
(2, 'PayPal', 'Completed', '2025-01-02', 299.99),
(3, 'Debit Card', 'Pending', '2025-01-03', 799.99),
(4, 'Credit Card', 'Completed', '2025-01-04', 1499.95);
