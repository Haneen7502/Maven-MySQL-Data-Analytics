/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 
select store.store_id,
staff.first_name,
staff.last_name,
address.address,
address.district,
city.city,
country.country
from store
join staff
on store.manager_staff_id = staff.staff_id
join address
on store.address_id = address.address_id
join city
on address.city_id = city.city_id
join country
on city.country_id = country.country_id;	
/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/
select inventory.store_id,
inventory.inventory_id,
film.title,
film.rating,
film.rental_rate,
film.replacement_cost
from inventory
join film
on inventory.film_id = film.film_id;
/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/
select inventory.store_id,
film.rating,
count(inventory.inventory_id) inventory_items 
from inventory
join film
on inventory.film_id = film.film_id
group by film.rating, inventory.store_id;
/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 
select inventory.store_id,
category.name category,
count(film.film_id) number_of_films,
avg(film.replacement_cost) average_replacement_cost ,
sum(film.replacement_cost) total_replacement_cost
from film
join inventory
on film.film_id = inventory.film_id
join film_category
on film.film_id = film_category.film_id
join category
on film_category.category_id = category.category_id
group by inventory.store_id , category.name;
/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/
select customer.first_name,
customer.last_name,
customer.store_id,
customer.active,
address.address,
address.district,
city.city,
country.country
from customer
join address
on customer.address_id = address.address_id
join city
on address.city_id = city.city_id
join country
on city.country_id = country.country_id;	
/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/
select customer.first_name,
customer.last_name,
count(rental.rental_id) lifetime_rentals,
sum(payment.amount) sum_of_payments
from customer
join rental
on customer.customer_id = rental.customer_id
join payment
on rental.rental_id = payment.rental_id
group by  customer.customer_id
order by sum_of_payments desc;
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/
select 
'advisor' type,
first_name,
last_name,
null company_name
from advisor
union
select 'investor' type,
first_name,
last_name, 
company_name
from investor;
/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/


select case when awards = 'Emmy, Oscar, Tony '
then '3 awards'
when awards = 'Emmy' or awards ='Oscar' or awards = 'Tony'
then '1 awards'
when awards = 'Emmy, Oscar' or awards = 'Emmy, Tony' or awards =  'Oscar, Tony'
then '2 awards'
end awards,
avg( case when actor_id is null
then 0
else 1 
end) actor_per
from actor_award
group by 
case when awards = 'Emmy, Oscar, Tony ' 
then '3 awards'
when awards = 'Emmy' or awards ='Oscar' or awards = 'Tony'
then '1 awards'
when awards = 'Emmy, Oscar' or awards = 'Emmy, Tony' or awards =  'Oscar, Tony'
then '2 awards'
end; 

