-- CREATE TABLE accounts (
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(30) NOT NULL,
--     balance INTEGER NOT NULL DEFAULT 0,
--     CHECK (balance >= 0) 
-- );

-- INSERT INTO public.accounts (name, balance)  
-- VALUES ('Emmanuel', 200), ('Titi', 50);

BEGIN; -- used to initate a transaction 

-- ALL queries to run as single transaction go in here

COMMIT; -- this command is used to merge final results of transaction to the DB

ROLLBACK; -- used to undo all changes made in a transaction
-- any syntac error or bad command that occurs in a transaction leads to an 'aborted state. At this point a manual ROLLBACK must be initiated to proceed'
-- anytime connection is lost in between running a transaction, Postgres automatically initiates a ROLLBACK