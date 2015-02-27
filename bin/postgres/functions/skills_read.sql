--function for retrieving one or all skills
CREATE OR REPLACE FUNCTION skills_read(INTEGER) RETURNS SETOF skills AS
$Body$
BEGIN
    RETURN QUERY
        WITH RECURSIVE sorted_skills AS
        (
            SELECT * FROM skills WHERE previous_id = 0 AND user_id = $1

            UNION ALL

            SELECT s.*
            FROM
                skills AS s
            JOIN
                sorted_skills AS ss
                ON (s.previous_id = ss.id)
            WHERE s.user_id = $1
        )
        SELECT *
        FROM sorted_skills;
END;
$Body$
language plpgsql;
