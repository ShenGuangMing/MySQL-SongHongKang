DELIMITER //
CREATE PROCEDURE get_count_by_limit_total_salary(IN limit_total_salary DOUBLE,OUT
    total_count INT)
BEGIN
    DECLARE sum_salary DOUBLE DEFAULT 0; #记录累加的总工资
    DECLARE cursor_salary DOUBLE DEFAULT 0; #记录某一个工资值
    DECLARE emp_count INT DEFAULT 0; #记录循环个数
#定义游标
    DECLARE emp_cursor CURSOR FOR SELECT salary FROM employees ORDER BY salary DESC;
#打开游标
    OPEN emp_cursor;
    REPEAT
        #使用游标（从游标中获取数据）
        FETCH emp_cursor INTO cursor_salary;
        SET sum_salary = sum_salary + cursor_salary;
        SET emp_count = emp_count + 1;
    UNTIL sum_salary >= limit_total_salary
        END REPEAT;
    SET total_count = emp_count;
#关闭游标
    CLOSE emp_cursor;
END //
DELIMITER ;

DELIMITER &
CREATE PROCEDURE get_count_by_limit_total_salary(IN limit_total_salary DOUBLE, OUT total_count INT)
BEGIN
    DECLARE sum_salary DOUBLE DEFAULT 0; #记录累加的总工资
    DECLARE cursor_salary DOUBLE DEFAULT 0; #记录某一个工资值
    DECLARE emp_count INT DEFAULT 0; #记录循环个数
    DECLARE emp_cursor CURSOR FOR SELECT salary FROM employees ORDER BY salary DESC; # 定义游标
    # 打开游标
    OPEN emp_cursor;
    REPEAT
        # 使用游标
        FETCH emp_cursor INTO cursor_salary; # 读取的salary放到cursor_salary中
        SET sum_salary = sum_salary + cursor_salary; # sum_salary累加
        SET emp_count = emp_count + 1; # 记录数
    until sum_salary > limit_total_salary
        end repeat ;
    SET  total_count = emp_count;
    CLOSE emp_cursor; # 关闭游标
end &
DELIMITER ;