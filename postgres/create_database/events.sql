CREATE SCHEMA IF NOT EXISTS events;

SET search_path TO events;

CREATE TABLE events (
    id SERIAL PRIMARY KEY NOT NULL,
    ownerId integer REFERENCES account.users(id) NOT NULL,
    eventType VARCHAR(10) NOT NULL,
    title VARCHAR(50) NOT NULL,
    content TEXT,
    startTime timestamptz NOT NULL,
    endTime timestamptz NOT NULL
);

CREATE TABLE eventUser(
    id SERIAL PRIMARY KEY NOT NULL,
    eventId integer REFERENCES events.events(id) NOT NULL,
    userId integer REFERENCES account.users(id) NOT NULL
);
