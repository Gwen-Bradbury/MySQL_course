-- Constraints are things that you can add when setting up a table ie NOT NULL /Primary Key
CREATE TABLE contacts (
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);