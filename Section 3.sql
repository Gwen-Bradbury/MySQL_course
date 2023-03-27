SHOW DATABASES;

CREATE DATABASE pet_shop;
SHOW DATABASES;
CREATE DATABASE SlimeStore;
SHOW DATABASES;
CREATE DATABASE chicken_coop;
SHOW DATABASES;

DROP DATABASE SlimeStore;
SHOW DATABASES;
DROP DATABASE pet_shop;
SHOW DATABASES;

USE chicken_coop; -- I am using this DB
SELECT database(); -- shows which DB you're working inside of (using)
CREATE DATABASE tea_shop;
SELECT database(); -- still shows chicken_coop as that's the one we're using even though we've just made tea_shop
USE tea_shop; -- I have now swapped to use tea_shop not chicken_coop
SELECT database();
-- can also double click the DB name in SCHEMAS <- to change the DB you're using

SELECT database();
CREATE DATABASE pet_shop;
USE pet_shop;
SELECT database();
CREATE TABLE cats (
	name VARCHAR(50),
	age INT
);
CREATE TABLE dogs (
	name VARCHAR(50),
    breed VARCHAR(50),
	age int
);

SHOW TABLES; -- shows tables in DB you're using
USE tea_shop;
SHOW TABLES; -- won't show any cause you haven't created any inside this DB
USE pet_shop;
SHOW TABLES;
SHOW COLUMNS FROM cats; -- shows the column names from the DB pet_shop table cats
SHOW COLUMNS FROM dogs;
DESC cats; -- desc - describe; also shows column names for DB pet_shop table cats
-- you can also just click the columns in SCHEMAS <- to view the column names

SHOW TABLES;
DROP TABLE cats; -- deletes cats table from pet_shop DB
SHOW TABLES;
-- can also right click on table in SCHEMAS <- and click drop table

-- activity
USE tea_shop;
SELECT database();
CREATE TABLE pastries (
	name VARCHAR(50),
    quantity int
);
SHOW TABLES;
SHOW COLUMNS FROM pastries;
DROP TABLE pastries;
SHOW TABLES;
DESC pastries; -- Error Code:1146. Table 'tea_shop.pastries' doesn't exist