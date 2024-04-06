
CREATE OR REPLACE FUNCTION check_ancestry() RETURNS TRIGGER AS $$
DECLARE
    cnt int;
    parent_gen varchar;
BEGIN
    SELECT gender INTO parent_gen FROM Specimen WHERE EID =
        (SELECT parent FROM Ancestry WHERE NEW.parent = parent);

    SELECT COUNT(*) INTO cnt FROM Ancestry WHERE EID = NEW.EID;
    IF cnt > 1
        THEN RAISE EXCEPTION 'Offspring already has two parents.';
    ELSIF (SELECT gender FROM Specimen WHERE NEW.parent = EID) LIKE parent_gen
        THEN RAISE EXCEPTION 'Offspring already has this gender parent, fix ancestries first.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION check_children() RETURNS TRIGGER AS $$
DECLARE
    p_cnt int;
    c_id int;
    Child record;
BEGIN
    IF NEW.gender IS NULL
        THEN RAISE EXCEPTION 'Parent gender is set to NULL.';
    END IF;
--    SELECT EID INTO c_id FROM Ancestry WHERE parent = NEW.EID;

    FOR Child IN SELECT EID FROM Ancestry WHERE parent = NEW.EID LOOP
        SELECT COUNT(*) INTO p_cnt FROM Ancestry WHERE EID = Child.EID;

        IF p_cnt > 1
            THEN RAISE EXCEPTION 'Offspring already has this gender parent, fix ancestries first.';
        END IF;
    END LOOP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER check_ancestry
    BEFORE INSERT OR UPDATE
    ON Ancestry
FOR EACH ROW EXECUTE PROCEDURE check_ancestry();


CREATE TRIGGER parenting_check
    BEFORE UPDATE OR INSERT
    ON Specimen
FOR EACH ROW EXECUTE PROCEDURE check_children();

