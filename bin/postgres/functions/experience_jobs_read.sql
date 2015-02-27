--function for retrieving the jobs in each experience entry
CREATE OR REPLACE FUNCTION experience_jobs_read(INTEGER, INTEGER) RETURNS SETOF experience_jobs AS
$Body$
BEGIN
    RETURN QUERY
        WITH RECURSIVE sort_experience_jobs AS
        (
            SELECT * FROM experience_jobs WHERE previous_id = 0 AND user_id = $1 AND experience_id = $2

            UNION ALL

            SELECT e.*
            FROM
                experience_jobs AS e
            JOIN
                sort_experience_jobs AS ee
                ON (e.previous_id = ee.id)
            WHERE e.user_id = $1 AND e.experience_id = $2
        )
        SELECT *
        FROM sort_experience_jobs;
END;
$Body$
language plpgsql;
