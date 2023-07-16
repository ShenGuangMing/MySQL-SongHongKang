# 1.2单列排序
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date;

SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date DESC ;

SELECT employee_id, last_name, salary*12 AS annsal
FROM employees
ORDER BY annsal;

# 1.3 多列排序
SELECT last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC;


# 2.2
SELECT employee_id AS ID, CONCAT(last_name, ' ', first_name) AS NAME
FROM employees
LIMIT 4, 3;