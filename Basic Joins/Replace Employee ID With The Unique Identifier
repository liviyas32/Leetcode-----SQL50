select t.unique_id, t.name
from
(select e.id, name, eu.unique_id
from employees as e 
left join employeeuni as eu
on e.id = eu.id) as t;
