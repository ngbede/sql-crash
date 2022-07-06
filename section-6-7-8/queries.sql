-- Exercises

-- get the number of paid and unpaid orders
SELECT o.paid, COUNT(*)
FROM orders o
GROUP BY o.paid;

-- get 1st and last name of each user, then if they have paid for their order or not 
SELECT e.first_name, e.last_name, o.id AS order_id, o.paid
FROM e_users e
JOIN orders o ON e.id = o.user_id;

-- order products by price
-- ASC => lowest to highest
-- DESC => highest to lowest
SELECT name, price FROM products ORDER BY price;


-- order by multiple props if 2 records have same sort val for a column you can add second sort criteria
SELECT * FROM products ORDER BY price, weight; -- 2 sort alternatives

-- OFFSET => skip specified number of ROWS from result set
-- LIMIT => return specified length of ROWS from result set 

SELECT * FROM e_users OFFSET 20; -- skip first 20 users
SELECT * FROM e_users LIMIT 10; -- get first 10 users

-- get the 5 least most expensive products
SELECT * FROM e_users FROM products ORDER BY price LIMIT 5;

-- get the 5 most expensive products
SELECT * FROM e_users FROM products ORDER BY price DESC LIMIT 5;

-- get the 5 most expensive price with the exception of the first
-- By convention limit goes before offset
-- We use limit and offset to controll the number of data we show to a user. Kinda like pagination
SELECT * FROM e_users FROM products ORDER BY price LIMIT 5 OFFSET 1;


-- Find the 4 products with the highest price alongside the 4 prods with the highest price/weight ratio
-- If a row exist in both queries, the UNION keyword will pick only a single instance and drop the duplicate.
-- TO override the above behaviour do UNION ALL 
(
    SELECT * FROM products ORDER BY price DESC LIMIT 4
)
UNION -- combines the results of both queries into single result
(
    SELECT * FROM products ORDER BY price / weight DESC LIMIT 4
);
-- UNIONS can only be used on the result of 2 queries where they have the exact same columns, 
-- i.e column names and data type must match between both queries results

-- other SET related queries
-- INTERSECT => find the common rows in the result of two queries, then remove duplicates
-- INTERSECT ALL => Find rows common in the results of two queries

(
    SELECT * FROM products ORDER BY price DESC LIMIT 4
)
INTERSECT -- find the common row between both queries
(
    SELECT * FROM products ORDER BY price / weight DESC LIMIT 4
);


-- EXCEPT => FIND the rows that are present in the 1st query but not in 2nd query, then remove duplicates
-- EXCEPT ALL => FInd the rows that are present in first query but not not in 2nd query
-- the order of the query matters here
(
    SELECT * FROM products ORDER BY price DESC LIMIT 4
)
EXCEPT -- find the common row between both queries
(
    SELECT * FROM products ORDER BY price / weight DESC LIMIT 4
);
