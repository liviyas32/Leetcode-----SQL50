select distinct author_id as id
from
(select author_id, viewer_id, author_id - viewer_id as diff
from views) as temp
where diff = 0
order by id asc;
