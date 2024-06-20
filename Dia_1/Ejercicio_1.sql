-- ###########################
-- #####  EJERCICIO DIA1  ####
-- ###########################


create database Dia1;

use Dia1;

create table medico(
	id INT(10) primary key,
    nombre VARCHAR(25) not null,
    direccion VARCHAR(25) not null,
    telefono VARCHAR(10),
    poblacion VARCHAR(25),
    provincia VARCHAR(25),
    codigo_postal VARCHAR(25),
    NIF VARCHAR(10) not null,
    seguridad_social VARCHAR(20)  not null,
    colegiado VARCHAR(20) unique not null,
    tipo ENUM('Titular','Interino','Sustituto') not null
);


create table empleado(
	id INT(10) primary key,
    nombre VARCHAR(25) not null,
    direccion VARCHAR(25) not null,
    telefono VARCHAR(10),
    poblacion VARCHAR(25),
    provincia VARCHAR(25),
    codigo_postal VARCHAR(25),
    NIF VARCHAR(10) not null,
    seguridad_social VARCHAR(20)  not null,
    tipo_empleado ENUM('ATS', 'ATS de Zona', 'Auxiliar de Enfermería', 'Celador', 'Administrativo') not null
);

create table paciente(
	id INT(10) primary key,
    nombre VARCHAR(25) not null,
    direccion VARCHAR(25) not null,
    telefono VARCHAR(10),
    codigo_postal VARCHAR(25),
    NIF VARCHAR(10) not null,
    seguridad_social VARCHAR(20)  not null,
    id_medico INT(10),
    foreign key (id_medico)references medico(id)
);

create table consulta(
	id INT(10) primary key,
    id_medico INT(10) not null,
    dia_semana ENUM('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo') not null,
    horario TIME not null,
    foreign key(id_medico)references medico(id)
);

create table sustitucion(
	id INT(10) primary key,
    id_medico INT(10) not null,
    fecha_alta DATE not null,
    fecha_baja DATE not null,
    foreign key (id_medico)references medico(id)
);

create table vacaciones(
	id INT(10) primary key,
    id_empleado INT(10) not null,
	id_medico INT(10) not null,
    fecha_inicio DATE not null,
    fecha_fin DATE not null,
    foreign key(id_empleado)references empleado(id),
    foreign key(id_medico)references medico(id)
);

show tables;

-- MEDICO
INSERT INTO medico VALUES (1, 'Dr. Juan Pérez', 'Calle Falsa 123', '555-1234', 'Madrid', 'Madrid', '28001', '12345678A', 'SS12345678', 'COL123456', 'Titular');
INSERT INTO medico VALUES (2, 'Dr. Ana López', 'Av. Siempre Viva 742', '555-5678', 'Barcelona', 'Barcelona', '08001', '87654321B', 'SS87654321', 'COL876543', 'Interino');
INSERT INTO medico VALUES (3, 'Dr. Carlos García', 'Plaza Mayor 1', '555-8765', 'Valencia', 'Valencia', '46001', '45678912C', 'SS45678912', 'COL456789', 'Sustituto');
INSERT INTO medico VALUES (4, 'Dr. Laura Martínez', 'Calle Real 5', '555-4321', 'Sevilla', 'Sevilla', '41001', '23456789D', 'SS23456789', 'COL234567', 'Titular');
INSERT INTO medico VALUES (5, 'Dr. Luis Fernández', 'Calle Sol 23', '555-8764', 'Málaga', 'Málaga', '29001', '34567890E', 'SS34567890', 'COL345678', 'Interino');
INSERT INTO medico VALUES (6, 'Dr. Carmen Gómez', 'Calle Luna 12', '555-6543', 'Bilbao', 'Vizcaya', '48001', '56789012F', 'SS56789012', 'COL567890', 'Sustituto');
INSERT INTO medico VALUES (7, 'Dr. Jorge Ruiz', 'Av. Principal 15', '555-9876', 'Zaragoza', 'Zaragoza', '50001', '67890123G', 'SS67890123', 'COL678901', 'Titular');
INSERT INTO medico VALUES (8, 'Dr. María Díaz', 'Calle Verde 45', '555-3456', 'Murcia', 'Murcia', '30001', '78901234H', 'SS78901234', 'COL789012', 'Interino');
INSERT INTO medico VALUES (9, 'Dr. David Sánchez', 'Calle Azul 67', '555-7890', 'Oviedo', 'Asturias', '33001', '89012345I', 'SS89012345', 'COL890123', 'Sustituto');
INSERT INTO medico VALUES (10, 'Dr. Paula Jiménez', 'Calle Blanca 89', '555-0123', 'Salamanca', 'Salamanca', '37001', '90123456J', 'SS90123456', 'COL901234', 'Titular');
INSERT INTO medico VALUES (11, 'Dr. Javier Rodríguez', 'Calle Roja 21', '555-1235', 'Córdoba', 'Córdoba', '14001', '01234567K', 'SS01234567', 'COL012345', 'Interino');
INSERT INTO medico VALUES (12, 'Dr. Teresa Hernández', 'Calle Amarilla 43', '555-5679', 'Alicante', 'Alicante', '03001', '12345678L', 'SS12345679', 'COL123457', 'Sustituto');
INSERT INTO medico VALUES (13, 'Dr. Francisco Moreno', 'Calle Naranja 65', '555-8767', 'Granada', 'Granada', '18001', '23456789M', 'SS23456780', 'COL234568', 'Titular');
INSERT INTO medico VALUES (14, 'Dr. Nuria Romero', 'Calle Morada 87', '555-4322', 'Santander', 'Cantabria', '39001', '34567890N', 'SS34567891', 'COL345679', 'Interino');
INSERT INTO medico VALUES (15, 'Dr. Alberto Gil', 'Calle Negra 109', '555-6544', 'Pamplona', 'Navarra', '31001', '45678901O', 'AS45678912', 'COL456790', 'Sustituto');

-- EMPLEADO
INSERT INTO empleado VALUES (1, 'Ana Torres', 'Calle Luna 123', '555-1111', 'Madrid', 'Madrid', '28001', '65432198A', 'SS65432198', 'ATS');
INSERT INTO empleado VALUES (2, 'Carlos Herrera', 'Calle Sol 456', '555-2222', 'Barcelona', 'Barcelona', '08001', '65432199B', 'SS65432199', 'ATS de zona');
INSERT INTO empleado VALUES (3, 'Laura Gómez', 'Av. Siempre Viva 789', '555-3333', 'Valencia', 'Valencia', '46001', '65432200C', 'SS65432200', 'Auxiliar de enfermeria');
INSERT INTO empleado VALUES (4, 'Pedro Martínez', 'Plaza Mayor 123', '555-4444', 'Sevilla', 'Sevilla', '41001', '65432201D', 'SS65432201', 'Celador');
INSERT INTO empleado VALUES (5, 'Lucía Fernández', 'Calle Real 456', '555-5555', 'Málaga', 'Málaga', '29001', '65432202E', 'SS65432202', 'Administrativo');
INSERT INTO empleado VALUES (6, 'Javier Sánchez', 'Calle Falsa 789', '555-6666', 'Bilbao', 'Vizcaya', '48001', '65432203F', 'SS65432203', 'ATS');
INSERT INTO empleado VALUES (7, 'Carmen Ruiz', 'Calle Verde 123', '555-7777', 'Zaragoza', 'Zaragoza', '50001', '65432204G', 'SS65432204', 'ATS de zona');
INSERT INTO empleado VALUES (8, 'Sergio López', 'Calle Blanca 456', '555-8888', 'Murcia', 'Murcia', '30001', '65432205H', 'SS65432205', 'Auxiliar de enfermeria');
INSERT INTO empleado VALUES (9, 'Patricia Díaz', 'Calle Azul 789', '555-9999', 'Oviedo', 'Asturias', '33001', '65432206I', 'SS65432206', 'Celador');
INSERT INTO empleado VALUES (10, 'David Rodríguez', 'Calle Roja 123', '555-1010', 'Salamanca', 'Salamanca', '37001', '65432207J', 'SS65432207', 'Administrativo');
INSERT INTO empleado VALUES (11, 'Isabel Jiménez', 'Calle Amarilla 456', '555-1112', 'Córdoba', 'Córdoba', '14001', '65432208K', 'SS65432208', 'ATS');
INSERT INTO empleado VALUES (12, 'Juan Moreno', 'Calle Morada 789', '555-1212', 'Alicante', 'Alicante', '03001', '65432209L', 'SS65432209', 'ATS de zona');
INSERT INTO empleado VALUES (13, 'Sandra Romero', 'Calle Naranja 123', '555-1313', 'Granada', 'Granada', '18001', '65432210M', 'SS65432210', 'Auxiliar de enfermeria');
INSERT INTO empleado VALUES (14, 'Raúl Gil', 'Calle Negra 456', '555-1414', 'Santander', 'Cantabria', '39001', '65432211N', 'SS65432211', 'Celador');
INSERT INTO empleado VALUES (15, 'Beatriz Pérez', 'Calle Roja 789', '555-1515', 'Pamplona', 'Navarra', '31001', '65432212O', 'SS65432212', 'Administrativo');

-- PACIENTE
INSERT INTO paciente VALUES (1, 'Mario Pérez', 'Calle Falsa 123', '555-1111', '28001', '12345678Z', 'SS12345678Z', 1);
INSERT INTO paciente VALUES (2, 'Lucía Torres', 'Calle Luna 456', '555-2222', '08001', '87654321X', 'SS87654321X', 2);
INSERT INTO paciente VALUES (3, 'Carlos Herrera', 'Av. Siempre Viva 789', '555-3333', '46001', '34567890W', 'SS34567890W', 3);
INSERT INTO paciente VALUES (4, 'Laura Gómez', 'Plaza Mayor 123', '555-4444', '41001', '23456789V', 'SS23456789V', 4);
INSERT INTO paciente VALUES (5, 'Pedro Martínez', 'Calle Real 456', '555-5555', '29001', '45678901U', 'SS45678901U', 5);
INSERT INTO paciente VALUES (6, 'Ana Ruiz', 'Calle Sol 789', '555-6666', '48001', '67890123T', 'SS67890123T', 6);
INSERT INTO paciente VALUES (7, 'María López', 'Calle Verde 123', '555-7777', '50001', '89012345S', 'SS89012345S', 7);
INSERT INTO paciente VALUES (8, 'Luis Gómez', 'Calle Blanca 456', '555-8888', '30001', '01234567R', 'SS01234567R', 8);
INSERT INTO paciente VALUES (9, 'Elena Sánchez', 'Calle Azul 789', '555-9999', '33001', '34567890Q', 'SS34567890Q', 9);
INSERT INTO paciente VALUES (10, 'Miguel Fernández', 'Calle Roja 123', '555-1010', '37001', '56789012P', 'SS56789012P', 10);
INSERT INTO paciente VALUES (11, 'Patricia Jiménez', 'Calle Amarilla 456', '555-1112', '14001', '78901234O', 'SS78901234O', 11);
INSERT INTO paciente VALUES (12, 'David Rodríguez', 'Calle Morada 789', '555-1212', '03001', '90123456N', 'SS90123456N', 12);
INSERT INTO paciente VALUES (13, 'Isabel Moreno', 'Calle Naranja 123', '555-1313', '18001', '12345678M', 'SS12345678M', 13);
INSERT INTO paciente VALUES (14, 'Sandra Romero', 'Calle Negra 456', '555-1414', '39001', '34567890L', 'SS34567890L', 14);
INSERT INTO paciente VALUES (15, 'Raúl Gil', 'Calle Roja 789', '555-1515', '31001', '56789012K', 'SS56789012K', 15);

-- CONSULTA
INSERT INTO consulta VALUES (1, 1, 'Lunes', '08:00:00');
INSERT INTO consulta VALUES (2, 1, 'Martes', '08:00:00');
INSERT INTO consulta VALUES (3, 2, 'Miércoles', '08:00:00');
INSERT INTO consulta VALUES (4, 2, 'Jueves', '08:00:00');
INSERT INTO consulta VALUES (5, 3, 'Viernes', '08:00:00');
INSERT INTO consulta VALUES (6, 3, 'Sábado', '08:00:00');
INSERT INTO consulta VALUES (7, 4, 'Domingo', '08:00:00');
INSERT INTO consulta VALUES (8, 4, 'Lunes', '09:00:00');
INSERT INTO consulta VALUES (9, 5, 'Martes', '09:00:00');
INSERT INTO consulta VALUES (10, 5, 'Miércoles', '09:00:00');
INSERT INTO consulta VALUES (11, 6, 'Jueves', '09:00:00');
INSERT INTO consulta VALUES (12, 6, 'Viernes', '09:00:00');
INSERT INTO consulta VALUES (13, 7, 'Sábado', '09:00:00');
INSERT INTO consulta VALUES (14, 7, 'Domingo', '09:00:00');
INSERT INTO consulta VALUES (15, 8, 'Lunes', '10:00:00');

-- SUSTITUCION
INSERT INTO sustitucion VALUES (1, 3, '2023-01-01', '2023-01-15');
INSERT INTO sustitucion VALUES (2, 3, '2023-02-01', '2023-02-15');
INSERT INTO sustitucion VALUES (3, 6, '2023-03-01', '2023-03-15');
INSERT INTO sustitucion VALUES (4, 6, '2023-04-01', '2023-04-15');
INSERT INTO sustitucion VALUES (5, 9, '2023-05-01', '2023-05-15');
INSERT INTO sustitucion VALUES (6, 9, '2023-06-01', '2023-06-15');
INSERT INTO sustitucion VALUES (7, 12, '2023-07-01', '2023-07-15');
INSERT INTO sustitucion VALUES (8, 12, '2023-08-01', '2023-08-15');
INSERT INTO sustitucion VALUES (9, 15, '2023-09-01', '2023-09-15');
INSERT INTO sustitucion VALUES (10, 15, '2023-10-01', '2023-10-15');
INSERT INTO sustitucion VALUES (11, 3, '2023-11-01', '2023-11-15');
INSERT INTO sustitucion VALUES (12, 6, '2023-12-01', '2023-12-15');
INSERT INTO sustitucion VALUES (13, 9, '2023-01-16', '2023-01-31');
INSERT INTO sustitucion VALUES (14, 12, '2023-02-16', '2023-02-28');
INSERT INTO sustitucion VALUES (15, 15, '2023-03-16', '2023-03-31');

-- VACACIONES
INSERT INTO vacaciones VALUES (1, 1, 1, '2023-06-01', '2023-06-15');
INSERT INTO vacaciones VALUES (2, 2, 1, '2023-07-01', '2023-07-15');
INSERT INTO vacaciones VALUES (3, 3, 2, '2023-08-01', '2023-08-15');
INSERT INTO vacaciones VALUES (4, 4, 2, '2023-09-01', '2023-09-15');
INSERT INTO vacaciones VALUES (5, 5, 3, '2023-10-01', '2023-10-15');
INSERT INTO vacaciones VALUES (6, 6, 3, '2023-11-01', '2023-11-15');
INSERT INTO vacaciones VALUES (7, 7, 4, '2023-12-01', '2023-12-15');
INSERT INTO vacaciones VALUES (8, 8, 4, '2023-01-01', '2023-01-15');
INSERT INTO vacaciones VALUES (9, 9, 5, '2023-02-01', '2023-02-15');
INSERT INTO vacaciones VALUES (10, 10, 5, '2023-03-01', '2023-03-15');
INSERT INTO vacaciones VALUES (11, 11, 6, '2023-04-01', '2023-04-15');
INSERT INTO vacaciones VALUES (12, 12, 6, '2023-05-01', '2023-05-15');
INSERT INTO vacaciones VALUES (13, 13, 7, '2023-06-01', '2023-06-15');
INSERT INTO vacaciones VALUES (14, 14, 7, '2023-07-01', '2023-07-15');
INSERT INTO vacaciones VALUES (15, 15, 8, '2023-08-01', '2023-08-15');


-- 1. Número de pacientes atendidos por cada médico

select medico.id, medico.nombre, count(paciente.id) as num_pacientes
from medico
left join paciente on medico.id = paciente.id_medico
group by  medico.id;

-- REALIZADO POR PAULA MUÑOZ / ID.1.095.953.057
