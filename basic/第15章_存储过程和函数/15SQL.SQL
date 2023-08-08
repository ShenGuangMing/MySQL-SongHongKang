# 举例1：创建存储过程select_all_data()，查看 emps 表的所有数据
DELIMITER &
CREATE PROCEDURE select_all_data()
BEGIN
    SELECT * FROM `employees`;
end &
DELIMITER ;
# 举例2：创建存储过程avg_employee_salary()，返回所有员工的平均工资
DELIMITER //
CREATE PROCEDURE avg_emp_salary()
BEGIN
    SELECT AVG(salary) AS 'avg_salary' FROM `employees`;
end //
DELIMITER ;
# 举例3：创建存储过程show_max_salary()，用来查看“emps”表的最高薪资值。
CREATE PROCEDURE show_max_salary()
BEGIN
    SELECT MAX(salary) FROM `employees`;
end;

# 举例4：创建存储过程show_min_salary()，查看“emps”表的最低薪资值。并将最低薪资通过OUT参数“ms”输出
DELIMITER &
CREATE PROCEDURE show_min_salary(OUT ms DOUBLE)
BEGIN
    SELECT min(salary) INTO ms FROM employees;
end &
DELIMITER ;

# 举例5：创建存储过程show_someone_salary()，查看“emps”表的某个员工的薪资，并用IN参数 empname 输入员工姓名。
DELIMITER &
CREATE PROCEDURE show_someone_salary(IN  empname VARCHAR(20))
BEGIN
    SELECT salary FROM employees
        WHERE last_name = empname;
end &
DELIMITER ;

# 举例6：创建存储过程show_someone_salary2()，查看“emps”表的某个员工的薪资，并用IN参数empname输入员工姓名，用OUT参数empsalary输出员工薪资。
DELIMITER &
CREATE PROCEDURE show_someone_salary2(IN empname VARCHAR(20), OUT  empsalary DOUBLE)
BEGIN
    SELECT salary INTO empsalary FROM employees
        WHERE last_name = empname;
end &
DELIMITER ;
SHOW CREATE PROCEDURE show_someone_salary2;

# 创建存储函数，名称为email_by_name()，参数定义为空，该函数查询Abel的email，并返回，数据类型为字符串型。
DELIMITER &
CREATE FUNCTION email_by_name(empName VARCHAR(20))
RETURNS VARCHAR(30)
DETERMINISTIC
CONTAINS SQL
BEGIN
    RETURN (select email from employees where last_name = empName);
end &
DELIMITER ;

SHOW CREATE FUNCTION email_by_name;

