-- ##########################
-- ##### DIA 4 - MYSQL2 #####
-- ##########################

SHOW DATABASES;
CREATE DATABASE mysql2_dia4;
USE mysql2_dia4;

-- Creación de usuarios con acceso desde cualquier parte 
CREATE USER 'camper'@'%' IDENTIFIED BY 'campus2023';

-- Revisar permisos de x usuario
SHOW GRANTS FOR 'camper'@'%';

-- Crear una tabla de personas 
CREATE TABLE persona (
	id INT PRIMARY KEY, 
    nombre VARCHAR(255),
    apellido VARCHAR(255)
);

INSERT INTO persona (id,nombre,apellido) VALUES (1,'Paula','Muñoz');
INSERT INTO persona (id,nombre,apellido) VALUES (2,'Helen','Parga');
INSERT INTO persona (id,nombre,apellido) VALUES (3,'Daniela','Forero');
INSERT INTO persona (id,nombre,apellido) VALUES (4,'Catalina','Mulford');
INSERT INTO persona (id,nombre,apellido) VALUES (5,'Ruben','Ortiz');
INSERT INTO persona (id,nombre,apellido) VALUES (6,'Andres','Moreno');
INSERT INTO persona (id,nombre,apellido) VALUES (7,'Brayan','Carvajal');
INSERT INTO persona (id,nombre,apellido) VALUES (8,'Tobias','Suarez');
INSERT INTO persona (id,nombre,apellido) VALUES (9,'Karen','Infante');
INSERT INTO persona (id,nombre,apellido) VALUES (10,'Gabriela','Rojas');

-- Asignar permisos a x usuario para que acceda a la tabla y BBDD
GRANT SELECT ON mysql2_dia4.persona TO 'camper'@'%';

-- Refrescar permisos de la BBDD
FLUSH PRIVILEGES;

-- Añadir permiso para hacer CRUD
GRANT UPDATE,INSERT,DELETE ON mysql2_dia4.persona TO 'camper'@'%';

-- PELIGROSO: CREAR UN USUARIO CON PERMISOS A TODO DESDE CUALQUIER
--  LADO CON MALA CONTRASEÑA
CREATE USER 'todito'@'%' IDENTIFIED BY 'todito';
GRANT ALL ON *.* TO 'todito'@'%';
SHOW GRANTS FOR 'todito'@'%';

-- DENEGAR TODOS LOS PERMISOS
REVOKE ALL ON *.* FROM 'todito'@'%';

-- CREAR UN USUARIO CON ACCESO UNICO DESDE UNA IP ESTABLECIDA
CREATE USER 'deivid'@'172.16.102.30' IDENTIFIED BY 'deivid123';
GRANT SELECT,UPDATE,INSERT,DELETE ON mysql2_dia4.persona TO 'deivid'@'172.16.102.30';

-- Crear un usuario con acceso desde cualquier parte
CREATE USER 'deivid'@'172.16.102.30' IDENTIFIED BY 'deivid123';
GRANT SELECT ON mysql2_dia4.persona TO 'deivid'@'%';

-- Crear un limite para que solamente se hagan x consultas por hora
ALTER USER 'camper'@'%' WITH MAX_QUERIES_PER_HOUR 5;
FLUSH PRIVILEGES;

-- Revisar los limites o permisos que tiene un usuario a nivel de motor
SELECT * FROM mysql.user;
SELECT * FROM mysql.user WHERE HOST = '%';

-- elimiar usuarios
DROP user 'todito'@'%';

-- 	REVOCAR TODOS LOS PERMISOS DE CAMPER
REVOKE ALL ON *.* FROM 'camper'@'%';

-- Solo poner permisos para que consulte una X base de datos,
--  una Y tabla y una Z colimna
GRANT SELECT (nombre) ON mysql2_dia4.persona TO 'camper'@'%';

-- REALIZADO POR PAULA MUÑOZ /ID.1.095.953.057 
