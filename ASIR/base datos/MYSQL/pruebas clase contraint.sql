CREATE DATABASE ejercicio1;
USE ejercicio1;
CREATE TABLE vehiculos (
    id MEDIUMINT UNSIGNED AUTO_INCREMENT, -- MEDIUMINT, TAMAÑO DEL NUMERO ENTERO
    matricula VARCHAR(10) UNIQUE,
    tipo VARCHAR(50),
    precio DECIMAL(10,2),
    fecha_compra DATE,
    constraint pk_id PRIMARY KEY (id), -- ya incluye not null y unique
    CONSTRAINT chk_matricula_alfanumerica CHECK (matricula REGEXP '[A-Z0-9]' )
	-- ^: indica comienzo de la cadena.
    -- $: indica finakl de la cadena.
    -- [A-Z0-9]: indica los caracteres permitidos.
    -- {6,10} : indica la longitud.


);	
	

