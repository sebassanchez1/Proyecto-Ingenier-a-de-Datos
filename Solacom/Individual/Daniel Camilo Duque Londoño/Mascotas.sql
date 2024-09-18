-- 1 Crear base de datos

CREATE DATABASE Mascotas;
USE Mascotas;
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
use Mascotas;
select * from Mascota;
select * from Producto;
select * from Vacuna;
select * from Cliente;
describe Mascota;
describe Producto;
describe Vacuna;
describe Cliente;
insert into Mascota values('','Rusth','M',1);
insert into Mascota values(2,'Negra','F',1),(3,'Milo','M',1);
insert into Producto values(1,'shampoo','pets',15000,6658),(2,'Comida','hills',35000,52354);
insert into Vacuna values(1,'tetano',5,'tetano');
insert into Vacuna values(2,'pulgas',15,'pulgas');
insert into Cliente values(658,'Daniel','Duque','calle76',845231,6),(569,'Juan','Garcia','calle85',849683,7);



