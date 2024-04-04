
CREATE FUNCTION check_ancestry() RETURNS TRIGGER AS $$
DECLARE
    fSize numeric;
    fspaceReq numeric;
    fspaceUsed numeric;
BEGIN
    SELECT Size INTO fSize FROM Habitat WHERE HID = NEW.HID;
    SELECT spaceRequirements INTO fspaceReq FROM AnimalSpecies WHERE AID = NEW.AID;
    SELECT SUM(a.spaceRequirements) INTO fspaceUsed
        FROM Specimen s
        JOIN AnimalSpecies a ON a.AID = s.AID
        WHERE NEW.HID = s.HID;

    IF fSize < (fspaceReq + fspaceUsed)
        THEN RAISE WARNING '% Compound is overbooked by % / %', NEW.HID, fspaceUsed+fspaceReq, fSize;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION check_parents() RETURNS TRIGGER AS $$
DECLARE
    fSize numeric;
    fspaceReq numeric;
    fspaceUsed numeric;
BEGIN
    SELECT Size INTO fSize FROM Habitat WHERE HID = NEW.HID;
    SELECT spaceRequirements INTO fspaceReq FROM AnimalSpecies WHERE AID = NEW.AID;
    SELECT SUM(a.spaceRequirements) INTO fspaceUsed
        FROM Specimen s
        JOIN AnimalSpecies a ON a.AID = s.AID
        WHERE NEW.HID = s.HID;

    IF fSize < (fspaceReq + fspaceUsed)
        THEN RAISE WARNING '% Compound is overbooked by % / %', NEW.HID, fspaceUsed+fspaceReq, fSize;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER parenting_check
    BEFORE INSERT OR UPDATE
    ON Specimen
FOR EACH ROW EXECUTE PROCEDURE check_parents();


CREATE TRIGGER check_ancestry
    BEFORE INSERT OR UPDATE
    ON Ancestry
FOR EACH ROW EXECUTE PROCEDURE check_ancestry();
