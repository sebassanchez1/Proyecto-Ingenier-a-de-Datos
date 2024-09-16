/* punto 1 */
CREATE DATABASE Mascotas;
use Mascotas;

/* punto 2 */
-- tabla cliente
CREATE TABLE Cliente (
	cedulaCliente INT(11) primary key,
    nombreCliente varchar(15),
    apellidoCliente varchar(15),
    direccionCliente varchar(15),
    telefono int(10),
    idMascitaFK int(11)
);

-- tabla producto
CREATE TABLE Producto (
	codigoProducto int(11) primary key,
    nombreProducto varchar(10),
    marca varchar(15),
    precio float,
    cedulaClienteFK int(11)
);
-- tabla Mascota
CREATE TABLE Mascota (
idMascota int(11) primary key,
nombreMascota varchar(15),
generoMascota varchar(15),
cantidad int(10)
);
-- tabla Mascota_vacuna
CREATE TABLE mascota_vacuna (
codigoVacunaFK int(11),
idMascotaFK int(11),
enfermedad varchar(15)
);
-- tabla vacuna
CREATE TABLE Vacuna (
codigoVacuna int(11) primary key,
nombreVacuna varchar(15),
dosisVacuna int(15),
enfermedasd varchar(15)
);

/* punto 3 */

ALTER TABLE Producto 
add constraint codigoProducto
foreign key cedulaClienteFK
reference Cliente (cedulaCliente)


ALTER TABLE Cliente 
add constraint cedulaCliente
foreign key idMascotaFK
reference Mascota (idMascota)

ALTER TABLE Mascota
add constraint idMascota
reference Mascota (idMascota)

ALTER TABLE  Vacuna
add constraint codigoVacuna
foreign key codigoVacunaFK
reference mascota_vacuna (enfermedad)

