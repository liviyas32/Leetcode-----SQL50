#subquery
select id
from
(select id, recorddate, temperature, lag(temperature) over(order by recorddate) as next_day_temp, 
case when lag(temperature) over(order by recorddate) < temperature then 1 else 0 end as diff
from weather
group by id, recorddate, temperature) as temp
where diff = 1;

#self join
select distinct b.id
from weather a, weather b
where (b.temperature>a.temperature) and datediff(b.recorddate,a.recorddate) = 1;
