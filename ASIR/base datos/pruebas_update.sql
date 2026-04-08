USE erp_logistica;
select * from categorias;
select * from clientes;
select * from pedidos;
select * from productos;

-- ejercicio 1
-- ver que esta mal
select nombre_completo from clientes where nombre_completo like '%';
select count(nombre_completo) from clientes where nombre_completo like '%';
-- 2) intetar arreglarlo
SET SQL_SAFE_UPDATES=0;
update clientes set nombre_completo = TRIM(nombre_completo);
SET SQL_SAFE_UPDATES=1;
-- 3) COMPROBAR QUE ESTA BIEN
select nombre_completo from clientes where nombre_completo like '%';
select nombre_completo from clientes;


-- eJERCICIO 2
-- 1) que esta mal?
select email from clientes;
-- 2) Intetar arreglarlo
SET SQL_safe_UPDATEs = 0;
UPDATE clientes 
SET 
    email = REPLACE(email, '.con', '.com')
WHERE
    email LIKE '%@%';
SET SQL_safe_UPDATEs = 1;
-- 3) COmprobar que estan bien
SELECT 
    email
FROM
    clientes;
    
-- 3 telefonos

select telefono from clientes;

-- update clientes set telefono = REPLACE(telefono, ' ', '');
-- QWupdate clientes set telefono = REPLACE(telefono, '-', '');
SET SQL_safe_updates = 0;
update clientes set telefono = REPLACE(REPLACE(telefono, '-', ''), '-', '');
UPDATE clientes set telefono = REPLACE(REPLACE(telefono, '0024',''), '+34', '') where telefono like '0034%';
update clientes set telefono = substring(telefono,5,9) where telefono like '0034%';
update clientes set telefono= replace(telefono,'+34', '') where telefono like '+34%';
update clientes set telefono = TRIM(telefono);
SET SQL_safe_updates = 1;

select replace ('003460034','0034','');
select substring('0034600777888','');


-- ej 4

select * from pedidos;

SET SQL_SAFE_UPDATES = 0;
update pedidos set estado= UPPER(estado);
SET SQL_SAFE_UPDATES = 1;

-- ej 5


CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio_sucio` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio_oferta` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

explain productos;

ALTER TABLE productos
	ADD COLUMN precio_en_proceso VARCHAR(50);
explain productos;


select * from productos;
SET SQL_SAFE_UPDATES = 0;
update productos set precio_sucio= replace(precio_sucio,'$', '');
SET SQL_SAFE_UPDATES = 1;


START transaction;  -- todos los cambios de modificacion (DML) son temporales hasta el commit o reversibles
SAVEPOINT guardar_partida;
update productos set precio_sucio= replace(precio_sucio,'€', '');
update productos set precio_sucio= replace(precio_sucio,'$', '');
update productos set precio_sucio= replace(precio_sucio,',', '.');
update productos set precio_sucio= replace(precio_sucio,' ', '');
update productos set precio_sucio= replace(precio_sucio,'EUR', '');
update productos set precio_sucio= replace(precio_sucio,'Gratis', '0.00');
commit;
rollback TO guardar_partida;
select * from productos;
 
select * from productos;
SET SQL_SAFE_UPDATES = 1; -- BLOQUEA TODOS LOS UPDATES QUE TIENEN QUE IR LIEA POR LINEA PARA MODIFICARLA

-- ejercicio 9

explain productos;
select * from productos;
alter table productos
	change column precio_sucio precio DECIMAL(10,2);
explain productos;

-- modidy cambia el tipop de dato de varchar
-- rename cambia el nombre
-- change cambia ambas

-- ej 10
show tables;
select STR_TO_DATE('3-5-2027','%d-%m-%Y');
select STR_TO_DATE('3-5-2027','%m-%d-%Y');
select STR_TO_DATE('3-5-27','%m-%d-%y'); -- 27 es 2027
select STR_TO_DATE('3-5-70','%m-%d-%y'); -- 1970
select STR_TO_DATE('3-5-69','%m-%d-%y'); -- 2069
SET SQL_SAFE_UPDATES = 0;
update pedidos
	set fecha_texto = STR_TO_DATE(fecha_texto,'%d/%m/%Y')
    /* where fecha_texto LIKE '__/__/____' 
		OR fecha_texto LIKE '_/_/____'
        OR fecha_texto LIKE '_/__/____'
        OR fecha_texto LIKE '__/_/____'; */
	where fecha_texto like '%/%/____'; -- este filtro es fundamental 
UPDATE pedidos
set fecha_texto = STR_TO_DATE(fecha_texto,'%d-%m-%Y')
where fecha_texto like '%-%-____'; -- este filtro es fundamental 
UPDATE pedidos
set fecha_texto = STR_TO_DATE(fecha_texto,'%Y.%m.%d')
where fecha_texto like '____.%.%'; -- este filtro es fundamental
SET SQL_SAFE_UPDATES=1; 


-- Cambiar tipo de dato
ALTER TABLE pedidos
		CHANGE COLUMN fecha_texto fecha DATE;
explain pedidos;


-- 11) PRODUCTOS HUERFANOS

select * from productos;
select * from categorias;

UPDATE productos
	SET categoria_id = 4 WHERE id=4;
    
    
-- ¿ como se hace de forma general?
-- 1) ¿que productos estan huerfanos?

SELECT 
    *
FROM
    productos
        LEFT JOIN
    categorias ON productos.categoria_id = categorias.id
WHERE
    categorias.id IS NULL;
    
SET SQL_SAFE_UPDATES=0;
UPDATE productos 
SET 
    categoria_id = 4
WHERE
    categoria_id NOT IN (SELECT 
            id
        FROM
            categorias);
SET SQL_SAFE_UPDATES=1;


-- 13 DUPLICADODE  CLIENTES




select * from clientes;
UPDATE pedidos
 SET cliente_id = (SELECT 
    MIN(id)
FROM
    clientes
WHERE
    email IN (SELECT 
             email
        FROM
            clientes
        GROUP BY email
        HAVING COUNT(id) > 1))
WHERE cliente_id IN (SELECT 
    id
FROM
    clientes
WHERE
    email IN (SELECT 
             email
        FROM
            clientes
        GROUP BY email
        HAVING COUNT(id) > 1));
SET SQL_SAFE_UPDATES=1;



UPDATE pedidos
SET cliente_id = 3
where cliente_id in (4,5);
DELETE FROM clientes WHERE id IN (4,5);
select * from clientes;
SET SQL_SAFE_UPDATES=1;

	

