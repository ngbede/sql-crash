-- SELECT * from cities;

-- -- we could mix the order of column inserts
-- INSERT INTO cities (city, country, population, area) 
-- VALUES('Tokyo', 'Japan', 37468000, 2191);

-- insert multiple rows
INSERT INTO cities (city, country, population, area)
VALUES
    ('Delhi', 'India', 28514000, 1484),
    ('Shanghai', 'China', 25582000, 6341),
    ('Sau Paulo', 'Brazil', 21650000, 1521);


-- DROP TABLE cities;

-- SQL allows us to transform or process data before we receive it

-- get popultaion density i.e population / area
-- we can use other math operators like *, +, - etc

SELECT city, population / area AS pop_density 
FROM cities;

--  String Operators and FUNCTIONS
-- || and CONCAT() => concatenation
-- LOWER() => returns a lowercase string
-- LENGTH() => number of chars in a string
-- UPPER() => returns the uppercase of a string

SELECT city || ', ' || country AS location FROM cities;

SELECT CONCAT( UPPER(city), ', ', country) AS location FROM cities;