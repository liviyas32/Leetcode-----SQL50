select class
from
(select class, count(*) as student_count
from courses
group by class
having count(*)>=5) as t;
