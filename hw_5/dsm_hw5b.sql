CREATE ROLE trainee WITH LOGIN VALID UNTIL '2023-05-30';
GRANT
    INSERT (orderdate, shippeddate),
    UPDATE (orderdate, shippeddate),
    REFERENCES (orderdate, shippeddate),
    SELECT (orderdate, shippeddate)
ON Orders
    TO trainee;



-- b) Create a new role: trainee. Grant privileges only to columns orderdate and shippeddate to trainee and set the role valid until 30.5.2023.

/*

GRANT SELECT ON ALL TABLES IN SCHEMA public TO db_user;
--ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO db_user;
*/
