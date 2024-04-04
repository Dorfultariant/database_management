
CREATE FUNCTION specimen_valid_age() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.BirthDate > (
        SELECT BirthDate FROM Specimen WHERE EID = (
            SELECT EID FROM Ancestry WHERE parent = NEW.EID
            )
        )
        THEN
            RAISE EXCEPTION 'Has older offsprings, fix ancestries first.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION ancestry_valid_age() RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT BirthDate FROM Specimen WHERE EID = NEW.EID)
        <
        (SELECT BirthDate FROM Specimen WHERE EID = NEW.parent)
        THEN
            RAISE EXCEPTION 'Has older offsprings, fix ancestries first.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER specimen_correct_age
    BEFORE INSERT OR UPDATE
    ON Specimen
FOR EACH ROW EXECUTE PROCEDURE specimen_valid_age();


CREATE TRIGGER ancestry_correct_age
    BEFORE INSERT OR UPDATE
    ON Ancestry
FOR EACH ROW EXECUTE PROCEDURE ancestry_valid_age();
