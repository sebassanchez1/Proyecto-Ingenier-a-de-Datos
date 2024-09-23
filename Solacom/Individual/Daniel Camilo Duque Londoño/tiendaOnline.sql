-- crear BD tiendaOnline
create database tiendaOnline;
-- habilitar la BD
use tiendaOnline;
-- crear tablas producto (id,autoincrement,CB), usuarios, clientes (autoincrement) y ventas (id,autincrement,#orden)
create table cliente(
idCliente int(17) auto_increment primary key,
nombreCliente varchar(17),
apellidoCliente varchar(17),
fechaNacimiento date
);
create table Producto(
idProducto int auto_increment unique,
nombreProducto varchar(17),
codigoBarras varchar(20) primary key,
precio int(20),
idClienteFK int(20)
);
create table venta(
idVenta int auto_increment unique,
numeroVenta varchar(17) primary key,
idClienteFK int(20),
idUsuarioFK int(20),
fechaVenta date
);
create table usuario(
idUsuario int(17) auto_increment primary key,
rolUsuario varchar(20)
);

create table venta_producto(
codigoBarrasFK int(20),
numeroVentaFK int(17),
cantidad int(25),
total int(20)
);
-- realizar relaciones 1. un cliente pude realizar muchas ordenes(ventas) 2.un usuario puede generar muchas ordenes 3.un cliente puede generar muchos productos

alter table Venta
add constraint FKcliente_ventas
foreign key (idClienteFK)
references Cliente(idCliente);

alter table venta
add constraint FKusuario_venta
foreign key (idUsuarioFK)
references Usuario(idUsuario);

alter table Producto
add constraint FKcliente_productos
foreign key (idClienteFK)
references cliente(idCliente);

alter table venta_producto
add constraint FKorden_productos
foreign key (codigoBarrasFK)
references Producto(codigoBarras);

alter table venta_producto
add constraint FKproducto_ordenes
foreign key (codigoBarrasFK)
references venta_producto(cantidad);


-- promedio de ventas, suma total de ventas, cantidad de clientes, venta mas economica realizada