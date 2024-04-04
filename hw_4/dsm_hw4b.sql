CREATE OR REPLACE PROCEDURE hw4b_add_freight() LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Orders
    SET freight = ROUND((freight::numeric * 1.10), 2)::money;
    COMMIT;
END; $$;

