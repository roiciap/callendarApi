CREATE SCHEMA IF NOT EXISTS account;

CREATE TABLE account.users IF NOT EXISTS (
    UserId SERIAL PRIMARY KEY NOT NULL,
    PasswordHash VARCHAR(100) NOT NULL,
    USERNAME VARCHAR(26) NOT NULL,
    JoinTime timestamp with time zone
)