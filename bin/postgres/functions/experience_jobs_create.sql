--function to create a new job
CREATE OR REPLACE FUNCTION experience_jobs_create(INTEGER, INTEGER, TEXT, INTEGER) RETURNS VOID AS 
$$
BEGIN
    INSERT INTO experience_jobs (user_id, experience_id, job, previous_id) 
    VALUES ($1, $2, $3, $4);
END;
$$ LANGUAGE plpgsql;
