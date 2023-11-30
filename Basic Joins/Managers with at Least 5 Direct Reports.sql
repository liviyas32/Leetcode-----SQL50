select e.name
from employee as e
join 
(select managerid, count(*) as direct_reports
from employee
group by managerid
having count(*) >= 5) as m
on e.id = m.managerid;
