-- 1. Crear base de datos
CREATE DATABASE TIENDAONLINE;
USE TIENDAONLINE;

-- 2. Crear tablas

-- Tabla Cliente
CREATE TABLE Cliente (
    cedulaCliente INT(11) AUTO_INCREMENT PRIMARY KEY,
    nombreCliente VARCHAR(50),
    apellidoCliente VARCHAR(50),
    mes_nacimiento VARCHAR(15)
);

-- Tabla Producto
CREATE TABLE Producto (
    codigoProducto INT(11) AUTO_INCREMENT PRIMARY KEY,
    codigo_barras VARCHAR(30),
    precio FLOAT
);

-- Tabla Usuarios
CREATE TABLE Usuarios (
    idUsuario INT(11) AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(50),
    rol VARCHAR(15)
);

-- Tabla Ventas (Órdenes)
CREATE TABLE Ventas (
    numero_orden INT(11) AUTO_INCREMENT PRIMARY KEY,
    cantidad_productos INT(10),
    total FLOAT,
    idCliente INT(11),
    idUsuario INT(11),
    FOREIGN KEY (idCliente) REFERENCES Cliente(cedulaCliente),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla Detalle_Venta (Relación muchos a muchos entre Ventas y Productos)
CREATE TABLE Detalle_Venta (
    idVenta INT(11),
    idProducto INT(11),
    cantidad INT(11),
    total FLOAT,
    PRIMARY KEY (idVenta, idProducto),
    FOREIGN KEY (idVenta) REFERENCES Ventas(numero_orden),
    FOREIGN KEY (idProducto) REFERENCES Producto(codigoProducto)
);

-- 4. Inserciones de ejemplo

-- Insertar productos
INSERT INTO Producto (codigo_barras, precio) 
VALUES ('1236547', 50000),('1236587', 25000),('7654569', 19000),('8765432', 15000);

-- Insertar usuarios
INSERT INTO Usuarios (nombreUsuario, rol) 
VALUES ('Ana Cardona', 'empleado'),('María Gómez', 'administrador'),('Andres Castano', 'empleado'),('Andrea Torres', 'cliente');

-- Insertar clientes
INSERT INTO Cliente (nombreCliente, apellidoCliente, mes_nacimiento) 
VALUES ('Mariana', 'Acosta', 'junio'), ('Daniel', 'Maecha', 'marzo'),('Sara', 'Diaz', 'abril'),('Juan Daniel', 'Moreno', 'enero');

-- Insertar ventas
INSERT INTO Ventas (cantidad_productos, total, idCliente, idUsuario) 
VALUES (3, 165000, 1, 1), (1, 19000, 2, 2), (2, 75000, 3, 3), (4, 184000, 4, 4);

-- Insertar detalles de ventas (relacionando productos y ventas)
INSERT INTO Detalle_Venta (idVenta, idProducto, cantidad, total) 
VALUES (1, 1, 2, 100000), (1, 2, 1, 25000), (2, 3, 1, 19000), (3, 2, 2, 50000);

-- 5. Consultas

-- a. Consulta general de todos los productos
SELECT * FROM Producto;

-- b. Ordenar productos por precio (menor a mayor)
SELECT * FROM Producto ORDER BY precio ASC;

-- c. Consultar los clientes que nacen en enero
SELECT * FROM Cliente WHERE mes_nacimiento = 'enero';

-- d. Consultar usuarios con el rol de empleado
SELECT * FROM Usuarios WHERE rol = 'empleado';

-- e. Consultar las órdenes generadas entre marzo y junio
SELECT * FROM Ventas WHERE idCliente IN (
    SELECT cedulaCliente FROM Cliente WHERE mes_nacimiento IN ('marzo', 'abril', 'mayo', 'junio')
);

-- f. Consultar productos que contengan la letra 'r'
SELECT * FROM Producto WHERE codigo_barras LIKE '%r%';

-- g. Consultar las ventas que tengan productos con precios entre 15,000 y 30,000
SELECT v.* 
FROM Ventas v
JOIN Detalle_Venta dv ON v.numero_orden = dv.idVenta
JOIN Producto p ON dv.idProducto = p.codigoProducto
WHERE p.precio BETWEEN 15000 AND 30000;

-- 6. Funciones agregadas

-- a. Promedio de ventas
SELECT AVG(total) AS promedio_venta FROM Ventas;

-- b. Total de ventas, cantidad de productos vendidos, y venta más económica
SELECT 
    COUNT(*) AS total_ventas,
    SUM(cantidad_productos) AS total_elementos_vendidos,
    MIN(total) AS venta_mas_economica 
FROM Ventas;

-- 7. INNER JOIN entre Ventas y Cliente
SELECT * 
FROM Ventas v
INNER JOIN Cliente c ON v.idCliente = c.cedulaCliente;

-- 8. Consultas adicionales

-- a. Consultar el cliente con la mayor venta
SELECT c.nombreCliente, c.apellidoCliente, MAX(v.total) AS mayor_venta
FROM Cliente c
JOIN Ventas v ON c.cedulaCliente = v.idCliente
GROUP BY c.cedulaCliente
ORDER BY mayor_venta DESC;

-- b. Consultar el usuario y la venta de una venta específica
SELECT u.nombreUsuario, v.numero_orden, v.total
FROM Usuarios u
JOIN Ventas v ON u.idUsuario = v.idUsuario
WHERE v.numero_orden = 1; -- Reemplazar '1' por el número de orden específico

-- c. Consultar los productos que compró un cliente específico
SELECT p.codigo_barras, p.precio, dv.cantidad
FROM Producto p
JOIN Detalle_Venta dv ON p.codigoProducto = dv.idProducto
JOIN Ventas v ON dv.idVenta = v.numero_orden
WHERE v.idCliente = 1; -- Reemplazar '1' por el ID del cliente específico

-- d. Consultar todos los clientes que han hecho compras (ventas u órdenes)
SELECT DISTINCT c.nombreCliente, c.apellidoCliente
FROM Cliente c
JOIN Ventas v ON c.cedulaCliente = v.idCliente;

UPDATE Producto set precio = 35000 where codigoProducto = 1;

Describe Cliente;
insert into Cliente values (123456, 'Tatiana', 'ING', 'junio');

insert into Usuarios values (2607, 'David Hernandez', 'Gerente');

insert into Producto values(5, 989666, 600000);

insert into Ventas values(5, 3, 1800000, 123456, 2607);

SELECT * FROM Ventas;


insert into Cliente values (55163118, 'Tatiana', 'ING', 'junio');

UPDATE Ventas set idCliente = 55163118 where numero_orden = 5;

delete from Cliente where cedulaCliente = 123456;

SELECT * FROM Cliente;





-- Crear procedimientos

-- Procedimiento para inactivar un cliente
DELIMITER //
CREATE PROCEDURE inactivar_cliente(IN idClienteInactivo INT)
BEGIN
    DELETE FROM Cliente WHERE idCliente = idClienteInactivo;
END//
DELIMITER ;

-- Procedimiento para consultar los productos que ha comprado un cliente
DELIMITER //
CREATE PROCEDURE productos_comprados(IN clienteID INT)
BEGIN
    SELECT P.nombreProducto, VP.cantidad 
    FROM Producto P
    INNER JOIN Ventas_Producto VP ON P.codigoBarras = VP.codigoBarrasFK
    INNER JOIN Ventas V ON VP.idVentasFK = V.idVentas
    WHERE V.idClienteFK = clienteID;
END//
DELIMITER ;

-- Procedimiento para modificar la fecha de nacimiento de un cliente
DELIMITER //
CREATE PROCEDURE modificar_fecha_nacimiento(IN clienteID INT, IN nuevaFecha DATE)
BEGIN
    UPDATE Cliente SET fechaNacimiento = nuevaFecha WHERE idCliente = clienteID;
END//
DELIMITER ;

-- Crear vistas

-- Vista para consultar qué cliente compró un producto y su número de orden
CREATE VIEW Cliente_Producto_Orden AS
SELECT C.nombreCliente, P.nombreProducto, V.numeroOrden
FROM Cliente C
INNER JOIN Ventas V ON C.idCliente = V.idClienteFK
INNER JOIN Ventas_Producto VP ON V.idVentas = VP.idVentasFK
INNER JOIN Producto P ON VP.codigoBarrasFK = P.codigoBarras;

-- Vista para mostrar el cliente que ha realizado más compras
CREATE VIEW Cliente_Mas_Compras AS
SELECT C.nombreCliente, COUNT(V.idVentas) AS total_compras
FROM Cliente C
INNER JOIN Ventas V ON C.idCliente = V.idClienteFK
GROUP BY C.idCliente
ORDER BY total_compras DESC
LIMIT 1;




/* Sub Consultas:son consultas anidadas dentro de otra consulta  
select campo2, campo3 from tabla_negra where columna2=(select columna 2x from otratabla where condicion);

*/


-- consultar los datos de lo empleados y su sueldo promedio 

select id_empleado ,nombre_empleado, salario, (select avg(salario) from empleado as promedio) from empleado;

-- consultar los datos de lo empleados y su sueldo promedio Y EL QUE TENGA MAYOR SALARIO A PROMEDIO

select id_empleado ,nombre_empleado, salario from empleado where salario >  (select avg(salario) from empleado);

-- empleados pertenencen a un area y quieren consultar a que area pertenece un empleado 

select id_empleado, nombre_empleado, id_area, nombre_area from empleado where id_area in (select id_area from area where nombre_empleado='David');

-- calcular los productos que se vendan a un precio mayor del promedio de todos los productos
-- Mostar los clientes que el total de compra sea mayor al promedio de compras de la tienda 
-- mostrar el promedio de precios de productos comprados por un cliente 





