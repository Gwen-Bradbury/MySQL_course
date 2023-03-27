SELECT database();
USE pet_shop;
SELECT database();
DESC cats;
CREATE TABLE cats (
	name VARCHAR(50),
    age INT
    );
DESC cats;
INSERT INTO cats (name, age)
VALUES ('Blus Steele', 5);
INSERT INTO cats (name, age)
VALUES ('Jenkins', 7);

SELECT * FROM cats; -- return everything from the cats table
INSERT INTO cats (age, name) 
VALUES (2, 'Beth');
SELECT * FROM cats;

INSERT INTO cats (name, age)
VALUES ('Meatball', 5),
	   ('Turkey', 1),
       ('Potato Face', 15);
SELECT * FROM cats;

-- activity
CREATE TABLE people (
	first_name VARCHAR(20),
    last_name VARCHAR(20),
    age int
);
INSERT INTO people (first_name, last_name, age)
VALUES ('Tina', 'Belcher', 13);
SELECT * FROM people;
INSERT INTO people (first_name, last_name, age)
VALUES ('Bob', 'Belcher', 32);
INSERT INTO people (first_name, last_name, age)
VALUES ('Linda', 'Belcher', 45),
	   ('Philip', 'Frond', 38),
       ('Calvin', 'Fichoender', 70);
SELECT * FROM people;
DROP TABLE people;
SHOW TABLES; 

DESC cats;
-- Null - YES means null value is permitted in this column
INSERT INTO cats (name) VALUE ('Todd');
SELECT * FROM cats; -- Todds age is null as it wasn't inputted with his name
INSERT INTO cats () VALUES (); -- inserts a null value for name and age - probably not wanted
SELECT * FROM cats; 

CREATE TABLE cats2 (
	name VARCHAR(50) NOT NULL,
    age INT NOT NULL
);
INSERT INTO cats2 (name) 
VALUE ('Bilbo'); -- Error Code: 1364. Field 'age' doesn't have a default value
SELECT * FROM cats2;
INSERT INTO cats2 (name, age) 
VALUE ('Bilbo', 19);
SELECT * FROM cats2;
DESC cats2; -- has null - NO so null is not permitted

CREATE TABLE shops (
	name VARCHAR(100)
);
INSERT INTO shops (name) VALUES ('Mario\'s Pizza');
SELECT * FROM shops;
INSERT INTO shops (name) VALUES ('She said "haha"');
SELECT * FROM shops;

CREATE TABLE cats3 (
	name VARCHAR(50) DEFAULT 'Mystery',
    age INT DEFAULT 99
);
INSERT INTO cats3 (age) VALUES (2);
SELECT * FROM cats3;
INSERT INTO cats3 () VALUES ();
SELECT * FROM cats3;
INSERT INTO cats3 (name, age) VALUES (NULL, NULL); -- can still add null values to DB with a default value
SELECT * FROM cats3;
CREATE TABLE cats4 (
	name VARCHAR(50) NOT NULL DEFAULT 'unnamed',
    age INT NOT NULL DEFAULT 99
);
INSERT INTO cats4 (name, age) VALUES (NULL, NULL); -- Error Code:1048. Column 'name' cannot be null.
INSERT INTO cats4 () VALUES (); -- gives default values
SELECT * FROM cats4;
DESC cats4;

CREATE TABLE unique_cats (
	cat_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    age INT
);
DESC unique_cats;
INSERT INTO unique_cats (cat_id, name, age) VALUES (1, 'Bingo', 2);
INSERT INTO unique_cats (cat_id, name, age) VALUES (1, 'Bongo', 3); -- Error Code: 1062. Duplicate entry '1' for key 'unique_cats.PRIMARY'
INSERT INTO unique_cats (cat_id, name, age) VALUES (2, 'Bongo', 3);

DROP TABLE unique_cats;
CREATE TABLE unique_cats (
	cat_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);
INSERT INTO unique_cats (cat_id, name, age) VALUES (1, 'Oingo', 2);
INSERT INTO unique_cats (cat_id, name, age) VALUES ('Oingo', 2); -- Error Code: 1136. Column count doesn't match value at row 1.
INSERT INTO unique_cats (name, age) VALUES ('Oingo', 2); -- Error Code: 1364. Field 'cat_id' doesn't have a default value.
DESC unique_cats;
CREATE TABLE unique_cats3 (
	cat_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT
);
INSERT INTO unique_cats3 (name, age) VALUES ('Boingo', 1); -- don't need to add a value for PRIMARY KEY with AUTO_INCREMENT
SELECT * FROM unique_cats3;
DROP TABLE unique_cats3;
CREATE TABLE unique_cats3 (
	cat_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT
);
DESC unique_cats3;
INSERT INTO unique_cats3 (name, age) VALUES ('Boingo', 1);
SELECT * FROM unique_cats3;
DROP TABLE unique_cats3;
CREATE TABLE unique_cats3 (
	cat_id INT AUTO_INCREMENT PRIMARY KEY, -- put AUTO_INCREMENT BEFORE PRIMARY KEY
    name VARCHAR(50),
    age INT
);
INSERT INTO unique_cats3 (name, age) VALUES ('Boingo', 1);
SELECT * FROM unique_cats3;
INSERT INTO unique_cats3 (name, age) VALUES ('Boingo', 1);
INSERT INTO unique_cats3 (name, age) VALUES ('Boingo', 1);
INSERT INTO unique_cats3 (name, age) VALUES ('Boingo', 1);
SELECT * FROM unique_cats3;
DESC unique_cats3;

-- activity
CREATE TABLE employees (
	id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    age INT NOT NULL,
    current_status VARCHAR(50) NOT NULL DEFAULT 'employed'
);
DESC employees;
INSERT INTO employees (first_name, last_name, age) VALUES ('Thomas', 'Chickenman', 87);
SELECT * FROM employees;
INSERT INTO employees (first_name, last_name, age) VALUES ('Thomas', 'Chickenman', 87);
INSERT INTO employees (first_name, last_name, age) VALUES ('Thomas', 'Chickenman', 87);
SELECT * FROM employees;