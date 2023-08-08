# 查看已有约束
# information_schema数据库名（系统库）
# table_constraints表名称（专门存储各个表的约束）
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'test_unique';

# 唯一约束
create table test_unique (
    username CHAR(10) UNIQUE
);
# 唯一约束可以添加多个NULL
INSERT INTO test_unique values (NULL), (NULL);

# 查询约束表索引
show index from test_unique;

# 删除唯一约束
ALTER TABLE `test_unique`
    DROP INDEX `username`; # username是指约束名