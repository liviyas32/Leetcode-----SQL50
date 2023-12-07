select id, count(*) as num
from 
((select requester_id as id
from requestaccepted)
union all
(select accepter_id as id
from requestaccepted)) as rat
group by id
order by num desc
limit 1;
