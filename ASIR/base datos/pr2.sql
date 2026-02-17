use sakila;
-- Ejercicio 1 
SELECT 
    category.name AS category,
    film.title AS title,
    film.length AS length
FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE film.length = (
    SELECT MAX(film2.length)
    FROM film film2
    JOIN film_category film_category2 USING (film_id)
    WHERE film_category2.category_id = film_category.category_id
)
ORDER BY category.name;

-- Ejercicio 2

SELECT 
    COUNT(DISTINCT film.film_id) AS num_unavailable_films
FROM film
WHERE NOT EXISTS (
    SELECT 1
    FROM inventory
    WHERE inventory.film_id = film.film_id
);

-- Ejercicio 3 

SELECT 
    category.name AS category,
    MONTH(payment.payment_date) AS month,
    SUM(payment.amount) AS total
FROM payment
JOIN rental USING (rental_id)
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE YEAR(payment.payment_date) = 2024
GROUP BY category.name, MONTH(payment.payment_date)
ORDER BY category.name, month;

-- Ejercicio 4
SELECT 
	customer_id,
	CONCAT(customer.first_name, customer.last_name) AS customer
FROM 
	customer 
WHERE EXISTS (
    SELECT rental.rental_id
    FROM rental 
    WHERE rental.customer_id = customer.customer_id
)
AND NOT EXISTS (
    SELECT 
		payment.payment_id
    FROM 
		payment
    WHERE payment.customer_id = customer.customer_id
);

-- Ejercicio 5
WITH gasto_por_cliente AS (
    SELECT 
        country.country_id,
        country.country,
        customer.customer_id,
        CONCAT(customer.first_name, ' ', customer.last_name) AS top_customer,
        SUM(payment.amount) AS total_gastado
    FROM payment
    JOIN customer USING (customer_id)
    JOIN address USING (address_id)
    JOIN city USING (city_id)
    JOIN country USING (country_id)
    GROUP BY country.country_id, customer.customer_id
),
max_gasto_por_pais AS (
    SELECT 
        country_id,
        country,
        MAX(total_gastado) AS max_spent
    FROM gasto_por_cliente
    GROUP BY country_id, country
)
SELECT 
    max_gasto_por_pais.country,
    gasto_por_cliente.top_customer,
    max_gasto_por_pais.max_spent
FROM max_gasto_por_pais
JOIN gasto_por_cliente USING (country_id)
WHERE max_gasto_por_pais.max_spent = gasto_por_cliente.total_gastado
ORDER BY max_gasto_por_pais.country;


-- Ejercicio 6
SELECT 
    category.name AS category, SUM(payment.amount) AS total_revenue
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory i USING (film_id)
        JOIN
    rental r USING (inventory_id)
        JOIN
    payment p USING (rental_id)
GROUP BY ca.category_id
HAVING SUM(p.amount) > (SELECT 
        AVG(cat_total)
    FROM
        (SELECT 
            ca2.category_id, SUM(p2.amount) AS cat_total
        FROM
            category ca2
        JOIN film_category fc2 USING (category_id)
        JOIN film f2 USING (film_id)
        JOIN inventory i2 USING (film_id)
        JOIN rental r2 USING (inventory_id)
        JOIN payment p2 USING (rental_id)
        GROUP BY ca2.category_id) AS x)
ORDER BY total_revenue DESC;




