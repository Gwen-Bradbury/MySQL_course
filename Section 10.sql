CREATE TABLE friends (name VARCHAR(10));
INSERT INTO friends VALUES ('tom'), ('juan pablo'), ('james'); 
SELECT * FROM friends;
-- VARCHAR will error if you try and insert a value thats longer than specified character limit in ()
CREATE TABLE states (abbr CHAR(2));
INSERT INTO states (abbr) VALUES ('CA'), ('NY'); -- optimised to only store 2 charatcers and take up less memory
SELECT * FROM states;
-- if you want to store less than 2 characters SQL will add whitespace to make it 2 characters and remove the whitespace when we retrieve it, unless settings are changed to keep the whitespace included
INSERT INTO states (abbr) VALUES ('X');
SELECT * FROM states;
SELECT CHAR_LENGTH(abbr) FROM states; -- returns 1 for 'X' but in memory it's stored as 2
INSERT INTO states (abbr) VALUES ('Ohio'); -- returns 'Error Code: 1406. Data too long for column 'abbr' at row 1' error.

CREATE TABLE parent (children TINYINT);
INSERT INTO parent (children) VALUES (3), (5), (0);
INSERT INTO parent (children) VALUES (200); -- Error Code:1264 Out of range value for column 'children' at row 1.
-- max value for tinyint 127.
DROP TABLE parent;
CREATE TABLE parent (children TINYINT UNSIGNED); -- unsigned means it can't be a negative number no - sign (see table in docs).
INSERT INTO parent (children) VALUES (3), (5), (0);
INSERT INTO parent (children) VALUES (-3); -- Error Code: 1264. Out of range value for column 'children' at row 1.

INSERT INTO parent VALUES (1.5);
SELECT * FROM parent; -- inserting a decimal where value should be int/tinyint ect type will result in the value being rounded up/down to a whole number.
INSERT INTO parent VALUES (90.008);
SELECT * FROM parent;
-- DECIMAL(<total number of digits>, <digits after decimal>); -- can have less than 5 digits - this is a max number
-- DECIMAL(5, 2); -- 3 digits before decimal - max, 2 after = 5 total.
CREATE TABLE products (price DECIMAL(5,2));
INSERT INTO products (price) VALUES (4.50);
SELECT * FROM products;
INSERT INTO products (price) VALUES (456.50);
SELECT * FROM products;
INSERT INTO products (price) VALUES (8347.1); -- Error Code: 1264. Out of range value. - Needs 2 numbers after decimal!
INSERT INTO products (price) VALUES (5.026); -- Warning: 1265. Data truncated for column 'price' at row 1.
-- truncated - rounds the data up/down to the nearest 2 decimals (cause thats what we stated for after the decimal) and makes it less precise.
