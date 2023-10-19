--1. List all customers who live in Texas (use JOINs)
select first_name, last_name, district
from customer c
join address a
on a.address_id = c.address_id
where a.district = 'Texas';

--2. List all payments of more than $7.00 with the customer’s first and last name
select first_name, last_name, amount
from customer c
join payment p on p.customer_id = c.customer_id
where amount > 7.00
;

--3. Show all customer names who have made over $175 in payments (use
--subqueries)
select *
from customer where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
);

--4. List all customers that live in Argentina (use the city table)
select first_name, last_name, country
from customer c
join address a
on c.address_id = a.address_id
join city c2
on c2.city_id = a.city_id
join country c3 
on c3.country_id = c2.country_id
where c3.country = 'Argentina';

--5. Show all the film categories with their count in descending order
select f.category_id, c.name , count(*) as num_movies_in_cat
from film_category f
join category c
on c.category_id = f.category_id 
group by  f.category_id, c.name order by count(*) DESC
;

--6. What film had the most actors in it (show film info)?
select count(*), film_id from film_actor
group by film_id order by count(*) desc limit 1;

select title, film_id  from film 
where film_id in (
	select film_id from film_actor
	group by film_id order by count(*) desc limit 1
);
--Lambs Cincinatti
--7. Which actor has been in the least movies?
select count(actor_id), actor_id  from film_actor
group by  actor_id
order by count(actor_id) 
;
--8. Which country has the most cities?
select  distinct country_id
from city;

select  c.country, count(city) as num_cities
from city c1
join country c
on c.country_id  = c1.country_id
group by country
order by num_cities desc
;
--9. List the actors who have been in between 20 and 25 films.
select a.actor_id, first_name, last_name, count(*)
from actor a
join film_actor fa 
on a.actor_id = fa.actor_id 
join film f 
on f.film_id = fa.film_id
group by a.actor_id 
having count(*) between 20 and 25
order by count(*) desc
;
