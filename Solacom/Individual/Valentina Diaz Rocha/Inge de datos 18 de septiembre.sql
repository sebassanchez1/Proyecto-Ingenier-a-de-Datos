-- 1 Crear base de datos

-- CREATE DATABASE Mascotas;
USE Mascotas;
/*
-- 2 Crear tablas
-- Tabla Cliente
CREATE TABLE Cliente (
    cedulaCliente INT(11) auto_increment PRIMARY KEY,
    nombreCliente VARCHAR(15),
    apellidoCliente VARCHAR(15),
    direccionCliente VARCHAR(15),
    telefono INT(10),
    idMascotaFK INT(11)
);

-- Tabla Producto
CREATE TABLE Producto (
    codigoProducto INT(11) auto_increment PRIMARY KEY,
    nombreProducto VARCHAR(15), 
    marca VARCHAR(15),
    precio FLOAT,
    cedulaClienteFK INT(11)
);

-- Tabla Mascota
CREATE TABLE Mascota (
    idMascota INT(11) auto_increment PRIMARY KEY,
    nombreMascota VARCHAR(15),
    generoMascota VARCHAR(15),
    razaMascota VARCHAR(15),
    cantidad INT(10)
);

-- Tabla Vacuna
CREATE TABLE Vacuna (
    CodigoVacuna INT(11) auto_increment PRIMARY KEY,
    nombreVacuna VARCHAR(15),
    dosisVacuna INT(15),
    enfermedad VARCHAR(15)
);


-- Tabla mascota_vacuna
CREATE TABLE mascota_vacuna (
    CodigoVacunaFK INT(11),
    idMascotaFK INT(11),
    enfermedad VARCHAR(15)
);

-- 3 Crear relaciones

alter table Cliente
add constraint FKClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);


alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);


alter table mascota_vacuna
add constraint FKmascota_vacunaMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table mascota_vacuna
add constraint FKmascota_vacunaVacuna
foreign key (CodigoVacunaFK)
references Vacuna(CodigoVacuna);

-- 4 Agregar cantidad en producto
alter table Producto
ADD COLUMN cantidad Int(15) NOT NULL;

-- 5 Cambiar nombre cantidad por cantidadmascota en mascota
ALTER TABLE Mascota
CHANGE COLUMN cantidad cantidadMascota INT(10);

-- 6 cambiar de mascota_vacuna a DETALLE VACUNA
ALTER TABLE mascota_vacuna
RENAME detalleVacuna;
*/
 select * from Cliente;
describe Cliente;
insert into Cliente values(132968534,'Valentina','Rojas','Calle 85A#9-6',3152469856,1);
insert into Cliente values(13296569,'David ','Hernandez','Calle 85A#9-6',3152469856,1);
select * from Mascota;
describe Mascota;
insert into Mascota values(1,'Snow','M','criollo','1'),(2,'London','F','Persa','1'),(3,'Milan','M','pomerania','2');
UPDATE Mascota set razaMascota= 'pomerania' where idMascota= 3;
describe Vacuna;
insert into Vacuna values(1,'Vacuna1','3','Rabia'),(2,'Vacuna2','2','Moquillo'),(3,'Vacuna','2','Leucosis');
select * from Vacuna;

select * from Producto;
describe Producto;
insert into Producto values(236,'Concentrado_gatos','BR',100,132968534,2),(156,'Gimnasio_gatos','ColombiaCarpinteros',300,132968534,1);

select * from detalleVacuna;
insert into detalleVacuna values(1,1,'Rabia'),(3,2,'Moquillo');