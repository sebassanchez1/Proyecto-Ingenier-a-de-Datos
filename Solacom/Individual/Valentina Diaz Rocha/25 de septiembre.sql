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

Create Table Detalle_Venta (
   idVenta INT(11),
   Venta_t INT (12) Primary Key,
   cantidad INT(200),
   Total int (200)
   );

-- 3 Crear relaciones
-- Se crean relaciones entre Ventas, Cliente y Usuarios en la definición de la tabla Ventas.

-- 4 Insertar datos
-- Insertar productos
INSERT INTO Producto (codigo_barras, precio) VALUES ('1236547', 50000),('1236547', 50000),('1236587', 25000),('7654569', 19000);

-- Insertar usuarios
describe Usuarios;
INSERT INTO Usuarios (idUsuario,nombreUsuario, rol) VALUES (11659875,'Ana Cardona', 'empleado'),(96854769,'María Gómez', 'administrador'),(65987436,'Andres Castano', 'empleado'),(36985721,'Andrea Torres', 'ama de casa');

-- Insertar clientes
describe Cliente;

INSERT INTO Cliente (cedulaCliente,nombreCliente, apellidoCliente, mes_nacimiento) VALUES (36987846,'Mariana', 'Acosta', 'junio'), (98856745,'Daniel','Maecha','marzo'),(65987436,'Sara','Diaz','abril'),(63598742,'JuanDaniel','Moreno','enero');

-- Insertar ventas
Describe Ventas;
INSERT INTO Ventas (cantidad_productos, total, idCliente, idUsuario) VALUES (3, 165000,36987846 ,11659875 ), (1, 19000,98856745 ,96854769 ),(2, 75000,65987436,65987436 ),(4, 184000,63598742 ,36985721 );


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

-- estudiar sentencias join de teoria de cojuntos de sql 
-- inner join entre Venta y cliente 
-- se puede renombrar las tablas con 'c' para Cliente para ahorrar sintaxis y tambien se pueden haxcer operaciones entre ellas 
describe Cliente;
Select * From Ventas inner join Cliente on Ventas.idCliente=Cliente.cedulaCliente;

-- consultar un cliente con la mayor venta 
-- consultar el usuario y venta de una venta especificca 
-- consultar los productos que compro un cliente especifico 
-- consultar todos los clientes que han hecho compras (Ventas o orden) 
Select * From Ventas inner join Cliente on Cliente.idCliente=numero_orden.cedulaCliente;
