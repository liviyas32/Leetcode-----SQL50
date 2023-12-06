(select distinct product_id, first_value(new_price) over(partition by product_id order by change_date desc) as price
from products
where change_date<= '2019-08-16'
order by change_date desc)
union
(select product_id, 10 as new_price
from products
where change_date > '2019-08-16'
and product_id not in (select distinct product_id from products where change_date <= '2019-08-16'));
