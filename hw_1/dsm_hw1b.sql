WITH PS AS (
    SELECT n name,
        MIN(d) "first_purchase",
        MAX(d) "last_purchase"
    FROM purchases
    GROUP BY n
    HAVING MAX(d) - MIN(d) >= 0)
    SELECT PS."name", PS."first_purchase", PS."last_purchase", (PS."last_purchase" - PS."first_purchase") "active_time" FROM PS PS ORDER BY "active_time" DESC, "last_purchase" DESC, "name" DESC;
