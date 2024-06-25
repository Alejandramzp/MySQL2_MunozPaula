-- ##########################
-- ##### DIA 4 - MYSQL2 #####
-- ##########################

CREATE DATABASE auto_rental;
USE auto_rental;

CREATE TABLE vehiculo(
	id INT PRIMARY KEY,
    tipo VARCHAR(50),
    placa VARCHAR(20) NOT NULL,
    referencia VARCHAR(100) NOT NULL,
    modelo YEAR NOT NULL,
    puertas TINYINT(1),
    capacidad INT NOT NULL,
    sunroof TINYINT(1),
    motor VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL
);

CREATE TABLE cliente(
	id INT PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    celular VARCHAR(20) NOT NULL,
    correo VARCHAR(100)
);

CREATE TABLE sucursal(
	id INT PRIMARY KEY,
	ciudad VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    celular VARCHAR(20) NOT NULL,
    correo VARCHAR(100) NOT NULL
);

CREATE TABLE empleado(
	id INT PRIMARY KEY,
    id_sucursal INT NOT NULL,
    cedula VARCHAR(20) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    celular VARCHAR(20) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id)
);

CREATE TABLE alquiler(
	id INT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    sucursal_salida INT NOT NULL,
    fecha_salida DATE NOT NULL,
    sucursal_llegada INT NOT NULL,
    fecha_llegada DATE NOT NULL,
    fecha_esperada_llegada DATE NOT NULL,
    alquiler_semana DECIMAL(10,2) NOT NULL,
    alquiler_dia DECIMAL(10,2) NOT NULL,
    descuento FLOAT,
    valor_cotizado DECIMAL(10,2) NOT NULL,
    valor_pagado DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id),
    FOREIGN KEY (sucursal_salida) REFERENCES sucursal(id),
    FOREIGN KEY (sucursal_llegada) REFERENCES sucursal(id)
);

SHOW TABLES;

-- VEHICULO
INSERT INTO vehiculo VALUES ();

-- REALIZADO POR PAULA MUÑOZ /ID.1.095.953.057 