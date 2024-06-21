-- #####################
-- ### MySQL2  DIA 2 ###
-- #####################

CREATE DATABASE mysql2_dia2_ejericio1;

USE mysql2_dia2_ejericio1;

-- TABLAS
CREATE TABLE departamento (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DOUBLE UNSIGNED NOT NULL,
gastos DOUBLE UNSIGNED NOT NULL
);


CREATE TABLE empleado (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nif VARCHAR(9) NOT NULL UNIQUE,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
id_departamento INT UNSIGNED,
FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

SHOW TABLES;

-- DEPARTAMENTO
INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

-- EMPLEADO
INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero',NULL);

-- ########### CONSULTA UNA TABLA ################
-- 1. Lista el primer apellido de todos los empleados.
DELIMITER //
CREATE PROCEDURE primer_apellido()
BEGIN
	SELECT apellido1 AS Primer_Apellido
	FROM empleado;
END //
DELIMITER ;

CALL primer_apellido();

-- 2.Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos. 
DELIMITER //
CREATE PROCEDURE primer_apellido_distinto()
BEGIN
	SELECT DISTINCT apellido1 AS Primer_Apellido
	FROM empleado;
END //
DELIMITER ;

CALL primer_apellido_distinto();

-- 3.Lista todas las columnas de la tabla empleado.
DELIMITER //
CREATE PROCEDURE empleado()
BEGIN
	SELECT *
	FROM empleado;
END //
DELIMITER ;

CALL empleado();

-- 4.Lista el nombre y los apellidos de todos los empleados.
DELIMITER //
CREATE PROCEDURE nombre_apellidos()
BEGIN
	SELECT nombre, apellido1, apellido2 
	FROM empleado;
END //
DELIMITER ;

CALL nombre_apellidos();

-- 5.Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.
DELIMITER //
CREATE PROCEDURE identificador_d()
BEGIN
	SELECT e.id_departamento AS Identificador
	FROM empleado AS e;
END //
DELIMITER ;

CALL identificador_d();

-- 6.Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, 
-- eliminando los identificadores que aparecen repetidos.
DELIMITER //
CREATE PROCEDURE identificadorD_distinto()
BEGIN
	SELECT DISTINCT e.id_departamento AS Identificador
	FROM empleado AS e;
END //
DELIMITER ;

CALL identificadorD_distinto();

-- 7.Lista el nombre y apellidos de los empleados en una única columna.
DELIMITER //
CREATE FUNCTION Nombre_Apellidos(nombre VARCHAR(100), apellido1 VARCHAR(100), apellido2 VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	RETURN CONCAT(nombre,' ',apellido1,' ',apellido2);
END //
DELIMITER ;

SELECT Nombre_Apellidos(nombre,apellido1,apellido2)
FROM empleado;

-- 8.Lista el nombre y apellidos de los empleados en una única columna,convirtiendo todos los caracteres en mayúscula.
DELIMITER //
CREATE FUNCTION Nombre_Mayuscula(nombre VARCHAR(100), apellido1 VARCHAR(100), apellido2 VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	IF apellido2 IS NULL THEN
		RETURN UPPER(CONCAT(nombre,' ',apellido1));
    ELSE  
		RETURN UPPER(CONCAT(nombre,' ',apellido1,' ',apellido2));
    END IF;
END //
DELIMITER ;

SELECT Nombre_Mayuscula(nombre,apellido1,apellido2)
FROM empleado e;

-- 9.Lista el nombre y apellidos de los empleados en una única columna,convirtiendo todos los caracteres en minúscula.
DELIMITER //
CREATE FUNCTION Nombre_Minuscula(nombre VARCHAR(100), apellido1 VARCHAR(100), apellido2 VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	IF apellido2 IS NULL THEN
		RETURN LOWER(CONCAT(nombre,' ',apellido1));
    ELSE 
		RETURN LOWER(CONCAT(nombre,' ',apellido1,' ',apellido2));
    END IF;    
END //
DELIMITER ;

SELECT Nombre_Minuscula(nombre,apellido1,apellido2)
FROM empleado e;

-- 10.Lista el identificador de los empleados junto al nif, pero el nif deberá aparecer en dos columnas,
--  una mostrará únicamente los dígitos del nif y la otra la letra.
DELIMITER //
CREATE PROCEDURE nif()
BEGIN
	SELECT id, SUBSTRING(nif,1, LENGTH(nif) -1) AS Digitos, RIGHT(nif, 1) AS Letra
	FROM empleado;
END //
DELIMITER ;

CALL nif();

-- 11.Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para calcular 
-- este dato tendrá que restar al valor del presupuesto inicial (columna presupuesto) los gastos que se han generado
-- (columna gastos). Tenga en cuenta que en algunos casos pueden existir valores negativos. Utilice un alias
--  apropiado para la nueva columna columna que está calculando.
DELIMITER //
CREATE FUNCTION presupuesto (presupuesto DOUBLE, gastos DOUBLE)
RETURNS DOUBLE DETERMINISTIC
BEGIN
	DECLARE valor_presupuesto DOUBLE;
    SET valor_presupuesto = (presupuesto - gastos);
    RETURN valor_presupuesto; 
    
END //
DELIMITER ;

SELECT nombre,presupuesto(presupuesto,gastos) AS valor_presupuesto
FROM departamento;

-- 12.Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
SELECT nombre, presupuesto(presupuesto,gastos) AS valor_presupuesto -- FUNCION presupuesto
FROM departamento
ORDER BY valor_presupuesto ASC;

-- 13.Lista el nombre de todos los departamentos ordenados de forma ascendente.
DELIMITER //
CREATE PROCEDURE nombreD_asc()
BEGIN
	SELECT nombre
	FROM departamento
	ORDER BY nombre ASC;
END //
DELIMITER ;

CALL nombreD_asc();

-- 14.Lista el nombre de todos los departamentos ordenados de forma descendente.
DELIMITER //
CREATE PROCEDURE nombreD_desc()
BEGIN
	SELECT nombre
	FROM departamento
	ORDER BY nombre DESC;
END //
DELIMITER ;

CALL nombreD_desc();

-- 15.Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética teniendo
--  en cuenta en primer lugar sus apellidos y luego su nombre.
DELIMITER //
CREATE PROCEDURE nombre_alfabeticamente()
BEGIN
	SELECT apellido1,apellido2,nombre
	FROM empleado
	ORDER BY apellido1,apellido2,nombre ASC;
END //
DELIMITER ;

CALL nombre_alfabeticamente();

-- 16.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
DELIMITER //
CREATE PROCEDURE presupuesto_mayor()
BEGIN
	SELECT nombre,presupuesto
	FROM departamento
	ORDER BY presupuesto DESC LIMIT 3;
END //
DELIMITER ;

CALL presupuesto_mayor();

-- 17.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
DELIMITER //
CREATE PROCEDURE presupuesto_menor()
BEGIN
	SELECT nombre,presupuesto
	FROM departamento
	ORDER BY presupuesto ASC LIMIT 3;
END //
DELIMITER ;

CALL presupuesto_menor();

-- 18.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
DELIMITER //
CREATE PROCEDURE gasto_mayor()
BEGIN
	SELECT nombre, gastos 
	FROM departamento 
	ORDER BY gastos DESC LIMIT 2;
END //
DELIMITER ;

CALL gasto_mayor();

-- 19.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
DELIMITER //
CREATE PROCEDURE gasto_menor()
BEGIN
	SELECT nombre, gastos 
	FROM departamento 
	ORDER BY gastos ASC LIMIT 2;
END //
DELIMITER ;

CALL gasto_menor();

-- 20.Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La tercera fila
-- se debe incluir en la respuesta. La respuesta debe incluir todas las columnas de la tabla empleado.
DELIMITER //
CREATE PROCEDURE empleado_filas()
BEGIN
	SELECT *
	FROM empleado 
	LIMIT 5 OFFSET 2;
END //
DELIMITER ;

CALL empleado_filas();

-- 21.Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen
-- un presupuesto mayor o igual a 150000 euros.
DELIMITER //
CREATE PROCEDURE departamento_presupuesto_mayor()
BEGIN
	SELECT nombre, presupuesto
	FROM departamento
	WHERE presupuesto >= 150000;
END //
DELIMITER ;

CALL departamento_presupuesto_mayor();

-- 22. Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos
-- de 5000 euros de gastos.
DELIMITER //
CREATE PROCEDURE departamento_gasto_menor()
BEGIN
	SELECT nombre, gastos
	FROM departamento
	WHERE gastos < 5000;
END //
DELIMITER ;

CALL departamento_gasto_menor();

-- 23. Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un
--  presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE departamento_presupuesto_rango()
BEGIN
	SELECT nombre,presupuesto
	FROM departamento
	WHERE (presupuesto >= 100000) AND (presupuesto <= 200000); 
END //
DELIMITER ;

CALL departamento_presupuesto_rango();

-- 24. Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 
-- y 200000 euros. Sin utilizar el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE departamento_presupuesto_norango()
BEGIN
	SELECT nombre,presupuesto
	FROM departamento
	WHERE NOT(presupuesto >= 100000) OR NOT(presupuesto <= 200000); 
END //
DELIMITER ;

CALL departamento_presupuesto_norango();

-- 25.Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre 100000 
-- y 200000 euros. Utilizando el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE departamento_presupuesto_between()
BEGIN
	SELECT nombre,presupuesto
	FROM departamento
	WHERE presupuesto BETWEEN 100000 AND 200000; 
END //
DELIMITER ;

CALL departamento_presupuesto_between();

-- 26.Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 
-- y 200000 euros. Utilizando el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE departamento_presupuesto_notbetween()
BEGIN
	SELECT nombre,presupuesto
	FROM departamento
	WHERE presupuesto NOT BETWEEN 100000 AND 200000; 
END //
DELIMITER ;

CALL departamento_presupuesto_notbetween();

-- 27.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos 
-- donde los gastos sean mayores que el presupuesto del que disponen.
DELIMITER //
CREATE PROCEDURE departamento_gastoMayorPresupuesto()
BEGIN
	SELECT nombre,gastos,presupuesto
	FROM departamento
	WHERE (gastos > presupuesto); 
END //
DELIMITER ;

CALL departamento_gastoMayorPresupuesto();

-- 28.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos
--  donde los gastos sean menores que el presupuesto del que disponen.
DELIMITER //
CREATE PROCEDURE departamento_gastoMenorPresupuesto()
BEGIN
	SELECT nombre,gastos,presupuesto
	FROM departamento
	WHERE (gastos < presupuesto); 
END //
DELIMITER ;

CALL departamento_gastoMenorPresupuesto();

-- 29.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos
--  donde los gastos sean iguales al presupuesto del que disponen.
DELIMITER //
CREATE PROCEDURE departamento_gastoIgualPresupuesto()
BEGIN
	SELECT nombre,gastos,presupuesto
	FROM departamento
	WHERE (gastos = presupuesto); 
END //
DELIMITER ;

CALL departamento_gastoIgualPresupuesto();

-- 30.Lista todos los datos de los empleados cuyo segundo apellido sea NULL.
DELIMITER //
CREATE PROCEDURE apellido_null()
BEGIN
	SELECT *
	FROM empleado
	WHERE apellido2 IS NULL;
END //
DELIMITER ;

CALL apellido_null();

-- 31.Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.
DELIMITER //
CREATE PROCEDURE apellido_notnull()
BEGIN
	SELECT *
	FROM empleado
	WHERE apellido2 IS NOT NULL;
END //
DELIMITER ;

CALL apellido_notnull();

-- 32.Lista todos los datos de los empleados cuyo segundo apellido sea López.
DELIMITER //
CREATE PROCEDURE apellido_Lopez()
BEGIN
	SELECT *
	FROM empleado
	WHERE apellido2 = 'López';
END //
DELIMITER ;

CALL apellido_Lopez();

-- 33.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Sin utilizar el operador IN.
DELIMITER //
CREATE PROCEDURE apellido_Diaz_Moreno()
BEGIN
	SELECT *
	FROM empleado
	WHERE (apellido2 = 'Díaz') or (apellido2 = 'Moreno');
END //
DELIMITER ;

CALL apellido_Diaz_Moreno();

-- 34.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Utilizando el operador IN.
DELIMITER //
CREATE PROCEDURE apellido_Diaz_Moreno_IN()
BEGIN
	SELECT *
	FROM empleado
	WHERE apellido2 IN ('Díaz','Moreno');
END //
DELIMITER ;

CALL apellido_Diaz_Moreno_IN();

-- 35.Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento 3.
DELIMITER //
CREATE PROCEDURE departamento3()
BEGIN
	SELECT nombre,apellido1,apellido2,nif
	FROM empleado
	WHERE id_departamento = 3;
END //
DELIMITER ;

CALL departamento3();

-- 36.Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.
SELECT nombre,apellido1,apellido2,nif
FROM empleado
WHERE id_departamento IN(2,4,5);

DELIMITER //
CREATE PROCEDURE departamento245()
BEGIN
	SELECT nombre,apellido1,apellido2,nif
	FROM empleado
	WHERE id_departamento IN(2,4,5);
END //
DELIMITER ;

CALL departamento245();

-- REALIZADO POR PAULA MUÑOZ/ID.1.095.953.057
