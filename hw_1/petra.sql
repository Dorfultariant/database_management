SELECT DISTINCT p1.n "p1_name",
    MIN(p1.d) "p1_first_purchase",
    MAX(p1.d) "p1_lastpurchase",
    p2.n "p2_name",
    MIN(p2.d) "p2_first_purchase",
    MAX(p2.d) "p2_lastpurchase"

    FROM Purchases p1
    JOIN purchases p2 ON p1.n < p2.n

    GROUP BY p1.n, p2.n

    HAVING
            MIN(p1.d) <= MAX(p2.d)
        AND
            MAX(p1.d) >= MIN(p2.d)
        AND
            COUNT (*) > 1

ORDER BY p1_name, p2_name;
