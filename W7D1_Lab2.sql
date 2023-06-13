#Here are for each store its store ID, city, and country.

SELECT
	s.store_id as "store_id",
    ci.city as "city",
    c.country as "country"
FROM store s
LEFT JOIN address a ON s.address_id = a.address_id
LEFT JOIN city ci ON a.city_id = ci.city_id
LEFT JOIN country c ON ci.country_id = c.country_id;

#Here is the amount of business in dollars each store brought in.

SELECT
	i.store_id as store_id,
    sum(p.amount) as amount_dollars
FROM rental r
JOIN payment p ON p.rental_id = r.rental_id
JOIN inventory i ON i.inventory_id = r.inventory_id
GROUP BY i.store_id;

#Here is the average running time of films by category?

SELECT
	fc.category_id as category,
    avg(f.length) as avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY fc.category_id;

#Which film categories are longest?

SELECT
	fc.category_id as category,
    avg(f.length) as avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY fc.category_id
ORDER BY avg(f.length) desc
LIMIT 1;

#Display the 10 most frequently rented movies in descending order.

SELECT 
	f.film_id,
    count(r.rental_id) as Nb_rentals 
FROM rental r
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY count(r.rental_id) desc
LIMIT 10;

#List the top five genres in gross revenue in descending order.

SELECT
	c.name as name,
    sum(p.amount) as revenue
FROM payment p
LEFT JOIN rental r ON p.rental_id = r.rental_id
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN film_category fc ON i.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY sum(p.amount) desc
LIMIT 5;

#Is "Academy Dinosaur" available for rent from Store 1?

SELECT
	i.inventory_id,
    f.film_id,
	f.title,
    r.rental_date,
    f.rental_duration,
    r.return_date
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE f.title = "Academy Dinosaur" AND i.store_id = "1"
ORDER BY r.rental_date desc;

SELECT *
FROM inventory;

SELECT *
FROM rental;