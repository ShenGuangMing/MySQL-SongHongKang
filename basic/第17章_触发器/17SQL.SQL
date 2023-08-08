DROP TABLE IF EXISTS test_trigger;
DROP TABLE IF EXISTS test_trigger_log;

CREATE TABLE IF NOT EXISTS test_trigger (
                              id INT PRIMARY KEY AUTO_INCREMENT,
                              t_note VARCHAR(30)
) CHAR SET 'utf8';
CREATE TABLE IF NOT EXISTS test_trigger_log (
                                  id INT PRIMARY KEY AUTO_INCREMENT,
                                  t_log VARCHAR(30)
)CHAR SET 'utf8';

# 创建触发器：创建名称为before_insert的触发器，向test_trigger数据表插入数据之前，向test_trigger_log数据表中插入before_insert的日志信息。
DELIMITER &
CREATE TRIGGER before_insert BEFORE INSERT ON test_trigger
    FOR EACH ROW
    BEGIN
        INSERT INTO test_trigger_log (t_log) VALUES ('before_insert');
    end &
DELIMITER ;
# 测试
INSERT INTO test_trigger (t_note) VALUES ('测试 BEFORE INSERT 触发器');
SELECT * FROM test_trigger_log;
