-- Crear una base de datos que se llame tienda online 
-- Habilitar la BD
-- Crear tablas producto( id autoincrement, codigo de barras ), usuarios, clientes (autoincrement),ventas ordenes (# de orden )
-- Realizar relaciones un cliente puede realizar muchas ordenes (ventas) un usuario puede generar muchas ordenes un cliente puede comprar muchos productos 
-- un cliente puede comprar muchos productos, una orden puede contener muchos productos,un producto puede ser comprados muchas veces 
-- hacer min 4 innserciones x tabla
-- realizar consultas (genereal de todos los productos),ordenar productos x precio menor a mayor
-- consultar los clientes que nacen en enero, consultar los usuarios con el rol de empleado
-- consultar las ordenes generadas entre mazo y junio , consultar productos que contengan la letra r
-- consultar las ventas que tengan productos con precios de 15.000 a 30.000

-- 1 Crear base de datos
CREATE DATABASE TIENDAONLINE;
USE TIENDAONLINE;

-- 2 Crear tablas
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

-- Tabla Ventas u Órdenes 
CREATE TABLE Ventas (
    numero_orden INT(11) AUTO_INCREMENT PRIMARY KEY,
    cantidad_productos INT(10),
    total FLOAT,
    idCliente INT(11),
    idUsuario INT(11),
    FOREIGN KEY (idCliente) REFERENCES Cliente(cedulaCliente),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- 3 Crear relaciones
-- Se crean relaciones entre Ventas, Cliente y Usuarios en la definición de la tabla Ventas.

-- 4 Insertar datos
-- Insertar productos
INSERT INTO Producto (codigo_barras, precio) VALUES ('1236547', 50000),('1236547', 50000),('1236587', 25000),('7654569', 19000);

-- Insertar usuarios
INSERT INTO Usuarios (nombreUsuario, rol) VALUES ('Ana Cardona', 'empleado'),('María Gómez', 'administrador'),('Andres Castano', 'empleado'),('Andrea Torres', 'ama de casa');

-- Insertar clientes
INSERT INTO Cliente (nombreCliente, apellidoCliente, mes_nacimiento) VALUES ('Mariana', 'Acosta', 'junio'), ('Daniel','Maecha','marzo),('Sara','Diaz','abril'),('JuanDaniel','Moreno','enero');

-- Insertar ventas
INSERT INTO Ventas (cantidad_productos, total, idCliente, idUsuario) VALUES (3, 165000, 6598743, 1), (1, 19000, 65912543, 1),(2, 75000, 6598789, 2),(4, 184000, 65918583, 1);


-- 5 Realizar consultas
--  Consulta general de todos los productos
SELECT * FROM Producto;

--  Ordenar productos por precio de menor a mayor
SELECT * FROM Producto ORDER BY precio ASC;

--  Consultar los clientes que nacen en enero
SELECT * FROM Cliente WHERE mes_nacimiento = 'enero';

--  Consultar los usuarios con el rol de empleado
SELECT * FROM Usuarios WHERE rol = 'empleado';

--  Consultar las órdenes generadas entre marzo y junio
SELECT * FROM Ventas WHERE numero_orden BETWEEN 1 AND 4; 

--  Consultar productos que contengan la letra "r"
SELECT * FROM Producto WHERE codigo_barras LIKE '%r%';

--  Consultar las ventas que tengan productos con precios de 15.000 a 30.000
SELECT *
FROM Ventas
WHERE total IN (
    SELECT p.precio
    FROM Producto p
    WHERE p.precio BETWEEN 15000 AND 30000
);


-- 6 Se deben realizar sum y avg de ventas (tambien se debe tenr en cuenta la venta mas economica) 
-- Promedio venta
SELECT AVG(total) AS promedio_venta FROM Ventas;

-- 7 Total venta, cantidad de elementos, venta más económica realizada
SELECT 
    COUNT(*) AS total_ventas,
    SUM(cantidad_productos) AS total_elementos_vendidos,
    MIN(total) AS venta_mas_economica 
FROM Ventas;

