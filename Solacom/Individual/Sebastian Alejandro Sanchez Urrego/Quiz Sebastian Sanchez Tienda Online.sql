/* 
QUIZ 23/09/2024 SEBASTIÁN SÁNCHEZ
1) #Crear una base de datos Tienda Online
2) Habilitar la base datos
3) Crear tablas:
	Producto -> id auto incremente, codigo de barras
	Usuario
    Cliente -> auto increment
    Ventas (Ordenes) -> id auto increment, numero de orden
4) Realizar Relaciones
	Un cliente puede realizar muchas ordenes (ventas)
    Un usuario puede generar muchas ordenes (ventas)
    Un cliente puede comprar muchos productos
    Una orden puede contener muchos productos 
    Un producto puede ser comprado muchas veces
5) Hacer mínimo 4 incersiones por tabla
6) Realizar las siguientes consultas
	Consulta general de todos los productos
    Ordenar productos por precio, menor precio a mayor
    Conusltar los clientes que nacen en Enero
    Consultar los usuarios con rol Empleado
    Consultar las ordenes generadas entre Marzo y Junio
    Consultar productos que contengan la letra 'R'
    Consultar las ventas que tengan productos con precio de 11000 o 30000
7) Promedio de ventas, suma total de ventas, cantidad de clientes (Tiene que dar 4 en todas), y la venta mas económica hecha 
*/

create database TiendaOnline;
use TiendaOnline;

create table Producto(
idProducto int(15) auto_increment primary key not null,
codigoBarras varchar(30) not null,
nombreProducto varchar(30) not null,
precioProducto int(15) not null
);

create table Usuario(
idUsuario int(15) auto_increment primary key not null,
nombreUsuario varchar(30) not null,
rolUsuario varchar(30) not null
);

create table Cliente(
idCliente int(15) auto_increment primary key not null,
nombreCliente varchar(30) not null,
mesNacimiento varchar(30) not null
);

create table Venta(
idVentas int(15) auto_increment primary key not null, 
numeroVenta int(15) not null,
idUsuarioFK int(15) not null,
idClienteFK int(15) not null
);

create table detalleVenta(
idProductoFK int(15) not null,
numeroVentaFK int(15) not null,
total int(15),
cantidadVenta int(15) not null
);

alter table Venta
add constraint VentaUsuario
foreign key (idUsuarioFK)
references Usuario(idUsuario);

alter table Venta
add constraint VentaCliente 
foreign key (idClienteFK)
references Cliente(idCliente);

alter table detalleVenta
add constraint detVentProd
foreign key (idProductoFK)
references Producto(idProducto);

alter table detalleVenta
add constraint detVentVent
foreign key (numeroVentaFK)
references Venta(idVentas);

describe Producto;
insert into producto values ('', '7501031311309', 'coca cola', 20000), ('', '7501234613540', 'pepsi', 18000), ('', '7501020345008', 'agua', 31000), ('', '7503021335402', 'jugo del valle', 25000);

describe Usuario;
insert into usuario values ('', 'Carlos', 'Administrador'), ('', 'Lucia', 'Empleado'), ('', 'Fernando', 'Empleado'), ('', 'Daniela', 'Empleado');

describe Cliente;  
insert into cliente values ('', 'Juan', 'Enero'), ('', 'Ana', 'Febrero'), ('', 'Pedro', 'Marzo'), ('', 'Laura', 'Enero');
select* from Cliente;

describe Venta;
insert into venta values ('', 1001, 1, 1), ('', 1002, 2, 2), ('', 1003, 3, 3), ('', 1004, 4, 4);

describe detalleVenta;
select* from detalleVenta;
select* from Producto;
select* from Venta;
-- Inserciones corregidas para detalleVenta
insert into detalleVenta values (1, 1, 40000, 2),(2, 2, 36000, 2), (3, 3, 62000, 2), (4, 4, 50000, 2);

select * from producto;
select * from producto order by precioproducto asc;
select * from cliente where mesnacimiento = 'Enero';
select * from usuario where rolusuario = 'Empleado';
select * from venta where numeroventa between 1001 and 1004;
select * from producto where codigobarras like '%r%';
select v.*  from venta v join detalleVenta dv on v.idVentas = dv.numeroVentaFK join producto p on dv.idProductoFK = p.idProducto where p.precioProducto between 9000 and 31000;
select avg(total) as promedio_venta from detalleVenta;
select count(*) as total_ventas, sum(cantidadventa) as total_elementos_vendidos, min(total) as venta_mas_economica from detalleVenta;
select * from venta inner join cliente on venta.idclientefk = cliente.idcliente;

/* consultar el cliente de la maxima venta hecha 
consultar usuario y cliente de una venta específica
consultar los productos que compro un cliente en especifico
consultar todos los clientes que han hecho ventas 
*/

select c.nombreCliente, MAX(dv.total) as max_venta  from Venta v inner join Cliente c on v.idClienteFK = c.idCliente 
inner join detalleVenta dv on v.idVentas = dv.numeroVentaFK group by c.nombreCliente  order by max_venta desc limit 1;

select v.numeroVenta, u.nombreUsuario, c.nombreCliente from Venta v inner join Usuario u on v.idUsuarioFK = u.idUsuario 
inner join Cliente c on v.idClienteFK = c.idCliente where v.numeroVenta = 2;

select p.nombreProducto from detalleVenta dv inner join Producto p on dv.idProductoFK = p.idProducto 
inner join Venta v on dv.numeroVentaFK = v.idVentas inner join Cliente c on v.idClienteFK = c.idCliente 
where c.nombreCliente = 'Juan'; 

select distinct c.nombreCliente from Venta v inner join Cliente c on v.idClienteFK = c.idCliente;

describe CLiente;
insert into Cliente values('', 'Tatiana', 'Enero');
select * from Cliente;

describe Usuario;
insert into Usuario values('', 'Sebastian', 'Empleado');
select * from Usuario;

describe Producto;
insert into Producto values('', '750123461324', 'Pañales', 24000);
select * from Producto;

/* Procedimientos almacenados -> Subrutinas almacenar la información en la base de datos
Estructura
DELIMITER //
CREATE PROCEDURE nombre_procedimeinto(parametros)
BEGIN
--LÓGICA SENTENCIA QUE SE QUIERA UTILIZAR
END//

DELIMITER;
*/

use tiendaonline;
describe producto;
Delimiter // 
create procedure registrarproductos(idProducto int(15), codigoBarras varchar(30), nombreProducto varchar(30), precioProducto int(30))
BEGIN
insert into Producto values(idProducto, codigoBarras, nombreProducto, precioProducto);
END //
Delimiter ; 

call registrarproductos('', '7501031334893', 'fanta', 19000);
select * from Producto;

/* Consultas 
Se usa cuando consultas multitabla o consultas muy grnades en espacio */ 
create view consultar_cliente as 
select * from cliente; 

select * from consultar_cliente;

/* Sub consultas: Son consultas anidadas dentro de otra consulta 
select campo2, campo3 from tablanegra
where columna2=(select columna2x from otratablal where condición);

*/

/* Consultar los datos de los empleados y su sueldo promedio */
select idEmpleado, nombreEmpleado, salario, (select avg(salario) from Empleado) as Promedio from Empleado; 
use tiendaonline;

/* Consultar el empleado que tenga el salario mayor que el salario promedio */
select idEmpleado, nombreEmpleado, salario from empleado where salario>(select avg(salario) from Empleado); 

/* Consultar a que área pertenece un empleado*/ 
select idEmpleado, nombreEmpleado, idArea, nombreArea
from Empleado 
where idArea in (select idArea from area where nombreEmpleado='Juan');

/* Consultar de tiendaonline, calcular los productos que se vendan a un precio mayor del promedio de todos los productos*/
select* from Producto;
select idProducto, nombreProducto, precioProducto from pro
/* Mostrar los clientes que el total de compra sea mayor al promedio de compras de la tienda */

/* Mostrar el promedio de precios de productos comprados por un cliente*/

