-- 1
CREATE DATABASE TiendaOnline;
-- 2
use TiendaOnline;

-- 3
CREATE TABLE Producto(
codigoBarras INT(15) auto_increment PRIMARY KEY,
nombreProducto VARCHAR(15),
precioProducto INT(11)
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
insert into Ventas values(1,'03', 4,2),(2,'05', 4,3), (3,'07', 3,1), (4,'03', 2,3);
select * from Ventas;

describe Producto;
insert into Producto values(112,'Audifonos', 42.000),(113,'Labial', 14.300), (114,'Gamepass', 31.000), (115,'Reloj', 230.000);
select * from Producto;

describe Ventas_Producto;
insert into Ventas_Producto values(112,3,42.000,2),(113,2,14.300, 3), (114,1,31.000, 1), (115,2,230.000, 3);
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
select * from Ventas inner join Cliente on Ventas.idClienteFK = Cliente.idCliente;
-- consultar datos cliente de la maxima venta hecha
select Cliente.nombreCliente, Ventas.idClienteFK, Ventas_Producto.Cantidad from Ventas
inner join Cliente on Cliente.idCliente = Ventas.idClienteFK
inner join Ventas_Producto on Ventas.idVentas = Ventas_Producto.codigoBarrasFK
where totalVentas = max(totalVentas);
-- consultar usuario y cliente de una venta especifica

UPDATE Ventas
SET idUsuarioFK = 4
WHERE idVentas =2 ;

SELECT V.idVentas, C.nombreCliente, U.nombreUsuario
FROM Ventas V
JOIN Cliente C ON V.idClienteFK = C.idCliente
JOIN Usuario U ON V.idUsuarioFK = U.idUsuario
WHERE V.idVentas = 3;
-- consultar los productos que compró un cliente especifico
-- consultar todos los clientes que han hecho ventas
describe Ventas_Producto;
select * from Usuario;
select * from Ventas;
select * from Cliente;
select * from Ventas_Producto;
select * from Producto;