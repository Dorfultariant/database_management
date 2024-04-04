SELECT
    p1.n AS p1_name,
    MIN(p1.d) AS p1_first_purchase,
    MAX(p1.d) AS p1_last_purchase,

    p2.n AS p2_name,
    MIN(p2.d) AS p2_first_purchase,
    MAX(p2.d) AS p2_last_purchase

    FROM
        purchases p1
    JOIN purchases p2 ON p1.n != p2.n
    WHERE
            (SELECT MIN(d) FROM purchases WHERE n = p1.n)
        BETWEEN
            (SELECT MIN(d) FROM purchases WHERE n = p2.n)
        AND
            (SELECT MAX(d) FROM purchases WHERE n = p2.n)
    GROUP BY
        p1_name, p2_name

    HAVING
        COUNT(DISTINCT p1.d) > 1 AND COUNT(DISTINCT p2.d) > 1

    ORDER BY
        p1_name;


        --         THE OTHER WAY AROUND :-) (SELECT MIN(d) FROM purchases WHERE n = p2.n) BETWEEN (SELECT MIN(d) FROM purchases WHERE n = p1.n) AND (SELECT MAX(d) FROM purchases WHERE n = p1.n)
