-- Ejemplo 3: Creación BBDD completa (Ejercicio de hacer en clase que se corrige automático)
drop database EJERCICIO3;
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
    id_departamento INT unsigned,
    nombre varchar(40) unique,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    CONSTRAINT pk_id_proyecto PRIMARY KEY (id_proyecto)
);

CREATE TABLE asignaciones (
    id_empleado INT UNSIGNED,
    id_proyecto INT UNSIGNED,
    horas_asignadas DECIMAL(5 , 0 ),
    PRIMARY KEY (id_empleado , id_proyecto),
    CONSTRAINT fk_id_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleados (id_empleado)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_id_proyecto FOREIGN KEY (id_proyecto)
        REFERENCES proyectos (id_proyecto)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE departamentos (
    id_departamento INT UNSIGNED AUTO_INCREMENT,
    codigo_dpto VARCHAR(5) NOT NULL,
    nombre VARCHAR(10) NOT NULL,
    presupuesto DECIMAL(5 , 2 ) NOT NULL,
    CONSTRAINT pk_id_departamento PRIMARY KEY (id_departamento),
    CONSTRAINT chk_presupuesto_no_negativo CHECK (presupuesto >= 0)
);

alter table proyectos
	add constraint fk_id_departamento foreign key (id_departamento)
    references departamentos (id_departamento)
    on delete restrict on update cascade;
    
    
    