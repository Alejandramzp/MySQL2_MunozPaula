-- #####################
-- ### MySQL2  DIA 2 ###
-- #####################

CREATE DATABASE mysql2_dia2;

USE mysql2_dia2;

CREATE TABLE productos(
    id INT auto_increment,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    PRIMARY KEY(id)
);

INSERT INTO productos VALUES
    (1,"Pepito",23.2),
    (2,"MousePad",100000.21),
    (3,"Espionap",2500.25),
    (4,"BOB-ESPONJA",1500.25),
    (5,"Cary",23540000.23),
    (6,"OvulAPP",198700.23),
    (7,"PapayAPP",2000.00),
    (8,"Menosprecio",3800.00),
    (9,"PerfumeMascotas",2300.00),
    (10,"Perfume La Cumbre", 35000.25),
    (11,"Nevera M800",3000.12),
    (12,"Crema Suave", 2845.00),
    (13,"juego de mesa La Cabellera",9800.00),
    (14,"Cargador iPhone",98000.00);

-- Para crear una funcion la cual me retorne el nombre del producto con el precio mas iva(19%)
-- donde si vale mas de 1000 se aplica un descuento del 20%
DELIMITER //
CREATE FUNCTION TotalConIva(precio DECIMAL(10,2), iva DECIMAL(5,3))
RETURNS VARCHAR(255) DETERMINISTIC 
BEGIN
	IF precio > 1000 THEN
		RETURN CONCAT('Tu precio con el descuento es de: ',(precio+(precio*iva))-((precio+(precio*iva))*0.2));
	ELSE
		RETURN CONCAT('Tu precio completo es de: ',precio+(precio*iva));
    END IF;
END//
DELIMITER ;

-- Utilizar la funcion iva:
SELECT TotalConIva(25000,0.19);  

-- Eliminar funcion
DROP FUNCTION TotalConIva;

-- Extrapolar funcion con datos de la base de datos
SELECT TotalConIva(precio,0.19)
FROM productos;

-- Funcion para obtener el precio de un producto dado su nombre
DELIMITER //
CREATE FUNCTION obtener_precio_producto(nombre_producto VARCHAR(100))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE precio_producto DECIMAL(10,2);
    SELECT precio INTO precio_producto FROM productos
    WHERE nombre = nombre_producto;
    RETURN precio_producto;
END//
DELIMITER ;

-- Eliminar funcion
DROP FUNCTION obtener_precio_producto_prom;

-- Usar funcion
SELECT obtener_precio_producto('Pepito') AS Precio;

-- Función para obtener el precio de un producto (con su iva y promoción) dado su nombre
DELIMITER //
CREATE FUNCTION obtener_precio_producto_prom(nombre_producto VARCHAR(100), iva DECIMAL(5,3))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE precio_producto DECIMAL(10,2);
    SELECT precio INTO precio_producto FROM productos
    WHERE nombre = nombre_producto;
    IF precio_producto > 1000 THEN
		RETURN precio_producto+(precio_producto*iva)-(precio_producto+(precio_producto*iva))*0.2;
	ELSE
		RETURN precio_producto+(precio_producto*iva);
    END IF;
END//
DELIMITER ;

-- Usar funcion
SELECT obtener_precio_producto_prom('Pepito',0.19) AS Precio;

-- Eliminar funcion
DROP FUNCTION obtener_precio_producto_prom;

-- Funcion para calcular el precio promedio de todos los productos
DELIMITER //
CREATE FUNCTION precio_promedio_productos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE promedio DECIMAL(10,2);
    SELECT AVG(precio) INTO promedio from productos;
    RETURN promedio;
END //
DELIMITER ;

-- Usar funcion
SELECT precio_promedio_productos();

-- Procedimiento para insertar un nuevo producto
DELIMITER //
CREATE PROCEDURE insertar_producto(IN nombre_producto VARCHAR(100),
IN precio_producto DECIMAL(10,2))
BEGIN
	INSERT INTO productos (nombre,precio)
    VALUES (nombre_producto,precio_producto);
END//
DELIMITER ;

CALL insertar_producto('Gorra',50000.00);
SELECT * FROM productos;

-- Procedimiento para eliminar un producto dado su nombre
DELIMITER //
CREATE PROCEDURE eliminar_producto(IN nombre_producto VARCHAR(100))
BEGIN
	DELETE FROM productos WHERE nombre = nombre_producto;
END//
DELIMITER ;

-- Eliminar procedimiento
DROP PROCEDURE eliminar_producto;

CALL eliminar_producto('Gorra');
SELECT * FROM productos;

-- REALIZADO POR PAULA MUÑOZ/ID.1.095.953.057
