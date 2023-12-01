select contest_id, round(contest_users/total_users*100,2) as percentage
from
(select contest_id, count(r.user_id) as contest_users, 
(select count(distinct user_id) from users) as total_users
from users as u join register as r on u.user_id = r.user_id
group by contest_id) as user_registry
order by percentage desc, contest_id asc;
