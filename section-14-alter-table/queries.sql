-- ROw level validation validates the info in a row whenever it is inserted or updated.
-- all queries run on the validation DB
-- we can't add a new rule to SQL tables columns of any of the existing rows already violate the new rule being added.  

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40),
    department VARCHAR (40),
    price INTEGER,
    weight NUMERIC
);

INSERT INTO public.products (name, department, price, weight)
VALUES ('Shirt', 'Clothes', 20, 1.2);

-- should not be able to add null price based on constraint
INSERT into products (name, department, weight)
VALUES ('Pants', 'Clothes', 3.67);

-- alter the tables price column so as to add the NOT NULL constraint
ALTER TABLE public.products
ALTER COLUMN price
SET NOT NULL;

UPDATE products
SET price = 0 WHERE price is 

-- default constraint
price INTEGER DEFAULT 29;

ALTER TABLE products
ALTER COLUMN price
SET DEFAULT 0 -- set default price of product to 0

-- unique constraint via the UNIQUE keyword

-- all values in column must be unique before adding this constraint in created table
ALTER TABLE products
ADD UNIQUE(name); -- specify column to add uniqe constraint
ADD UNIQUE (name, department) -- multi column uniquenes OPTION

DELETE FROM products WHERE id IN (5,6)

-- removing a CONSTRAINT you refer to the constraint name
ALTER TABLE products
DROP CONSTRAINT products_name_key

-- adding validation on columns via the CHECK(condition-to-check) keyword
-- checks work only on rows that are getting added/updated. No select is allowed
ALTER TABLE products
ADD CHECK(price > 0);

-- checks over multiple COLUMNS
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    est_delivery TIMESTAMP NOT NULL,
    CHECK (created_at < est_delivery) -- check estimated delivery is in the future
)

INSERT INTO orders (name. created_at, est_delivery)
VALUES ('belt', '2022-Nov-20 01:00AM', '2021-Jan-15 01:00AM');