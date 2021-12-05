DROP VIEW IF EXISTS sum_goods_by_goods_type;
DROP VIEW IF EXISTS sum_goods_by_goods_id;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS goods;
DROP TABLE IF EXISTS goods_type;
CREATE TABLE goods_type
(
   goods_type_id INT GENERATED ALWAYS AS IDENTITY,
   goods_type_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(goods_type_id)
);
CREATE TABLE goods
(
   goods_id INT GENERATED ALWAYS AS IDENTITY,
   goods_name VARCHAR(255) NOT NULL,
   goods_type_id INT,
   PRIMARY KEY(goods_id),
   CONSTRAINT fk_goods
      FOREIGN KEY(goods_type_id)
    REFERENCES goods_type(goods_type_id)
);
CREATE TABLE orders
(
   order_id INT GENERATED ALWAYS AS IDENTITY,
   user_name VARCHAR(255) NOT NULL,
   total INT,
   goods_id INT,
   PRIMARY KEY(order_id),
   CONSTRAINT fk_order
      FOREIGN KEY(goods_id)
    REFERENCES goods(goods_id)
);
INSERT INTO goods_type(goods_type_name)
VALUES('vegetables'),
      ('fruits'),
      ('cookie');

INSERT INTO goods(goods_name, goods_type_id)
VALUES('tomato',1),
      ('potatoes',1),
      ('banana',2),
      ('orange',2),
      ('oreo',3),
      ('chocopie',3);

INSERT INTO orders(user_name, total, goods_id)
VALUES('John',2,1),
      ('John',1,3),
      ('Jane',3,5),
      ('Jane',3,6),
      ('David',10,2),
      ('David',5,5),
      ('David',3,1),
      ('Ann', 1,6);

CREATE VIEW sum_goods_by_goods_id
    AS SELECT sum(total) AS sum_goods, goods_type_id, g.goods_name
    FROM orders JOIN goods g ON orders.goods_id = g.goods_id
    GROUP BY g.goods_id;

CREATE VIEW sum_goods_by_goods_type
    AS SELECT sum(sum_goods) as sum_by_type, gt.goods_type_id, gt.goods_type_name
    FROM sum_goods_by_goods_id JOIN goods_type gt
         ON sum_goods_by_goods_id.goods_type_id = gt.goods_type_id
    GROUP BY gt.goods_type_id;

SELECT goods_type_name
FROM sum_goods_by_goods_type
WHERE sum_by_type = (
    SELECT max(sum_by_type)
    FROM sum_goods_by_goods_type
);