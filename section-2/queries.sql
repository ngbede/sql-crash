SELECT city, area FROM cities WHERE area < 4000;

-- comparisons are executed for every single row
SELECT MAX(population) FROM cities;

-- check for a row whose area is in BETWEEN 2000 and 4000
SELECT city, area FROM cities WHERE area BETWEEN 2000 AND 4000;

-- check for row whose city is contained in the list provided
-- adding NOT in frony of IN returns the opposite
SELECT city, area FROM cities WHERE city IN ('Delhi', 'Tokyo');

-- OR command can also be used
SELECT city, area FROM cities WHERE area NOT IN (2191, 1484) AND city = 'Shanghai';

-- calculation on WHERE clauses
SELECT city, area FROM cities 
WHERE (population / area) > 6000;

-- updating records
UPDATE table_name SET column = new_value WHERE column = certain_value
UPDATE cities SET population = 30000000 WHERE city IN ('Sau Paulo', 'Delhi');

SELECT * FROM cities

-- deleting records
DELETE FROM table_name WHERE column = certain_value
DELETE FROM cities WHERE city != 'Tokyo';

SELECT * FROM cities