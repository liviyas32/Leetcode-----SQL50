select round(count(*)/(select count(distinct player_id) from activity),2) as fraction
from activity 
where (player_id, date_sub(event_date, interval 1 day)) in
(
    select player_id, min(event_date) 
    from activity 
    group by player_id
);
