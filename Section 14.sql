CREATE DATABASE tv_db;
USE tv_db;
CREATE TABLE reviewers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
CREATE TABLE series (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    released_year YEAR,
    genre VARCHAR(100)
);
CREATE TABLE reviews (
	id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
);
SHOW TABLES;
INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
SELECT * FROM series;
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
SELECT * FROM reviewers;
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
SELECT * FROM reviews;

SELECT title, rating FROM series
JOIN reviews ON reviews.series_id = series.id; -- returns every rating for every show

SELECT title, AVG(rating) AS avg_rating FROM series
JOIN reviews ON reviews.series_id = series.id
GROUP BY title
ORDER BY avg_rating;
SELECT ROUND(3.1412, 2); -- rounds 3.1412 to 2 decimal places returning 3.14.
SELECT title, ROUND(AVG(rating),2) AS avg_rating FROM series
JOIN reviews ON reviews.series_id = series.id
GROUP BY title
ORDER BY avg_rating;

SELECT first_name, last_name, rating FROM reviewers
JOIN reviews ON reviews.reviewer_id = reviewers.id;

SELECT title AS unreviewed_series FROM series
LEFT JOIN reviews ON reviews.series_id = series.id
WHERE rating IS NULL; -- returns all titles that don't have reviews.
SELECT title AS unreviewed_series FROM reviews
RIGHT JOIN series ON reviews.series_id = series.id
WHERE rating IS NULL; -- returns all titles that don't have reviews.

SELECT genre, AVG(rating) AS avg_rating FROM series
JOIN reviews ON reviews.series_id = series.id
GROUP BY genre; 
SELECT genre, ROUND(AVG(rating), 2) AS avg_rating FROM series
JOIN reviews ON reviews.series_id = series.id
GROUP BY genre;

SELECT 
	first_name,
    last_name,
    COUNT(rating) AS count,
    IFNULL(MIN(rating), 0) AS min,
    IFNULL(MAX(rating), 0) AS max,
    ROUND(IFNULL(AVG(rating), 0), 2) AS avg,
    -- CASE WHEN MIN(rating) IS NULL THEN 0.0 ELSE MIN(rating) END AS min, - this is what I did. It still works!
    -- I also did it for max and avg
    CASE
		WHEN COUNT(rating) = 0 -- could also do WHEN COUNT(rating) > 0 THEN 'ACTIVE' ELSE 'INACTIVE'
        THEN 'INACTIVE'
        ELSE 'ACTIVE'
    END AS status
    -- instead of case you could do IF(COUNT(rating) > 0, 'ACTIVE', 'INACTIVE') AS status
FROM reviewers
LEFT JOIN reviews ON reviews.reviewer_id = reviewers.id
GROUP BY first_name, last_name;
	-- CASE
		-- WHEN COUNT(rating) >= 10 THEN 'POWERUSER'
        -- WHEN COUNT(rating) > 10 THEN 'ACTIVE'
        -- ELSE 'INACTIVE'
    -- END AS status
-- cases are better when there's multiple statements

SELECT title, 
	   ROUND(rating, 2) AS rating,
       CONCAT_WS(' ', first_name, last_name) AS reviewer -- could also do CONCAT(first_name, ' ', last_name)
FROM reviews
JOIN reviewers ON reviews.reviewer_id = reviewers.id
JOIN series ON reviews.series_id = series.id
ORDER BY title;
