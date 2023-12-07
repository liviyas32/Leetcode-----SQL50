select product_name, unit
from products as p join
(select product_id, sum(unit) as unit
from orders 
where order_date like '2020-02%' 
group by product_id
having sum(unit) >= 100) as o on o.product_id = p.product_id;
