-- 29th January 2026 --
-- #1 Basic Aggregations & Filtering --

-- #6 Find the number of rentals made each month in the year 2005. --
SELECT strftime('%m',rental_date) as rental_month, count(*) as rentals_made
FROM rental
WHERE strftime('%Y',rental_date) = '2005'
GROUP by rental_month
order by rental_month;


-- #7 Determine the average rental duration per film category, considering the rental and return dates. --
