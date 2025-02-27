-- 1.Could you pull a list of the first name, last name, and email of each of our customers?
select first_name,
last_name,
email
from customer;
-- 2.Could you pull the records of our films and see if there are any other rental durations?
select distinct rental_duration
from film;
-- 3.Could you pull all payments from our first 100 customers (based on customer ID)?
select *
from payment
where customer_id <= 100;
-- 4.Now I’d love to see just payments over $5 for those same customers, since January 1, 2006.
select *
from payment
where customer_id <= 100 and 
amount>5 and 
payment_date >= '2006-01-01';
-- 5.Now, could you please write a query to pull all payments from those specific customers,along with payments over $5, from any customer?
select *
from payment
where customer_id in (42,53,60,75) or 
amount>5 ;
-- 6.Could you pull a list of films which include a Behind the Scenes special feature?
select *
from film
where special_features like '%Behind the Scenes%';
-- 7.Could you please pull a count of titles sliced by rental duration?
select count(title) as Number_of_Films,
rental_duration
from film
group by rental_duration;
-- 8.Can you help me pull a count of films, along with the average, min, and max rental rate, grouped by replacement cost?
select count(film_id)  films,
avg(rental_rate) average_rental_rate,
min(rental_rate) min_rental_rate,
max(rental_rate)max_rental_rate ,
replacement_cost
from film 
group by replacement_cost;
-- 9.Could you pull a list of customer_ids with less than 15 rentals all-time?
select customer_id, count(rental_id) rentals
from rental
group by customer_id
having rentals<15;
-- 10.Could you pull me a list of all film titles along with their lengths and rental rates, and sort them from longest to shortest?
select title,length,rental_rate
from film
order by length desc;
-- 11. Could you pull a list of first and last names of all customers, and label them as either ‘store 1 active’, ‘store 1 inactive’, ‘store 2 active’, or ‘store 2 inactive’?
select first_name,
last_name,
case
when store_id = 1 and active = 1
then 'store 1 active'
when store_id = 1 and active = 0
then 'store 1 inactive'
when store_id = 2 and active = 1
then 'store 2 active'
when store_id = 2 and active = 0
then 'store 2 inactive'
else 'error'
end as store_status
from customer;
-- 12.Could you please create a table to count the number of customers broken down by store_id(in rows), and active status (in columns)?
select store_id,
count(case when active = 1 then customer_id else null end) as active, 
count(case when active = 0 then customer_id else null end )as inactive 
from customer
group by store_id;
-- 13.Can you pull for me a list of each film we have in inventory? 
select distinct 
inventory.inventory_id,
inventory.store_id,
film.title,
film.description
from film
inner join inventory
on film.film_id = inventory.film_id;
-- 14.Can you pull a list of all titles, and figure out how many actors are associated with each title?
select film.title,
count(film_actor.actor_id)  actors
from film
left join film_actor
on film.film_id = film_actor.film_id
group by film.title;
-- 15.It would be great to have a list of all actors, with each titlethat they appear in. Could you please pull that for me?
select actor.first_name,
actor.last_name,
film.title
from actor
join film_actor
on actor.actor_id = film_actor.actor_id
join film
on film_actor.film_id = film.film_id;
-- 16.Could you pull a list of distinct titles and their descriptions, currently available in inventory at store 2?
select distinct
film.title,
film.description
from film
join inventory
on film.film_id = inventory.film_id
and inventory. store_id = 2;
-- 17.Could you pull one list of all staff and advisor names, and include a column noting whether they are a staff member or advisor?
select 'advisor' type,
first_name,
last_name
from advisor
union
select 'staff' type,
first_name,
last_name
from staff;