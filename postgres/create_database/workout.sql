CREATE SCHEMA IF NOT EXISTS workout;

SET search_path TO workout;

CREATE TABLE workoutType (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(30) NOT NULL,
    userId integer REFERENCES account.users(id)
);

CREATE TABLE workoutSession (
    id SERIAL PRIMARY KEY NOT NULL,
    sessionName VARCHAR(20),
    eventId integer REFERENCES events.events(id)
);


CREATE TABLE workout (
    id SERIAL PRIMARY KEY NOT NULL,
    sessionId integer REFERENCES workout.workoutSession(id) NOT NULL,
    workoutTypeId integer REFERENCES workout.workoutType(id) NOT NULL,
    reps integer,
    sets integer,
    weight integer
);

