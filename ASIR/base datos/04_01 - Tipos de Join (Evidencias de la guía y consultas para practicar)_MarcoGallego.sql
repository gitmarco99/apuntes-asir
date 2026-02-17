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
    
    select matriculas.id_matricula, alumnos.id_alumno, curso.id_curso from 
    