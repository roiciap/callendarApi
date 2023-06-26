
CREATE OR REPLACE FUNCTION events.check_overlap(
    p_startTime timestamptz,
    p_endTime timestamptz,
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


CREATE OR REPLACE FUNCTION events.get_events(p_user_id integer, p_start_date timestamptz, p_end_date timestamptz)
  RETURNS TABLE (event_id integer, event_type varchar(10), title varchar(50), event_start timestamptz, event_end timestamptz)
AS $$
BEGIN
  RETURN QUERY 
    SELECT e.id, e.eventType, e.title, e.startTime, e.endTime
    FROM events.events e
    JOIN events.eventUser eu ON e.id = eu.eventId
    WHERE eu.userId = p_user_id AND e.startTime >= p_start_date AND e.endTime <= p_end_date;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION workout.get_last_workout(user_id integer)
  RETURNS TABLE (workout_id integer, session_name varchar(20), event_id integer, start_time timestamptz)
AS $$
BEGIN
  RETURN QUERY 
    SELECT w.id, wt.name, w.reps, w.sets, w.weight, e.start_time
    FROM workout.workout w
    JOIN workout.workoutSession ws ON w.sessionId = ws.id
    JOIN workout.workoutType wt ON wt.id = w.workoutTypeId
    JOIN events.events e ON ws.eventId = e.id
    JOIN events.eventUser eu ON eu.eventId = ws.eventId
    WHERE eu.userId = user_id
    ORDER BY e.startTime DESC, w.id DESC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;