-- 1.Retrive the total number of rental made in the sakila database --
SELECT COUNT(*) AS TotalRentals FROM rental;

-- 2.Find the average rental duration(in days) of movies rented from the sakila database.--
SELECT AVG(DATEDIFF(return_date, rental_date)) AS AvgRentalDuration FROM rental;

-- 3.Display the first name and last name of customers in uppercase.--
SELECT UPPER(first_name) AS UpperFirstName, UPPER(last_name) AS UpperLastName FROM customer;

-- 4.Extract the month from the rental date and display it alongside the rental ID.--
SELECT rental_id, MONTH(rental_date) AS RentalMonth FROM rental;

-- 5.Retrive the count of rentals of each customer(Display customer ID and the count of rentals).--
SELECT customer_id, COUNT(*) AS RentalCount FROM rental GROUP BY customer_id;

-- 6.Find the total revenue generated by each store.--
SELECT SUM(amount) AS TotalRevenue FROM payment;

-- 7.Dispaly the title of the movie,customer's first name , and last name who rented it.--
SELECT film.title AS MovieTitle, customer.first_name AS FirstName, customer.last_name AS LastName
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id;

-- 8.Retrive the name of all actors who have appered in the film "Gone with the wind".--
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Gone with the Wind';


-- GROUP BY:.--
-- 1.Determine the total number of rentals of each category of movies.--
SELECT film_category.category_id, COUNT(rental.rental_id) AS RentalCount
FROM film_category
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film_category.category_id;

-- 2.Find the average rental rate of movies in each langage.--
SELECT language.name AS Language, AVG(film.rental_rate) AS AvgRentalRate
FROM film
JOIN language ON film.language_id = language.language_id
GROUP BY language.name;


-- 3.Retrieve the customer names along with the total amount they've spent on rentals.--
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS TotalAmountSpent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
JOIN rental ON payment.rental_id = rental.rental_id
GROUP BY customer.customer_id;

-- 4.List the titles of movies rented by each customer in a particular city (e.g., 'London').--
SELECT customer.first_name, customer.last_name, film.title
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE city.city = 'London';

-- 5.Display the top 5 rented movies along with the number of times they've been rented.--
SELECT film.title, COUNT(rental.rental_id) AS RentalCount
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY RentalCount DESC
LIMIT 5;

-- 6.Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).--
SELECT customer_id
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
WHERE inventory.store_id IN (1, 2)
GROUP BY customer_id
HAVING COUNT(DISTINCT inventory.store_id) = 2;
