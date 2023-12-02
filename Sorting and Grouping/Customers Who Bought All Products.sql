select customer_id
from
(select customer_id, count(distinct product_key) as counter
from customer
group by customer_id) as cp
where counter = (select count(distinct product_key) from product);
