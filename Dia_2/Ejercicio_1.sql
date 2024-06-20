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
SELECT apellido1 AS Primer_Apellido
FROM empleado;

-- 2.Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos. 
SELECT DISTINCT apellido1 AS Primer_Apellido
FROM empleado;

-- 3.Lista todas las columnas de la tabla empleado.
SELECT *
FROM empleado;

-- 4.Lista el nombre y los apellidos de todos los empleados.
SELECT nombre, apellido1, apellido2 
FROM empleado;

-- 5.Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.
SELECT e.id_departamento AS Identificador
FROM empleado AS e;

-- 6.Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, 
-- eliminando los identificadores que aparecen repetidos.
SELECT DISTINCT e.id_departamento AS Identificador
FROM empleado AS e;

-- 7.Lista el nombre y apellidos de los empleados en una única columna.
DELIMITER //
CREATE FUNCTION Nombre_Apellidos(nombre VARCHAR(100),apellido1 VARCHAR(100),apellido2 VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	RETURN CONCAT(nombre,' ',apellido1,' ',apellido2);
END //
DELIMITER ;

SELECT Nombre_Apellidos(nombre,apellido1,apellido2)
FROM empleado;

-- 8.Lista el nombre y apellidos de los empleados en una única columna,convirtiendo todos los caracteres en mayúscula.
SELECT UPPER(CONCAT(nombre,' ',apellido1,' ',apellido2)) AS 'Nombre y Apellidos'
FROM empleado;

-- 9.Lista el nombre y apellidos de los empleados en una única columna,convirtiendo todos los caracteres en minúscula.


-- 10.Lista el identificador de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.


-- REALIZADO POR PAULA MUÑOZ/ID.1.095.953.057
