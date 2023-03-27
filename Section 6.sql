CREATE DATABASE shirts_db;
USE shirts_db;
CREATE TABLE shirts (
	shirt_id INT AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(50),
    colour VARCHAR(50),
    shirt_size VARCHAR(5),
    last_worn INT
);
SHOW TABLES;
DESC shirts;
INSERT INTO shirts (article, colour, shirt_size, last_worn) 
VALUES ('t-shirt', 'white', 'S', 10),
	   ('t-shirt', 'green', 'S', 200),
	   ('polo shirt', 'black', 'M', 10),
	   ('tank top', 'blue', 'S', 50),
	   ('t-shirt', 'pink', 'S', 0),
	   ('polo shirt', 'red', 'M', 5),
	   ('tank top', 'white', 'S', 200),
	   ('tank top', 'blue', 'M', 15);
SELECT * FROM shirts;
INSERT INTO shirts (article, colour, shirt_size, last_worn) 
VALUES ('polo shirt', 'purple', 'M', 50);
SELECT * FROM shirts;
SELECT article, colour FROM shirts;
SELECT article, colour, shirt_size, last_worn FROM shirts WHERE shirt_size='M';
UPDATE shirts SET shirt_size='L' WHERE article='polo shirt';
SELECT * FROM shirts;
UPDATE shirts SET last_worn=0 WHERE last_worn=15;
SELECT * FROM shirts;
UPDATE shirts SET colour='off white', shirt_size='XS' WHERE colour='white';
SELECT * FROM shirts;
DELETE FROM shirts WHERE last_worn=200;
SELECT * FROM shirts;
DELETE FROM shirts WHERE article='tank top';
SELECT * FROM shirts;
DELETE FROM shirts;
SELECT * FROM shirts;
DESC shirts;
DROP TABLE shirts;
DESC shirts;