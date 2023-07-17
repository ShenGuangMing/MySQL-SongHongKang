# 1.1 AVG和SUM函数
SELECT AVG(salary) AS "平均工资",
       MAX(salary) AS "最高工资",
       MIN(salary) AS "最低工资",
       SUM(salary) AS "工资总和"
FROM employees
WHERE job_id LIKE '%REP%';

# 1.2 MIN和MAX函数
SELECT MIN(hire_date) "最早", MAX(hire_date) "最晚"
FROM employees;

# 1.3 COUNT函数
# COUNT(*)返回表中记录总数，适用于任意数据类型。
SELECT COUNT(*)
FROM employees;
# COUNT(expr) 返回expr不为空的记录总数。
SELECT COUNT(commission_pct)
FROM employees;

# 2. GROUP BY
# 2.1在SELECT列表中所有未包含在组函数中的列都应该包含在 GROUP BY子句中
SELECT d.department_name, AVG(e.salary) "组平均工资"
FROM employees e
         join departments d on e.department_id = d.department_id
GROUP BY e.department_id;

# 2.2 使用多个列分组
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id;

# 2.3 GROUP BY中使用WITH ROLLUP
/*
使用 WITH ROLLUP 关键字之后，在所有查询出的分组记录之后增加一条记录，该记录计算查询出的所
有记录的总和，即统计记录数量。例如下面最后一个举例是：department_id大于80的部门平均工资
*/
SELECT department_id, AVG(salary)
FROM employees
WHERE department_id > 80
GROUP BY department_id WITH ROLLUP;

SELECT AVG(salary)
FROM employees
WHERE department_id > 80;

# 3. HAVING
# 3.1简单使用：查询部门最高工资大于10000的部门
SELECT department_id, MAX(salary) "maxSalary"
FROM employees
GROUP BY department_id
HAVING maxSalary > 10000;

