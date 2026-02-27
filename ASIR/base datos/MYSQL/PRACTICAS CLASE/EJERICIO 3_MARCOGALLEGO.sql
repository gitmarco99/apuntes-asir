-- Ejemplo 3: Creación BBDD completa (Ejercicio de hacer en clase que se corrige automático)

create database EJERCICIO3;
use EJERCICIO3;

create table empleados (
	id_empleado INT unsigned auto_increment,
    DNI VARCHAR(9) NOT NULL,
    salario DECIMAL(6, 2 ),
    estado ENUM ('ACTIVO', 'INACTIVO'),
    CONSTRAINT pk_id_empleado PRIMARY KEY (id_empleado)
);

create table proyectos(
	id_proyecto INT unsigned auto_increment,
    nombre varchar(40) unique,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    constraint fk_id_departamento foreign key (id_departamento)
    REFERENCES compositor (id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

create table asignaciones (
	id_empleado 
    