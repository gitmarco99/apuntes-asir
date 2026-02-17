-- 18) Productos NUNCA vendidos
use  tienda_online;
SELECT 
    productos.id_producto, nombre
FROM
    productos
        LEFT JOIN
    detalle_pedido USING (id_producto)
WHERE
    detalle_pedido.id_producto IS NULL;


-- 04_01 - Tipos de Join (Evidencias de la guía y consultas para practicar)as de la guÃ­a y consultas para practicar)_MarcoGallego
use ejemplos_tipos_join;

-- 1: Listado de alumnos con sus id_curso (sólo emparejados)

SELECT 
    alumnos.id_alumno, nombre, matriculas.id_curso
FROM
    alumnos
       INNER JOIN
    matriculas USING (id_alumno);

-- 2: Alumnos sin ninguna matrícula (anti-join)

SELECT 
    alumnos.id_alumno, alumnos.nombre
FROM
    alumnos
        LEFT JOIN
    matriculas USING (id_alumno)
WHERE
    matriculas.id_alumno IS NULL;
    
-- 3: Matrículas sin alumno (huérfanas)
    
    SELECT 
    id_matricula, id_alumno, id_curso
FROM
    matriculas
        LEFT JOIN
    alumnos USING (id_alumno)
WHERE
    alumnos.id_alumno IS NULL;
    
-- 4 Cursos del catálogo sin ninguna matrícula

SELECT 
    cursos.id_curso, nombre_curso
FROM
    cursos
        LEFT JOIN
    matriculas USING (id_curso)
        LEFT JOIN
    alumnos USING (id_alumno)
WHERE
    id_alumno IS NULL;
    
-- 5 Número de matrículas por alumno (incluye 0).

SELECT 
    id_alumno, nombre, COUNT(id_matricula) as n_matriculas
FROM
    alumnos
         left JOIN
    matriculas USING (id_alumno)
GROUP BY id_alumno , nombre;

-- 6 Alumnos con más de un curso.

SELECT 
    id_alumno, nombre, COUNT(id_curso) AS n_cursos
FROM
    alumnos
        JOIN
    matriculas USING (id_alumno)
        JOIN
    cursos USING (id_curso)
GROUP BY id_alumno , nombre
HAVING n_cursos >= 2;

-- 7 FULL OUTER JOIN emulado (alumnos y sus matrículas, incluyendo huérfanas).
SELECT 
    alumnos.id_alumno, alumnos.nombre, id_matricula, matriculas.id_curso
FROM
    alumnos
        LEFT JOIN
    matriculas USING (id_alumno) 
UNION SELECT 
    alumnos.id_alumno, alumnos.nombre, id_matricula, matriculas.id_curso
FROM
    alumnos
        RIGHT JOIN
    matriculas using(id_alumno)
    where id_alumno is null;
-- 8 Para cada curso del catálogo, número de alumnos con matrícula válida (alumno y curso existen).

SELECT 
    cursos.id_curso,
    nombre_curso,
    COUNT(alumnos.id_alumno) AS n_alumno
FROM
    cursos
        LEFT JOIN
    matriculas USING (id_curso)
        LEFT JOIN
    alumnos USING (id_alumno)
GROUP BY cursos.id_curso , nombre_curso;  


-- TIPO TEST 
/*
1. INNER JOIN devuelve. . .
B-- Solo las filas que cumplen la condición en ambas tablas.

2. En un LEFT JOIN, las filas no emparejadas de la tabla derecha. . .
B-- Se rellenan como NULL en sus columnas.


3. En un RIGHT JOIN, ¿qué se garantiza?
B-- Ver todas las filas de la derecha.


4. En MySQL, FULL OUTER JOIN. . .
C-- No existe; se emula con LEFT + RIGHT y UNION.


5. En un LEFT JOIN, poner en WHERE una condición sobre la tabla derecha (WHERE m.id_curso=101)
B--Puede hacer que el resultado se comporte como un INNER (filtra las NULL).


6. Para encontrar alumnos sin matrícula, lo más idiomático es. . .
B-- LEFT JOIN y WHERE m.id_matricula IS NULL.


7. Detectar matrículas huérfanas de alumno:

B. RIGHT JOIN alumnos←matriculas + IS NULL en a.id_alumno.


8. Si haces INNER JOIN matriculas m con cursos c ON m.id_curso=c.id_curso, ¿aparece la matrícula 1005?
B. No, porque 105 no existe en cursos.


9. Para listar todos los cursos y cuántos alumnos tienen (incluye 0), lo más correcto es. . .
B. LEFT JOIN desde cursos hacia matriculas y GROUP BY.


10. En el FULL emulado, la parte RIGHT ... WHERE a.id_alumno IS NULL sirve para. . .

B. Añadir solo las filas que están solo en la derecha (huérfanas).

*/