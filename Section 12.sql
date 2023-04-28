-- Constraints are things that you can add when setting up a table ie NOT NULL /Primary Key
CREATE TABLE contacts (
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);
INSERT INTO contacts (name, phone) VALUES ('billybob', 8781213455);
SELECT * FROM contacts;
INSERT INTO contacts (name, phone) VALUES ('timmytimtim', 8781213455); -- Error Code: 1062. Duplicate entry.
INSERT INTO contacts (name, phone) VALUES ('billybob', 9781213455);
SELECT * FROM contacts;

CREATE TABLE users (
	username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 0)
);
INSERT INTO users (username, age) VALUES ('bluethecat', 50);
SELECT * FROM users;
INSERT INTO users (username, age) VALUES ('coltsteele', -3); -- Error Code: 3819. Check constraint.
CREATE TABLE palindromes (
	word VARCHAR(100) CHECK (REVERSE(word) = word)
);
SELECT REVERSE('racecar');
INSERT INTO palindromes (word) VALUE ('racecar');
INSERT INTO palindromes (word) VALUE ('mommy'); -- Error Code: 3819. Check constraint.
INSERT INTO palindromes (word) VALUE ('mom');

-- SQL automatically names your check constraints. The first will be named 1, the second 2 ect.
CREATE TABLE users2 (
	username VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT age_not_negative CHECK (age >= 0)
);
INSERT INTO users2 (username, age) VALUES ('ChickenNugget', -9); -- Error Code: 3819. Check constraint 'age_not_negative' is violated.
-- easier to see the error if the check is named.
CREATE TABLE palindromes2 (
	word VARCHAR(100),
    CONSTRAINT word_is_palindrome CHECK (REVERSE(word) = word)
);
INSERT INTO palindromes2 (word) VALUE ('mom');
INSERT INTO palindromes2 (word) VALUE ('momma'); -- Error Code: 3819. Check constraint 'word_is_palindrome' is violated.

CREATE TABLE companies (
	name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name, address)
);
-- name doesn't have to be unique and address doesn't have to be unique but both of them together does.
INSERT INTO companies (name, address) VALUES ('blackbird auto', '123 spruce');
INSERT INTO companies (name, address) VALUES ('luigis pies', '123 spruce');
INSERT INTO companies (name, address) VALUES ('luigis pies', '123 spruce'); -- Error Code: 1062. Duplicate entry for key companies.name_address
CREATE TABLE houses (
	purchase_price INT NOT NULL,
    sale_price INT NOT NULL,
    CONSTRAINT sprice_greaterthan_pprice CHECK (sale_price >= purchase_price)
);
INSERT INTO houses (purchase_price, sale_price) VALUES (100, 200);
INSERT INTO houses (purchase_price, sale_price) VALUES (300, 250); -- Error Code: 3819. Check constraint sprice_greaterthan_pprice is violated.

SELECT * FROM companies;
ALTER TABLE companies 
	ADD COLUMN phone VARCHAR(15); 
-- will default to NULL when data is already in table without a phone unless you state NOT NULL.
-- if NOT NULL, default for string values will be an empty string and default for numbers will be 0.
SELECT * FROM companies;
ALTER TABLE companies
	ADD COLUMN employee_count INT NOT NULL;
SELECT * FROM companies;
-- could have set ADD COLUMN employee_count INT NOT NULL DEFAULT 1; to set a default value.

ALTER TABLE companies DROP COLUMN phone;
SELECT * FROM companies;
ALTER TABLE companies DROP COLUMN employee_count; -- it doesn't matter if the column has values, it will still drop it and the data will be lost.

SELECT * FROM companies;
RENAME TABLE companies TO suppliers;
SELECT * FROM companies; -- doesn't exist.
SELECT * FROM suppliers; -- data is there.
ALTER TABLE suppliers RENAME TO companies; -- also renames tables.
SHOW TABLES;
DESC companies;
ALTER TABLE companies RENAME COLUMN name TO company_name;
DESC companies;

DESC companies;
ALTER TABLE companies MODIFY company_name VARCHAR(100) DEFAULT 'unknown'; -- changes the type of a column.
DESC companies;
INSERT INTO companies (address) VALUES ('2554 rose lane');
SELECT * FROM companies;
-- ALTER TABLE <table name> CHANGE <column name> <new column name> <type>; 
-- changes column name and column type.

SELECT * FROM houses;
DESC houses;
ALTER TABLE houses ADD CONSTRAINT positive_pprice CHECK (purchase_price >= 0);
DESC houses;
INSERT INTO houses (purchase_price, sale_price) VALUES (-1, 4); -- Error Code: 3819. Check constraint positive price is violated.
ALTER TABLE houses DROP CONSTRAINT positive_pprice;
INSERT INTO houses (purchase_price, sale_price) VALUES (-1, 4); -- no error now.
