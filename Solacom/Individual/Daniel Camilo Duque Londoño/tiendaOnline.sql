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
idProductoFK INT(11),
idVentaFK INT(11),
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
foreign key (idProductoFK)
references Producto(codigoBarras);

alter table Ventas_Producto
add constraint FKVentas_Producto_Venta
foreign key (idVentaFK)
references Ventas(idVentas);
 
describe Cliente;
insert into Cliente values(1,'Santiago', '2015-12-10'),(2,'Daniel', '2008-07-07'), (3,'Laura', '2013-12-01'), (4,'David', '2005-02-05');
select * from Cliente;

describe Usuario;
insert into Usuario values(1,'Santiago', 'Santiago@dd.com','Empleado',1234),(2,'Daniela', 'Daniela@dd.com','Empleado',12345), (3,'Loren', 'Loren@dd.com','Provedor',12346), (4,'Devid', 'Devid@dd.com','Provedor',12347);
select * from Usuario;

describe Ventas;
insert into Ventas values(1,'03', 4,2),(2,'05', 4,3), (3,'07', 3,1), (4,'03', 2,3);
select * from Ventas;

describe Producto;
insert into Producto values(12,'Limpiador', 42),(13,'CPU', 43), (14,'Celular', 31), (15,'Reloj', 23);
select * from Producto;

describe Ventas_Producto;
insert into Ventas_Producto values(12,3,2),(13,2, 3), (14,1, 1), (15,2, 3);
select * from Ventas_Producto;

select * from Producto;
select * from Producto ORDER BY precioProducto ASC;
select * from Cliente where fechaNacimiento like '%01';
select * from Usuario where rol = 'Empleado';
select * from Ventas where fechaVenta between '03' and '04';
select * from Producto where nombreProducto like '%r%';
select * from Ventas;
select avg(idVentas) from Ventas;
select suma(idVentas) from Ventas;

use tiendaOnline;
select * from Ventas inner join Cliente on Ventas.idClienteFK = Cliente.idCliente;
-- consultar datos cliente de la maxima venta hecha
select Cliente.nombreCliente, Ventas.idClienteFK, Ventas_Producto.Cantidad from Cliente, Ventas, Ventas_Producto
inner join Cliente on Cliente.idCliente = Ventas.idClienteFK
inner join Ventas_Producto on Ventas.idVentas = Ventas_Producto.idProductoFK;
-- consultar usuario y cliente de una venta especifica
-- consultar los productos que compró un cliente especifico
-- consultar todos los clientes que han hecho ventas
describe Ventas_Producto;
select * from Ventas;
select * from Cliente;
select * from Ventas_Producto;