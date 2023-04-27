SELECT title FROM books WHERE released_year != 2017;
SELECT title, author_lname FROM books;
SELECT title, author_lname FROM books WHERE author_lname != 'Gaiman';

SELECT title FROM books WHERE title LIKE '% %';
SELECT title FROM books WHERE title NOT LIKE '% %';
SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE 'da%';
SELECT title, author_fname, author_lname FROM books WHERE author_fname NOT LIKE 'da%';
SELECT title FROM books WHERE title NOT LIKE '%e%';
SELECT title FROM books WHERE title NOT LIKE '%a%';

SELECT * FROM books WHERE released_year > 2000;
SELECT * FROM books WHERE released_year > 2005;
SELECT * FROM books WHERE pages > 500;
SELECT 80 > 40; -- returns 1 as 1 is true and 0 is false.
SELECT 80 > 100; -- returns 0 as 0 is false and 1 is true.
SELECT title, pages, released_year FROM books WHERE pages > 500; 
-- SQL will go through the table and if a book has more pages than 500 it will return 1, which is true, if the book doesn't contain
-- more than 500 pages it will return 0, false, and not include it in the results.
SELECT 1 > NULL; -- returns NULL as NULL is neither true or false it's the lack of a value. You can't compare something to nothing, it's nothing.

SELECT title, released_year FROM books WHERE released_year < 2000;
SELECT title, released_year FROM books WHERE released_year < 2000 ORDER BY released_year;
SELECT title, pages FROM books WHERE pages < 200;
SELECT title, released_year FROM books WHERE released_year >= 2010;
SELECT title, released_year FROM books WHERE released_year <= 1985;

SELECT * FROM books WHERE author_lname = 'Eggers';
SELECT * FROM books WHERE released_year > 2010;
SELECT * FROM books WHERE author_lname = 'Eggers' AND released_year > 2010;
SELECT * FROM books WHERE author_lname = 'Eggers' && released_year > 2010;
-- both author_lname and released_year have to be true for them to be included in the results.
SELECT title, author_lname, released_year FROM books 
	WHERE released_year > 2010 AND author_lname = 'Eggers';
SELECT * FROM books 
	WHERE author_lname = 'Eggers' AND released_year > 2010 AND title LIKE '%novel%';
-- all 3 must be true for a result to be returned.
SELECT title, author_lname, released_year FROM books 
	WHERE released_year > 2010 AND author_lname = 'Eggers' AND title LIKE '%novel%';
-- if one side of the AND statement is false, the entire statement equates to false.
SELECT 1 > 0 AND 8 = 8; -- returns 1, which is true, as both sides of the AND are true.
SELECT 1 > 0 AND 8 = 7; -- returns 0, which is false, as the right side (8 = 7) is false. 8 is not equal to 7.
SELECT title, pages FROM books WHERE CHAR_LENGTH(title) > 30 AND pages > 500;

SELECT title, author_lname FROM books WHERE author_lname = 'Eggers' AND released_year > 2010;
SELECT title, author_lname, released_year FROM books WHERE author_lname = 'Eggers' OR released_year > 2010;
-- returns all eggers books and all books with a released year greater than 2010.
-- only one side of the OR has to be true for the whole query to be considered true.
SELECT 1 < 5 OR 4 = 5; -- returns 1, which is true, even though 4 is not equal to 5, as 1 is less than 5.
SELECT 1 < 0 OR 4 = 5; -- returns 0, which is false as both sides of the OR are false.
SELECT title, pages FROM books WHERE pages < 200 OR title LIKE '%stories%';

SELECT title, released_year FROM books WHERE released_year >= 2004 AND released_year <= 2015;
SELECT title, released_year FROM books WHERE released_year BETWEEN 2004 AND 2015;
SELECT title, pages FROM books WHERE pages BETWEEN 200 AND 300;
SELECT title, pages FROM books WHERE pages NOT BETWEEN 200 AND 300; -- returns all books with more than 300 and less than 200 pages.

SELECT * FROM people WHERE birthdate < '2005-01-01';
-- SQL can usually work out a string date to compare if it's in the correct formatt. But it's not guaranteed to work.
SELECT * FROM people WHERE YEAR(birthdate) < 2005; -- more explicit, fewer places it could go wrong.
SELECT * FROM people WHERE birthtime > '09:00:00';
SELECT * FROM people WHERE birthtime > '12:00:00';
-- comparing to a string, not guarenteed to work.
SELECT * FROM people WHERE HOUR(birthtime) > 9; -- best when only need the hour.
SELECT CAST('09:00:00' AS TIME);
SELECT CAST('9:00:00' AS TIME); -- reformatts it to have the first 0 - 09:00:00.
SELECT * FROM people WHERE birthtime BETWEEN CAST('12:00:00' AS TIME) AND CAST('16:00:00' AS TIME);
-- the correct way to compare times when you need the hour, mins and secs.
-- CAST works with dates, datetimes, timestamps, times.

SELECT title, author_lname FROM books WHERE author_lname = 'Carver'
	OR  author_lname = 'Lahiri'
    OR author_lname = 'Smith';
SELECT title, author_lname FROM books WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
SELECT title, author_lname FROM books WHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');
SELECT title, released_year FROM books 
	WHERE released_year NOT IN (2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016);
SELECT title, released_year FROM books 
	WHERE released_year >= 2000 AND
    released_year NOT IN (2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016);
-- modulo (%) also known as remainder operator.
SELECT 10 % 4; -- gives the remainder of 10 divided by 4, which is 2.
SELECT 17 % 6; -- returns 5.
SELECT 18 % 2; -- returns 0 as 2 goes into 18 9 times and there's nothing left over.
-- if a number can divide by 2 with no remainder - it's an even number.
SELECT title, released_year FROM books WHERE released_year >= 2000 AND released_year % 2 != 0;
-- if released_year divided by 2 doesn't have a remainder of 0. No remainder = even, remainder 1 = odd.
-- could also do released_year % 2 = 1; - odd numbers have remainders 1.
SELECT title, released_year FROM books WHERE released_year >= 2000 AND released_year % 2 = 1;

SELECT title, released_year,
	CASE 
		WHEN released_year >= 2000 THEN 'Modern Lit'
        ELSE '20th Century Lit'
	END AS genre
FROM books;
SELECT title, stock_quantity,
	CASE
		WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
	END AS stock 
FROM books;
SELECT title, stock_quantity,
	CASE
		WHEN stock_quantity BETWEEN 0 AND 40 THEN '*'
        WHEN stock_quantity BETWEEN 41 AND 70 THEN '**'
		WHEN stock_quantity BETWEEN 71 AND 100 THEN '***'
		WHEN stock_quantity BETWEEN 101 AND 140 THEN '****'
        ELSE '*****'
	END AS stock 
FROM books;
SELECT title, stock_quantity,
	CASE
		WHEN stock_quantity <= 40 THEN '*'
        WHEN stock_quantity <= 70 THEN '**'
		WHEN stock_quantity <= 100 THEN '***'
		WHEN stock_quantity <= 140 THEN '****'
        -- SQL will check to see if the stock quantity is less than 40 - if false it will check if it's less than 70 until it finds the statement thats true and carries out that statements THEN.
        ELSE '*****'
	END AS stock 
FROM books;

SELECT * FROM books WHERE author_lname IS NULL;
SELECT * FROM books WHERE author_lname IS NOT NULL;
SELECT * FROM books WHERE title IS NULL;
DELETE FROM books WHERE title IS NULL;
SELECT * FROM books WHERE title IS NULL;

-- activity
#FALSE - 0
#TRUE - 1
#TRUE - 1
SELECT * FROM books WHERE released_year < 1980;
SELECT * FROM books WHERE author_lname = 'Eggers' OR author_lname = 'Chabon';
SELECT * FROM books WHERE author_lname = 'Lahiri' AND released_year > 2000;
SELECT * FROM books WHERE pages BETWEEN 100 AND 200;
SELECT * FROM books WHERE author_lname LIKE 'c%' OR author_lname LIKE 's%';
-- SELECT title, author_lname FROM books WHERE SUBSTR(author_lname, 1, 1) IN ('C', 'S');
SELECT title, author_lname, 
	CASE
		WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title = 'Just kids' OR title = 'A heartbreaking work of staggering genius' THEN 'Memoir'
        ELSE 'Novel'
	END AS type
FROM books;
SELECT author_fname, author_lname,
	CASE
		WHEN COUNT(*) < 2 THEN '1 book' -- WHEN COUNT(*) = 1 THEN '1 book'
        ELSE CONCAT(COUNT(*), ' books')
	END AS COUNT
FROM books WHERE author_lname IS NOT NULL GROUP BY author_fname, author_lname;
