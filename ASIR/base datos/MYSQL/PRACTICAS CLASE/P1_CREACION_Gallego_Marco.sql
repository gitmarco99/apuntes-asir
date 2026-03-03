create database gestion_universidad;
use gestion_universidad;

CREATE TABLE facultades (
    id_facultad INT UNSIGNED AUTO_INCREMENT,
    codigo VARCHAR(4) UNIQUE NOT NULL,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    CONSTRAINT pk_id_facultad PRIMARY KEY (id_facultad)
    -- clave foranea
); 

Create table profesores (
	id_profesor INT UNSIGNED AUTO_INCREMENT,
    id_facultad INT UNSIGNED,
    nif varchar(9) unique not null,
    nombre_completo varchar(50) NOT NULL, 
    salario DECIMAL(6 , 2) DEFAULT 2000.00,
    constraint pk_id_profesor PRIMARY KEY (id_profesor),
    CONSTRAINT chk_salario CHECK ( salario > 0 ),
    CONSTRAINT fk_id_facultad foreign key (id_facultad)
    references facultad (id_facultad)
    ON DELETE RESTRICT ON UPDATE CASCADE
);


