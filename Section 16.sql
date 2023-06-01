-- group by collapses each row in the group by into a single result row.
-- window functions perform aggregate functions on groups of rows (like group by does) except they produce a result for each row in the group (or window of data).
	-- if you calculate the AVG() salary of each department it will return all the rows (unlike a group by where they're all put into one) and put the AVG() department salary column on the end of every row.
    -- rows in the same department will have the same AVG() salary figure in the AVG() department salary column.

-- The OVER() clause constructs a window. If it's left empty the window will include all records.
CREATE DATABASE window_funcs;
USE window_funcs;
CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);
SELECT * FROM employees;
SELECT department, AVG(salary) FROM employees GROUP BY department;
-- 7 rows in each department group have been collapsed down into one row for each group in the group by.
SELECT AVG(salary) FROM employees;
-- returns the AVG() salary of all the rows combined and collapses all the rows down into one row.
SELECT AVG(salary) OVER() FROM employees; 
-- returns the AVG() salary of all the rows combined and returns it for every row. - if you have 21 rows it will return it 21 times.
	-- as the OVER() is empty it will include all rows. So one result for each row.
SELECT emp_no, department, salary, AVG(salary) OVER() FROM employees;
-- returns AVG() salary for all rows and returns it for every row.
SELECT 
	emp_no, 
    department, 
    salary, 
    MIN(salary) OVER(),
    MAX(salary) OVER()
    FROM employees;
-- returns the min and max salary for all rows and returns both for every row.

-- PARTITION BY allows a window function work with multiple windows.
-- windows are the same concept as groups. PARTITION BY is like saying GROUP BY.
SELECT 
	emp_no,
    department,
    salary, 
    AVG(salary) OVER(PARTITION BY department) AS dept_avg 
    FROM employees;
    -- returns the average of each departments salary for every row in that department. 
    -- There are 7 rows in the customer service department and the AVG is 46571.4286 so it will return that value for every row in that department, 7 rows so 7 times.
-- you can't see the aggregate function info for every row in a GROUP BY as it groups the rows together in one.
SELECT department, AVG(salary) FROM employees GROUP BY department;
-- returns one row for each department with the average salary for that department.
SELECT 
	emp_no,
    department,
    salary, 
    AVG(salary) OVER(PARTITION BY department) AS dept_avg,
    AVG(salary) OVER() AS company_avg
    FROM employees;
SELECT
	emp_no,
    department,
    salary, 
    COUNT(emp_no) OVER(PARTITION BY department)
    FROM employees;
    -- returns the amount of employees in each department for each row.
SELECT 
	emp_no,
    department,
    salary,
    SUM(salary) OVER(PARTITION BY department) AS department_payroll, -- returns the payroll value for each department for every row within that department.
    SUM(salary) OVER() AS total_payroll -- returns the payroll value for the entire company for every row.
    FROM employees;

-- using ORDER BY in an OVER() reorders the rows within the windows.
SELECT 
	emp_no,
    department,
    salary,
    SUM(salary) OVER(PARTITION BY department) AS total_department_salary -- returns that departments total salary for every row.
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
    SUM(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS rolling_department_salary, -- returns the SUM of the current salary row plus the salary row before it. So it's adding up the salaries by row as it moves down the column.
		-- starting with the highest salary in that department.
    SUM(salary) OVER(PARTITION BY department) AS total_department_salary 
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
    SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_department_salary, -- returns the SUM of the current salary row plus the salary row before it. So it's adding up the salaries by row as it moves down the column.
    -- starting with the lowest salary in that department.
    SUM(salary) OVER(PARTITION BY department) AS total_department_salary 
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
    MIN(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_min -- returns the min salary for that department for every row.
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
    MIN(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS rolling_min 
    -- So if the salary is 51000 on one row in a department, it will return 51000 but if it's 45000 on the next row in the same dept, it will return 45000, as thats the new lowest salary in that dept.
    FROM employees;
-- ORDER BY gives a rolling AVG or MIN when used in a window function.

-- RANK() can only be used with a window function.
SELECT 
	emp_no,
    department,
    salary,
    RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank -- gets the first,second,third ect ranking salary from highest to lowest.
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
	RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank, -- gets the first,second,third ect ranking salary from highest to lowest within each dept.
    RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank -- gets the first,second,third ect ranking salary from highest to lowest.
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
	RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank, -- gets the first,second,third ect ranking salary from highest to lowest within each dept (within each dept is the partion by section).
    RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank -- gets the first,second,third ect ranking salary from highest to lowest.
    FROM employees ORDER BY department; -- returns the results by department with the highest paid person in that department at the top of each department window.

-- ROW_NUMBER() labels each row in a partition starting with 1 and counts the rows.
SELECT 
	emp_no,
    department,
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_row_number, -- counts the number of rows in each dept.
	RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank, -- gets the first,second,third ect ranking salary from highest to lowest within each dept (within each dept is the partion by section).
    RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank -- gets the first,second,third ect ranking salary from highest to lowest.
    FROM employees ORDER BY department;
-- DENSE_RANK() returns the ranks like RANK() but when rows have the same rank ie a tie (also known as a peer group) it applies consecutive ranks to those peer groups.
SELECT 
	emp_no,
    department,
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_row_number, -- counts the number of rows in each dept.
	RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank,
    RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS overall_salary_dense_rank 
    -- with RANK() if you have 2 rows with the same rank ie 5 the next rows rank after the two 5's will be 7.
    -- with DENSE_RANK() the next row after the two rows with 5 ranks will be 6.
    FROM employees ORDER BY overall_salary_rank;
SELECT 
	emp_no,
    department,
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_row_number, -- counts the number of rows in each dept.
	RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank,
    RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS overall_salary_dense_rank,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS overall_number 
    FROM employees ORDER BY overall_salary_rank;

-- NTILE() divides windows into buckets based on the amount of buckets specified. NTILE(4) - 4 buckets.
-- returns bucket number that row lands in.
SELECT 
	emp_no,
    department,
    salary,
    NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_quartile, -- returns the salary quartile for the different departments.
    NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile -- returns the salary quartile for the entire company.
    FROM employees;

-- FIRST_VALUE() returns the value of the expression specified in the () from the first row in the window frame.
SELECT 
	emp_no,
    department,
    salary,
    FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) 
    -- returns the emp_no of the employee with then highest salary for every row ie the first value when the rows are ordered by highest salary first.
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) AS highest_paid_dept,
        -- returns the emp_no of the employee with the highest salary in each dept for every row in that dept. ie the first value in each dept when the rows in that dept are ordered by highest salary first. 
    FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) AS highest_paid_overall
    -- returns the emp_no of the employee with then highest salary for every row ie the first value when the rows are ordered by highest salary first.
    FROM employees;
-- same for LAST_VALUE() and NTH_VALUE()

-- LEAD() and LAG() are used to find a difference between the current row and the one before or the current row and the one after.
-- LAG() - previous row.
-- LEAD() - next row.
SELECT 
	emp_no,
    department,
    salary,
    LAG(salary) OVER(ORDER BY salary) -- returns the previous salary for each row in a window.
    FROM employees;
-- if there's no previous value it will return NULL if the previous value is the same, it will return 0.
SELECT 
	emp_no,
    department,
    salary,
    salary - LAG(salary) OVER(ORDER BY salary DESC) AS salary_diff -- returns the difference between the current and previous salary for each row in a window.
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
    salary - LEAD(salary) OVER(ORDER BY salary DESC) AS salary_diff -- returns the difference between the current and next salary for each row in a window.
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
    salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_diff -- returns the difference between the current and next salary for each row within the dept windows.
    FROM employees;
SELECT 
	emp_no,
    department,
    salary,
    LAG(salary, 2) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_diff -- returns the salary from 2 rows back.
    FROM employees;
