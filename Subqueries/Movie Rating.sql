(select name as results
from users 
group by user_id in (select user_id
                from movierating
                group by user_id
                having count(movie_id) = (select count(movie_id)
                                            from movierating
                                            group by user_id
                                            order by count(movie_id) desc
                                            limit 1))
order by name
limit 1)
union all
(select title as results
from movies
where movie_id in
(select movie_id
from movierating
where month(created_at) = 02 and year(created_at) = 2020
group by movie_id
having avg(rating) = (select avg(rating) 
                        from movierating
                        where month(created_at) = 02 and year(created_at) = 2020 
                        group by movie_id
                        order by avg(rating) desc
                        limit 1))
order by title asc
limit 1);


# other way
(select name as results
from users as u join movierating as mr
on u.user_id = mr.user_id
group by mr.user_id
order by count(mr.movie_id) desc, name asc
limit 1 )
union all
(select title as results
from movies as m join movierating as mr
on m.movie_id = mr.movie_id
where created_at like '2020-02%'
group by mr.movie_id
order by avg(rating) desc, title asc
limit 1);
