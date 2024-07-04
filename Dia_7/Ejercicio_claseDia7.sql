-- #########################
-- #### DIA 7 - MySQL 2 ####
-- #########################

USE mysql2_dia5;
USE `world`;
-- SUBCONSULTAS: Se usan para realizar operaciones que requieren un conjunto de datos que
-- se obtiene de manera dinámica a tŕaves de otra consulta

-- Subconsulta Escalar : Toda subconsulta que devuelve un solo valor (fila y columna) 
-- EJ: Devuelva el nombre del país con la mayor población
SELECT Name
FROM country
WHERE Population = (SELECT max(Population) FROM country);

-- Subconsulta de Columna Única: Devuelve una columna de múltiples filas.
-- EJ: Encuentre los nombres de todas las ciudades en los paises que tienen un área 
-- mayor a 1000000 km2
SELECT Name
FROM city
WHERE CountryCode IN (SELECT Code FROM country WHERE SurfaceArea > 1000000);

-- Subconsulta de Múltiples Columnas: Devuelve múltiples columnas de múltiples filas
-- EJ: Encontrar las ciudades que tengan la misma población y distrito que cualquier
--  ciudad del país. 'USA'
SELECT Name,CountryCode,District,Population
FROM city
WHERE (District,Population) IN (SELECT District,Population FROM
city WHERE CountryCode = 'USA');

-- Subconsulta Correlacionada: Depende de la consulta externa para cada
-- fila procesada.
-- EJ: Liste las ciudades con una población mayor que el promedio de la 
-- población de las ciudades en el mismo país
SELECT Name,CountryCode,Population
FROM city c1
WHERE Population > (SELECT avg(Population) FROM city c2 
WHERE c1.CountryCode = c2.CountryCode);

-- Subconsulta Múltiple:
-- EJ: Listar las ciudades que tengan la misma población que la capital del país 'JPN'(Japón)
SELECT Name
FROM city
WHERE Population = (SELECT Population FROM city WHERE ID=(
SELECT Capital FROM country WHERE Code = 'JPN'));

-- INDEXACIÓN
SELECT * FROM city;

-- Crear índece en la columna 'NAME' de City
CREATE INDEX idx_city_name ON city(Name);
SELECT * FROM city;
SELECT Name FROM city;

-- Crear índice compuesto de las columnas 'District' y 'Population'
CREATE INDEX idx_city_district_population ON city(District,Population);

-- Datos estadísticos para ver los índices creados
SELECT 
    TABLE_NAME, 
    INDEX_NAME, 
    SEQ_IN_INDEX, 
    COLUMN_NAME, 
    CARDINALITY, 
    SUB_PART, 
    INDEX_TYPE, 
    COMMENT
FROM 
    information_schema.STATISTICS
WHERE 
    TABLE_SCHEMA = 'world';
-- Revisar tamaño de Indexaciones creadas
SELECT 
    TABLE_NAME, 
    INDEX_LENGTH 
FROM 
    information_schema.TABLES 
WHERE 
    TABLE_SCHEMA = 'world';

-- TRANSACCIONES
-- Son secuencias de uno o más operaciones SQL, las cuales son ejecutadas como una única
-- unidad de trabajo. En otras palabras, las transacciones aseguran que todas las operaciones
-- se realicen de manera correcta antes de ser ejecutadas en La BBDD real, buscando cumplir 
-- con las propiedades ACID.(ATOMICIDAD, CONSISTENCIA, AISLAMIENTO, DURABILIDAD).
	
-- Primer Paso: INICIAR LA TRANSACCIÓN
START TRANSACTION;

-- Segundo Paso: HACER COMANDOS
-- EJ: Actualizar la población de la ciudad de 'New York'
UPDATE city
SET population = 9000000
WHERE Name = 'New YORK';

SELECT * FROM city WHERE Name = 'New YORK';

-- Tercer Paso: Si quiero que los cambios se mantengan pongo COMMIT, sino
-- revierto mis cambios con ROLLBACK.
COMMIT; -- Mandar cambios a produccion
ROLLBACK; -- Revertir cambios 

