CREATE SCHEMA IF NOT EXISTS events;

SET search_path TO events;

CREATE TABLE events (
    id SERIAL PRIMARY KEY NOT NULL,
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


CREATE OR REPLACE FUNCTION check_overlap(
    p_startTime timestamptz,
    p_endTime interval,
    p_userId integer
) RETURNS boolean
AS $$
DECLARE
    overlap_exist boolean := false;
BEGIN
    SELECT true
    INTO overlap_exist
    FROM events.events ev
    JOIN events.eventUser eu ON eu.eventId = ev.id
    WHERE eu.userId = p_userId 
    AND (ev.endTime) >= p_startTime
    AND ev.startTime <= (p_endTime)
    LIMIT 1;

    RETURN overlap_exist;
END;
$$ LANGUAGE plpgsql;
