--create table skills
CREATE TABLE IF NOT EXISTS skills (
	id SERIAL PRIMARY KEY,
	user_id INTEGER REFERENCES accounts(id),
	skill VARCHAR(1000) NOT NULL,
	previous_id INTEGER NULL
);
