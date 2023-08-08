CREATE DATABASE db_test01;
USE db_test01;
#查看服务器的字符集和比较规则
SHOW VARIABLES LIKE '%_server';
#查看数据库的字符集和比较规则
SHOW VARIABLES LIKE '%_database';
#查看具体数据库的字符集
SHOW CREATE DATABASE db_test01;
#修改具体数据库的字符集
ALTER DATABASE db_test01 DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

## 6.1 linux下查看大小写是否敏感
SHOW VARIABLES LIKE '%lower_case_table_names%';

## 7.4模式查看和设置
### a.查看当前的sql_mode
select @@session.sql_mode;
select @@global.sql_mode;
### b.测试
#### b.1数据准备
CREATE TABLE my_tb12
(
    `id`   INT,
    `name` VARCHAR(16),
    `age`  INT,
    `dept` INT
);
INSERT INTO `my_tb12` VALUES
                          (1, '张三', 33, 101),
                          (2, '谌光明', 33, 102),
                          (3, '黄熙评', 20, 102),
                          (4, '李四', 30, 101),
                          (5, '李华', 42, 101);
#### b.2查询每个部门年龄最大的人
SELECT `name`,`dept`,MAX(`age`) FROM `my_tb12` GROUP BY `dept`;
#### b.3设置sql_mode
SET SESSION sql_mode = '';
#### b.4重新查询
SELECT `name`,`dept`,MAX(`age`) FROM `my_tb12` GROUP BY `dept`;
#### b.5插入一条有错误的数据
INSERT INTO `my_tb12` values (6, 'Tom', 'aa', 102);
#### b.6查询
SELECT * FROM `my_tb12`;
#### b.7设置回去
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

