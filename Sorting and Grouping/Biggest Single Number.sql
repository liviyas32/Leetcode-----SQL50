select 
    (select num
        from 
        (select num, count(*) as counter
        from mynumbers
        group by num
        having count(*) = 1
        order by num desc) as numtab
        limit 1) as num
    from dual;
