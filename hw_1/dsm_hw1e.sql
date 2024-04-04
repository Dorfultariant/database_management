SELECT n name,
    d purchase_date
    FROM purchases
    WHERE
        EXTRACT(ISODOW FROM d) = 5
    AND
        EXTRACT(DAY FROM d) >= 23
ORDER BY purchase_date;
