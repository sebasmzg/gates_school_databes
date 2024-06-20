-- ------------------------------
-- LISTADO DE ESTUDIANTES POR GRUPOS
-- -------------------------------

/*
SELECT 
	`estudiantes`.`id` AS id,
	`estudiantes`.`nombre` AS nombre,
	`estudiantes`.`apellido` AS apellido,
    `grados`.`nombre` AS grado,
    `grupos`.`nombre` AS grupo
    
FROM `bx6crrqekkqo9qroeyb0`.`estudiantes` 
INNER JOIN 
	`bx6crrqekkqo9qroeyb0`.`grupos` 
    ON 
	`estudiantes`.`grupos_id` = `grupos`.`id`
INNER JOIN 
	`bx6crrqekkqo9qroeyb0`.`grados` 
    ON 
    `grupos`.`grados_id` = `grados`.`id`
     
     WHERE `grados`.`nombre` = 6 AND `grupos`.`nombre` = 'A'
*/

-- ---------------------------
-- LISTADO DE ESTUDIANTES POR ASIGNATURA
-- ---------------------------

/*
SELECT 
	`estudiantes`.`id` AS id,
	`estudiantes`.`nombre` AS nombre,
	`estudiantes`.`apellido` AS apellido,
    `materias`.`nombre` AS materia
    
FROM `bx6crrqekkqo9qroeyb0`.`estudiantes` 
INNER JOIN 
	`bx6crrqekkqo9qroeyb0`.`grupos` 
    ON 
    `estudiantes`.`grupos_id` = `grupos`.`id`
INNER JOIN 
	`bx6crrqekkqo9qroeyb0`.`horarios` 
    ON 
    `grupos`.`horarios_id` = `horarios`.`id`
INNER JOIN 
	`bx6crrqekkqo9qroeyb0`.`materias` 
    ON 
    `horarios`.`materias_profesores_id` = `materias`.`id`
    
WHERE `materias`.`nombre` = 'materia 3'
*/

-- --------------------------------------
-- LISTA DE PROFESORES QUE LE DICTAN CLASE A UN ESTUDIANTE
-- --------------------------------------

/*
SELECT 
	`estudiantes`.`nombre` AS nombre,
	`estudiantes`.`apellido` AS apellido,
    `profesores`.`nombre` AS nombre_profe,
    `profesores`.`apellido` AS apellido_profe
    
FROM `bx6crrqekkqo9qroeyb0`.`estudiantes` 
INNER JOIN 
	`bx6crrqekkqo9qroeyb0`.`grupos` 
    ON 
    `estudiantes`.`grupos_id` = `grupos`.`id`
INNER JOIN 
	`bx6crrqekkqo9qroeyb0`.`horarios` 
    ON 
    `grupos`.`horarios_id` = `horarios`.`id`
INNER JOIN 
	`bx6crrqekkqo9qroeyb0`.`materias` 
    ON 
    `horarios`.`materias_profesores_id` = `materias`.`id`
INNER JOIN 
	`bx6crrqekkqo9qroeyb0`.`profesores` 
    ON 
    `materias`.`profesores_id` = `profesores`.`id`
    
WHERE `profesores`.`id` = 1
*/

-- --------------------------------
-- GRUPOS ORDENADOS POR LA CANTIDAD DESC POR LA CANTIDAD DE INSCRITOS
-- --------------------------------

/*
SELECT
	`grados`.`nombre` AS grado,
	`grupos`.`nombre` AS grupo,
    COUNT(`estudiantes`.`id`) AS cantidad_estudiantes
FROM 
	`bx6crrqekkqo9qroeyb0`.`grupos`
INNER JOIN
	`bx6crrqekkqo9qroeyb0`.`grados`
    ON
    `grupos`.`grados_id` = `grados`.`id`
LEFT JOIN 
	`bx6crrqekkqo9qroeyb0`.`estudiantes`
	ON 
    `grupos`.`id` = `estudiantes`.`grupos_id`
GROUP BY
	`grupos`.`nombre`, `grados`.`nombre`
ORDER BY
		cantidad_estudiantes DESC
*/