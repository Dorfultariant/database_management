CREATE OR REPLACE PROCEDURE hw4a_add_days(oid int, cid int, days int) LANGUAGE plpgsql
AS $$
DECLARE
    --VARIABLES
BEGIN
    IF oid != NULL
        THEN
            UPDATE Orders
            SET requireddate = requireddate + days
            WHERE orderid = oid

    ELSE
        UPDATE Orders
        SET requireddate = requireddate + days
        WHERE custid = cid

    COMMIT;
END; $$;



/*
create or replace procedure transfer(
   sender int,
   receiver int,
   amount dec
)
language plpgsql
as $$
begin
    -- subtracting the amount from the sender's account
    update accounts
    set balance = balance - amount
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts
    set balance = balance + amount
    where id = receiver;

    commit;
end;$$;*/
