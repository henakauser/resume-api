--function for creating new skills
CREATE OR REPLACE FUNCTION skills_create(INTEGER, VARCHAR(1000), INTEGER) RETURNS VOID AS $$
BEGIN
    WITH ROWS AS (
    INSERT INTO skills (user_id, skill, previous_id) VALUES ($1, $2, $3) RETURNING id
    )

    UPDATE skills SET previous_id = t.id
    FROM (SELECT id FROM ROWS) t
    WHERE skills.id <> t.id AND skills.previous_id = $3;

END;
$$ LANGUAGE plpgsql;
