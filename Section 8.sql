INSERT INTO books(title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
	   ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
	   ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
SELECT * FROM books;

SELECT DISTINCT author_lname FROM books; -- doesn't return duplicate last names even if the first name is different.
SELECT released_year FROM books;
SELECT DISTINCT released_year FROM books;
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) FROM books; -- returns distinct full names.
SELECT DISTINCT author_fname, author_lname FROM books; -- returns distinct full names like above.
SELECT DISTINCT author_fname, author_lname, released_year FROM books; -- gets every row as every rows released year is distinct.
-- all 3 columns would have to be the same/duplicated for DISTINCT to do anything

USE book_shop;
SELECT book_id, title, author_lname FROM books; -- returns data based on order it's saved in in DB
SELECT book_id, author_fname, author_lname FROM books ORDER BY author_lname; -- returns data alphabetically using first letter of authors last name from A-Z
SELECT book_id, author_fname, author_lname FROM books ORDER BY author_fname; -- returns data alphabetically using first letter of authors first name from A-Z
-- NULL values come before any ordered values in the returned list when returned by ascending order 
-- orders by ascending order by default eg from A-Z from 1-99 from oldest - youngest
SELECT book_id, author_fname, author_lname FROM books ORDER BY author_fname DESC; -- returns data alphabetically using first letter of authors first name from Z-A
-- NULL values come after any ordered values in the returned list when returned using DESC
-- can use ASC for ascending which is also the default
SELECT title, pages FROM books ORDER BY pages; 
SELECT title, pages FROM books ORDER BY pages DESC; 
SELECT title, pages FROM books ORDER BY released_year; -- you can order by columns you're not selecting 

SELECT book_id, author_fname, author_lname, pages FROM books ORDER BY pages;
SELECT book_id, author_fname, author_lname, pages FROM books ORDER BY 4; -- orders by pages as it's the 4th column in the SELECT list
SELECT book_id, author_fname, author_lname, pages FROM books ORDER BY 4 DESC;
SELECT book_id, author_fname, author_lname, pages FROM books ORDER BY 2; -- orders by author_fname
SELECT author_lname, released_year, title FROM books ORDER BY author_lname;
SELECT author_lname, released_year, title FROM books ORDER BY author_lname, released_year; 
-- returns data ordered alphabetically A-Z by author_lname, then within that, orders those with mutiple books by thier year oldest to youngest
SELECT author_lname, released_year, title FROM books ORDER BY author_lname, released_year DESC;
-- returns data ordered alphabetically A-Z by author_lname, then within that, orders those with mutiple books by thier year youngest to oldest
SELECT CONCAT(author_fname, ' ', author_lname) AS author FROM books ORDER BY author;

SELECT book_id, title, released_year FROM books LIMIT 5; -- gets first 5 books in DB
SELECT book_id, title, released_year  FROM books ORDER  BY released_year LIMIT 5; -- gets the first 5 books from list ordered by released_year (oldest 5 books)
SELECT book_id, title, released_year  FROM books ORDER  BY released_year DESC LIMIT 5; -- gets the first 5 books from list ordered by released_year DESC (youngest 5 books)
SELECT book_id, title, released_year  FROM books ORDER  BY released_year LIMIT 0, 5; -- gets first 5 books
SELECT book_id, title, released_year  FROM books ORDER  BY released_year LIMIT 1, 5; -- start at 1 and go for 5 - gets the books from index 1 - index 5 
SELECT book_id, title, released_year  FROM books ORDER  BY released_year LIMIT 3, 2;
SELECT book_id, title, released_year  FROM books ORDER  BY released_year LIMIT 5, 7;
SELECT title FROM books ORDER BY title LIMIT 40; -- there isn't 40 books so it will give you as many as it can (all of them)

SELECT title, author_fname, author_lname FROM books WHERE author_fname='David';
SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE '%da%';
-- % is a wildcard that means there are 0 or more characters here
SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE 'da'; -- will return data that exactly matches 'da'
SELECT * FROM books WHERE title LIKE '%:%';
SELECT * FROM books WHERE author_fname LIKE '%'; -- returns every book as long as there is an author_fname
SELECT * FROM books WHERE author_fname LIKE '%a%'; -- returns everything with an a in
SELECT * FROM books WHERE author_fname LIKE '%n'; -- returns books whos authors first names end with n
SELECT * FROM books WHERE author_fname LIKE '____'; -- returns authors whos first names have 4 characters as there are 4 underscores
-- _ is a wildcard that represents any character
SELECT * FROM books WHERE author_fname LIKE '_____';
SELECT * FROM books WHERE author_fname LIKE '_a_'; -- returns data where any character is followed by an a and then another character

SELECT * FROM books WHERE title LIKE '%\%%'; -- escapes the % so it searches for titles with the % in instead of using the % as a wildcard and returning everything
SELECT * FROM books WHERE title LIKE '%\_%'; -- escapes the _ so it searches for titles with an _ in instead of using the _ as a wildcard and returning a character

-- activity
SELECT title FROM books WHERE title LIKE '%stories%';
DESC books;
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 0, 1; -- LIMIT 1 also works
SELECT CONCAT(title, ' - ', released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 0, 3; -- LIMIT 3 also works
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';
SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity, title LIMIT 0, 3; -- LIMIT 3 also works
SELECT title, author_lname FROM books ORDER BY author_lname, title;
SELECT UPPER(CONCAT('MY FAVORITE AUTHOR IS ', author_fname, ' ', author_lname, ' !')) AS yell FROM books ORDER BY author_lname;