CREATE DATABASE book_shop;
USE book_shop;
CREATE TABLE books 
	(
		book_id INT AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);
 
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
	('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
	('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
	('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
	('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
	('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
	('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
	('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
	('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
	('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
	('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
	('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
	("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
	('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
	('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
	('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
	('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);
DESC books;
SELECT * FROM books;

SELECT CONCAT('H', 'E', 'L', 'L', 'O');
SELECT CONCAT(author_fname, '!!!') FROM books;
SELECT CONCAT(author_fname, author_lname) FROM books;
SELECT CONCAT(author_fname, ' ', author_lname) FROM books;
SELECT CONCAT(author_fname, ' ', author_lname) AS author_name FROM books;
SELECT CONCAT_WS('!', 'hi', 'bye', 'lol');
SELECT CONCAT_WS('-', title, author_fname, author_lname) FROM books;

SELECT SUBSTRING('Hello World', 1, 4); -- 'Hello World' is the argument. 1 is the starting position. 4 is length of substring (go for 4 characters).
SELECT SUBSTRING('Hello World', 1, 6);
SELECT SUBSTRING('Hello World', 1, 7);
SELECT SUBSTRING('Hello World', 2, 4);
SELECT SUBSTRING('Hello World', 7); -- If no length provided, it will start at position specified, and just go to the end.
SELECT SUBSTRING('Hello World', 5);
SELECT SUBSTRING('Hello World', -3); -- minus means counts backwards from end of string then from there goes forwards to the end.
SELECT SUBSTRING('Hello World', -1); -- -1 will always get last character in string.
SELECT SUBSTRING('Hello World', -2, 1); -- get me only the second from last character.
SELECT SUBSTRING(title, 1, 15) FROM books;
SELECT SUBSTR(author_lname, 1, 1) FROM books; -- gets first character in string.
SELECT SUBSTR(author_lname, 1, 1), author_lname FROM books; -- gets first character in string and complete last name after.
SELECT SUBSTR(author_lname, 1, 1) AS initial, author_lname FROM books;

SELECT SUBSTR(title, 1, 10) FROM books;
SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS short_title FROM books;
SELECT CONCAT(
	SUBSTR(author_fname, 1, 1), '.', SUBSTR(author_lname, 1, 1), '.'
) AS author_initials FROM books;

SELECT REPLACE('Hello World', 'Hell', '#@$*');
SELECT REPLACE('cheese bread coffee milk', ' ', ' and ');
SELECT REPLACE(title, ' ', '-') FROM books;

SELECT REVERSE('Hello World');
SELECT REVERSE('Chicken Nuggets');
SELECT REVERSE(NULL); -- Doesn't reverse; If you pass it nothing you get nothing.
SELECT REVERSE(author_fname) FROM books;
SELECT CONCAT(author_fname, REVERSE(author_fname)) FROM books;

SELECT CHAR_LENGTH('Hello World');
SELECT CHAR_LENGTH('Hey!');
SELECT CHAR_LENGTH(title), title FROM books;
SELECT CHAR_LENGTH(title) AS length, title FROM books;

SELECT UPPER('Hello World');
SELECT LOWER('Hello World');
SELECT UCASE('Hello World');
SELECT LCASE('Hello World');
SELECT UPPER(title) FROM books;
SELECT CONCAT('I love ' , UPPER(title), ' !!!') FROM books;

SELECT INSERT('Hello Bobby', 6, 0, ' There');
SELECT INSERT('Hello Bobby', 6, 4, ' There'); -- replaces 4 characters from position 6 with 'There': Hello Thereby.
SELECT LEFT('omghahalol!', 3); -- selects 3 left most characters.
SELECT RIGHT('omghahalol!', 3); -- selects 3 right most characters.
SELECT RIGHT('omghahalol!', 4);
SELECT LEFT(author_lname, 1) FROM books;
SELECT REPEAT('ha', 4); -- repeats ha 4 times.
SELECT TRIM('    boston  '); -- removes leading and trailing whitespace. Not whitespace between words.
SELECT TRIM(LEADING '.' FROM '....San Antonio....');
SELECT TRIM(TRAILING '.' FROM '....San Antonio....');
SELECT TRIM(BOTH '.' FROM '....San Antonio....'); -- removes leading and trailing 

-- activity
SELECT REVERSE(UPPER('Why does my cat look at me with such hatred'));
SELECT REPLACE(CONCAT('I', ' ', 'like', ' ', 'cats'), ' ', '-');
SELECT REPLACE(title, ' ', '->') AS title FROM books;
SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;
SELECT CONCAT(UPPER(author_fname), ' ', UPPER(author_lname)) AS 'full name in caps' FROM books;
SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps' FROM books;
SELECT * FROM books;
SELECT CONCAT(title, ' was released in ', released_year) AS blurb FROM books;
SELECT title, CHAR_LENGTH(title) AS 'character count' FROM books;
SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title', 
	   CONCAT(author_lname, ',', author_fname) AS author,
       CONCAT(stock_quantity, ' in stock') AS quantity
FROM books;