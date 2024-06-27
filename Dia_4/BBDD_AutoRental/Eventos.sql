-- ##########################
-- ##### EVENTOS #####
-- ##########################

USE auto_rental;

--  Nueva columna en la tabla para saber si ya se cuenta con el descuento del aniversario
ALTER TABLE alquiler ADD COLUMN descuento_aplicado TINYINT(1) DEFAULT 0;

-- Evento anual por el aniversario de la empresa AutoRent 50% de descuento

DELIMITER //
CREATE EVENT descuento_anual
ON SCHEDULE EVERY 1 YEAR
STARTS '2024-06-27 00:00:00'
DO
BEGIN
    UPDATE alquiler
    SET 
        descuento = IFNULL(descuento, 0) + 0.50,
        valor_cotizado = valor_cotizado * 0.5,
        valor_pagado = valor_pagado * 0.5,
        descuento_aplicado = 1
    WHERE 
        descuento_aplicado = 0;
END//

DELIMITER ;

-- Insertar datos de prueba 
INSERT INTO alquiler (id, id_vehiculo, id_cliente, id_empleado, sucursal_salida, fecha_salida, sucursal_llegada, fecha_llegada, fecha_esperada_llegada, alquiler_semana, alquiler_dia, descuento, valor_cotizado, valor_pagado, descuento_aplicado)
VALUES (101, 60, 20, 46, 2, '2024-06-07', 2, '2024-06-08', '2024-06-09', 100.00, 26.00, 0, 800.00, 600.00, 0);

-- Verificar los datos actualizados
SELECT * FROM alquiler WHERE id = 101;
