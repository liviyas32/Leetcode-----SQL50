select s.machine_id, round(sum(end_time - start_time)/count(s.process_id),3) as processing_time
from
(select machine_id, process_id, activity_type, timestamp as start_time
from activity
where activity_type = 'start') s
join
(select machine_id, process_id, activity_type, timestamp as end_time 
from activity
where activity_type = 'end') e
on s.machine_id = e.machine_id and s.process_id = e.process_id
group by s.machine_id;

#other way
select a.machine_id, round(avg(b.timestamp - a.timestamp),3) as processing_time
from activity a join activity b
on a.machine_id = b.machine_id and a.process_id = b.process_id and b.timestamp>a.timestamp
group by a.machine_id;
