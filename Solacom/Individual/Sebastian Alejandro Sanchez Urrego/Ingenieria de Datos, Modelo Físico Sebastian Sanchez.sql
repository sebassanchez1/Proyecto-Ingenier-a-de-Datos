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
alter table mascota_vacuna rename detalle_vacuna;

/* Hecho por Sebastian Sanchez */

/* Clase 18/09/2024 */
describe Mascota;
insert into Mascota values(1, 'Rusth', 'M', 'Criollo', 1);
insert into Mascota values(2, 'Macarena', 'F', 'Criollo', 1), (3, 'Fridom', 'M', 'Criollo', 1);
insert into Mascota values(4, '', '', '','');
select * from Mascota;

describe Vacuna;
insert into Vacuna values(11211, 'vacuna1', 2, 'desparacitante'), (11212, 'vacuna2', 1, 'gripa');
select * from Vacuna;

describe Cliente;
insert into Cliente values(29302821, 'Alberto', 'Rodriguez', 'Cr 30 #40-50', '23223442', '3');
insert into Cliente values(45230232, 'Carlos', 'Martinez', 'Calle 2 #3-90', 312343422, '2');
select * from Cliente;

describe Producto;
insert into Producto values(1, 'Shampoo', 'pets', 10500, 29302821, 2), (2, 'Rascador', 'pets', 15300, 29302821, 3);
select * from Producto;

describe detalle_vacuna; 
insert into detalle_vacuna values(11211, 1, 'desparacitante');
insert into detalle_vacuna values(11212, 2, 'gripa');
select * from detalle_vacuna;

alter table Cliente change column telefono telefono varchar(15);
describe Cliente;

/* Consulta de Datos 
Para cosultar campos específicos de la tabla utilizaremos las sentencia SELECT 
*/
describe mascota;
select nombreMascota, razaMascota from mascota;

/* Utilización Alias */
select * from Cliente;
select cedulaCliente as 'Documento', direccionCliente as 'Dirección' from Cliente;

select * from mascota;
select * from vacuna;
select * from producto;

select nombreMascota as 'Nombre', generoMascota as 'Género' from mascota;
select nombreVacuna as 'Vacuna', dosisVacuna as 'CantidadDosis' from vacuna;
select nombreProducto as 'Nombre', cedulaClienteFK as 'Cédula del Cliente' from producto;

/* Si queremos que la consulta muestre los resultados organizados por algun campo: 
SELECT campo1, campo2 FROM nombre_tabla ORDER BY campofecha ASC 
Devuelve campo1 y campo2 de la tabla y ordena los registros por campofecha ascendentemente
SELECT campo1, campo2 FROM nombre_tabla ORDER BY campofecha DESC 
Devuelve campo1 y campo2 de la tabla y ordena los registros por campofecha descendientemente */

select cedulaCliente as 'Documento', idMascotaFK as 'Código de Mascota' from Cliente order by nombreCliente asc;
select cedulaCliente as 'Documento', idMascotaFK as 'Código de Mascota' from Cliente order by nombreCliente desc;

select * from Producto;
select nombreProducto as 'Nombre', marca from producto order by precio desc;

/* Operadores Clausula WHERE 
SELECT campo1 from nombre_tabla WHERE campo_numerico operador valor_consulta */
select nombreProducto from Producto where precio>=1000;

select enfermedad from detalle_vacuna where codigoVacunaFK >= 0;

select nombreProducto from Producto where precio = 10500 and codigoProducto>=0;

describe vacuna;
describe cliente;
describe mascota;

select nombreVacuna from Vacuna where enfermedad = 'gripa' and codigoVacuna >= 1;
select cedulaCliente from Cliente where apellidoCliente != 'Rodriguez' and telefono = '312343422';
select nombreMascota as 'Nombre' from Mascota where razaMascota = 'Criollo' and generoMascota = 'M' ;

/* Operador que acompaña el WHERE que es el BETWEEN 
SELECT campo1, campo 2 from nombre_tabla WHERE campo1 BETWEEN valor1 AND valor 2 */

select nombreProducto from Producto where precio between 1000 and 1000000;

/* Búsqueda de Patrones LIKE 
SELECT * FROM nombre_tabla WHERE ciudad (not) LIKE 'Bo%' or '%Bo' or '%Bo%' */

select nombreProducto from Producto where marca not like '%a%';
/* Hacer dos búsquedas con los patrones like y not like en el ejercicio de Mascotas */