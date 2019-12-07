CREATE TABLE employees(
emp_no int NOT NULL,
birth_date date NOT NULL,
first_name VARCHAR NOT NULL,
last_name VARCHAR NOT NULL,
gender VARCHAR NOT NULL,
hire_date date NOT NULL,
PRIMARY KEY (emp_no)
)

CREATE TABLE departments(
dept_no VARCHAR NOT NULL,
dept_name VARCHAR NOT NULL,
PRIMARY KEY (dept_no),
UNIQUE (dept_name)
)

CREATE TABLE dept_manager(
dept_no VARCHAR NOT NULL,
emp_no int NOT NULL,
from_date date NOT NULL,
to_date date NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
)


CREATE TABLE dept_emp(
emp_no int NOT NULL,
dept_no VARCHAR NOT NULL,
from_date date NOT NULL,
to_date date NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
)

CREATE TABLE titles(
emp_no int NOT NULL,
title VARCHAR NOT NULL,
from_date date NOT NULL,
to_date date NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (emp_no, title, from_date)
)

CREATE TABLE salaries(
emp_no int NOT NULL,
salary int NOT NULL,
from_date date NOT NULL,
to_date date NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (emp_no, from_date)
)

--List the following details of each employee: 
--employee number, last name, first name, gender, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;


--List employees who were hired in 1986.

SELECT last_name, first_name, hire_date
FROM employees
WHERE hire_date = ('1986-1-1');


--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date 
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no; 


--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no;


--List all employees whose first name is 
--"Hercules" and last names begin with "B."

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'B%' AND first_name ='Hercules'

--List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.

SELECT last_name, first_name, gender, salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;


--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, 
--and department name.

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name IN ('Development','Sales')
ORDER BY dept_name ASC;

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.

SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY count DESC;


