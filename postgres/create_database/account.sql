CREATE SCHEMA IF NOT EXISTS account;

SET search_path TO account;

CREATE TABLE users(
    id SERIAL PRIMARY KEY NOT NULL,
    passwordHash VARCHAR(100) NOT NULL,
    username VARCHAR(26) NOT NULL
);

