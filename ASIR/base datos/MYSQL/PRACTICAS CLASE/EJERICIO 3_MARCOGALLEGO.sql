-- Ejemplo 3: Creación BBDD completa (Ejercicio de hacer en clase que se corrige automático)

create database EJERCICIO3;
use EJERCICIO3;

create table empleados (
	id_empleado INT unsigned auto_increment,
    DNI VARCHAR(9) NOT NULL,
    salario DECIMAL(5, 2 ),
    estado ENUM ('ACTIVO', 'INACTIVO'),
    CONSTRAINT pk_id_empleado PRIMARY KEY (id_empleado)
);
