--function for creating new experience
CREATE OR REPLACE FUNCTION experience_create(INTEGER, VARCHAR(100), VARCHAR(200), INTEGER, INTEGER, INTEGER, INTEGER, INTEGER) RETURNS VOID AS 
$$
BEGIN
    INSERT INTO experience (user_id, employer, role, start_month, start_year, end_month, end_year, previous_id) 
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8);
END;
$$ LANGUAGE plpgsql;
