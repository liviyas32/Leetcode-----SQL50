select s.user_id, round(coalesce(u.confirmed/u.total_actions,0),2) as confirmation_rate
from signups as s
left join
(select user_id, 
count(case when action = 'confirmed' then 1 end) as confirmed,
count(action) as total_actions
from confirmations
group by user_id) as u
on s.user_id = u.user_id;
