select
    p1_name,
    p1_first_purchase,
    p1_last_purchase,
    p2_name,
    p2_first_purchase,
    p2_last_purchase
from purchases t1
    INNER join (select t3.n as p2_name, t3.d as p2_first_purchase, t4.d as p2_last_purchase from purchases t3 INNER join purchases t4 ON t3.n = t4.n where t3.d < t4.d)
ON p1_name < p2_name and
((p1_first_purchase BETWEEN p2_first_purchase and p2_last_purchase)
 or (p1_last_purchase BETWEEN p2_first_purchase and p2_last_purchase)
 or (p2_first_purchase BETWEEN p1_first_purchase and p1_last_purchase)
 or (p2_last_purchase BETWEEN p1_first_purchase and p1_last_purchase))
order by p1_name, p2_name;
