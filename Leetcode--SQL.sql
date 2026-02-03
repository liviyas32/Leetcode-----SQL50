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


with abc as
(select id, num, id-row_number() over(partition by num order by id asc) as grp
from logs)

select distinct num as consecutiveNums
from abc
group by grp,num
having count(grp) >=3;


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


-- 2nd February 2026 --
-- #28 1251. Average Selling Price
select p.product_id, round(coalesce(sum(p.price*u.units)/sum(u.units),0),2) as average_price
from prices as p left join unitssold as u
on p.product_id = u.product_id
and u.purchase_date >= p.start_date 
and u.purchase_date <= p.end_date
group by 1;


-- #29 1075. Project Employees I
select p.project_id, round(avg(e.experience_years),2) as average_years
from project as p left join employee as e
on p.employee_id = e.employee_id
group by 1;


-- #30 1633. Percentage of Users Attended a Contest
select contest_id, round(count(distinct r.user_id)/(select count(distinct user_id) from users)*100,2) as percentage
from users as u right join register as r
on u.user_id = r.user_id
group by 1
order by percentage desc, contest_id asc;


-- #31 1211. Queries Quality and Percentage
select query_name, round(avg(rating/position),2) as quality, 
round(sum(case when rating<3 then 1 else 0 end)/count(rating)*100,2) as poor_query_percentage
from queries
group by 1;


-- 3rd February 2026 --
-- #32 1193. Monthly Transactions I
select date_format(trans_date,'%Y-%m') as month, country, 
count(trans_date) as trans_count,
sum(case when state = 'approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from transactions
group by 1,2;


-- #33 1174. Immediate Food Delivery II
with fo_date as
(select customer_id, min(order_date) as first_order
from delivery 
group by 1)

select 
round(sum(case when datediff(customer_pref_delivery_date, fo.first_order) = 0 then 1 else 0 end)/count(d.customer_id)*100,2) as immediate_percentage
from delivery as d join fo_date as fo
on d.customer_id = fo.customer_id and d.order_date = fo.first_order;


-- #34 550. Game Play Analysis IV
with first_login as
(select player_id, min(event_date) as first_date
from activity
group by 1)

select 
round(sum(case when a.player_id is not null then 1 else 0 end)/count(lg.player_id),2) as fraction
from activity as a right join first_login as lg
on a.player_id = lg.player_id and a.event_date = date_add(lg.first_date,interval 1 day


-- #35 2356. Number of Unique Subjects Taught by Each Teacher
select teacher_id, count(distinct subject_id) as cnt
from teacher
group by 1;


-- #36 1141. User Activity for the Past 30 Days I
select activity_date as day, count(distinct user_id) as active_users
from activity
where activity_date between date_sub('2019-07-27', interval 29 day) and '2019-07-27'
group by 1;


-- #37 1070. Product Sales Analysis III
with fy as
(select product_id, min(year) as first_year
from sales
group by 1)

select fy.product_id, fy.first_year, s.quantity, s.price
from fy left join sales as s
on fy.product_id = s.product_id and fy.first_year = s.year;


-- #38 596. Classes With at Least 5 Students
select class
from courses
group by 1
having count(distinct student)>=5;


-- #39 1729. Find Followers Count
select user_id, count(*) as followers_count
from followers
group by 1
order by user_id asc;


-- #40 619. Biggest Single Number
select 
  (select num
from mynumbers
group by 1
having count(*)=1
order by num desc
limit 1) as num;


-- #41 1045. Customers Who Bought All Products
select customer_id
from customer as c right join product as p
on c.product_key = p.product_key
group by 1
having count(distinct c.product_key) = (select count(distinct product_key) from product);


-- #42 1731. The Number of Employees Which Report to Each Employee
select m.employee_id, m.name, count(e.reports_to) as reports_count, round(avg(e.age)) as average_age
from employees as e join employees as m
on e.reports_to=m.employee_id
group by 1
order by 1;
