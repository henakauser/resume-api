--function for retrieving one or all education entries
CREATE OR REPLACE FUNCTION education_read(INTEGER DEFAULT NULL) 
RETURNS TABLE (id INTEGER, user_id INTEGER, name VARCHAR(50), institute VARCHAR(100), state VARCHAR(50), country VARCHAR(50), 
year SMALLINT, degree VARCHAR(100)) AS
$$
BEGIN
    IF $1 IS NOT NULL THEN
        RETURN QUERY
        SELECT e.id, e.user_id, CAST(a.first_name || ' ' ||a.last_name AS VARCHAR(50)) AS name, e.institute, e.state, e.country, e.year, e.degree
        FROM education e 
        JOIN accounts a ON a.id = e.user_id
        WHERE a.id = $1
        ORDER BY e.year;
    ELSE
        RETURN QUERY
        SELECT e.id, e.user_id, CAST(a.first_name || ' ' ||a.last_name AS VARCHAR(50)) AS name, e.institute, e.state, e.country, e.year, e.degree
        FROM education e 
        JOIN accounts a ON a.id = e.user_id
        ORDER BY e.year;
    END IF;
    RETURN;
END;
$$ LANGUAGE plpgsql;
