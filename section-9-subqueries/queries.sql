-- subqueries combine the result of the first query to be used in a second query
-- e.g

-- list name & price of all products that are more expensive than the products in the 'Toy' department
-- we 1st get the the max price for Toy products, then make use of it in the second query.

SELECT name, price
FROM products 
WHERE price > 
-- this is our subquery enclosed in the parenthesis
-- it is ran first on our DB
(
    SELECT MAX(price)
    FROM products WHERE department = 'Toys'
);


-- Rules to consider in subqueries
-- 1. subquery in select statement: the result must produce a single value 
SELECT name, price, (
    SELECT MAX(price) FROM products -- has to return a single value to work
)
FROM products
WHERE price > 867;

SELECT name, p.price, (
    SELECT p2.price FROM products p2 WHERE id = 3 -- single val returned
) AS id_3_price
FROM products p
WHERE p.price > 867;


-- 2. subquery in from clause: allows us to return a wide variety of data structure as far as outer query is compatible with the subquery
-- we must always make use of an alias on the result of a FROM clause subquery
-- column names selected in first query must match the column names in the subquery

SELECT name, price_weight_ratio
FROM (
    SELECT name, price / weight AS price_weight_ratio FROM products
) AS p -- always use an alias here
WHERE p.price_weight_ratio > 5;

-- we can return a single value from subquery in FROM clause

SELECT * 
FROM (SELECT MAX(price) FROM products) AS m;

-- FIND the average number of orders for all users i.e total_orders / total_users
SELECT SUM(o.all_orders) / COUNT(*) AS avg_orders_per_user -- can use AVG(o.all_orders)
FROM ( 
    SELECT user_id, COUNT(*) AS all_orders FROM orders
    GROUP BY user_id
) AS o;

-- 3. subquery in JOIN clause: we can put in any subquery in join clause as far as its result is compatible with the ON clause 
-- users who ordered product with id 3
SELECT first_name 
FROM e_users 
JOIN (
    SELECT user_id FROM orders WHERE product_id = 3
) AS o 
ON o.user_id = e_users.id;

-- 4. subqueriies in WHERE clause: structure of data allowed to be returned changes depending on the comparison operator
-- show id of orders that involce a product with price/weight ratio > 5
SELECT id
FROM orders
WHERE id IN (
    SELECT o.id 
    FROM orders o
    JOIN products p ON o.product_id = p.id
    WHERE p.price / p.weight > 50
); --AS lines; seems we can't use the AS syntax here

-- below is probably the best solution tbf
-- SELECT id
-- FROM orders
-- WHERE orders.product_id IN (
--     SELECT p.id 
--     FROM products p
--     WHERE p.price / p.weight > 50
-- ) --AS lines; seems we can't use the AS syntax here

-- show name of all products with price greater than the avg product price
SELECT name, price 
FROM products p
WHERE p.price > (
    SELECT AVG(price) FROM products
);

-- show name of all products not in the same department as products with price less than 100
SELECT name, price, department
FROM products
WHERE department NOT IN (
    SELECT p.department
    FROM products p
    WHERE p.price < 100
);

-- show name, department and price of prods that are more expensive than all prods in industrial department
-- ALL operator compares all rows value to another single row to get all rows that match bool check
SELECT name, department, price
from products
WHERE price > ALL ( -- subquery has to return a single column
    SELECT price 
    FROM products p
    WHERE department = 'Industrial'
)
ORDER BY price DESC;

-- show name of products that are more expensive than at least one product in 'Industrial' department
-- SOME / ANY: both do the same thing

SELECT name, department, price
FROM products 
WHERE price > SOME ( -- any product that is greater than the lowest and the maximum industrial product's
    SELECT price FROM products p
    WHERE p.department = 'Industrial'
) AND department != 'Industrial';

-- SHOW the name, department, and price of most expensive product in each department
-- correlated subquery: allow us to relate to upper and subquery properties in a single operation
-- refering to row from outer query in subquery via the use of alias
SELECT name, department, price
FROM products p1
WHERE p1.price = (
    SELECT MAX(price)
    FROM products p2
    WHERE p1.department = p2.department
);

-- without the use of join or group by print number of orders for each product
-- 1st: not so correct answer
SELECT p.name, COUNT(*) AS number_of_orders
FROM products p
LEFT JOIN orders o ON p.id = o.product_id
GROUP BY p.name
ORDER BY number_of_orders DESC;

-- 2nd: correct answer I guess
SELECT name, (
    SELECT COUNT(*)
    FROM orders o
    WHERE o.product_id = p.id
) AS number_of_orders
FROM products p
ORDER BY number_of_orders DESC;

-- WE are allowed to exlcude the FROM clause from any query whose subquery in SELECT clause returns a single value

SELECT (
    SELECT MAX(price) FROM products -- returns a single value so we are good
);

-- FIND ratio of maximum priced item to avg price of all items
-- useful for calculations that involve 1 row of results/values
SELECT (
    SELECT MAX(price)  FROM products
) / (
    SELECT AVG(price)  FROM products
);