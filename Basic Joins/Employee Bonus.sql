select name, bonus
from employee as e left join bonus as b
on e.empid = b.empid
where coalesce(bonus,0)<1000;
