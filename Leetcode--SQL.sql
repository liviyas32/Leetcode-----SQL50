-- 28th January 2026 --
-- #1 175. Combine Two Tables --
select firstname, lastname, city, state
from person as p left join address as a
on p.personid = a.personid;


-- #2 176. Second Highest Salary --
select 
(select distinct salary 
from employee
order by salary desc
limit 1 offset 1) as SecondHighestSalary;


-- #3 177. Nth Highest Salary --
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  DECLARE val int;
  SET val = N-1;
  RETURN (
      # Write your MySQL query statement below.
      select distinct salary
      from employee
      order by salary desc
      limit 1 offset val

  );
END


-- #4 178. Rank Scores --
select score, dense_rank() over(order by score desc) as rank 
from scores;


-- #5 180. Consecutive Numbers --
select distinct l1.num as ConsecutiveNums
from logs as l1 join logs as l2 join logs as l3
on l1.num = l2.num and l1.id = l2.id+2
and l1.num = l3.num and l1.id = l3.id+1;


-- #6 181. Employees Earning More Than Their Managers --
select e.name as employee 
from employee as e join employee as m
on e.managerid = m.id
where e.salary>m.salary;


-- #6 182. Duplicate Emails --
select email
from person 
group by 1
having count(email)>1;


-- #7 183. Customers Who Never Order --
select c.name as customers
from customers as c left join orders as o
on c.id = o.customerid
where o.id is null;


-- #8 184. Department Highest Salary --
with abc as
(select d.name as department, e.name as employee, e.salary as salary, dense_rank() over(partition by d.name order by salary desc) as ranking
from employee as e join department as d
on e.departmentid = d.id)

select department, employee, salary
from abc 
where ranking = 1;


select d.name as department, e.name as employee, e.salary as salary
from employee as e join department as d
on e.departmentid = d.id
where e.salary = (select max(salary) 
                  from employee
                  where departmentid = e.departmentid);


-- #9 185. Department Top Three Salaries --
with abc as
(select d.name as department, e.name as employee, e.salary as salary, dense_rank() over (partition by departmentid order by salary desc) as ranking
from department as d join employee as e
on e.departmentid = d.id)

select department, employee, salary
from abc
where ranking < 4;


-- #10 196. Delete Duplicate Emails --
delete a
from person as a, person as b
where a.email = b.email and b.id<a.id;


-- 29th January 2026 --
-- #11 197. Rising Temperature --
select w1.id as id
from weather as w1 join weather as w2
on w1.recorddate = date_add(w2.recorddate, interval 1 day)
and w1.temperature>w2.temperature;


-- #12 262. Trips and Users --
with abc as
(select client_id, driver_id, status, request_at, u.banned as user_banned, ud.banned as driver_banned
from trips as t join users as u join users as ud
on t.client_id=u.users_id and t.driver_id = ud.users_id 
where u.banned = 'No' and ud.banned = 'No'
order by request_at)

select request_at as Day, 
round(sum(case when status = 'cancelled_by_client' or status = 'cancelled_by_driver' then 1 else 0 end)/
count(request_at),2) as `Cancellation Rate`
from abc
where request_at between '2013-10-01' and '2013-10-03'
group by 1
order by 1;


select request_at as Day, 
round(sum(case when status = 'cancelled_by_driver' or status = 'cancelled_by_client' then 1 else 0 end)/count(request_at),2) as `Cancellation Rate`
from trips
where client_id in (select users_id from users where banned='No' and role = 'client')
and driver_id in (select users_id from users where banned='No' and role = 'driver')
and request_at between '2013-10-01' and '2013-10-03'
group by 1
order by 1;


