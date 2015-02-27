--create table experience
CREATE TABLE IF NOT EXISTS experience (
	id SERIAL PRIMARY KEY,
	user_id INTEGER REFERENCES accounts(id),
	employer VARCHAR (100) NOT NULL,
	role VARCHAR(200) NOT NULL,
    start_month SMALLINT NULL,
	start_year SMALLINT NOT NULL,
    end_month SMALLINT NULL,
	end_year SMALLINT NOT NULL CHECK (end_year >= start_year),
	previous_id INTEGER NOT NULL
);

