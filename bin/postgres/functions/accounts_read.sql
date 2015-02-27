--function for retrieving one or all accounts
CREATE OR REPLACE FUNCTION accounts_read(INTEGER DEFAULT NULL) 
RETURNS SETOF accounts AS
$$
BEGIN
    IF $1 IS NOT NULL THEN
        RETURN QUERY
        SELECT id, user_name, first_name, last_name, address, cell, email 
        FROM accounts
        WHERE id = $1;
    ELSE
        RETURN QUERY
        SELECT id, user_name, first_name, last_name, address, cell, email 
        FROM accounts;
    END IF;
    RETURN;
END;
$$ LANGUAGE plpgsql;
