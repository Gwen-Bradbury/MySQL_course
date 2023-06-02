#quit; 
#mysql -u root -p;
-- quits and restarts the mysql session.

#always use single quotes around strings. Double quotes can throw an error. Escape ' inside of strings with a \.
#you can use "" inside ''.

#just because you have a default value, doesn't mean the value can't be null. You can use NOT NULL as well as DEFAULT.

#setting NOT NULL on a PRIMARY KEY is redundant as a PRIMARY KEY cannot be NULL.

# * means give me all the columns in specified table.

#to upload data via command line cd into file where data is > run 'mysql -u root -p' > enter password
# > 'CREATE DATABASE <database name>;' > 'USE <database name>;' > 'SOURCE <file name>.sql'

#LENGTH returns length of a string in bytes (some characters can take up more than one byte).
#CHAR_LENGTH returns length of string in characters (one letter/number/! = 1 character).

#UPPER is also called UCASE.
#LOWER is also called LCASE.

#sub query is a query within another query - the inner query will run first.

#you can group by mulitiple columns just add a , and the second column after the first.

#store dates as YYYY-MM-DD

#store times as HH:MM:SS

#store datetimes as YYYY-MM-DD HH:MM:SS

#TIMESTAMP takes up less storage space than DATETIME but have a more limited range of dates.
#DATETIMES are usually used to store DOB, TIMESTAMP is commonly used to store the date/time something was posted/uploaded ect.

# '=' and '!=' are comparison operators not logical operators although they sometimes may be called logical operators.
# '<', '<=', '>', '>=', 'LIKE', 'NOT LIKE', 'BETWEEN' are also comparison operators not logical. They compare 2 values.

# 'AND', 'OR' are logical operators.

# [] in the docs means optional.

# using PRIMARY KEY (<id_column> , <id_column>) makes sure you can only make one DB input with both those id combinations.
# eg PRIMARY KEY(user_id, photo_id) -- makes sure that you can only make one like with that user_id and photo_id combination.

# Modes are settings that can be turned on and off. They change behaviour and validations of mysql.
# A full list of settings can be found on the MySQL docs - https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html

#you can find the full list of agregate functions on the MySQL website (docs). - agregate functions need a GROUP BY!

#you can find all the date format code on the MySQL website (docs).

#you can find out about the different data types on the MySQL website (docs).
#string types-
-- varchar() - variable length text up to max length of characters specified in ()
-- char() - has a fixed length of characters specified in ()
#number types-
-- int (integer)
-- tinyint 
-- smallint
-- mediumint
-- bigint
-- all whole numbers
-- the difference is the min and max signed values - tinyint being the smallest and bigint being the biggest - and the memory each one takes up to store.
-- decimal - large or small numbers but are always guaranteed to be accurate.

#commands
#section 3
-- SHOW DATABASES;
-- CREATE DATABASE <DB name>;
-- DROP DATABASE <DB name>;
-- USE <DB name>;
-- SELECT database();
-- CREATE TABLE <table name> (
	-- <column name> <data type>,
	-- <column name> <data type>
-- );
-- SHOW TABLES;
-- SHOW COLUMNS FROM <table name>;
-- DESC <table name>;
-- DROP TABLE <table name>;

#section 4
-- INSERT INTO <table name> (<column names seperated by ,>) VALUES (<match the order of column names seperated by ,>);
-- SELECT * FROM <table name>;
-- NOT NULL
-- DEFAULT
-- PRIMARY KEY
-- AUTO_INCREMENT

#section 5
-- WHERE
-- AS
-- UPDATE <table name> SET <column name = new value> WHERE <column name = current value>
-- SET
-- DELETE FROM <table name> WHERE <column name = value>

#section 7
-- SOURCE <file name>.sql
-- SELECT CONCAT(<column name>, <column name>) FROM <table name>;
-- SELECT CONCAT_WS('<seperator>', <column name>, <column name>) FROM <table name>; - WS = with seperator; Specified seperator comes between all values.
-- SELECT SUBSTRING(<column name>, <start position>, <length>) FROM <table name>;
-- SUBSTR() - Same as above just shortened from SUBSTRING().
-- SELECT REPLACE(<column name>, <what we want to replace>, <what we want to replce it with>);
-- SELECT REVERSE(<column name>);
-- SELECT CHAR_LENGTH(<column name>);
-- SELECT UPPER(<column name>);
-- SELECT LOWER(<column name>);
-- SELECT INSERT(<string>, <position you want to insert at>, <number of characters you want to replace>, <what you're adding in>);
-- SELECT LEFT(<column name>, 5) FROM <table name>;
-- SELECT RIGHT(<column name>, 5) FROM <table name>;
-- SELECT REPEAT(<string>, 4);
-- SELECT TRIM(<string>); - whitespace
-- SELECT TRIM(LEADING <character you want to trim> FROM <string>);
-- SELECT TRIM(TRAILING <character you want to trim> FROM <string>);
-- SELECT TRIM(BOTH <character you want to trim> FROM <string>);

#section 8
-- SELECT DISTINCT <column name> FROM <table name>;
-- SELECT <column name> FROM <table name> ORDER BY <column name>/<column number from select list>;
-- SELECT <column name> FROM <table name> ORDER BY <column name>/<column number> DESC; 
-- SELECT <column name> FROM <table name> ORDER BY <column name>/<column number> ASC; 
-- SELECT <column name> FROM <table name> ORDER BY <column name>/<column number>, <column name>/<column number>;
-- SELECT <column name> FROM <table name> ORDER BY <column name>/<column number> LIMIT <number>, <number>;
-- SELECT <column name> FROM <table name> WHERE <column name> LIKE '%<letters>%'
-- %
-- _

#section 9 - Agregate Functions
-- SELECT COUNT(*) FROM <table name>;
-- SELECT <column name> FROM <table name> GROUP BY <column name>;
-- SELECT MIN(<column name>) FROM <table name>;
-- SELECT MAX(<column name>) FROM <table name>;
-- SELECT SUM(<column name>) FROM <table name>;
-- SELECT AVG(<column name>) FROM <table name>;

#section 10
-- SELECT CHAR_LENGTH(<column name>) FROM <table name>;
-- CREATE TABLE <table name> (<column name> TINYINT UNSIGNED);
-- DECIMAL(<total number of digits>, <digits after decimal>);
-- FLOAT
-- DOUBLE
-- DATE
-- TIME
-- DATETIME
-- SELECT CURDATE(); - CURRENT_DATE();
-- SELECT CURTIME(); - CURRENT_TIME();
-- SELECT NOW(); - CURRENT_TIMESTAMP();
-- SELECT DAY(<column name>) FROM <table name>;
-- SELECT DAYOFWEEK(<column name>) FROM <table name>;
-- SELECT DAYOFYEAR(<column name>) FROM <table name>;
-- SELECT MONTHNAME(<column name>) FROM <table name>;
-- SELECT DAYNAME(<column name>) FROM <table name>;
-- SELECT YEAR(<column name>) FROM <table name>;
-- SELECT HOUR(<column name>) FROM <table name>;
-- SELECT MINUTE(<column name>) FROM <table name>;
-- SELECT SECOND(<column name>) FROM <table name>;
-- SELECT DATE(<column name>) FROM <table name>;
-- SELECT TIME(<column name>) FROM <table name>;
-- SELECT DATE_FORMAT(<column name>, '<format code from docs>') FROM <table name>;
-- SELECT DATEDIFF(<date/CURDATE()/column name>, <column name>) FROM <table name>;
-- DATE_ADD(<a date/ column name>, INTERVAL <1 day/ 1 year/ 1 month>) FROM <table name>;
-- DATE_SUB(<a date/ column name>, INTERVAL <1 day/ 1 year/ 1 month>) FROM <table name>;
-- SELECT TIMEDIFF(<time/CURTIME()/column name>, <time/column name>) FROM <table name>;

#section 11 - Logical Operators
-- != 
-- NOT LIKE
-- >
-- <
-- >=
-- <=
-- && - can also use 'AND'
-- OR
-- BETWEEN
-- NOT BETWEEN
-- SELECT CAST(<insert string/int/ect> AS <insert type>);
-- IN (<value>, <value>);
-- NOT IN (<value>, <value>);
-- % - modulo
-- CASE WHEN <clause> THEN <clause> ELSE <clause> END
-- IS NULL
-- IS NOT NULL

#section 12 - Constraints and ALTER TABLE
-- UNIQUE
-- CHECK (<true or false condition based on column name>)
-- CONSTRAINT <your name for the constraint> <constraint you want to use>
-- ALTER TABLE <table name> ADD COLUMN <column name> <type>;
-- ALTER TABLE <table name> DROP COLUMN <column name>;
-- RENAME TABLE <table name> TO <new name>; -could also do- ALTER TABLE <table name> RENAME TO <new name>;
-- ALTER TABLE <table name> RENAME COLUMN <column name> TO <new name>;
-- ALTER TABLE <table name> MODIFY <column name> <type-varchar/int>;
-- ALTER TABLE <table name> CHANGE <column name> <new column name> <type>;
-- ALTER TABLE <table name> ADD CONSTRAINT <constraint name> CHECK (<the check>);
-- ALTER TABLE <table name> DROP CONSTRAINT <constraint name>; -could also do- ALTER TABLE <table name> DROP CHECK <constraint check>;

#section 13 - One to Many and Joins
-- PRIMARY KEY
-- FOREIGN KEY (<name of column from this table which references the other table>) REFERENCES <table it references>(<column name from table it references>);
-- JOIN <table name> ON <table name>.<column name> = <corresponding table name>.<corresponding column name>;
-- LEFT JOIN <table name> ON <table name>.<column name> = <corresponding table name>.<corresponding column name>;
-- IFNULL(<function>(<column>), <what you replace null with>);
-- RIGHT JOIN <table name> ON <table name>.<column name> = <corresponding table name>.<corresponding column name>;
-- ON DELETE CASCADE

#section 14 - Many to Many
-- YEAR
-- ROUND(<value you want to round>, <how many decimals you want to round to>)

#section 15 - Views and Modes
-- CREATE VIEW <view name> AS <query you want to store>;
-- CREATE OR REPLACE VIEW <view name> AS <query you want to store>;
-- ALTER VIEW <view name> AS <updated query you want to store>;
-- DROP VIEW <view name>;
-- GROUP BY <column name> HAVING <condtion that the group by needs to filter results>
-- WITH ROLLUP;
-- SELECT @@GLOBAL.sql_mode;
-- SELECT @@SESSION.sql_mode;
-- SET GLOBAL sql_mode = '<list of modes>';
-- SET SESSION sql_mode = '<list of modes>';
-- ONLY_FULL_GROUP_BY
-- NO_ZERO_IN_DATE 
-- quit; 
-- mysql -u root -p;

#section 16 - Window Functions
-- OVER()
-- PARTITION BY <column name>
-- RANK()
-- ROW_NUMBER()
-- DENSE_RANK()
-- NTILE()
-- FIRST_VALUE()
-- LAST_VALUE()
-- NTH_VALUE(<expression>, <number>)
-- LEAD()
-- LAG()

#section 18
-- HAVING
