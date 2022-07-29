-- Selecting distinct records we do so using the DISTINCT clause.
-- It is used in the SELECT clause and returns a list of all different unique values in a column

SELECT DISTINCT department
FROM products;

-- count number of unique departments
-- can only do count when performing DISTINCT on a single column
SELECT COUNT(DISTINCT department)
FROM products;

-- we can use group by in place of distinct, but not use distinct in place of group by

-- return unique combinations of multiple rows
SELECT DISTINCT department, name FROM products;

-- get GREATEST value in a list of values 
SELECT GREATEST( 2, 98, 10, 32 );

-- compute the cost to ship for each product 
-- if weight * 2 is less than $30 we set it to $30 else we set it to the weight * $2 val

SELECT name, weight, GREATEST(30, 2 * weight) AS shipping_cost
FROM products;

-- compute the least value from a list using the LEAST keyword
SELECT LEAST (20, 0, 10, 17, -20);

-- compute discounted product as per sale
SELECT name, price, LEAST(price * 0.5, 400) as sale_price
FROM products;

-- CASE keyword: this is equivalent of if-else statment in any other programming language
-- price > 600 'high' price > 300 'medium' else 'cheap'
SELECT
    name,
    price,
    CASE
        WHEN price > 600 THEN 'high'
        WHEN price > 300 THEN 'medium'
        ELSE 'cheap' -- if no else included NULL is default value for rows that don't meet up to upper conditions
    END
FROM products;
