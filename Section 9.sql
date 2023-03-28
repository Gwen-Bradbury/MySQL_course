SELECT COUNT(*) FROM books; -- * means return the amount of rows
SELECT COUNT(author_fname) FROM books; -- doesn't include null values
SELECT COUNT(DISTINCT author_fname) FROM books;
SELECT COUNT(DISTINCT released_year) FROM books;
SELECT COUNT(DISTINCT author_lname) FROM books;
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

SELECT author_lname FROM books GROUP BY author_lname;
-- groups data that has the same info together 
-- eg if books have the same author they would be grouped together and the author name would only be returned once
SELECT author_lname FROM books;
SELECT author_lname FROM books GROUP BY author_lname;
SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname; -- returns authors last name and counts how many rows in each group (authors last name is the group, the rows are the books they have written)
SELECT author_lname, COUNT(*) AS books_written FROM books GROUP BY author_lname ORDER BY books_written;
SELECT author_lname, COUNT(*) AS books_written FROM books GROUP BY author_lname ORDER BY books_written DESC;
SELECT released_year, COUNT(*) FROM books GROUP BY released_year ORDER BY released_year; 

SELECT MIN(released_year) FROM books;
SELECT MAX(pages) FROM books;
SELECT MIN(author_lname) FROM books; -- finds earliest alphabetically (with text)
SELECT MIN(author_lname), MAX(author_lname) FROM books; -- finds earliest and lastest alphabetically (with text)

SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;
SELECT title, pages FROM books 
	WHERE pages = (
		SELECT MAX(pages) FROM books
    ); -- WHERE pages is equal to the results of the subquery (inner query)
INSERT INTO books (title, pages) VALUES ('My life in words', 634);
SELECT title, pages FROM books 
	WHERE pages = (
		SELECT MAX(pages) FROM books
    );
SELECT MIN(released_year) FROM books;
SELECT title, released_year FROM books
	WHERE released_year = (
		SELECT MIN(released_year) FROM books
	);

SELECT author_fname, author_lname FROM books ORDER BY author_lname;
SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname;
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname;
SELECT CONCAT(author_fname, ' ', author_lname) AS author, COUNT(*) FROM books GROUP BY author;

SELECT author_lname, MIN(released_year) FROM books GROUP BY author_fname, author_lname;
SELECT author_lname, MAX(released_year) FROM books GROUP BY author_fname, author_lname;
SELECT author_lname, MAX(released_year), MIN(released_year) FROM books GROUP BY author_fname, author_lname;
SELECT author_lname,
    COUNT(*) AS books_written,
    MAX(released_year) AS latest_released,
    MIN(released_year) AS earliest_released
    FROM books GROUP BY author_fname, author_lname;
    
SELECT author_lname,
    COUNT(*) AS books_written,
    MAX(released_year) AS latest_released,
    MIN(released_year) AS earliest_released,
    MAX(pages) AS longest_page_count
    FROM books GROUP BY author_fname, author_lname;
    
SELECT author_lname,
	author_fname,
    COUNT(*) AS books_written,
    MAX(released_year) AS latest_released,
    MIN(released_year) AS earliest_released,
    MAX(pages) AS longest_page_count
    FROM books GROUP BY author_fname, author_lname;
    
SELECT SUM(pages) FROM books;
SELECT author_lname, SUM(pages) FROM books GROUP BY author_lname;
SELECT author_lname, COUNT(*), SUM(released_year) FROM books GROUP BY author_lname;
-- if you try to sum a string it will return 0.

SELECT AVG(released_year) FROM books; -- very close to 2000
SELECT AVG(pages) FROM books;
SELECT AVG(stock_quantity) FROM books;
SELECT released_year, AVG(stock_quantity) FROM books GROUP BY released_year;
SELECT released_year, AVG(stock_quantity), COUNT(*) FROM books GROUP BY released_year;

-- activity
SELECT COUNT(*) FROM books;
SELECT COUNT(*), released_year FROM books GROUP BY released_year;
SELECT SUM(stock_quantity) FROM books;
SELECT author_fname, author_lname, AVG(released_year) FROM books GROUP BY author_fname, author_lname;
SELECT CONCAT(author_fname, ' ', author_lname) AS full_name FROM books
	WHERE pages = (SELECT MAX(pages) FROM books);
SELECT CONCAT(author_fname, ' ', author_lname) AS full_name FROM books ORDER BY pages LIMIT 1; -- another solution to above.
SELECT released_year AS year, 
	COUNT(*) AS '# books',
    AVG(pages) AS 'avg pages' 
    FROM books GROUP BY released_year ORDER BY year; -- can ORDER BY released_year