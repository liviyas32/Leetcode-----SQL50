select id,
case when mod(id,2)<>0 then coalesce(odd, student) 
    else even end as student
from
(select id, student, lead(student) over() as odd, lag(student) over() as even
from seat
order by id) as st;
