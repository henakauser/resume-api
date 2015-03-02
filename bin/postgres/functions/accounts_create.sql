--function for creating new accounts
CREATE OR REPLACE FUNCTION accounts_create(user_name VARCHAR(50), 
                                            first_name VARCHAR(50), 
                                            last_name VARCHAR(50), 
                                            address VARCHAR(150), 
                                            cell VARCHAR(12), 
                                            email VARCHAR(100),
                                            OUT account_id INTEGER) RETURNS INTEGER AS 
$$
#variable_conflict use_variable
BEGIN
    INSERT INTO accounts (user_name, 
                            first_name, 
                            last_name, 
                            address, 
                            cell, 
                            email) 
                    VALUES (
                        user_name,
                        first_name,
                        last_name,
                        address,
                        cell,
                        email) RETURNING id INTO account_id;
END;
$$ LANGUAGE plpgsql;
