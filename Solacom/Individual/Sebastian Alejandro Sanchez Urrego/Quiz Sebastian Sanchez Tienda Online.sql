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
idClienteFK int(15) not null,
total int(15),
cantidadVenta int(15) not null
);

create table detalleVenta(
idProductoFK int(15) not null,
numeroVentaFK int(15) not null
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
insert into Producto values('', 'fff1', 'ruedas', 30000), ('', 'fff2', 'sillon', 13000), ('', 'fff3', 'computador', 11000), ('', 'fff4', 'mouse', 2000);

describe Usuario;
insert into Usuario values('', 'Marco', 'Jefe'), ('', 'Sofia','Gerente'), ('', 'Antonio', 'Empleado'), ('', 'Estella', 'Empleado');

describe Cliente;  
insert into Cliente values('', 'Maria', 'Junio'), ('', 'Jose', 'Enero'), ('', 'Santiago', 'Enero'), ('', 'Tomas', 'Octubre');
select* from Cliente;

describe Venta;
insert into Venta values('',1,1,2, '',6);
insert into Venta values('',2, 3, 1, '', 10), ('',3, 1, 4, '', 8), ('', 4, 2, 3, '', 3);
select* from cliente;
describe venta;

describe detalleVenta;
select* from detalleVenta;
select* from Producto;
select* from Venta;
insert into detalleVenta values(1,4), (2,3), (1,4), (4,2);


select* from Producto;
select* from Producto order by precioProducto asc;
select* from Cliente where mesNacimiento = 'Enero';
select* from Usuario where rolUsuario = 'empleado';
select* from Venta where numeroVenta between 1 and 4;
select* from Producto where codigoBarras like '%r%';
select* from Venta where total in (select p.precioProducto from Producto p where p.precioProducto between 9000 AND 31000);
select avg(total) as promedio_venta from Venta;
select count(*) as total_ventas, SUM(cantidadVenta) as total_elementos_vendidos, MIN(total) as venta_mas_economica from Venta;

select * from Venta inner join Cliente on venta.idClienteFK = Cliente.idCliente;

/* consultar el cliente de la maxima venta hecha 
consultar usuario y cliente de una venta específica
consultar los productos que compro un cliente en especifico
consultar todos los clientes que han hecho ventas 
*/




