

WITH PS AS (
SELECT
    n name,
    MIN(d) first_purchase,
    MAX(d) last_purchase
FROM purchases
    GROUP BY n
    HAVING COUNT(*) > 1
)

SELECT
    PS1.name p1_name,
    PS1.first_purchase p1_first_purchase,
    PS1.last_purchase p1_last_purchase,

    PS2.name p2_name,
    PS2.first_purchase p2_first_purchase,
    PS2.last_purchase p2_last_purchase

FROM PS PS1

JOIN PS PS2
    ON
        PS1."name" < PS2."name"
    AND
        PS1."first_purchase" <= PS2."last_purchase"
    AND
        PS1."last_purchase" >= PS2."first_purchase"

    ORDER BY PS1.name ASC, PS2.name ASC;
