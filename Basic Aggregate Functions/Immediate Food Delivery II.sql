select round(sum(case when datediff(order_date, customer_pref_delivery_date) = 0 then 1 else 0 end)/count(*)*100,2) as immediate_percentage
from
(select *, row_number() over(partition by customer_id order by order_date asc) as ranking
from delivery) as t
where ranking = 1;
