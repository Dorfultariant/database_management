SELECT n "name", d "purchase_date" FROM purchases WHERE ((EXTRACT(YEAR FROM d)::integer % 4) = 0) AND (EXTRACT(MONTH FROM d)::integer = 2 OR EXTRACT(MONTH FROM d)::integer = 3) ORDER BY n, d;
