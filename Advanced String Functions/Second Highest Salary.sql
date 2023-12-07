select max(salary) as secondhighestsalary
from employee
where salary <> (select max(salary) from employee);  

# otherway
select (select salary 
from
(select salary, dense_rank() over(order by salary desc) as ranking
from employee) as et
where ranking = 2
limit 1) as secondhighestsalary
from dual;
