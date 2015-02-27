--function for creating new education entry
CREATE OR REPLACE FUNCTION education_create(INTEGER, VARCHAR(100), VARCHAR(50), VARCHAR(50), SMALLINT, VARCHAR(100)) RETURNS VOID AS 
$$
BEGIN
    INSERT INTO education (user_id, institute, state, country, year, degree)
    VALUES ($1, $2, $3, $4, $5, $6);
END;
$$ LANGUAGE plpgsql;
