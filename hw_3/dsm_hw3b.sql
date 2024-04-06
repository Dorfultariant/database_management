
CREATE OR REPLACE FUNCTION check_habitat() RETURNS TRIGGER AS $$
BEGIN
    IF POSITION((SELECT habitat FROM habitat WHERE NEW.HID = HID) IN (SELECT habitat FROM AnimalSpecies WHERE NEW.AID = AID)) = 0
        THEN
            RAISE EXCEPTION 'Not the correct habitat';
    ELSE
        RAISE NOTICE 'Correct habitat';
    END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION check_temp() RETURNS TRIGGER AS $$
DECLARE
    temp numeric;
    aniTemp numeric;
BEGIN
    SELECT temperature INTO temp FROM Habitat WHERE HID = NEW.HID;
    SELECT temperature INTO aniTemp FROM AnimalSpecies WHERE AID = NEW.AID;

    IF temp NOT BETWEEN (aniTemp - 7) AND (aniTemp + 7)
        THEN
            RAISE EXCEPTION 'The Temperature difference can kill animals';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION check_habitat_temp() RETURNS TRIGGER AS $$
DECLARE
    temp numeric;
    aniTemp numeric;
    specimen record;
BEGIN
    FOR Specimen IN SELECT * FROM Specimen WHERE HID = NEW.HID LOOP
        SELECT temperature INTO temp FROM Habitat WHERE HID = specimen.HID;
        SELECT temperature INTO aniTemp FROM AnimalSpecies WHERE AID = specimen.AID;

        IF temp BETWEEN (aniTemp - 7) AND (aniTemp + 7)
            THEN
                RAISE EXCEPTION 'The Temperature difference can kill animals';
        END IF;
    END LOOP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER temp_check
    BEFORE INSERT OR UPDATE
    ON Specimen
FOR EACH ROW EXECUTE FUNCTION check_temp();


CREATE OR REPLACE TRIGGER habitat_check
    BEFORE INSERT OR UPDATE
    ON Specimen
FOR EACH ROW EXECUTE FUNCTION check_habitat();


CREATE OR REPLACE TRIGGER habitat_temp_check
    BEFORE INSERT OR UPDATE
    ON Habitat
FOR EACH ROW EXECUTE FUNCTION check_habitat_temp();

