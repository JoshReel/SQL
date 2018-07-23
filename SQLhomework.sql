-- 1a.
SELECT first_name, last_name
	FROM actor;
    
-- 1b.
SELECT CONCAT (first_name, " ", last_name) AS 'Actor Name'
	FROM actor;
 
--  2a.
SELECT *
	FROM actor
    WHERE first_name = 'Joe';
 
-- 2b.
SELECT first_name, last_name
	FROM actor
    WHERE last_name LIKE '%GEN%';
    
-- 2c.
SELECT last_name, first_name
	FROM actor
    WHERE last_name LIKE '%LI%';
    
-- 2d.
SELECT country_id, country
	FROM country
    WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
    
-- 3a.
ALTER TABLE actor
	ADD middle_name VARCHAR(50) AFTER first_name;
    
-- 3b.
ALTER TABLE actor
	MODIFY COLUMN middle_name BLOB;
    
-- 3c.
ALTER TABLE actor
	DROP middle_name;
    
-- 4a.
SELECT last_name, COUNT(DISTINCT last_name) AS number_actors
	FROM actor
    GROUP BY 1;

-- 4b.
SELECT last_name, COUNT(*) AS number_actors
	FROM actor
    GROUP BY last_name
    HAVING count(*) >= 2;
    
-- 4c.
UPDATE actor
	SET first_name = 'Harpo'
	WHERE first_name = 'Groucho'; 

-- 4d.***DONT UNDERSTAND THE QUESTION***
UPDATE actor
	SET first_name = 'Groucho'
	WHERE first_name = 'Harpo';
    
-- 5a.
SHOW CREATE TABLE address;

-- 6a.
SELECT s.first_name, s.last_name, a.address
	FROM staff s
	JOIN address a ON a.address_id = s.address_id;

-- 6b.***
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount)
	FROM staff s
	JOIN payment p ON p.staff_id = s.staff_id 
	AND p.payment_date LIKE '2005-08';
    
-- 6c.
SELECT f.title, SUM(a. actor_id) AS number_actors
	FROM film_actor a
    JOIN film f ON f.film_id = a.film_id
    GROUP BY f.title;
    
-- 6d.
SELECT f.title, SUM(i.inventory_id) AS total_copies
	FROM inventory i
	JOIN film f ON f.film_id = i.film_id
	WHERE title = 'Hunchback Impossible';

-- 6e.
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_paid
	FROM customer c
	JOIN payment p ON p.customer_id = c.customer_id
	GROUP BY c.customer_id
	ORDER BY c.last_name;

-- 7a.
SELECT title
	FROM film
	WHERE title LIKE 'K%' OR title LIKE 'Q%'
	AND title IN ( 
SELECT title
	FROM film 
	WHERE language_id = 'English'); 

-- 7b.
SELECT first_name, last_name
	FROM actor
	WHERE actor_id IN (
SELECT actor_id
	FROM film_actor
	WHERE film_id IN (
SELECT film_id
	FROM film
    WHERE title = 'Alone Trip'));

-- 7c.
SELECT c.first_name, c.last_name, c.email
	FROM customer c
	JOIN address a ON (a.address_id = c.address_id)
	JOIN city ct ON (ct.city_id = a.city_id)
	JOIN country cnt ON (cnt.country_id = ct.country_id)
	WHERE cnt.country = 'Canada';

-- 7d.
SELECT title, description
	FROM film WHERE film_id IN (
SELECT film_id
	FROM film_category
	WHERE category_id IN (
SELECT category_id
	FROM category
	WHERE name = 'family'));

-- 7e.
SELECT f.title, COUNT(rental_id) as 'Number Rented'
	FROM rental r
    JOIN inventory i ON (i.inventory_id = r.inventory_id)
    JOIN film f ON (f.film_id = i.film_id)
    GROUP BY f.title
    ORDER BY 2 DESC;
    
-- 7f.
SELECT s.store_id, SUM(amount) as 'Total Dollars'
	FROM payment p
	JOIN rental r ON (p.rental_id = r.rental_id)
	JOIN inventory i ON (i.inventory_id = r.inventory_id)
	JOIN store s ON (s.store_id = i.store_id)
	GROUP BY s.store_id;
    
-- 7g.
SELECT s.store_id, ct.city, cnt.country
	FROM store s
	JOIN address a ON (s.address_id = a.address_id)
	JOIN city ct ON (ct.city_id = a.city_id)
	JOIN country cnt ON (cnt.country_id = ct.country_id);
    
-- 7h.
SELECT c.name AS 'Genre', SUM(p.amount) AS 'Total Dollars'
	FROM category c
    JOIN film_category fc ON (c.category_id = fc.category_id)
    JOIN inventory i ON (fc.film_id = i.film_id)
    JOIN rental r ON (i.inventory_id = r.inventory_id)
    JOIN payment p ON (r.rental_id = p.rental_id)
    GROUP BY c.name
    ORDER BY 2 DESC
    LIMIT 5;
    
-- 8a.
CREATE VIEW top_five_genres AS
SELECT c.name AS 'Genre', SUM(p.amount) AS 'Total Dollars'
	FROM category c
    JOIN film_category fc ON (c.category_id = fc.category_id)
    JOIN inventory i ON (fc.film_id = i.film_id)
    JOIN rental r ON (i.inventory_id = r.inventory_id)
    JOIN payment p ON (r.rental_id = p.rental_id)
    GROUP BY c.name
    ORDER BY 2 DESC
    LIMIT 5;
    
-- 8b.
SELECT *
	FROM top_five_genres;
    
-- 8c.
DROP VIEW top_five_genres;