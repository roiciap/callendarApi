CREATE SCHEMA IF NOT EXISTS events;

SET search_path TO events;

CREATE TABLE events (
    id SERIAL PRIMARY KEY NOT NULL,
    title VARCHAR(50),
    Content TEXT,
    startTime timestamp with time zone,
    duration INTERVAL
);

CREATE TABLE eventUser(
    id SERIAL PRIMARY KEY NOT NULL,
    eventId integer REFERENCES events.events(id),
    userId integer REFERENCES account.users(id)
);