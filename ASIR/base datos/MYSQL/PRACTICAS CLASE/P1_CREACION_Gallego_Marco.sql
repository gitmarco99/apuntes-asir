drop database gestion_universidad;
create database gestion_universidad;
use gestion_universidad;

CREATE TABLE facultades (
    id_facultad SMALLINT UNSIGNED AUTO_INCREMENT,
    id_decano SMALLINT UNSIGNED,
    codigo VARCHAR(4) UNIQUE NOT NULL,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    CONSTRAINT pk_id_facultad PRIMARY KEY (id_facultad),
    CONSTRAINT chk_codigo_cuatro CHECK (length(codigo) = 4 ) 
); 

alter table facultades
	ADD constraint fk_id_decano foreign key (id_decano)
    references profesores (id_profesor)
    ON DELETE RESTRICT ON UPDATE CASCADE;

Create table profesores (
	id_profesor SMALLINT UNSIGNED AUTO_INCREMENT,
    id_facultad SMALLINT UNSIGNED NOT NULL,
    nif varchar(9) unique not null,
    nombre_completo varchar(50) NOT NULL, 
    salario DECIMAL(6 , 2) DEFAULT 2000.00,
    constraint pk_id_profesor PRIMARY KEY (id_profesor),
    CONSTRAINT chk_salario CHECK ( salario > 0 ),
    constraint chk_nif_longitud check (LENGTH(nif) = 9 ),
    CONSTRAINT fk_id_facultad foreign key (id_facultad)
    references facultades (id_facultad)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE grados (
    id_grado SMALLINT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(40),
    id_facultad SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT pk_id_grado PRIMARY KEY (id_grado),
    CONSTRAINT fk_id_facultad_2 FOREIGN KEY (id_facultad)
        REFERENCES facultades (id_facultad)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE asignaturas (
    id_asignatura SMALLINT UNSIGNED AUTO_INCREMENT,
    codigo_asig VARCHAR(10) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    creditos DECIMAL(2 , 0 ) DEFAULT 6,
    CONSTRAINT pk_id_asignatura PRIMARY KEY (id_asignatura),
    CONSTRAINT chk_creditos_igual_mayor CHECK (creditos >= 3),
    CONSTRAINT chk_codigo_asig_max_logitud CHECK (LENGTH(codigo_asig) <= 10)
);

CREATE TABLE imparten (
    id_profesor SMALLINT UNSIGNED,
    id_asignatura SMALLINT UNSIGNED,
    tipo_grupo ENUM('Teoria', 'Practica') DEFAULT 'Teoria',
    CONSTRAINT fk_id_profesor FOREIGN KEY (id_profesor)
        REFERENCES profesores (id_profesor)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_id_asignatura FOREIGN KEY (id_asignatura)
        REFERENCES asignaturas (id_asignatura)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
