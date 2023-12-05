select employee_id, name, reports_count, average_age
from employees as e join 
(select reports_to, count(*) as reports_count, round(avg(age)) as average_age
from employees
where reports_to is not null
group by reports_to) as temp
on e.employee_id = temp.reports_to
group by employee_id, name, reports_count
order by employee_id;
