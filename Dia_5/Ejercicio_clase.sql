-- ##########################
-- ##### DIA 5 - MYSQL2 #####
-- ##########################

CREATE DATABASE mysql2_dia5;
USE mysql2_dia5;

SELECT * FROM country;	
SELECT * FROM city;

-- Trigger para insertar o actualizar una ciudad
DELIMITER //
CREATE TRIGGER after_city_insert_update
AFTER INSERT ON city
FOR EACH ROW
BEGIN
	UPDATE country
    SET Population = Population + NEW.Population
    WHERE CODE = NEW.CountryCode;
END //
DELIMITER ;

-- Test 
INSERT INTO city (Name,CountryCode,District,Population)
VALUES ('Artemis','AFG','Piso 6',1250000); 

-- Trigger cuando se elimina una ciudad
DELIMITER //
CREATE TRIGGER after_city_delete
AFTER DELETE ON city
FOR EACH ROW
BEGIN
	UPDATE country
    SET Population = Population - OLD.Population
    WHERE CODE = OLD.CountryCode;
END //
DELIMITER ;

-- Test 
SELECT * FROM city WHERE Name = 'Artemis';
DELETE FROM city WHERE ID = 4080;

-- Crear una tabla para auditoria de ciudad
CREATE TABLE IF NOT EXISTS city_audit (
	audit_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT,
    action VARCHAR(10),
    old_population INT,
    new_population INT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para auditoria de ciudades cuando se inserta
DELIMITER //
CREATE TRIGGER after_city_insert_audit
AFTER INSERT ON city
FOR EACH ROW
BEGIN
	INSERT INTO city_audit(city_id,action,new_population)
    VALUES (NEW.ID,'INSERT',NEW.Population);
END //
DELIMITER ;

-- Test 
SELECT * FROM city_audit;
INSERT INTO city (Name,CountryCode,District,Population)
VALUES ('Artemis','AFG','Piso 6',1250000); 

-- Trigger para auditoria de ciudades cuando se actualiza
DELIMITER //
CREATE TRIGGER after_city_update_audit
AFTER UPDATE ON city
FOR EACH ROW
BEGIN
	INSERT INTO city_audit(city_id,action,old_population,new_population)
    VALUES (OLD.ID,'UPDATE',OLD.Population,NEW.Population);
END //
DELIMITER ;

-- Test
UPDATE city SET Population = 1550000 WHERE ID=4084;
SELECT * FROM city_audit;

-- ###########################################
-- EVENTOS
-- CREACION DE TABLA PARA BK DE CIUDADES
CREATE TABLE IF NOT EXISTS city_backup (
	ID INT NOT NULL,
    Name CHAR(35) NOT NULL,
    CountryCode CHAR(3) NOT NULL,
    District CHAR(20) NOT NULL,
    Population INT NOT NULL,
    PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

DELIMITER //
CREATE EVENT IF NOT EXISTS weekly_city_backup
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
	TRUNCATE TABLE city_backup;
    INSERT INTO city_backup(ID,Name,CountryCode,District,Population)
    SELECT ID,Name,CountryCode,District,Population FROM city;
END;
DELIMITER ;