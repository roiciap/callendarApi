CREATE SCHEMA IF NOT EXISTS events;

SET search_path TO events;

CREATE TABLE events (
    id SERIAL PRIMARY KEY NOT NULL,
    title VARCHAR(50),
    Content TEXT,
    startTime timestamptz,
    duration interval
);

CREATE TABLE eventUser(
    id SERIAL PRIMARY KEY NOT NULL,
    eventId integer REFERENCES events.events(id),
    userId integer REFERENCES account.users(id)
);


CREATE OR REPLACE FUNCTION check_overlap(
    p_startTime timestamptz,
    p_duration interval,
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
    AND (ev.startTime + ev.duration) >= p_startTime
    AND ev.startTime <= (p_startTime + p_duration)
    LIMIT 1;

    RETURN overlap_exist;
END;
$$ LANGUAGE plpgsql;
