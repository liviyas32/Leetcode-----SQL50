select product_id, round(coalesce(sum(selling_price)/sum(units),0),2) as average_price
from
(select p.product_id as product_id, purchase_date, units, price, units*price as selling_price
from prices as p left join unitssold as u
on p.product_id = u.product_id and u.purchase_date >= p.start_date and u.purchase_date <= p.end_date
group by p.product_id, purchase_date
order by p.product_id, purchase_date) as price_sold
group by product_id;
