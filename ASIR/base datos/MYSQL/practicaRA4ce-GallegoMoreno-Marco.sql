use sakila;

-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.
SELECT 
    first_name,
    last_name,
    actor.actor_id,
    COUNT(film_actor.film_id)
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY film_actor.actor_id;
-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.
SELECT 
    first_name,
    last_name,
    actor.actor_id,
    COUNT(film_actor.film_id) as film_actors
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY film_actor.actor_id having  film_actors > 20;
-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.
SELECT 
    language.name, COUNT(film.film_id)
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY language.name;
-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.
SELECT 
    language.name, COUNT(film.film_id), AVG(film.length) as film_length
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY language.name having film_length > 110 ;
-- 5:  Para cada película, muestra cuántas copias hay en el inventario.
SELECT 
    film.title, COUNT(inventory.film_id) AS film_copies
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY film.title;
-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.
SELECT 
    film.title, COUNT(inventory.film_id) AS film_copies
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY film.title having film_copies >= 5;
-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.
SELECT 
    inventory.inventory_id, COUNT(rental.rental_id) as total_rent
FROM
    inventory
        JOIN
    rental USING (inventory_id)
GROUP BY inventory.inventory_id;
-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.
SELECT 
    customer.first_name,
    rental.customer_id,
    COUNT(rental.rental_id)
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY rental.customer_id;
-- 9:  Lista los clientes con 30 o más alquileres acumulados.
SELECT 
    customer.first_name,
    rental.customer_id,
    COUNT(rental.rental_id) AS total_rent
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY rental.customer_id
HAVING total_rent > 30;
-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.
SELECT 
    first_name, last_name, SUM(payment.amount) AS pay_amount
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY first_name , last_name;
-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.
SELECT 
    first_name, last_name, SUM(payment.amount) AS pay_amount
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY first_name , last_name having pay_amount < 200;
-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.
SELECT 
    first_name, last_name, COUNT(payment_id)
FROM
    staff
        JOIN
    payment USING (staff_id)
GROUP BY first_name , last_name;
-- 13:  Para cada empleado, muestra el importe total procesado.
SELECT 
    first_name, last_name, sum(amount) as amount
FROM
    staff
        JOIN
    payment USING (staff_id)
GROUP BY first_name , last_name;
-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.
SELECT 
    store.store_id, COUNT(inventory.inventory_id) AS inv_id
FROM
    store
        JOIN
    inventory USING (store_id)
GROUP BY store.store_id;
-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.
SELECT 
    store.store_id, count(customer.customer_id)
FROM
    store
        JOIN
    customer USING (store_id)
GROUP BY store.store_id;
-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.
SELECT 
    store.store_id, count(staff.staff_id)
FROM
    store
        JOIN
    staff USING (store_id)
GROUP BY store.store_id;
-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).
SELECT 
    address, count(store.store_id)
FROM
    address
        JOIN
    store USING (address_id)
GROUP BY address;
-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.
SELECT 
    address, count(store.store_id)
FROM
    address
        JOIN
    store USING (address_id)
GROUP BY address;
-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.
SELECT 
    address, count(customer.customer_id) as customer_address
FROM
    address
        JOIN
    customer USING (address_id)
GROUP BY address;
-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.
SELECT 
    city, count(address.address_id) as address
FROM
    city
        JOIN
    address USING (city_id)
GROUP BY city;
-- 21:  Para cada país, cuenta cuántas ciudades existen.
SELECT 
    country, count(city.city_id) as city
FROM
    country
        JOIN
    city USING (country_id)
GROUP BY country;
-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.
SELECT 
    language.language_id, language.name , avg(film.length) as avg_length
FROM
    language
        JOIN
    film USING (language_id)
    GROUP BY language.name, language.language_id having avg_length between 90 and 120;

-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).
SELECT 
    film.title, COUNT(inventory.inventory_id)
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY film.title;
-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).

-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).
-- 26:  Para cada actor, muestra la duración media (length) de sus películas.
-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
-- 28:  Para cada película, cuenta cuántos actores tiene asociados.
-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).
-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.
-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.
-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.
-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.
-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.
-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.
-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).
-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).
-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.
-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.
-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.
-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).
-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).
-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).
-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.
-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.
-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.
-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.
-- 48:  Para cada categoría, suma la duración total (length) de sus películas.
-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.
-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).
-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.
-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.
-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.
-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.
-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.
-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.
-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.
-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).
-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).
-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).
-- 70:  Para cada país, suma los importes pagados por sus clientes.
-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.
-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).
-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.
-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.
-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.
-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).
-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.
-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.
-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.
-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.
-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.
-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.
-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.
-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).
-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).
-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.
-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.
-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.
-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).
-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.
-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.
-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.
-- 94:  Para cada tienda, suma los importes pagados en fines de semana.
-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).
-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.
-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.
-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.
-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.