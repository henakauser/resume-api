--function for retrieving one account's experience
CREATE OR REPLACE FUNCTION experience_read(INTEGER) RETURNS SETOF experience AS
$Body$
BEGIN
    RETURN QUERY
        WITH RECURSIVE sort_experience AS
        (
            SELECT * FROM experience WHERE previous_id = 0 AND user_id = $1

            UNION ALL

            SELECT e.*
            FROM
                experience AS e
            JOIN
                sort_experience AS ee
                ON (e.previous_id = ee.id)
            WHERE e.user_id = $1
        )
        SELECT *
        FROM sort_experience;
END;
$Body$
language plpgsql;
