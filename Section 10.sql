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

CREATE TABLE nums (x FLOAT, y DOUBLE);
INSERT INTO nums (x,y) VALUES (1.123, 1.123);
SELECT * FROM nums;
INSERT INTO nums (x,y) VALUES (1.12345678, 1.12345678); -- FLOAT values are less precise when theres seven or more digits after the decimal.
SELECT * FROM nums;
INSERT INTO nums (x,y) VALUES (1.12345678, 1.12345678987654323456789);
SELECT * FROM nums; -- DOUBLE values lose precision when there's 14 or more digits after the decimal (double the float).
-- the number will be rounded up or down to the nearest number within the range.

CREATE TABLE people (
	name VARCHAR(100),
	birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);
DESC people;
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('ELton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');
SELECT * FROM people;
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10');
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Juan', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');

SELECT CURTIME();
SELECT CURDATE();
SELECT NOW();
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());
SELECT * FROM people;

SELECT birthdate FROM people;
SELECT birthdate, DAY(birthdate) FROM people; -- returns the date of the month (25th / 3rd ect).
SELECT birthdate, DAY(birthdate), DAYOFWEEK(birthdate) FROM people; -- 1 = Sunday, 2 = Monday, 3 = Tuesday, 4 = Wednesday, 5 = Thursday, 6 = Friday, 7 = Saturday
SELECT birthdate, DAY(birthdate), DAYOFWEEK(birthdate), DAYOFYEAR(birthdate) FROM people; -- returns the day of the year from 1 - 365.
SELECT birthdate, MONTHNAME(birthdate) FROM people;
-- can't pass a time column into these it has to be a date or datetime column!!
SELECT name, birthdt, YEAR(birthdt) FROM people;
SELECT name, birthdt, YEAR(birthdt), MONTHNAME(birthdt) FROM people;

SELECT name, birthtime, HOUR(birthtime) FROM people;
SELECT name, birthtime, MINUTE(birthtime) FROM people;
SELECT name, birthtime, SECOND(birthtime) FROM people;
-- can't pass a date column into these it has to be a time or datetime column!!
SELECT birthdt, HOUR(birthdt) FROM people;
-- with datetime you can use all the date and time specific formatting functions.
SELECT birthdt, DATE(birthdt) FROM people; -- just returns date from datetime.
SELECT birthdt, TIME(birthdt) FROM people; -- just returns time from datetime.

SELECT CONCAT(MONTHNAME(birthdate), ' ', DAY(birthdate), ' ', YEAR(birthdate)) FROM people;
SELECT DATE_FORMAT(birthdate, '%b') FROM people; -- %b returns abbreviated month name.
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b') FROM people; -- %a returns abbreviated day of week.
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %e') FROM people; -- %e returns day of the month (25th/3rd).
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people; -- %D returns the suffix (st/nd/rd/th).
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people; -- %H returns hours. %i returns minutes from the datetime.
SELECT birthdt, DATE_FORMAT(birthdt, '%r') FROM people; -- %r returns time in 12 hour time with AM or PM.
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN AT: %r') FROM people; 

SELECT birthdate FROM people;
SELECT birthdate, DATEDIFF(CURDATE(), birthdate) FROM people; -- returns current date - birthdate.
SELECT birthdt, DATEDIFF(CURDATE(), birthdt) FROM people;
SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR); -- adds a year onto todays date.
SELECT DATE_ADD(CURDATE(), INTERVAL 12 YEAR);
SELECT DATE_ADD(CURDATE(), INTERVAL 1 MONTH); -- adds a month onto todays date.
SELECT DATE_SUB(CURDATE(), INTERVAL 1 MONTH); -- subtracts a month from todays date.
SELECT birthdate, DATE_ADD(birthdate, INTERVAL 18 YEAR) FROM people;
SELECT TIMEDIFF(CURTIME(), '07:00:00'); -- returns difference between the current time and 7am.
SELECT NOW() - INTERVAL 18 YEAR; -- returns todays date - 18 years.
SELECT name, birthdate FROM people;
SELECT name, birthdate, birthdate + INTERVAL 21 YEAR FROM people; -- returns name, birthdate and birthdate + 21 years.
SELECT name, birthdate, YEAR(birthdate + INTERVAL 21 YEAR) FROM people; -- returns name, birthdate and just the year from birthdate + 21 years.
SELECT name, birthdate, YEAR(birthdate + INTERVAL 21 YEAR) AS will_be_21 FROM people;

CREATE TABLE captions (
	text VARCHAR(150),
    created_at TIMESTAMP default CURRENT_TIMESTAMP()
);
INSERT INTO captions (text) VALUES ('just me and the girls chillin');
SELECT * FROM captions;
INSERT INTO captions (text) VALUES ('beautiful sunset');
SELECT * FROM captions;
CREATE TABLE captions2 (
	text VARCHAR(150),
    created_at TIMESTAMP default CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP() -- updates the timestamp whenever a column gets updated.
);
INSERT INTO captions2 (text) VALUES ('i love life');
SELECT * FROM captions2;
UPDATE captions2 SET text='i love life!!!';
SELECT * FROM captions2;
UPDATE captions2 SET text='i love lofe!!!';
SELECT * FROM captions2;

-- activity
-- VARCHAR supports variable length and CHAR is fixed. Anything with a fixed number of characters would be a good use of CHAR.
CREATE TABLE inventory (
	item_name VARCHAR(100),
    price DECIMAL(7, 2), -- 7 before and 2 after
    quantity INT
);
-- DATETIME uses more memory but has a wider range than TIMESTAMP.
-- TIMESTAMP uses less memory but has less range than DATETIME.
SELECT CURTIME();
SELECT CURDATE();
SELECT DAYOFWEEK(CURDATE());
SELECT DAYNAME(CURDATE());
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');
SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');
CREATE TABLE tweets (
	content VARCHAR(180),
    username VARCHAR(20),
    created_at TIMESTAMP default CURRENT_TIMESTAMP() -- default NOW()
);
INSERT INTO tweets (content, username) VALUES ('first tweet wooo!', 'gwen');
SELECT * FROM tweets;