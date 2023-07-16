#计算出员工的年基本工资
SELECT employee_id,salary,salary * 12 annual_sal
FROM employees;

#筛选出employee_id是偶数的员工
SELECT * FROM employees
WHERE employee_id MOD 2 = 0;

#查询commission_pct等于0.40
SELECT employee_id,commission_pct FROM employees WHERE commission_pct = 0.40;
SELECT employee_id,commission_pct FROM employees WHERE commission_pct <=> 0.40;
#如果把0.40改成 NULL 呢？
SELECT employee_id,commission_pct FROM employees WHERE commission_pct = NULL;
SELECT employee_id,commission_pct FROM employees WHERE commission_pct <=> NULL;

#查询基本薪资不在9000-12000之间的员工编号和基本薪资
SELECT employee_id,salary FROM employees
WHERE NOT (salary >= 9000 AND salary <= 12000);

SELECT employee_id,salary FROM employees
WHERE salary <9000 OR salary > 12000;

SELECT employee_id,salary FROM employees
WHERE salary NOT BETWEEN 9000 AND 12000;
