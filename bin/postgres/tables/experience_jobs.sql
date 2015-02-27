--create table experience_jobs
CREATE TABLE IF NOT EXISTS experience_jobs (
	id SERIAL PRIMARY KEY,
	user_id INTEGER REFERENCES accounts(id),
    experience_id INTEGER REFERENCES experience(id),
    job TEXT NOT NULL,
    previous_id INTEGER NOT NULL
);
