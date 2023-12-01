select query_name, round(sum(rating/position)/count(query_name),2) as quality, 
round(count(case when rating < 3 then 1 end)/count(query_name)*100,2) as poor_query_percentage
from queries
group by query_name;
