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

