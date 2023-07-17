# 2.1基本函数
SELECT ABS(-123),
       ABS(32),
       SIGN(-23),
       SIGN(43),
       PI(),
       CEIL(32.32),
       CEILING(-43.23),
       FLOOR(32.32),
       FLOOR(-43.23),
       MOD(12, 5)
FROM DUAL;

SELECT RAND(), RAND(), RAND(10), RAND(10), RAND(-1), RAND(-1)
FROM DUAL;

SELECT ROUND(12.33),
       ROUND(12.343, 2),
       ROUND(12.324, -1),
       TRUNCATE(12.66, 1),
       TRUNCATE(12.66, -1)
FROM DUAL;

SELECT RADIANS(30), RADIANS(60), RADIANS(90), DEGREES(2 * PI()), DEGREES(RADIANS(90))
FROM DUAL;

SELECT SIN(RADIANS(30)),
       DEGREES(ASIN(1)),
       TAN(RADIANS(45)),
       DEGREES(ATAN(1)),
       DEGREES(ATAN2(1, 1))
FROM DUAL;

# 4.3
SELECT YEAR(CURDATE()),
       MONTH(CURDATE()),
       DAY(CURDATE()),
       HOUR(CURTIME()),
       MINUTE(NOW()),
       SECOND(SYSDATE())
FROM DUAL;
SELECT MONTHNAME('2021-10-26'),
       DAYNAME('2021-10-26'),
       WEEKDAY('2021-10-26'),
       QUARTER(CURDATE()),
       WEEK(CURDATE()),
       DAYOFYEAR(NOW()),
       DAYOFMONTH(NOW()),
       DAYOFWEEK(NOW())
FROM DUAL;

# 4.4
SELECT EXTRACT(MINUTE FROM NOW()),
       EXTRACT(WEEK FROM NOW()),
       EXTRACT(QUARTER FROM NOW()),
       EXTRACT(MINUTE_SECOND FROM NOW())
FROM DUAL;

SELECT DATE_ADD(NOW(), INTERVAL 1 DAY)                               AS col1,
       DATE_ADD('2021-10-21 23:32:12', INTERVAL 1 SECOND)            AS col2,
       ADDDATE('2021-10-21 23:32:12', INTERVAL 1 SECOND)             AS col3,
       DATE_ADD('2021-10-21 23:32:12', INTERVAL '1_1' MINUTE_SECOND) AS col4,
       DATE_ADD(NOW(), INTERVAL -1 YEAR)                             AS col5, #可以是负数
       DATE_ADD(NOW(), INTERVAL '1_1' YEAR_MONTH)                    AS col6  #需要单引号
FROM DUAL;

SELECT DATE_SUB('2021-01-21', INTERVAL 31 DAY)                  AS col1,
       SUBDATE('2021-01-21', INTERVAL 31 DAY)                   AS col2,
       DATE_SUB('2021-01-21 02:01:01', INTERVAL '1 1' DAY_HOUR) AS col3
FROM DUAL;

SELECT ADDTIME(NOW(), 20),
       SUBTIME(NOW(), 30),
       SUBTIME(NOW(), '1:1:3'),
       DATEDIFF(NOW(), '2021-10-01'),
       TIMEDIFF(NOW(), '2021-10-25 22:10:10'),
       FROM_DAYS(366),
       TO_DAYS('0000-12-25'),
       LAST_DAY(NOW()),
       MAKEDATE(YEAR(NOW()), 12),
       MAKETIME(10, 21, 23),
       PERIOD_ADD(20200101010101, 10)
FROM DUAL;

SELECT ADDTIME(NOW(), 50);




SELECT employee_id,salary, CASE WHEN salary>=15000 THEN '高薪'
                                WHEN salary>=10000 THEN '潜力股'
                                WHEN salary>=8000 THEN '屌丝'
                                ELSE '草根' END "描述"
FROM employees;



