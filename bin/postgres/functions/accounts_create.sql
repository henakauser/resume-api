--function for creating new accounts
CREATE OR REPLACE FUNCTION accounts_create(VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(150), VARCHAR(12), VARCHAR(100)) RETURNS VOID AS 
$$
BEGIN
    INSERT INTO accounts (user_name, first_name, last_name, address, cell, email) 
    VALUES ($1, $2, $3, $4, $5, $6);
END;
$$ LANGUAGE plpgsql;
