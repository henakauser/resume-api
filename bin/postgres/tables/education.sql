--create table education
CREATE TABLE IF NOT EXISTS education (
	id SERIAL PRIMARY KEY,
	user_id INTEGER REFERENCES accounts(id),
	institute VARCHAR(100) NOT NULL,
    state VARCHAR (50) NULL,
    country VARCHAR (50) NULL,
	year SMALLINT NOT NULL,
	degree VARCHAR (100) NOT NULL
);
