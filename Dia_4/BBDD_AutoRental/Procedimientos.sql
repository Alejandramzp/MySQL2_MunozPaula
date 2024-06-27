-- ##########################
-- ##### PROCEDIMIENTOS #####
-- ##########################

USE auto_rental;

-- Consulta de disponibilidad de vehículos para alquiler por tipo de vehículo, rango de
-- precios de alquiler y fechas de disponibilidad.

DELIMITER //
CREATE PROCEDURE disponibilidad_vehiculos()
BEGIN
	SELECT DISTINCT v.id,v.tipo,v.placa,v.referencia,v.modelo,v.color,a.alquiler_semana,a.alquiler_dia
	FROM vehiculo v
	INNER JOIN alquiler a ON a.id_vehiculo = v.id
	WHERE (a.fecha_llegada < a.fecha_esperada_llegada) AND (v.tipo = 'Deportivo') 
	AND (a.alquiler_semana BETWEEN 150 AND 200); 
END //
DELIMITER ;

CALL disponibilidad_vehiculos;

-- Alquiler de vehículos.

DELIMITER //
CREATE PROCEDURE alquiler_vehiculos()
BEGIN
	SELECT * FROM alquiler;
END //
DELIMITER ;

CALL alquiler_vehiculos;

-- Consulta de historial de alquileres.

DELIMITER //
CREATE PROCEDURE historial_alquileres()
BEGIN
	SELECT v.tipo,v.placa,v.referencia,v.modelo,v.motor,v.color,
    CONCAT(c.nombres,' ',c.apellidos,' CC.',c.cedula) AS Cliente,
    CONCAT(e.nombres,' ',e.apellidos,' CC.',e.cedula) AS Empleado, s.ciudad AS Sucursal,
    a.fecha_salida,a.fecha_llegada,a.fecha_esperada_llegada
    FROM alquiler a
    INNER JOIN vehiculo v ON v.id = a.id_vehiculo
    INNER JOIN cliente c ON c.id = a.id_cliente
    INNER JOIN empleado e ON e.id = a.id_empleado
    INNER JOIN sucursal s ON s.id = e.id_sucursal;
END //
DELIMITER ;

CALL historial_alquileres();

-- Si un cliente entrega el vehículo pasada la fecha de entrega contratada, se cobrarán los días
-- adicionales con un incremento del 8%.

DELIMITER //
CREATE FUNCTION incremento_retraso(id_vehiculo INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE Valor_incremento DECIMAL(10,2) DEFAULT 0.00;
    DECLARE dias INT;
    DECLARE fecha_llegada2 DATE;
    DECLARE fecha_esperada_llegada2 DATE;
    DECLARE alquiler_dia2 DECIMAL(10,2);
    
    SELECT fecha_llegada, fecha_esperada_llegada, alquiler_dia 
    INTO fecha_llegada2, fecha_esperada_llegada2, alquiler_dia2
    FROM alquiler
    WHERE alquiler.id_vehiculo = id_vehiculo
    LIMIT 1;
    
    IF fecha_llegada2 > fecha_esperada_llegada2 THEN
        SET dias = DATEDIFF(fecha_llegada2, fecha_esperada_llegada2);
        SET Valor_incremento = (alquiler_dia2 * dias * 1.08);
    END IF;
    
    RETURN Valor_incremento;
END //
DELIMITER ;

-- TEST
SELECT incremento_retraso(20);

DROP FUNCTION incremento_retraso;
