-- Práctica Avanzada: Saneamiento y Reestructuración Marco Gallego--
use gha_analytics;

START transaction;
-- Escenario 1: Blindaje Estructural

-- 1. Normalización de Identidad (Pacientes)

-- comprobar
select * from pacientes;
SELECT nif ,count(nif) as sum_nif from pacientes group by nif having sum_nif > 1; -- comprobamos cuales se duplican
select * from pacientes where NOT (char_length(nif)= 9 and nif regexp '[A-Z]{1}$'); -- comprobamos cuales tienen caracteres de mas o de menos en el DNI
-- modificar
-- Con esta primera modificación, primero modificamos todos los nombres para que tengan los mismos espacios para no generar errores, y luego eliminamos los que estan duplicados el nif y dejamos solo que que tiene el id mas bajo
SET SQL_safe_updates = 0 ;
UPDATE pacientes SET nombre_completo = TRIM(REPLACE(nombre_completo, '  ', ' '));
delete p1 from pacientes p1 INNER join pacientes p2 ON p1.nif = p2.nif where p1.id > p2.id;
SET SQL_safe_updates = 1 ; 
-- Luego, en esta modificación hemos eliminado caracteres de más en el dni y hemos obligado a que los 8 primeros sean números y el ulimo sea letra
savepoint corregir_dni; 
SET SQL_safe_updates = 0 ;
update pacientes set nif = replace(NIF,'-',''); 
UPDATE pacientes SET nif = TRIM(REPLACE(nif, ' ', ''));
SET SQL_safe_updates = 1 ;
rollback to corregir_dni; 
-- Aqui hemos convertido la columna nif en UNIQUE y NOT NULL.
savepoint alter_pacientes; 
SET SQL_safe_updates = 0 ;
alter table pacientes MODIFY COLUMN nif char(9) UNIQUE NOT NULL;
SET SQL_safe_updates = 1 ;
rollback to alter_pacientes; 

-- 2. Consistencia de Colegiados (Médicos)


Start transaction;

-- comprobar

select * from medicos;
select * from medicos where not (char_length(num_colegiado) = 11 and num_colegiado regexp '^COL-[0-9]{2}-[0-9]{4}$');

-- modificar

update medicos set num_coliago = CONCAT('COT-', num_colegiado) and  num_colegiado regexp '^COL-[0-9]{2}-[0-9]{4}$';
update medicos set num_colegiado = replace(NIF,'/','-');
 


