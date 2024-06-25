-- ###############################
-- ##### AutoRental - MYSQL2 #####
-- ###############################

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
INSERT INTO vehiculo (id, tipo, placa, referencia, modelo, puertas, capacidad, sunroof, motor, color) VALUES
(1, 'Sedán', 'ABC123', 'Toyota Corolla', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(2, 'Compacto', 'XYZ789', 'Honda Civic', 2021, 4, 5, 1, 'Gasolina', 'Blanco'),
(3, 'SUV', 'DEF456', 'Mitsubishi Outlander', 2020, 5, 7, 0, 'Híbrido', 'Gris'),
(4, 'Camioneta Platón', 'GHI789', 'Toyota Hilux', 2019, 4, 5, 0, 'Diesel', 'Negro'),
(5, 'Deportivo', 'JKL321', 'Ford Mustang', 2023, 2, 4, 0, 'Gasolina', 'Azul'),
(6, 'SUV', 'MNO987', 'Kia Sportage', 2021, 5, 5, 0, 'Gasolina', 'Plata'),
(7, 'Sedán', 'PQR456', 'Chevrolet Spark', 2022, 4, 4, 0, 'Gasolina', 'Blanco'),
(8, 'Camioneta Lujo', 'STU789', 'Nissan Pathfinder', 2020, 4, 7, 0, 'Gasolina', 'Rojo'),
(9, 'SUV', 'VWX123', 'Hyundai Tucson', 2021, 5, 5, 1, 'Gasolina', 'Negro'),
(10, 'Compacto', 'YZA789', 'Volkswagen Golf', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(11, 'Deportivo', 'BCD456', 'Subaru WRX', 2020, 2, 4, 0, 'Gasolina', 'Rojo'),
(12, 'Camioneta Platón', 'EFG789', 'Ford Ranger', 2021, 4, 5, 0, 'Diesel', 'Negro'),
(13, 'Sedán', 'HIJ321', 'BMW Serie 3', 2022, 4, 5, 0, 'Gasolina', 'Blanco'),
(14, 'SUV', 'KLM987', 'Mazda CX-5', 2020, 5, 5, 1, 'Gasolina', 'Rojo'),
(15, 'Deportivo', 'NOP456', 'Chevrolet Camaro', 2023, 2, 4, 0, 'Gasolina', 'Gris'),
(16, 'SUV', 'QRS123', 'Jeep Grand Cherokee', 2021, 5, 5, 0, 'Gasolina', 'Negro'),
(17, 'Camioneta Lujo', 'TUV789', 'Range Rover Velar', 2019, 4, 5, 0, 'Diesel', 'Azul'),
(18, 'Compacto', 'WXY321', 'Seat Ibiza', 2022, 4, 5, 0, 'Gasolina', 'Blanco'),
(19, 'SUV', 'ZAB987', 'Volvo XC60', 2020, 5, 5, 1, 'Gasolina', 'Negro'),
(20, 'Sedán', 'CDE456', 'Hyundai Elantra', 2023, 4, 5, 0, 'Gasolina', 'Gris'),
(21, 'Deportivo', 'FGH123', 'Porsche 911', 2021, 2, 4, 0, 'Gasolina', 'Rojo'),
(22, 'Camioneta Platón', 'IJK789', 'Toyota Tacoma', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(23, 'Compacto', 'LMN321', 'Renault Clio', 2022, 4, 5, 0, 'Gasolina', 'Blanco'),
(24, 'SUV', 'OPQ987', 'Honda CR-V', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(25, 'Deportivo', 'RST456', 'Ford Mustang GT', 2023, 2, 4, 0, 'Gasolina', 'Azul'),
(26, 'SUV', 'UVW123', 'Tesla Model X', 2021, 5, 5, 0, 'Eléctrico', 'Blanco'),
(27, 'Camioneta Lujo', 'XYZ789', 'Mercedes-Benz GLE', 2019, 4, 5, 0, 'Gasolina', 'Negro'),
(28, 'Compacto', 'ABC456', 'Peugeot 208', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(29, 'SUV', 'DEF123', 'Lexus NX', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(30, 'Sedán', 'GHI789', 'Audi A3', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(31, 'Deportivo', 'JKL456', 'BMW M4', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(32, 'Camioneta Platón', 'MNO123', 'Ram 1500', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(33, 'Compacto', 'PQR789', 'Kia Rio', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(34, 'SUV', 'STU123', 'Infiniti QX60', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(35, 'Sedán', 'VWX456', 'Volvo S60', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(36, 'Deportivo', 'YZA123', 'Ford Mustang Mach-E', 2021, 4, 5, 0, 'Eléctrico', 'Blanco'),
(37, 'Camioneta Lujo', 'BCD789', 'Audi Q7', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(38, 'Compacto', 'EFG123', 'Renault Captur', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(39, 'SUV', 'HIJ789', 'Subaru Ascent', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(40, 'Sedán', 'KLM456', 'Chevrolet Malibu', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(41, 'Deportivo', 'NOP123', 'Nissan 370Z', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(42, 'Camioneta Platón', 'QRS789', 'Ford F-150', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(43, 'Compacto', 'TUV123', 'Hyundai Accent', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(44, 'SUV', 'WXY789', 'Jeep Wrangler', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(45, 'Sedán', 'ZAB123', 'Toyota Camry', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(46, 'Deportivo', 'CDE789', 'Honda Civic Type R', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(47, 'Camioneta Lujo', 'FGH123', 'Mercedes-Benz GLS', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(48, 'Compacto', 'IJK789', 'Ford Fiesta', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(49, 'SUV', 'LMN123', 'Mitsubishi Montero Sport', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(50, 'Sedán', 'OPQ789', 'Audi A4', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(51, 'Deportivo', 'RST456', 'Chevrolet Corvette', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(52, 'Camioneta Platón', 'UVW123', 'Chevrolet Silverado', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(53, 'Compacto', 'XYZ789', 'Volkswagen Polo', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(54, 'SUV', 'ABC456', 'Ford Escape', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(55, 'Sedán', 'DEF123', 'Hyundai Sonata', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(56, 'Deportivo', 'GHI789', 'BMW M2', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(57, 'Camioneta Lujo', 'JKL321', 'Lexus LX', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(58, 'Compacto', 'MNO987', 'Seat Arona', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(59, 'SUV', 'PQR456', 'Kia Telluride', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(60, 'Sedán', 'STU789', 'Mercedes-Benz Clase E', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(61, 'Deportivo', 'VWX123', 'Acura NSX', 2021, 2, 4, 0, 'Híbrido', 'Blanco'),
(62, 'Camioneta Platón', 'YZA789', 'Isuzu D-Max', 2020, 4, 5, 0, 'Diesel', 'Negro'),
(63, 'Compacto', 'BCD456', 'Renault Zoe', 2022, 4, 5, 0, 'Eléctrico', 'Rojo'),
(64, 'SUV', 'EFG789', 'Land Rover Discovery Sport', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(65, 'Sedán', 'HIJ321', 'Alfa Romeo Giulietta', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(66, 'Deportivo', 'KLM987', 'Subaru BRZ', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(67, 'Camioneta Lujo', 'NOP456', 'Cadillac Escalade', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(68, 'Compacto', 'QRS123', 'Mazda 2', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(69, 'SUV', 'TUV789', 'BMW X5', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(70, 'Sedán', 'WXY321', 'Volvo S90', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(71, 'Deportivo', 'ZAB987', 'Ford Focus RS', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(72, 'Camioneta Platón', 'CDE456', 'Chevrolet Luv D-Max', 2020, 4, 5, 0, 'Diesel', 'Negro'),
(73, 'Compacto', 'FGH123', 'Nissan Micra', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(74, 'SUV', 'IJK789', 'Toyota 4Runner', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(75, 'Sedán', 'LMN321', 'Honda Accord', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(76, 'Deportivo', 'OPQ987', 'Toyota Supra', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(77, 'Camioneta Lujo', 'RST456', 'Mercedes-Benz G-Class', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(78, 'Compacto', 'UVW123', 'Hyundai i20', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(79, 'SUV', 'XYZ789', 'Audi Q5', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(80, 'Sedán', 'ABC456', 'Renault Fluence', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(81, 'Deportivo', 'DEF123', 'Chevrolet Camaro ZL1', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(82, 'Camioneta Platón', 'GHI789', 'Isuzu NPR', 2020, 4, 5, 0, 'Diesel', 'Negro'),
(83, 'Compacto', 'JKL321', 'Seat Leon', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(84, 'SUV', 'MNO987', 'Subaru Outback', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(85, 'Sedán', 'PQR456', 'BMW Serie 5', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(86, 'Deportivo', 'STU789', 'Ford Focus ST', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(87, 'Camioneta Lujo', 'VWX123', 'Lexus GX', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(88, 'Compacto', 'YZA789', 'Volkswagen Up!', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(89, 'SUV', 'BCD456', 'Jeep Renegade', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(90, 'Sedán', 'EFG789', 'Audi A6', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(91, 'Deportivo', 'HIJ321', 'Toyota GR Supra', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(92, 'Camioneta Platón', 'KLM987', 'Ford Super Duty', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(93, 'Compacto', 'NOP456', 'Ford Fiesta ST', 2022, 4, 5, 0, 'Gasolina', 'Rojo'),
(94, 'SUV', 'QRS123', 'Mitsubishi Pajero', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(95, 'Sedán', 'TUV789', 'Mercedes-Benz Clase S', 2023, 4, 5, 0, 'Gasolina', 'Azul'),
(96, 'Deportivo', 'WXY321', 'Subaru Impreza WRX', 2021, 2, 4, 0, 'Gasolina', 'Blanco'),
(97, 'Camioneta Lujo', 'ZAB987', 'Range Rover Sport', 2020, 4, 5, 0, 'Gasolina', 'Negro'),
(98, 'Compacto', 'CDE456', 'Renault Zoe', 2022, 4, 5, 0, 'Eléctrico', 'Rojo'),
(99, 'SUV', 'FGH123', 'Volvo XC90', 2020, 5, 5, 1, 'Gasolina', 'Gris'),
(100, 'Sedán', 'IJK789', 'Honda Civic Si', 2023, 4, 5, 0, 'Gasolina', 'Azul');

-- CLIENTE

-- SUCURSAL
INSERT INTO sucursal (id,ciudad,direccion,telefono,celular,correo) VALUES
(1,'Bogotá','Carrera 14 # 41-20','601-3198300','300 539 8812','sucursal.bogota@autorental.com'),
(2,'Medellín','Carrera 30 # 91-10','604-3405529','315 587 7773','sucursal.medellin@autorental.com'),
(3,'Cali','Calle 8 # 4-18','602-4226588','304 622 4412','sucursal.cali@autorental.com'),
(4,'Bucaramanga','Carrera 25 # 15-12','607-6754548','321 734 0621','sucursal.bucaramanga@autorental.com'),
(5,'Barranquilla','Calle 22 # 21-33','605-3207863','333 824 6566','sucursal.barranquillas@autorental.com');
-- EMPLEADO
select * 
from vehiculo
-- ALQUILER

-- REALIZADO POR PAULA MUÑOZ /ID.1.095.953.057 
