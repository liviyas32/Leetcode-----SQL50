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


-- 30th January 2026 --
-- #13 1757. Recyclable and Low Fat Products
select product_id
from products
where low_fats = 'Y' and recyclable = 'Y';


-- #14 584. Find Customer Referee
select name
from customer
where referee_id<>2 or referee_id is null;


-- #15 595. Big Countries
select name, population, area
from world
where area >= 3000000 or population >= 25000000;


-- #16 1148. Article Views I
select distinct author_id as id
from views
where author_id = viewer_id
order by id asc;


-- #17 1683. Invalid Tweets
select tweet_id
from tweets
where length(content)>15;


-- #18 1378. Replace Employee ID With The Unique Identifier
select eu.unique_id as unique_id, e.name as name
from employees as e left join employeeuni as eu
on e.id=eu.id;


-- #19 1068. Product Sales Analysis I
select product_name, year, price
from sales as s left join product as p
on s.product_id = p.product_id;


-- #20 1581. Customer Who Visited but Did Not Make Any Transactions
select customer_id, count(*) as count_no_trans
from visits as v left join transactions as t
on v.visit_id = t.visit_id
where transaction_id is null
group by customer_id;


-- #21 197. Rising Temperature
select w1.id
from weather as w1 join weather as w2
on w1.recorddate = date_add(w2.recorddate, interval 1 day)
and w1.temperature > w2.temperature;


-- #22 1661. Average Time of Process per Machine
select a1.machine_id, round(sum(a2.timestamp-a1.timestamp)/count(a1.machine_id),3) as processing_time
from activity as a1 inner join activity as a2
on a1.machine_id=a2.machine_id and a1.process_id = a2.process_id
where a1.activity_type = 'start' and a2.activity_type = 'end'
group by a1.machine_id;


-- #23 577. Employee Bonus
select name, bonus
from employee as e left join bonus as b
on e.empid=b.empid
where bonus<1000 or bonus is null;


-- #24 1280. Students and Examinations
select st.student_id, st.student_name, su.subject_name, count(e.subject_name) as attended_exams
from students as st cross join subjects as su left join examinations as e
on st.student_id = e.student_id and su.subject_name = e.subject_name
group by st.student_id, st.student_name, su.subject_name
order by st.student_id, su.subject_name;


-- #25 570. Managers with at Least 5 Direct Reports
select m.name as name
from employee as e join employee as m
on e.managerid=m.id
group by m.name, m.id
having count(*)>=5;


-- #26 1934. Confirmation Rate
select s.user_id, round(coalesce(sum(case when action='confirmed' then 1 else 0 end)/count(c.user_id),0),2) as confirmation_rate
from signups as s left join confirmations as c
on s.user_id = c.user_id
group by 1;


-- #27 620. Not Boring Movies
select id, movie, description, rating
from cinema
where mod(id,2)!=0 and  not description like 'boring'
order by rating desc;


-- #28 1251. Average Selling Price




