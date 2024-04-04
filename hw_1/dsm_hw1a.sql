SELECT p1.n AS "name",
    p2.i AS "item_1",
    p2.d AS "purchase_date_1",
    p1.i AS "item_2",
    p1.d AS "purchase_date_2"
FROM purchases p2
    JOIN purchases p1 ON p1.n = p2.n
    WHERE AGE(p1.d, p2.d) = INTERVAL '1 month'
        --AND
        --EXTRACT(DAY FROM p1.d) = EXTRACT(DAY FROM p2.d)
ORDER BY "name";
