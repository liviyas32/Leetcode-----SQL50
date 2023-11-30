select project_id, round(coalesce(sum(experience_years)/count(project_id),0),2) as average_years
from
(select e.employee_id, e.name, e.experience_years, p.project_id
from project as p join employee as e
on p.employee_id = e.employee_id) as t
group by project_id;
