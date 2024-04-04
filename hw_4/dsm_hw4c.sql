CREATE OR REPLACE PROCEDURE hw4c_round_freight() LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Orders
    SET freight = (ROUND((freight::numeric / 10), 0)*10)::money;
    COMMIT;
END; $$;



-- 124.045 / 10 = 12.4045
