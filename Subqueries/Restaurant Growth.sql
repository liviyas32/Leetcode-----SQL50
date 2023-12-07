select visited_on, amount, round(amount/7,2) as average_amount
from
(select distinct visited_on, sum(amount) over(order by visited_on range between interval 6 day preceding and current row) as amount
from customer
order by visited_on) as ct
where visited_on in (select date_add(visited_on, interval 6 day) from customer);
