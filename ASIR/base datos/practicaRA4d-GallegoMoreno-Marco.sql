use sakila;

-- 1 Clientes con al menos un alquiler

SELECT 
    customer_id, first_name, last_name
FROM
    customer
        JOIN
    store USING (store_id)
        JOIN
    rental USING (customer_id) where store_id = 1;
    
-- 2 Todos los clientes y sus alquileres

SELECT 
    customer.customer_id,
    first_name,
    last_name,
    COUNT(rental_id)
FROM
    customer
        LEFT JOIN
    rental USING (customer_id)
GROUP BY customer.customer_id , first_name , last_name;

-- 3 Actores y sus películas

SELECT 
    actor.actor_id, first_name, last_name, COUNT(film_id)
FROM
    actor
        LEFT JOIN
    film_actor USING (actor_id)
         left JOIN
    film USING (film_id)
GROUP BY actor.actor_id , first_name , last_name;

-- 4 Categorías y películas

SELECT 
    category_id, name, film_id, title
FROM
    category
        LEFT JOIN
    film_category USING (category_id)
        LEFT JOIN
    film USING (film_id) 
UNION SELECT 
    category_id, name, film_id, title
FROM
    category
        RIGHT JOIN
    film_category USING (category_id)
        RIGHT JOIN
    film USING (film_id)
WHERE
    category.category_id AND film_id IS NULL
ORDER BY category_id , film_id;

-- 5 Películas y sus actores

SELECT 
    film_id, title, actor_id, first_name, last_name
FROM
    film
        LEFT JOIN
    film_actor USING (film_id)
        LEFT JOIN
    actor USING (actor_id)
ORDER BY film_id , actor_id;
