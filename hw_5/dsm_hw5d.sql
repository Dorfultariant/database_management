
CREATE OR REPLACE FUNCTION hw5_get_shipping_info(shipn varchar, dat timestamp, moni money) RETURNS TABLE (orderid int, shipname varchar, shipaddress varchar, shipcity varchar, shipcountry varchar) LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
        SELECT O.orderid, O.shipname, O.shipaddress, O.shipcity, O.shipcountry
            FROM ORDERS O
            WHERE O.shipname ILIKE shipn
                AND
                    O.orderdate < dat
                AND
                    (O.freight::numeric BETWEEN (moni::numeric * 0.9) AND (moni::numeric * 1.1));
END;
$$;
