-- ####################
-- ##### USUARIOS #####
-- ####################

USE auto_rental;

-- Creacion de usuarios de AutoRent
CREATE USER 'administrador'@'%' IDENTIFIED BY 'administrador123';
CREATE USER 'ampleado'@'%' IDENTIFIED BY 'empleado456';
CREATE USER 'cliente'@'%' IDENTIFIED BY 'cliente789';