--create table accounts
CREATE TABLE IF NOT EXISTS accounts (
    id SERIAL PRIMARY KEY,                                                                                              
    user_name VARCHAR (50) UNIQUE NOT NULL, 
    first_name VARCHAR (50) NOT NULL, 
    last_name VARCHAR (50) NOT NULL, 
    address VARCHAR (150) NOT NULL, 
    cell VARCHAR (12) UNIQUE NOT NULL check (cell ~ '(\d{3}\-?\d{3}\-?\d{4})'), 
    email VARCHAR (100) UNIQUE NOT NULL check (email ~ '^[\w.%-]+@[\w.-]+[.][A-Za-z]+$')
);

