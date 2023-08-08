# 创建enum表
# mysql5.7中需要在字段后面添加 CHAR SET 'utf8',8.0之后不需要
CREATE TABLE test_enum(
    season ENUM('春','夏','秋','冬') CHAR SET 'utf8'
);
INSERT INTO `test_enum`
values ('春'), ('秋');

# 允许按照角标的方式获取指定索引位置的枚举值
INSERT INTO test_enum
VALUES('1'),(3); # 角标从1开始

SELECT * FROM test_enum;