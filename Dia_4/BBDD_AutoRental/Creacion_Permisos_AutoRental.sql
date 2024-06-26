-- ################################
-- ##### CREACION DE USUARIOS #####
-- ################################

USE auto_rental;

-- +++++++ Creacion de usuarios de AutoRent +++++++

-- ++++++++ Administrador ++++++++ 
CREATE USER 'administrador'@'%' IDENTIFIED BY 'administrador123';
GRANT SELECT,INSERT,UPDATE,DELETE ON auto_rental.* TO 'administrador'@'%';

-- ++++++++ Empleado ++++++++ 
CREATE USER 'empleado'@'%' IDENTIFIED BY 'empleado456';
GRANT SELECT,INSERT,UPDATE ON auto_rental.vehiculo to 'empleado'@'%';
GRANT SELECT,INSERT,UPDATE ON auto_rental.alquiler to 'empleado'@'%';

-- ++++++++ CLiente ++++++++ 
CREATE USER 'cliente'@'%' IDENTIFIED BY 'cliente789';
GRANT SELECT ON auto_rental.vehiculo to 'cliente'@'%';
GRANT SELECT ON auto_rental.alquiler to 'cliente'@'%';

SELECT * FROM mysql.user;

FLUSH PRIVILEGES;
