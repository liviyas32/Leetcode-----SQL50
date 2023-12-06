select last_value(person_name) over() as person_name
from 
(select person_id, person_name, weight, turn, sum(weight) over(order by turn) as running_weight
from queue
order by turn) as qt
where running_weight <= 1000
limit 1;
