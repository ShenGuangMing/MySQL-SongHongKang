# 1.1谁的工资比Abel高
# 1.1.1自连接
SELECT e2.last_name, e2.salary
FROM employees e1, employees e2
WHERE e1.last_name = 'Abel' AND
      e2.salary > e1.salary;
# 1.1.1子查询
SELECT last_name, salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Abel'
    LIMIT 1
    );

# 2. 单行子查询
## 2.1返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
SELECT job_id, salary
FROM employees
WHERE job_id =
    (SELECT job_id
     FROM employees
     WHERE employee_id = 141)
AND salary >
    (SELECT salary
     FROM employees
     WHERE employee_id = 143);
# 2.2返回公司工资最少的员工的last_name,job_id和salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
    );
# 2.3查询与141号或174号员工的manager_id和department_id相同的其他员工的employee_id，manager_id，department_id
# 不成对比较
SELECT employee_id, manager_id, department_id
FROM employees
WHERE manager_id IN (
    SELECT manager_id
    FROM employees
    WHERE employee_id IN (141, 174)
    )
AND department_id IN (
    SELECT department_id
    FROM employees
    WHERE employee_id IN (141, 174)
    )
AND employee_id NOT IN(174,141);
# 成对比较
SELECT employee_id, manager_id, department_id
FROM employees
WHERE (manager_id, department_id) IN (
    SELECT manager_id, department_id
    FROM employees
    WHERE employee_id IN (141, 174)
    )
AND employee_id NOT IN(174,141);

# 2.3 HAVING 中的子查询
# 查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT department_id, MIN(salary) "minSalary"
FROM employees
GROUP BY department_id
HAVING minSalary > (
    SELECT MIN(salary)
    FROM employees
    WHERE department_id = 50
    );

# 2.4 CASE中的子查询
/*显式员工的employee_id,last_name和location。其中，若员工department_id与location_id为1800
的department_id相同，则location为’Canada’，其余则为’USA’。
*/
SELECT employee_id, last_name, (
    CASE department_id
    WHEN (
        SELECT department_id
        FROM departments
        WHERE location_id = 1800
        )
    THEN 'Canada'
    ELSE 'USA'
    END
    ) 'location'
FROM employees;
# 2.5 子查询中的空值问题
SELECT last_name, job_id
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE last_name = 'Haas'
    );
# 2.6 非法使用子查询, 子查询的数据为多条
SELECT employee_id, last_name
FROM employees
WHERE salary =
      (SELECT MIN(salary)
       FROM employees
       GROUP BY department_id);

# 3. 多行子查询
# 返回其它job_id中比job_id为‘IT_PROG’部门任一工资低的员工的员工号、姓名、job_id 以及salary
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';
# 返回其它job_id中比job_id为‘IT_PROG’部门所有工资都低的员工的员工号、姓名、job_id以及salary
SELECT employee_id, last_name, job_id
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';
# 查询平均工资最低的部门id
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (SELECT MIN(avg_sal)
                      FROM (SELECT AVG(salary) "avg_sal" # 所有平均工资表
                            FROM employees
                            GROUP BY department_id) as dept_avg_sal);
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) <= ALL(SELECT AVG(salary)
                         FROM employees
                         GROUP BY department_id);

# 4. 相关子查询
# 查询员工中工资大于本部门平均工资的员工的last_name,salary和其department_id
SELECT last_name, salary, department_id
FROM employees e1
WHERE salary > (SELECT AVG(salary)
                FROM employees e2
                WHERE e2.department_id = e1.department_id);
# 上一个题基于FROM
SELECT e.last_name, e.salary, e.department_id
FROM employees e, (SELECT department_id, AVG(salary) avg_sal
                   FROM employees
                   GROUP BY department_id) t_dept_avg_sal
WHERE t_dept_avg_sal.department_id = e.department_id
AND e.salary > t_dept_avg_sal.avg_sal;

# 在ORDER BY 中使用子查询：
# 查询员工的id,salary,按照department_name 排序
SELECT employee_id, salary, department_id
FROM employees e
ORDER BY (SELECT department_name
          FROM departments d
          WHERE e.department_id = d.department_id);
# 若employees表中employee_id与job_history表中employee_id相同的数目不小于2，输出这些相同id的员工的employee_id,last_name和其job_id
SELECT employee_id, last_name, job_id
FROM employees e
WHERE 2 <= (SELECT COUNT(*)
           FROM job_history j
           WHERE e.employee_id = j.employee_id);

# 4.3 EXISTS 与 NOT EXISTS关键字
# 查询公司管理者的employee_id，last_name，job_id，department_id信息
SELECT employee_id, last_name, job_id, department_id
FROM employees e1
WHERE EXISTS(SELECT *
             FROM employees e2
             WHERE e2.manager_id = e1.employee_id);
# 方式二：自连接
SELECT DISTINCT e1.employee_id, e1.last_name, e1.job_id, e1.department_id
FROM employees e1 JOIN employees e2
WHERE e1.employee_id = e2.manager_id;

SELECT employee_id,last_name,job_id,department_id
FROM employees
WHERE employee_id IN (
    SELECT DISTINCT manager_id
    FROM employees
);
# 查询departments表中，不存在于employees表中的部门的department_id和department_name
SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS (SELECT 'X'
                  FROM employees
                  WHERE department_id = d.department_id);
# 4.4 相关更新
# 在employees中增加一个department_name字段，数据为员工对应的部门名称
# 1）
ALTER TABLE employees
    ADD(department_name VARCHAR2(14));
# 2）
UPDATE employees e
SET department_name = (SELECT department_name
                       FROM departments d
                       WHERE e.department_id = d.department_id);

SHOW CREATE TABLE employees;