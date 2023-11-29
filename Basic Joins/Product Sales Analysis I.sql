select product_name, year, price
from sales as s inner join product as p
on s.product_id = p.product_id
group by sale_id;
