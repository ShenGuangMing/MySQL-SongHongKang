# 3.1
SELECT *
FROM departments;

SELECT department_id, location_id
FROM departments;

# 3.2
SELECT last_name AS name, commission_pct comm
FROM employees;
SELECT last_name "Name", salary*12 "Annual Salary"
FROM employees;

# 3.3
SELECT department_id
FROM employees;
SELECT DISTINCT department_id
FROM employees;

# 3.4
SELECT employee_id,salary,commission_pct,
       12 * salary * (1 + commission_pct) "annual_sal"
FROM employees;

# 3.5
SELECT * FROM ORDER;
SELECT * FROM `order`;

# 4.0
desc employees;

# 5.0
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90;