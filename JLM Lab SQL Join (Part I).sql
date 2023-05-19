-- Lab | SQL Join (Part I)

USE sakila;

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT c.name as category_name, COUNT(fc.film_id) as number_of_films
FROM category c
JOIN film_category fc
USING (category_id)
GROUP BY category_name;

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT stf.first_name, SUM(py.amount) as total_amount
FROM staff stf
JOIN payment py
USING (staff_id)
WHERE date(py.payment_date) LIKE '2005-08-%'
GROUP BY stf.first_name;

-- 3. Which actor has appeared in the most films?
#WHY THE BELOW ONE DOES NOT WORK?
SELECT  ac.first_name, ac.last_name, COUNT(fi.film_id) AS number_of_films_the_actor_appears
FROM actor ac
JOIN film fi ON ac.last_update = fi.last_update
GROUP BY ac.first_name, ac.last_name
ORDER BY number_of_films DESC
LIMIT 1;
#WHY THE ABOVE ONE DOES NOT WORK?

SELECT ac.first_name, ac.last_name, COUNT(fi.film_id) AS number_of_films
FROM actor ac
JOIN film_actor fa ON ac.actor_id = fa.actor_id
JOIN film fi ON fa.film_id = fi.film_id
GROUP BY ac.actor_id, ac.first_name, ac.last_name
ORDER BY number_of_films DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentals DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, address_id
FROM staff;

-- 6. List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(a.actor_id) AS number_of_actors
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.title;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT cu.first_name, cu.last_name, SUM(py.amount) AS total_paid
FROM customer cu
JOIN payment py ON cu.customer_id = py.customer_id
GROUP BY cu.customer_id, cu.first_name, cu.last_name
ORDER BY cu.last_name;


-- 8. List number of films per category.
-- See Exercise 1.