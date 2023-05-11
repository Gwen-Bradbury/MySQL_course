-- One to One : not that common - customer and customer details table could be one to one. Customer contains name, customer details contains address.
-- One to Many : most common - one book can have lots of reviews.
-- Many to Many : relatively common - one book can have many authors, and authors can have many books.

-- Relationships between tables are usually made using id's. Going back to the customer and orders example, the customer table would have a customer_id and the orders table would
	-- also have a customer_id and one would correspond to the other.
-- The customer_ids on the customer table are primary keys, and are therefore unique, and correspond to only one user/customer.
-- The customer_ids on the orders table are foreign keys. A foreign key is a reference to another table within a given table 
	-- and will enforce that whatever key is being referenced as a foreign key, actually has a corresponding primary key within another table.
    
CREATE DATABASE shop;
USE shop;
CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
CREATE TABLE orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT
);
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
SELECT * FROM customers;
SELECT * FROM orders;
INSERT INTO orders (order_date, amount, customer_id) VALUES ('2022-11-11', 50.68, 975); -- there is no customer_id 975!!
-- still lets you insert the order.
-- need to set up a constraint that says this has to be a real id!
-- FOREIGN KEY (customer_id) REFERENCES customer(id) - tells sql that this customer_id relates to the id column in the customer table 
	-- and you can't just make it up.
DROP TABLE customers;
DROP TABLE orders;
CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
CREATE TABLE orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
SELECT * FROM customers;
SELECT * FROM orders;
INSERT INTO orders (order_date, amount, customer_id) VALUES ('2022-11-11', 78.99, 54); -- there is no customer id 54.
-- Error Code: 1452. Foreign key constraint fails.
INSERT INTO orders (order_date, amount, customer_id) VALUES ('2022-11-11', 78.99, 3);
SELECT * FROM orders;

SELECT id FROM customers WHERE last_name = 'George'; -- get back id = 1
SELECT * FROM orders WHERE customer_id = 1;
-- is the same as -
SELECT * FROM orders WHERE customer_id = (SELECT id FROM customers WHERE last_name = 'George'); 
-- SQL runs code in parentheses first!
-- Joins join the data from one table to the data from another.
-- Cross joins take every single row of one table and combine them with every single row of another table.
SELECT * FROM customers, orders; -- cross join. It gives every customer row an order row for every order.
-- cross joins are not very useful.

SELECT * FROM customers
	JOIN orders ON orders.customer_id = customers.id; 
-- joining the orders table onto the customer table where the customer_id from the orders table matches the id from the customers table.
-- shows you who placed an order along with thier email and customer id, alongside the order date and amount.
SELECT first_name, last_name, order_date, amount FROM customers
	JOIN orders ON orders.customer_id = customers.id;
-- returns first name, last name, order date and amount. - doesn't return customers who haven't placed an order!
SELECT * FROM orders
	JOIN customers ON customers.id = orders.customer_id;
-- same info but order is reversed - what is on the left and right are the other way round.
SELECT * FROM orders
	JOIN customers ON customers.id = orders.id; -- returns all the customers whos customer ids match the order ids - this is a pointless join as it doesn't give us any usable info, but shows that it can be done.
-- can type INNER JOIN but inner join is the default JOIN so it doesn't have to be explicit.

USE shop;
DROP TABLE orders;
DROP TABLE customers;
CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
CREATE TABLE orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
SELECT * FROM orders;
SELECT * FROM customers;
SELECT first_name, last_name, SUM(amount) FROM customers
	JOIN orders ON orders.customer_id = customers.id
    GROUP BY first_name, last_name; -- if there are first_name and last_name columns in both tables you have to specify the table - customers.first_name.
-- returns the first name and last name of the customers who have placed orders and the sum of thier individual orders.
SELECT first_name, last_name, SUM(amount) as total FROM customers
	JOIN orders ON orders.customer_id = customers.id
    GROUP BY first_name, last_name
    ORDER BY total;
-- INNER JOIN selects data from two tables where there is a match with both.

-- left join takes everything from the left table (the table specified in the SELECT part of the query)
	-- and takes any overlapping data from the right table (the table specified after the JOIN)
    -- if there are no values in the right table columns that correlate to the left, you will get NULL's for that column.
SELECT first_name, last_name, order_date, amount FROM customers 
	LEFT JOIN orders ON orders.customer_id = customers.id;
	-- left side is customers, right side is orders
	-- returns all the customers first and last names and the order date and amount from the customers who have ordered.
    -- the customers who haven't ordered get NULL values in the order_date and amount columns.
SELECT order_date, amount, first_name, last_name FROM orders -- the order of the columns in this SELECT is the order they will be returned in regardless of what table is on the right or left!
	LEFT JOIN customers ON orders.customer_id = customers.id;
    -- orders becomes the left table and customers becomes the right.
	-- this will look the same as the results for an inner join as we don't have any orders without customer ids!
    -- if we had orders without customer ids the first_name and last_name columns would have NULL values.

SELECT first_name, last_name, SUM(amount) AS money_spent FROM customers -- sum will add up the amounts of all that customers orders and return it as one figure.
	LEFT JOIN orders ON customers.id = orders.customer_id -- the order of the ON doesn't matter at all. It changes nothing.
	GROUP BY first_name, last_name;
SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS money_spent FROM customers 
	LEFT JOIN orders ON customers.id = orders.customer_id
	GROUP BY first_name, last_name;
	-- IFNULL(SUM(amount), 0) - do the sum and if you get NULL return 0 instead.

SELECT first_name, last_name, order_date, amount FROM customers -- customers is the left table.
	RIGHT JOIN orders ON customers.id = orders.customer_id; -- orders is the right table.
    -- this will return the same results as an inner join because we don't have any orders without customers.
	-- If we had orders without customers we'd get all the order_date's and amount's but we'd get NULL values for the first_name and last_name columns from the customer table.
INSERT INTO orders (amount, order_date) VALUES (100, CURDATE()); -- customer id for this order will be NULL.
SELECT first_name, last_name, order_date, amount FROM customers
	RIGHT JOIN orders ON customers.id = orders.customer_id;
	-- now it returns NULL values for the customer first and last name on the order we just inserted.

DELETE FROM customers WHERE last_name = 'George'; -- Error Code: 1451. Cannot delete or update parent row: foreigh key constraint fails.
-- deleting make foreign key constraint fail because every customer_id foreign key should have a customer id associated with it.
-- deleting a customer deletes the customer id associated with the orders which fails the foreign key constraint.
DROP TABLE orders;
DROP TABLE customers;
CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
CREATE TABLE orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE 
    -- when a customers(id) is deleted, delete all the rows in the orders table that also have that customer_id.
);
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
SELECT * FROM orders;
DELETE FROM customers WHERE last_name = 'George';
SELECT * FROM orders;
DELETE FROM customers WHERE last_name = 'Michael';
SELECT * FROM orders;
SELECT * FROM customers;

-- activity
CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50)
);
CREATE TABLE papers (
	title VARCHAR(50),
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);
INSERT INTO students (first_name) 
	VALUES 
		('Caleb'), 
        ('Samantha'), 
        ('Raj'), 
        ('Carlos'), 
        ('Lisa');
INSERT INTO papers (student_id, title, grade ) 
	VALUES
		(1, 'My First Book Report', 60),
		(1, 'My Second Book Report', 75),
		(2, 'Russian Lit Through The Ages', 94),
		(2, 'De Montaigne and The Art of The Essay', 98),
		(4, 'Borges and Magical Realism', 89);
SELECT first_name, title, grade FROM students
	JOIN papers ON papers.student_id = students.id
    ORDER BY grade DESC;
SELECT first_name, title, grade FROM students
	LEFT JOIN papers ON papers.student_id = students.id;
SELECT first_name, IFNULL(title, 'MISSING') as title, IFNULL(grade, 0) as grade FROM students
	LEFT JOIN papers ON papers.student_id = students.id;
SELECT first_name, IFNULL(AVG(grade), 0) as average FROM students
	LEFT JOIN papers ON papers.student_id = students.id
    GROUP BY first_name
    ORDER BY average DESC;
SELECT first_name, IFNULL(AVG(grade), 0) as average,
	CASE
		WHEN IFNULL(AVG(grade), 0) <= 75 THEN 'FAILLING'
        ELSE 'PASSING'
	END as passing_status
    FROM students
	LEFT JOIN papers ON papers.student_id = students.id
    GROUP BY first_name
    ORDER BY average DESC;
