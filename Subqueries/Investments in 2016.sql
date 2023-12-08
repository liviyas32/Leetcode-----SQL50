select round(sum(a.tiv_2016),2) as tiv_2016
from insurance a 
where a.tiv_2015 in (select tiv_2015
                    from insurance b
                    where a.pid<>b.pid)
and (a.lat,a.lon) not in (select lat,lon
                    from insurance c
                    where a.pid<>c.pid);
