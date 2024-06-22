-- init-db.sql
CREATE TABLE IF NOT EXISTS example_table (
    id SERIAL PRIMARY KEY,
    data TEXT NOT NULL
);
