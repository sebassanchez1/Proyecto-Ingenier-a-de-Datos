-- 1
CREATE DATABASE TiendaOnline;
-- 2
use TiendaOnline;

-- 3
CREATE TABLE Producto(
codigoBarras INT(15) auto_increment PRIMARY KEY,
nombreProducto VARCHAR(15),
precioProducto float
);

CREATE TABLE Usuario(
idUsuario INT(11) PRIMARY KEY,
nombreUsuario VARCHAR(15),
emailUsuario VARCHAR(15),
rol VARCHAR(15),
telefonoUsuario INT(11)
);

CREATE TABLE Cliente(
idCliente INT(11) auto_increment PRIMARY KEY,
nombreCliente VARCHAR(15),
fechaNacimiento date
);

CREATE TABLE Ventas(
idVentas INT(11) auto_increment PRIMARY KEY,
fechaVenta VARCHAR(15),
idClienteFK INT(11),
idUsuarioFK INT(11)
);

CREATE TABLE Ventas_Producto(
codigoBarrasFK INT(11),
idVentasFK INT(11),
precioProductoFK int,
cantidad INT(11)
);

alter table Ventas
add constraint FKClienteVenta
foreign key (idClienteFK)
references Cliente(idCliente);

alter table Ventas
add constraint FKUsuarioVenta
foreign key (idUsuarioFK)
references Usuario(idUsuario);

alter table Ventas_Producto
add constraint FKVentas_Producto_Producto
foreign key (codigoBarrasFK)
references Producto(codigoBarras);

alter table Ventas_Producto
add constraint FKVentas_Producto_Venta
foreign key (idVentasFK)
references Ventas(idVentas);
 
describe Cliente;
insert into Cliente values(1,'Maria', '2008-19-12'),(2,'Sandra', '1979-04-24'), (3,'Omar', '1980-06-27'), (4,'Daniel', '2001-02-09');
update Cliente set fechaNacimiento = '2008-12-19' where idCliente = 1 ;
select * from Cliente;
describe Usuario;
insert into Usuario values(1,'Maria', 'Maria.1@gmail.com','Empleado',1234),(2,'Sandra', 'Sandra@hotmail.com','Empleado',9876), (3,'nikolas', 'nikolas@yahoo.com','Provedor',7654), (4,'Omar', 'Omar@gmail.com','Provedor',5489);
select * from Usuario;

describe Ventas;
insert into Ventas values(1,'03', 4,2),(2,'05', 4,4), (3,'07', 3,1), (4,'03', 2,3);
select * from Ventas;

describe Producto;
insert into Producto values(112,'Audifonos', 42.000),(113,'Labial', 14.300), (114,'Gamepass', 31.000), (115,'Reloj', 230.000);
select * from Producto;

describe Ventas_Producto;
insert into Ventas_Producto values(112,3,42.000,2),(113,2,14.300, 3), (114,1,31.000, 1), (115,2,230.000, 4);
select * from Ventas_Producto;

select * from Producto;
select * from Producto ORDER BY precioProducto ASC;
select * from Cliente where fechaNacimiento like '%09';
select * from Usuario where rol = 'Empleado';
select * from Ventas where fechaVenta between '03' and '04';
select * from Producto where nombreProducto like '%r%';
select * from Ventas;
select avg(idVentas) from Ventas;
select sum(idVentas) from Ventas;

use tiendaOnline;
describe Ventas_Producto;
describe Ventas;
select * from Ventas inner join Cliente on Ventas.idClienteFK = Cliente.idCliente;
-- consultar datos cliente de la maxima venta hecha
select Cliente.nombreCliente, Ventas.idClienteFK, Ventas_Producto.Cantidad, max(cantidad) from Ventas
inner join Cliente on Cliente.idCliente = Ventas.idClienteFK
inner join Ventas_Producto on Ventas.idVentas = Ventas_Producto.codigoBarrasFK;
-- consultar usuario y cliente de una venta especifica

-- SELECT V.idVentas, C.nombreCliente, U.nombreUsuario
-- FROM Ventas V
-- JOIN Cliente C ON V.idClienteFK = C.idCliente
-- JOIN Producto P ON V.idUsuarioFK = P.nombreProducto;
-- consultar los productos que compró un cliente especifico
-- consultar todos los clientes que han hecho ventas

describe Ventas_Producto;
select * from Usuario;
select * from Ventas;
select * from Cliente;
select * from Ventas_Producto;
select * from Producto;

insert into Cliente values(5, 'Tatiana', 2000-06-06);
insert into Producto values(116, 'pañales',20000);
insert into Usuario values(5,'Daniel', 'daniel@gmail.com','empleado',9564);
insert into Ventas values(5,'27', 5,5);

alter table Cliente
add column apellido varchar(17);

alter table Ventas
add column codigoBarrasFK int;

alter table Ventas
add column numeroOrden int not null;

describe Cliente;
update Ventas set codigoBarrasFK = 116 where idClienteFK = 5;
update Cliente set  apellido = 'Cabrera Vargas', fechaNacimiento = '1985-11-24' where idCliente = 5;
update Ventas set idVentas = 20240927 where idVentas = 5;
describe Ventas;
update Ventas set numeroOrden = 45528536 where idClienteFK = 5;
update Ventas set idVentas = 5 where idClienteFK = 5;
update ventas set numeroOrden = 20240927 where idClienteFK = 5;

insert into Cliente values(55163118, 'Tatiana','1985-11-24','Cabrera Vargas');
update Ventas set idClienteFK = 55163118 where idClienteFK = 5;
delete from Cliente where idCliente = 5;

use tiendaOnline;
describe Cliente;
describe Producto;
DELIMITER //
CREATE PROCEDURE registrarProducto(codigoBarras int, nombreProducto varchar(15),precioProducto float)
BEGIN
insert into Producto values(codigoBarras,nombreProducto,precioProducto);
END//
DELIMITER ;
DELIMITER //
CREATE PROCEDURE updateProducto(codigo_Barras int, nombre_Producto varchar(15),precio_Producto float)
BEGIN
update Producto set nombreProducto = nombre_Producto where codigoBarras = codigo_Barras;
END//
DELIMITER ;
call registrarProducto(52635,'Cable de carga',55.000);
call updateProducto(52635,'Cargador',55.000);

CREATE VIEW ConsultarCliente as select nombreCliente from Cliente;

select * from consultarCliente;

-- crear tres procedimientos para inactivar un cliente, consultar los productos que ha comprado un cliente, modificar la fecha de nacimiento de un cliente
use tiendaOnline;
alter table Cliente
add column estadoCliente varchar(25);
DELIMITER //
CREATE PROCEDURE InactivarCliente(id_Cliente int)
BEGIN 
update Cliente set estadoCliente = 'Inactivo' where idCliente = id_Cliente;
END//
DELIMITER ;
describe Cliente;
DELIMITER //
CREATE PROCEDURE Update_fecha_nacimiento(id_Cliente int, fecha date)
BEGIN
update Cliente set fechaNacimiento = fecha where idCliente = id_Cliente;
END //
DELIMITER ;

select * from ventas_producto;
select * from ventas;
select * from producto;
DELIMITER //
CREATE PROCEDURE ProductoComprado(id_Cliente int)
BEGIN
select c.idCliente, v.codigoBarrasFK, p.nombreProducto,v.fechaVenta from cliente c
join ventas v on c.idCliente = v.idClienteFK
join Producto p on v.codigoBarrasFK = p.codigoBarras
where c.idCliente = id_Cliente;
END //
DELIMITER ;
drop procedure ProductoComprado;
-- crear dos vistas que consulte que cliente compró un producto y cual fue su número de orden, una vista que muestre el cliente que mas compras haya hecho 
CREATE view cliente_Producto as 
select P.nombreProducto, V.numeroOrden, c.nombreCliente from Cliente c
join ventas v on c.idCliente = v.idClienteFK
join Producto p on v.codigoBarrasFK = p.codigoBarras;

-- CREATE VIEW Mayor_Comprador as
-- select 

DELIMITER //
CREATE PROCEDURE registrarCliente(idCliente int, nombreCliente varchar(15),fechaNacimiento date, apellido varchar(25),estadoCliente varchar(25))
BEGIN
insert into Cliente values(idCliente,nombreCliente,fechaNacimiento,apellido,estadoCliente);
END//
DELIMITER ;

select * from Cliente;
call registrarCliente(233232,'Leonardo','1985-04-12','castro','activo');
call registrarCliente(256984,'Alejandro','1999-04-04','Londoño','activo');
call registrarCliente(583146,'Julian','1999-05-05','Herrera','activo');
call registrarCliente(874156,'Joseph','1975-08-12','Lozano','activo');
call registrarCliente(741369,'Paula','2002-07-09','Moreno','activo');
call registrarCliente(707077,'Camila','2004-12','De los Rios','activo');

select * from Usuario;
select * from Producto;
select * from Ventas;
select * from Cliente;
call update_fecha_nacimiento(707077,'2004-09-07');
insert into Ventas values('','2024-01-10',741369,1,113,5986),('','2024-08-21',874156,5,114,5987),('','2024-09-09',583146,2,112,5988),
('','2024-09-15',583146,2,114,5989),('','2024-01-10',741369,1,115,5990),('','2024-01-10',741369,1,116,5990),('','2023-01-10',256984,5,114,5991),
('','2023-01-10',256984,5,114,5991),('','2023-01-10',256984,5,114,5991),('','2023-01-10',256984,5,114,5991),('','2023-01-10',256984,5,114,5991),
('','2023-01-10',256984,5,114,5991),('','2023-01-10',256984,5,112,5991),('','2024-07-09',707077,1,115,5992),('','2024-01-10',707077,2,115,5993),
('','2024-01-12',707077,2,115,5994),('','2024-01-12',707077,2,115,5994),('','2024-01-12',707077,2,115,5994),('','2024-01-12',707077,2,115,5994),
('','2024-01-12',707077,2,115,5994),('','2024-01-12',707077,2,115,5994),('','2024-01-12',707077,2,115,5994),('','2024-01-12',707077,2,115,5994);

call ProductoComprado(707077);
call ProductoComprado(741369);
call ProductoComprado(874156);
call ProductoComprado(583146);
call ProductoComprado(256984);
call ProductoComprado(233232);

call InactivarCliente(233232);
select * from cliente_Producto;
select * from cliente_producto where nombreCliente = 'Camila';