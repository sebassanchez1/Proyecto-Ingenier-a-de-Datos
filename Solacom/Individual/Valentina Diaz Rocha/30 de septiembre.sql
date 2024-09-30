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

describe Ventas;
SELECT V.idVentas, C.nombreCliente
FROM Ventas V
JOIN Cliente C ON V.idClienteFK = C.idCliente
JOIN Producto P ON V.idUsuarioFK = P.nombreProducto;
-- consultar los productos que compró un cliente especifico
-- consultar todos los clientes que han hecho ventas
describe Ventas_Producto;
select * from Usuario;
select * from Ventas;
select * from Cliente;
select * from Ventas_Producto;
select * from Producto;

alter table Cliente
add column apellido varchar(17);

alter table Ventas
add column codigoBarrasFK int;

alter table Ventas
add column numeroOrden int not null;

insert into Cliente values(5, 'Tatiana', 2000-06-06);
insert into Producto values(116, 'pañales',20000);
insert into Usuario values(5,'Daniel', 'daniel@gmail.com','empleado',9564);
insert into Ventas values(5,'27', 5,5);
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

DELIMITER //
CREATE PROCEDURE registrar_producto(codigodebarras int(15),nombreProducto varchar(15),precioProducto float (20))
BEGIN
INSERT INTO Producto Values(codigodebarras,nombreProducto,precioProducto);
END// 
DELIMITER ;

call registrar_producto('','CamisetaHOPE','150000');
SELECT *From Producto;

-- vistas son como las maquinas virtuales (sentencias que crean maquinas virtuales) se usan para hacer consultas complejas de 3 tablas

Create View  ConsultarCliente as 
select *from Cliente;


-- Notas para el proyecto 
-- requisitos funcionales del proyecto (alto nivel) {abarcan otros requisitos crud} "create read update delete"
-- min 4 modulos (subsistemas)que son las clases (dependiendo el diagrama de clases) modulo de usuarios autenticacion y modulacion (must exist)
-- min hacer un requisito de consultas basicas y min 7 consultas especificas sobre el modulo (ejemplo cunsultar id) usando las sentencias vistas 
-- 40 requisitos funcionales en el proyecto 
-- cambiar diagrama de clases 
-- clase de 27 septiembre (modificacion\ eliminacion)
-- UPDATE tabla (condicion) y where ejemplo
-- UPDATE Mascota set generoMascota ='M'where idMascota=2
-- el lunes subconsultas 



-- Clase 30 de septiembre procedimientos almacenados y subconsultas y vistas 
-- Tarea para el miercoles subconsultas ( de nuestra tienda online crear tres procedimientos para 
-- inactivar un cliente, consultar los productos que a comprado un cliente , para modificar la fecha de nacimiento de cliente )
-- crear dos vistas (consulte que cliente compro un producto y cual fue su numero de orden
-- (muestre el cliente que mas compras ha realizado) (hacer mas insert en compras)
-- Viernes simulacro de parcial practico 
