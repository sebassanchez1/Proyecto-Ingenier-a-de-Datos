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
