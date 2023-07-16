# 1.1案例：查询员工的姓名及其部门名称
SELECT last_name, department_name
FROM employees,
     departments;

SELECT COUNT(employee_id)
FROM employees;
#输出107行
SELECT COUNT(department_id)
FROM departments;
#输出27行
SELECT 107 * 27
FROM dual;

# 2
SELECT employees.employee_id     AS '员工ID',
       employees.last_name       AS '姓',
       employees.department_id   AS '员工部门ID',
       departments.department_id AS '部门ID',
       departments.location_id   AS '部门地址ID'
FROM employees,
     departments
WHERE employees.department_id = departments.department_id;

SELECT employees.last_name, departments.department_name, employees.department_id
FROM employees,
     departments
WHERE employees.department_id = departments.department_id;

SELECT e.employee_id,
       e.last_name,
       e.department_id,
       d.department_id,
       d.location_id
FROM employees e,
     departments d
WHERE e.department_id = d.department_id;

SELECT CONCAT(emp.last_name, ' ', emp.first_name) AS '名字',
       dep.department_name                        AS '部门名',
       loc.city                                   AS '城市名'
FROM employees AS emp,
     departments AS dep,
     locations AS loc
WHERE emp.department_id = dep.department_id
  AND dep.location_id = loc.location_id;

# 非等职查询
SELECT e.last_name, e.salary, j.grade_level
FROM employees e,
     job_grades j
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal;

# 查询employees表，返回“Xxx works for Xxx”
SELECT CONCAT(
               worker.last_name,
               ' works for ',
               manager.last_name
           )
FROM employees AS worker,
     employees AS manager
WHERE worker.manager_id = manager.employee_id;
# 练习：查询出last_name为 ‘Chen’ 的员工的 manager 的信息。
SELECT m.*
FROM employees w,
     employees m
WHERE w.last_name = 'Chen'
  AND w.manager_id = m.employee_id;
# 内连接
SELECT last_name, department_name
FROM employees AS emp
         inner join departments dept on emp.department_id = dept.department_id;
# 左外链接
SELECT last_name, department_name
FROM departments AS dept
         left join employees emp on dept.department_id = emp.department_id;

SELECT e.employee_id,
       e.last_name,
       e.department_id,
       d.department_id,
       d.location_id
FROM employees e
         JOIN departments d
              ON (e.department_id = d.department_id);

SELECT employee_id, city, department_name
FROM employees e
         JOIN departments d
              ON d.department_id = e.department_id
         JOIN locations l
              ON d.location_id = l.location_id;

SELECT e.last_name, e.department_id, d.department_name
FROM employees e
         LEFT OUTER JOIN departments d
                         ON (e.department_id = d.department_id);

SELECT e.last_name, e.department_id, d.department_name
FROM employees e
         RIGHT OUTER JOIN departments d
                          ON (e.department_id = d.department_id);


SELECT employee_id, last_name, department_name
FROM employees e
         JOIN departments d
              ON e.`department_id` = d.`department_id`
                  AND e.`manager_id` = d.`manager_id`;

SELECT employee_id, last_name, department_name
FROM employees e
         NATURAL JOIN departments d;

SELECT employee_id, last_name, department_name
FROM employees e
         JOIN departments d
              USING (department_id);

#关联条件
#把关联条件写在where后面
SELECT last_name, department_name
FROM employees,
     departments
WHERE employees.department_id = departments.department_id;
#把关联条件写在on后面，只能和JOIN一起使用
SELECT last_name, department_name
FROM employees
         INNER JOIN departments
                    ON employees.department_id = departments.department_id;
SELECT last_name, department_name
FROM employees
         CROSS JOIN departments
                    ON employees.department_id = departments.department_id;
SELECT last_name, department_name
FROM employees
         JOIN departments
              ON employees.department_id = departments.department_id;
#把关联字段写在using()中，只能和JOIN一起使用
#而且两个表中的关联字段必须名称相同，而且只能表示=
#查询员工姓名与基本工资
SELECT last_name, job_title
FROM employees
         INNER JOIN jobs USING (job_id);
#n张表关联，需要n-1个关联条件
#查询员工姓名，基本工资，部门名称
SELECT last_name, job_title, department_name
FROM employees,
     departments,
     jobs
WHERE employees.department_id = departments.department_id
  AND employees.job_id = jobs.job_id;
SELECT last_name, job_title, department_name
FROM employees
         INNER JOIN departments
         INNER JOIN jobs
                    ON employees.department_id = departments.department_id
                        AND employees.job_id = jobs.job_id;