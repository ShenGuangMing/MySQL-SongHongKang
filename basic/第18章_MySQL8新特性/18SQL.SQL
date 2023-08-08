# 1.窗口函数
# 数据准备
CREATE TABLE goods
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    category    VARCHAR(15),
    NAME        VARCHAR(30),
    price       DECIMAL(10, 2),
    stock       INT,
    upper_time  DATETIME
);
INSERT INTO goods(category_id, category, NAME, price, stock, upper_time)
VALUES (1, '女装/女士精品', 'T恤', 39.90, 1000, '2020-11-10 00:00:00'),
       (1, '女装/女士精品', '连衣裙', 79.90, 2500, '2020-11-10 00:00:00'),
       (1, '女装/女士精品', '卫衣', 89.90, 1500, '2020-11-10 00:00:00'),
       (1, '女装/女士精品', '牛仔裤', 89.90, 3500, '2020-11-10 00:00:00'),
       (1, '女装/女士精品', '百褶裙', 29.90, 500, '2020-11-10 00:00:00'),
       (1, '女装/女士精品', '呢绒外套', 399.90, 1200, '2020-11-10 00:00:00'),
       (2, '户外运动', '自行车', 399.90, 1000, '2020-11-10 00:00:00'),
       (2, '户外运动', '山地自行车', 1399.90, 2500, '2020-11-10 00:00:00'),
       (2, '户外运动', '登山杖', 59.90, 1500, '2020-11-10 00:00:00'),
       (2, '户外运动', '骑行装备', 399.90, 3500, '2020-11-10 00:00:00'),
       (2, '户外运动', '运动外套', 799.90, 500, '2020-11-10 00:00:00'),
       (2, '户外运动', '滑板', 499.90, 1200, '2020-11-10 00:00:00');
# 1.1 序号函数
# 1.1.1 ROW_NUMBER()函数
# 举例：查询 goods 数据表中每个商品分类下价格降序排列的各个商品信息。
SELECT ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY price DESC) AS
           row_num,
       id,
       category_id,
       category,
       NAME,
       price,
       stock
FROM goods;
# 举例：查询 goods 数据表中每个商品分类下价格最高的3种商品信息。
SELECT * # 组内排序
FROM (SELECT ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY price DESC) AS
                 row_num,
             id,
             category_id,
             category,
             NAME,
             price,
             stock
      FROM goods) AS new_talbe
WHERE new_talbe.row_num <= 3;

# 1.1.2．RANK()函数
SELECT RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS
           row_num,
       id,
       category_id,
       category,
       NAME,
       price,
       stock
FROM goods;

# 1.1.3 DENSE_RANK()函数
SELECT DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS
           row_num,
       id,
       category_id,
       category,
       NAME,
       price,
       stock
FROM goods;

# 1.2 分布函数
# 1.2.1 PERCENT_RANK()函数
# 计算方式(rank - 1) / (rows - 1)
#写法一：
SELECT RANK() OVER (PARTITION BY category_id ORDER BY price DESC)         AS r,
       PERCENT_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS pr,
       id,
       category_id,
       category,
       NAME,
       price,
       stock
FROM goods
WHERE category_id = 1;
# 写法二
SELECT RANK() OVER w         AS r,
       PERCENT_RANK() OVER w AS pr,
       id,
       category_id,
       category,
       NAME,
       price,
       stock
FROM goods
WHERE category_id = 1 WINDOW w AS (PARTITION BY category_id ORDER BY price DESC);

# 1.2.2CUME_DIST()函数
SELECT CUME_DIST() OVER (PARTITION BY category_id ORDER BY price ASC) AS cd,
       id,
       category,
       NAME,
       price
FROM goods;
# 1.3前后函数
# 1.3.1 LAG(expr,n)函数: LAG(expr,n)函数返回当前行的前n行的expr的值。
# 举例：查询goods数据表中前一个商品价格与当前商品价格的差值。
SELECT id, category, NAME, price, pre_price, price - pre_price AS diff_price
FROM (SELECT id, category, NAME, price, LAG(price, 1) OVER w AS pre_price
      FROM goods
          WINDOW w AS (PARTITION BY category_id ORDER BY price)) t;
# 1.3.2 LEAD(expr,n)函数: LEAD(expr,n)函数返回当前行的后n行的expr的值。
SELECT id, category, NAME, price, next_price, price - next_price AS diff_price
FROM (SELECT id, category, NAME, price, LEAD(price, 1) OVER w AS next_price
      FROM goods
          WINDOW w AS (PARTITION BY category_id ORDER BY price)) t;

# 1.4 前后函数
# 1.4.1 FIRST_VALUE(expr)函数： FIRST_VALUE(expr)函数返回第一个expr的值。
# 举例：按照价格排序，查询第1个商品的价格信息。
SELECT id, category, NAME, price, FIRST_VALUE(price) OVER w AS first_price
FROM goods
    WINDOW w AS (PARTITION BY category_id ORDER BY price);
# 1.4.2 LAST_VALUE(expr)函数: 按照价格排序，查询最后一个商品的价格信息。
SELECT id, category, NAME, price, LAST_VALUE(price) OVER w AS last_price
FROM goods
    WINDOW w AS (PARTITION BY category_id ORDER BY price);

# 1.5其他函数

SELECT id,
       category,
       NAME,
       price,
       NTH_VALUE(price, 2) OVER w AS second_price,
       NTH_VALUE(price, 3) OVER w AS third_price
FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);





