USE pet_shop;
DROP TABLE cats;
CREATE TABLE cats (
	cat_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    breed VARCHAR(100),
    age INT
);
DESC cats;
INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);    
SELECT * FROM cats;

SELECT name FROM cats; -- returns name column only
SELECT age FROM cats; -- returns age column only
SELECT name, age FROM cats; -- returns name and age columns only
SELECT name, breed FROM cats; -- returns name and breed only

SELECT * FROM cats WHERE age=4;
SELECT name, age FROM cats WHERE age=4; -- returns name and age columns only where age is 4
SELECT name FROM cats WHERE age=4;
SELECT * FROM cats WHERE name='Egg'; 

-- activity
SELECT cat_id FROM cats;
SELECT name, breed FROM cats;
SELECT name, age FROM cats WHERE breed='Tabby';
SELECT cat_id, age FROM cats WHERE cat_id = age;

SELECT cat_id AS id, name FROM cats; -- renames cat_id column to id just in this queries results
SELECT name AS kittyName FROM cats;

UPDATE employees SET last_name='Roosterbeard'; -- Changes all last names in table to Roosterbeard
UPDATE employees SET current_status='Laid off', last_name='Who cares'; -- changes all last names and current statuses to whats specified
UPDATE cats SET breed='Shorthair'
WHERE breed='Tabby'; -- Change breed from Tabby to Shorthair
SELECT * FROM cats;
UPDATE cats SET age=14
WHERE name='Misty';
SELECT * FROM cats;

-- activity
UPDATE cats SET name='Jack' WHERE name='Jackson';
SELECT * FROM cats;
UPDATE cats SET breed='British Shorthair' WHERE name='Ringo';
SELECT * FROM cats;
UPDATE cats SET age=12 WHERE breed='Maine Coon';
SELECT * FROM cats;

DELETE FROM cats; -- deletes every row from table but doesn't delete table. Drop deletes the table.
DELETE FROM cats WHERE name='Egg';
SELECT * FROM cats;
SELECT * FROM employees;
DELETE FROM employees;
SELECT * FROM employees;

-- activity
SELECT * FROM cats;
DELETE FROM cats WHERE age=4;
SELECT * FROM cats;
DELETE FROM cats WHERE cat_id=age;
SELECT * FROM cats;
DELETE FROM cats;
SELECT * FROM cats;