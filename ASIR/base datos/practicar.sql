use tienda_online;
-- Lista todos los clientes
select * from clientes;
-- Muestra todos los productos
select * from productos;
-- Encuentra clientes de España
select * from clientes where pais ="España";
-- Lista productos con precio menor a 50
SELECT * FROM productos WHERE precio > 50;
-- Muestra clientes cuyo nombre empiece con "A"
select * from clientes where nombre like("A%");
-- Cuenta cuántos clientes hay
select count(nombre) as cantidad_clientes from clientes;
-- Encuentra el precio máximo de los productos
select MAX(precio) AS PRECIO_MAX from productos;
-- Lista los 5 productos más caros
select * from productos order by precio Desc limit 5;
-- Muestra clientes registrados después de 2025-01-01
select * from clientes where fecha_registro > "2025-01-01";
-- Cuenta productos por categoría que contenga "Electr"
SELECT 
    categoria, COUNT(nombre) AS cant_prod
FROM
    productos
WHERE
    categoria like("Elect%") group by categoria;
-- Lista productos entre 20 y 100 euros
select * from productos where precio between 20 and 100;
-- Encuentra clientes cuyo email termine en "gmail.com"
select * from clientes where email like("%gmail.com");
-- Muestra el nombre del producto más barato
select nombre from productos order by precio desc limit 1;
-- Cuenta pedidos con total mayor a 200
select count(id_pedido) as A from pedidos where A >200;
-- Lista productos ordenados por precio descendente
-- Encuentra clientes cuyo nombre tenga más de 8 caracteres
-- Muestra el año de los pagos más recientes
-- Cuenta productos cuyo precio no sea NULL
-- Lista detalles de pedido con cantidad mayor a 2
-- Encuentra el día de la semana del pedido más antiguo
-- Muestra el salario promedio por... espera, total promedio de pagos
-- Lista categorías en mayúsculas
-- Cuenta productos únicos por stock
-- Encuentra productos cuyo nombre contenga "phone" o "Phone"
-- Redondea a 2 decimales el precio mínimo de productos
-- Muestra el nombre del cliente con ID 5 en minúsculas
-- Cuenta detalles de pedido por producto que superen 100 unidades totales
-- Encuentra meses con más de 3 pagos realizados
-- Lista productos cuya descripción tenga exactamente 10 caracteres
-- Muestra categorías con más de 5 productos, ordenadas por cantidad descendente

