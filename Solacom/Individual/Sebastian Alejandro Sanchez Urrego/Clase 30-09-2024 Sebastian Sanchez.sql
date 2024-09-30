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

/* TAREA MIÉRCOLES
De tiendaonline vamos a crear tres procedimientos:
1) Inactivar un Cliente.
2) Consultar los productos que ha comprado un Cliente.
3) Procedimiento para modificar la fecha de nacimiento de Cliente.

Y crear dos vistas:
1) Vista que me consulte que Cliente compró un producto y cuál fue su número de orden.
2) Vista que me muestre el Cliente que más compras haya hecho. 

(Hacer más inserciones)
