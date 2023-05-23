SELECT * FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;
CREATE VIEW full_reviews AS 
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id; 
-- this creates a virtual table. Not a real one. But you will be able to see it if you run SHOW TABLES.
SHOW TABLES;
SELECT * FROM full_reviews;
SELECT * FROM full_reviews WHERE genre = 'Animation';
-- you can treat full_reviews as if it was a table even though it's not.
-- it allows us to write shorter, more readable queries.
SELECT genre, AVG(rating) FROM full_reviews GROUP BY genre;

SELECT * FROM full_reviews;
DELETE FROM full_reviews WHERE released_year = 2010; -- Error Code: 1395. Cannot delete from join view.
-- our view is not updatable. But some views are.
SELECT * FROM series ORDER BY released_year;
CREATE VIEW ordered_series AS SELECT * FROM series ORDER BY released_year; -- this view lets us insert into the real table.
SELECT * FROM ordered_series;
INSERT INTO ordered_series (title, released_year, genre) VALUES ('The Great', 2020, 'Comedy');
-- lets us update/delete as it doesn't break any of the rules laid out in the docs.
SELECT * FROM ordered_series;
SELECT * FROM series; -- The Great is in the table and the view.
DELETE FROM ordered_series WHERE title = 'The Great';
SELECT * FROM ordered_series; -- The Great has gone.
SELECT * FROM series; -- The Great has gone from here too.

CREATE VIEW ordered_series AS SELECT * FROM series ORDER BY released_year DESC;
-- added DESC on.
-- Error Code: 1050. Table already exists.
CREATE OR REPLACE VIEW ordered_series AS SELECT * FROM series ORDER BY released_year DESC;
SELECT * FROM ordered_series; -- order has changed cause of DESC.
ALTER VIEW ordered_series AS SELECT * FROM series ORDER BY released_year;
-- can also use ALTER VIEW to change/update the view.
SELECT * FROM ordered_series;
DROP VIEW ordered_series;
SELECT * FROM ordered_series; -- doesn't exist.

-- HAVING filters the groups we get back from a GROUP BY
SELECT title, AVG(rating) FROM full_reviews GROUP BY title HAVING COUNT(rating) > 1;
-- returns all titles alongside their average rating, with a rating of more than 1.
-- any titles with ratings of less than one will be filtered out and not returned.
SELECT title, AVG(rating) FROM full_reviews GROUP BY title HAVING title = 'Archer';
SELECT title, AVG(rating), COUNT(rating) AS review_count FROM full_reviews GROUP BY title HAVING COUNT(rating) > 1;

SELECT * FROM full_reviews;
SELECT AVG(rating) FROM full_reviews; -- gives one average rating for the whole table.
SELECT title, AVG(rating) FROM full_reviews GROUP BY title; -- gives average rating for each title.
-- the average function is operating a different levels.
-- its operating on all the rows in the first query and groups of rows grouped by title in the second.
SELECT title, AVG(rating) FROM full_reviews GROUP BY title WITH ROLLUP;
-- returns the average rating for each title and the average rating from the whole table.
-- WITH ROLLUP only works with GROUP BY.
SELECT title, COUNT(rating) FROM full_reviews GROUP BY title WITH ROLLUP; 
-- returns how many ratings each title has and how many ratings the whole table has - the total amount of ratings.
SELECT released_year, AVG(rating) FROM full_reviews GROUP BY released_year;
-- returns average rating for all the reviews in a given year.
SELECT released_year, AVG(rating) FROM full_reviews GROUP BY released_year WITH ROLLUP;
-- returns average rating for all the reviews in a given year and the average rating from the whole table.
SELECT released_year, genre, AVG(rating) FROM full_reviews GROUP BY released_year, genre;
-- returns the released year and each genre in that years average rating.
-- in 2009 all the animation genres had an average rating of 8.12000.
SELECT released_year, genre, AVG(rating) FROM full_reviews GROUP BY released_year, genre WITH ROLLUP;
-- returns average rating for each genre released in the released year, average rating from all genres released in the released year and average rating for the entire table.

SELECT @@GLOBAL.sql_mode; -- To view the current global scope modes.
SELECT @@SESSION.sql_mode; -- To view the current session scope modes. 
-- Modes are settings that can be turned on and off. They change behaviour and validations of mysql.
-- If you start a new session and haven't changed any modes these global and session modes will be the same.
-- If you change session modes, when you quit and restart the session the modes will revert back to the global modes.
-- If you change global modes, they won't revert back.
-- SET GLOBAL sql_mode = '<list of modes>'; -- sets the global modes.
-- SET SESSION sql_mode = '<list of modes>'; -- sets the session modes.
SELECT @@SESSION.sql_mode;
SELECT 3/0;
SHOW WARNINGS; -- Division by 0 warning.
-- SET SESSION sql_mode = ''; -- setting it to an empty string disables all session modes.
SELECT @@SESSION.sql_mode;
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
-- removing ERROR_FOR_DIVISION_BY_ZERO warning.
SELECT 3/0;
SHOW WARNINGS; -- No warnings there.

SELECT @@GLOBAL.sql_mode;
-- STRICT_TRANS_TABLES - controls how MySQL handles invalid or missing values in data exchange statements like UPDATE and INSERT.
-- String into number column, number into string, update string to be a number = invalid data.
INSERT INTO reviews(rating) VALUE ('hi'); -- Error Code: 1366. Incorrect decimal value.
SET SESSION sql_mode = '';
SELECT @@SESSION.sql_mode; -- empty.
INSERT INTO reviews(rating) VALUE ('hi');
SHOW WARNINGS; -- incorrect decimal value. Warning not Error!
SELECT * FROM reviews; -- returns the inserted 'hi' as a 0.0 decimal value.
SET SESSION sql_mode = 'STRICT_TRANS_TABLES';
INSERT INTO reviews(rating) VALUE ('hi'); -- Error Code:1366. Incorrect decimal value.

SET SESSION sql_mode = '';
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY';
SELECT title, rating FROM series
	JOIN reviews ON series.id = reviews.series_id;
SELECT title, AVG(rating) FROM series
	JOIN reviews ON series.id = reviews.series_id
    GROUP BY title;
-- ONLY_FULL_GROUP_BY says I'm only allowed to reference columns that are either aggregate function columns or columns that have been named in the group by clause.
-- Errors when the AVG(rating) is just rating in above query cause SQL doesn't know which rating, within the group, is being specified.
SET SESSION sql_mode = '';
SELECT title, rating FROM series
	JOIN reviews ON series.id = reviews.series_id
    GROUP BY title;
    -- would error with the ONLY_FULL_GROUP_BY mode enabled.
-- this is probably just giving you the first rating from each group.
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY';
SELECT title, rating FROM series
	JOIN reviews ON series.id = reviews.series_id
    GROUP BY title;
    -- Error Code: 1055. Expression not in GROUP BY and contains nonaggregated column. Incompatible with ONLY_FULL_GROUP_BY.
-- NO_ZERO_IN_DATE - doesn't allow 00 in dates. Example 2010-01-00 - there's no day! 2010-00-01 - there's no month!
SELECT DATE('2010-01-00');
SET SESSION sql_mode = 'NO_ZERO_IN_DATE';
SELECT DATE('2010-01-00');
-- get warning and NULL result with the NO_ZERO_IN_DATE mode on.
SHOW WARNINGS; 
-- incorrect datetime value.
-- if strict mode is enabled as well as the NO_ZERO_IN_DATE mode it will error instead of warning.
-- strict modes are STRICT_ALL_TABLES and STRICT_TRANS_TABLES.
CREATE TABLE dates (d DATE); -- column d with type DATE.
INSERT INTO dates (d) VALUES ('2023-11-00');
SHOW WARNINGS;
-- out of range value for column d at row 1.
SELECT * FROM dates; 
-- it did go in as 0000-00-00.
SET SESSION sql_mode = 'NO_ZERO_IN_DATE,STRICT_TRANS_TABLES';
INSERT INTO dates (d) VALUES ('2023-11-00');
-- Error Code: 1292. Incorrect date value.
