/* Punto 1 */
create database Mascotas;
use mascotas;

/* Punto 2*/
create table Cliente(
cedulaCliente int(11) primary key, 
nombreCliente varchar(15),
apellidoCliente varchar(15),
direccionCliente varchar(15),
telefono int(10),
idMascotaFK int(11) not null 
);

create table Producto(
codigoProducto int(11) primary key,
nombreProducto varchar(15),
marca varchar(15), 
precio float,
cedulaClienteFK int(11) not null
);

create table Mascota(
idMascota int(11) primary key,
nombreMascota varchar(15),
generoMascota varchar (15),
razaMascota varchar(15),
cantidad int(10)
);

create table mascota_vacuna(
codigoVacunaFK int(11) not null,
idMascotaFK int(11) not null,
enfermedad varchar(15)
);

create table Vacuna(
codigoVacuna int(11) primary key,
nombreVacuna varchar(15),
dosisVacuna int(10),
enfermedad varchar(15)
);

/* Punto 3*/
alter table Producto 
add constraint ClienteProducto
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Cliente
add constraint ClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table mascota_vacuna
add constraint MascVacMasc
foreign key (idMascotaFK)
references Mascota(idMascota); 

alter table mascota_vacuna
add constraint MacsVacVac
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

/* Punto 4 */
alter table Producto 
add cantidad int not null;

/* Punto 5 */
alter table Mascota change column cantidad cantMascota int;

/* Punto 6 */
alter table mascota_vacuna rename detalle_vacuna 

/* Hecho por Sebastian Sanchez */
