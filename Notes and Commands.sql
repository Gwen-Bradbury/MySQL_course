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

#you can find the full list of agregate functions on the MySQL website (docs)

#you can find out about the different data types on the MySQL website (docs)
-- varchar() - variable length text up to max length of characters specified in ()
-- int - whole number

#commands
#section 3
-- SHOW DATABASES;
-- CREATE DATABASE <DB name>;
-- DROP DATABASE <DB name>;
-- USE <DB name>;
-- SELECT database();
-- CREATE TABLE <table name> (
	-- <column name> <data type>,
	-- 	<column name> <data type>
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

#section 9
-- SELECT COUNT(*) FROM <table name>;
-- SELECT <column name> FROM <table name> GROUP BY <column name>;
-- SELECT MIN(<column name>) FROM <table name>;
-- SELECT MAX(<column name>) FROM <table name>;
-- SELECT SUM(<column name>) FROM <table name>;
-- SELECT AVG(<column name>) FROM <table name>;

#section 10
