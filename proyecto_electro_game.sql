CREATE DATABASE proyecto_facturacion_game;
GO

USE proyecto_facturacion_game;
GO

-- Tabla Clientes
CREATE TABLE Clientes (
    ID INT PRIMARY KEY IDENTITY(1,1), -- Ajustar
    Nombre VARCHAR(100) NOT NULL,
    Dirección VARCHAR(200),
    Teléfono CHAR(10),
    Correo_Electrónico VARCHAR(100),
    Tipo_Cliente VARCHAR(20), -- Ajustar
    Número_Identificación VARCHAR(50)
);
GO

-- Tabla Proveedores
CREATE TABLE Proveedor (
    ID INT PRIMARY KEY IDENTITY(1,1), -- Ajustar
    Nombre VARCHAR(100) NOT NULL,
    Dirección VARCHAR(200),
    Teléfono VARCHAR(15),
    Correo_Electrónico NVARCHAR(100)
);
GO

-- Tabla Productos
CREATE TABLE Productos (
    ID INT PRIMARY KEY IDENTITY(1,1), -- Ajustar
    Nombre_Producto VARCHAR(100) NOT NULL,
    Descripción TEXT NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    Categoría VARCHAR(50) NOT NULL,
    ID_Proveedor INT,
    CONSTRAINT fk_idproveedor_proveedor FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID)
	CONSTRAINT fk_idproveedor_proveedor FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID)
);
GO

-- Tabla Ventas
CREATE TABLE Ventas (
    ID INT PRIMARY KEY IDENTITY(1,1), -- Ajustar
    ID_Cliente INT,
    Fecha_Venta DATETIME NOT NULL,
    Monto_total DECIMAL(10, 2) NOT NULL, --Ajustar
    Estado_Venta VARCHAR(10) NOT NULL,
    Tipo_Venta VARCHAR(10) NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);
GO

-- Tabla Detalles_Venta
CREATE TABLE Detalles_Venta (
    ID INT PRIMARY KEY IDENTITY(1,1), -- Ajustar
    ID_Venta INT,
    ID_Producto INT,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10, 2) NOT NULL,

    Subtotal AS (Cantidad * Precio_Unitario) PERSISTED,
    CONSTRAINT fk_idventa_ventas FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID),
	CONSTRAINT fk_idproducto_productos FOREIGN KEY (ID_Producto) REFERENCES Productos(ID)
);
GO

-- Tabla Facturas Electrónicas
CREATE TABLE Facturas_Electronicas (
    ID INT PRIMARY KEY IDENTITY(1,1), -- Ajustar
    ID_Venta_FE INT,
    Fecha_Emisión DATETIME NOT NULL,
    Monto_Total DECIMAL(10, 2) NOT NULL,
    Estado_Factura VARCHAR(10) NOT NULL,
	CONSTRAINT fk_idventafe_ventas FOREIGN KEY (ID_Venta_FE) REFERENCES Ventas(ID)
);
GO

-- Tabla Inventario
CREATE TABLE Inventario (
    ID INT PRIMARY KEY IDENTITY(1,1), -- Ajustar
    ID_Producto_Inv INT,
    Fecha_Registro DATETIME NOT NULL,
    Stock_Disponible INT NOT NULL,
    Última_Actualización DATETIME NOT NULL,
    FOREIGN KEY (ID_Producto_Inv) REFERENCES Productos(ID)
);
GO

-- Datos en la tabla Proveedores (Tabla Independiente)
INSERT INTO Proveedor (Nombre, Dirección, Teléfono, Correo_Electrónico)
VALUES 
('Innova Tech S.A.C.', 'Av. José Larco 1234, Miraflores', '987654321', 'ventas@innovatech.com'),
('Gaming Perú', 'Calle Puno 567, San Isidro', '988877666', 'info@gamingperu.com'),
('Electrohogar S.A.', 'Av. Arenales 123, Lince', '966554433', 'contacto@electrohogar.com'),
('Tienda Gamer', 'Calle de la Paz 678, Surco', '955443322', 'soporte@tiendagamer.com'),
('Mega Accesorios', 'Av. Brasil 789, Jesús María', '944332211', 'ventas@megaaccesorios.com'),
('Tecnología Moderna', 'Calle San Borja 234, San Borja', '933221100', 'info@tecnologiamoderna.com'),
('Sistemas Avanzados', 'Av. La Marina 456, Pueblo Libre', '922110099', 'contacto@sistemasavanzados.com'),
('Cómputo Lima', 'Calle Los Olivos 789, Los Olivos', '911009988', 'ventas@computolima.com'),
('Electro Perú', 'Calle Javier Prado 1011, San Isidro', '900998877', 'contacto@electroperu.com'),
('Gadgets Perú', 'Av. Javier Prado 2020, San Borja', '889887766', 'info@gadgetsperu.com'),
('Smart Tech S.A.C.', 'Av. San Luis 3030, San Borja', '878776655', 'ventas@smarttech.com'),
('Digital Solutions', 'Calle José Galvez 4040, Miraflores', '867665544', 'info@digitalsolutions.com'),
('PC Gamer Store', 'Calle Alfonso Ugarte 5050, Breña', '856554433', 'contacto@pcgamerstore.com'),
('Tienda de Tecnología', 'Av. San Martín 6060, San Miguel', '845443322', 'ventas@tiendatecnologia.com'),
('Accesorios Lima', 'Calle San Juan 7070, La Victoria', '834332211', 'info@accesorioslima.com'),
('Hardware Plus', 'Av. Tacna 8080, Centro de Lima', '823221100', 'ventas@hardwareplus.com'),
('Lima Gaming Store', 'Calle Universitaria 9090, Lima Norte', '812110099', 'contacto@limagamingstore.com'),
('Tech Shop', 'Av. Pardo 10101, Miraflores', '801009988', 'info@techshop.com'),
('Gamer Zone', 'Calle Vallehermoso 11111, San Borja', '790998877', 'ventas@gamerzone.com'),
('Proveedores de Innovación', 'Calle La República 12121, Lince', '789887766', 'info@proveedoresdeinnovacion.com');

-- Datos en la tabla Clientes (Tabla Independiente)
INSERT INTO Clientes (Nombre, Dirección, Teléfono, Correo_Electrónico, Tipo_Cliente, Número_Identificación)
VALUES 
('Juan Pérez', 'Av. José Larco 123, Miraflores', '999888777', 'juan.perez@email.com', 'Natural', '12345678'),
('Empresa XYZ', 'Calle Puno 456, San Isidro', '988877666', 'contacto@xyz.com', 'Jurídico', '87654321'),
('Ana Gómez', 'Calle de la Paz 789, Surco', '977665544', 'ana.gomez@email.com', 'Natural', '23456789'),
('Carlos Martínez', 'Av. Brasil 321, Jesús María', '966554433', 'carlos.martinez@email.com', 'Natural', '34567890'),
('Servicios Integrales S.A.', 'Calle Las Flores 111, San Borja', '955443322', 'info@serviciosintegrales.com', 'Jurídico', '45678901'),
('Luis Fernández', 'Calle San Miguel 222, San Miguel', '944332211', 'luis.fernandez@email.com', 'Natural', '56789012'),
('Sara López', 'Av. Santa Cruz 333, Miraflores', '933221100', 'sara.lopez@email.com', 'Natural', '67890123'),
('Marta Jiménez', 'Calle Huánuco 444, Lince', '922110099', 'marta.jimenez@email.com', 'Natural', '78901234'),
('Global Tech S.A.', 'Av. de la Tecnología 555, San Isidro', '911009988', 'contacto@globaltech.com', 'Jurídico', '89012345'),
('Roberto Salas', 'Calle de la Libertad 666, Miraflores', '900998877', 'roberto.salas@email.com', 'Natural', '90123456'),
('Andrea Torres', 'Calle de la Independencia 777, Surco', '889887766', 'andrea.torres@email.com', 'Natural', '01234567'),
('José Martínez', 'Av. del Progreso 888, Breña', '878776655', 'jose.martinez@email.com', 'Natural', '12345679'),
('Ricardo Silva', 'Calle de la Innovación 999, San Borja', '867665544', 'ricardo.silva@email.com', 'Natural', '23456780'),
('Claudia Ruiz', 'Calle de la Creatividad 1010, San Miguel', '856554433', 'claudia.ruiz@email.com', 'Natural', '34567891'),
('Pedro Sánchez', 'Calle de la Excelencia 1212, Jesús María', '845443322', 'pedro.sanchez@email.com', 'Natural', '45678902'),
('Emma García', 'Calle de la Motivación 1313, La Victoria', '834332211', 'emma.garcia@email.com', 'Natural', '56789013'),
('María Morales', 'Calle de la Eficiencia 1414, Lince', '823221100', 'maria.morales@email.com', 'Natural', '67890124'),
('Alberto Castro', 'Calle de la Innovación 1515, San Borja', '812110099', 'alberto.castro@email.com', 'Natural', '78901235'),
('Laura Fernández', 'Calle del Éxito 1616, San Isidro', '801009988', 'laura.fernandez@email.com', 'Natural', '89012346'),
('Francisco Ortega', 'Calle de la Calidad 1717, Miraflores', '790998877', 'francisco.ortega@email.com', 'Natural', '90123457');

-- Datos en la tabla Productos (Tabla Independiente)
INSERT INTO Productos (Nombre_Producto, Descripción, Precio, Stock, Categoría, ID_Proveedor)
VALUES 
('Laptop Gamer', 'Laptop para gamers con altas especificaciones.', 4500.00, 10, 'Consolas', 1),
('Ratón Inalámbrico', 'Ratón ergonómico inalámbrico.', 150.00, 50, 'Accesorios', 2),
('Videojuego XYZ', 'El último juego de aventura.', 200.00, 30, 'Videojuegos', 3),
('Teclado Mecánico', 'Teclado mecánico retroiluminado.', 250.00, 20, 'Accesorios', 4),
('Monitor 4K', 'Monitor de alta resolución 4K.', 1200.00, 15, 'Consolas', 5),
('Silla Gamer', 'Silla ergonómica para largas horas de juego.', 600.00, 25, 'Accesorios', 1),
('Auriculares Inalámbricos', 'Auriculares de alta calidad con cancelación de ruido.', 300.00, 35, 'Accesorios', 2),
('Consola de Juegos', 'Consola de última generación para videojuegos.', 700.00, 20, 'Consolas', 3),
('Estación de Carga', 'Estación de carga rápida para dispositivos.', 80.00, 40, 'Accesorios', 4),
('Cámara Web', 'Cámara de alta definición para streaming.', 100.00, 30, 'Accesorios', 5),
('Mouse Pad XL', 'Mouse pad de gran tamaño para gamers.', 50.00, 60, 'Accesorios', 1),
('Cargador Rápido', 'Cargador para múltiples dispositivos.', 70.00, 55, 'Accesorios', 2),
('Funda para Laptop', 'Funda protectora para laptop de 15 pulgadas.', 40.00, 45, 'Accesorios', 3),
('Base de Refrigeración', 'Base para enfriar laptops.', 90.00, 20, 'Accesorios', 4),
('Teclado Compacto', 'Teclado mecánico compacto para gaming.', 220.00, 15, 'Accesorios', 5),
('Almohadilla Antideslizante', 'Almohadilla para teclado y mouse.', 30.00, 70, 'Accesorios', 1),
('Adaptador USB-C', 'Adaptador para conectar dispositivos USB-C.', 25.00, 50, 'Accesorios', 2),
('Cable HDMI', 'Cable HDMI de alta velocidad.', 15.00, 100, 'Accesorios', 3),
('Luz LED para Teclado', 'Luz LED para teclado mecánico.', 20.00, 60, 'Accesorios', 4),
('Soporte para Monitor', 'Soporte ajustable para monitores.', 35.00, 40, 'Accesorios', 5),
('Mochila para Laptop', 'Mochila resistente y cómoda para laptop.', 120.00, 30, 'Accesorios', 1);


-- Datos en la tabla Detalles_Venta (Tabla Transaccional)
INSERT INTO Detalles_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario)
VALUES 
(1, 1, 1, 4500.00),
(2, 3, 1, 200.00),
(3, 2, 1, 150.00),
(4, 4, 1, 250.00),
(5, 5, 1, 1200.00),
(6, 6, 1, 600.00),
(7, 7, 1, 300.00),
(8, 8, 1, 700.00),
(9, 9, 1, 100.00),
(10, 10, 1, 50.00),
(1, 2, 2, 150.00),
(2, 3, 3, 200.00),
(3, 4, 1, 250.00),
(4, 5, 2, 1200.00),
(5, 6, 3, 600.00),
(6, 7, 1, 300.00),
(7, 8, 2, 700.00),
(8, 9, 1, 100.00),
(9, 10, 1, 50.00),
(10, 1, 2, 4500.00),
(1, 1, 1, 4500.00);


-- Datos datos en la tabla Inventario (Tabla Independiente)
INSERT INTO Inventario (ID_Producto_Inv, Fecha_Registro, Stock_Disponible, Última_Actualización)
VALUES 
(1, GETDATE(), 10, GETDATE()),
(2, GETDATE(), 50, GETDATE()),
(3, GETDATE(), 30, GETDATE()),
(4, GETDATE(), 20, GETDATE()),
(5, GETDATE(), 15, GETDATE()),
(6, GETDATE(), 25, GETDATE()),
(7, GETDATE(), 35, GETDATE()),
(8, GETDATE(), 20, GETDATE()),
(9, GETDATE(), 30, GETDATE()),
(10, GETDATE(), 60, GETDATE()),
(1, GETDATE(), 55, GETDATE()),
(2, GETDATE(), 45, GETDATE()),
(3, GETDATE(), 70, GETDATE()),
(4, GETDATE(), 20, GETDATE()),
(5, GETDATE(), 25, GETDATE()),
(6, GETDATE(), 10, GETDATE()),
(7, GETDATE(), 15, GETDATE()),
(8, GETDATE(), 30, GETDATE()),
(9, GETDATE(), 40, GETDATE()),
(10, GETDATE(), 55, GETDATE());

SELECT * FROM Inventario;


-- Datos en la tabla Ventas (Tabla Transaccional)
INSERT INTO Ventas (ID_Cliente, Fecha_Venta, Monto_Total, Estado_Venta, Tipo_Venta)
VALUES 
(1, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 4500.00, 'Pagado', 'Online'),
(2, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 200.00, 'Pendiente', 'Presencial'),
(3, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 150.00, 'Pagado', 'Online'),
(4, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 250.00, 'Pagado', 'Presencial'),
(5, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 1200.00, 'Pendiente', 'Online'),
(6, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 600.00, 'Pagado', 'Online'),
(7, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 300.00, 'Pagado', 'Presencial'),
(8, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 700.00, 'Pendiente', 'Online'),
(9, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 100.00, 'Pagado', 'Presencial'),
(10, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 50.00, 'Pagado', 'Online'),
(1, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 70.00, 'Pagado', 'Presencial'),
(2, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 40.00, 'Pendiente', 'Online'),
(3, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 90.00, 'Pagado', 'Presencial'),
(4, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 220.00, 'Pagado', 'Online'),
(5, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 30.00, 'Pendiente', 'Presencial'),
(6, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 25.00, 'Pagado', 'Online'),
(7, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 15.00, 'Pagado', 'Presencial'),
(8, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 20.00, 'Pendiente', 'Online'),
(9, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 35.00, 'Pagado', 'Presencial'),
(10, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 120.00, 'Pagado', 'Online');

SELECT * FROM Ventas;

-- Datos en la tabla Facturas Electrónicas (Tabla Transaccional)
INSERT INTO Facturas_Electronicas (ID_Venta_FE, Fecha_Emisión, Monto_Total, Estado_Factura)
VALUES 
(1, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 4500.00, 'Emitida'),
(2, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 200.00, 'Emitida'),
(3, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 150.00, 'Emitida'),
(4, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 250.00, 'Emitida'),
(5, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 1200.00, 'Emitida'),
(6, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 600.00, 'Emitida'),
(7, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 300.00, 'Emitida'),
(8, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 700.00, 'Emitida'),
(9, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 100.00, 'Emitida'),
(10, DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 10080, '2023-01-01'), 50.00, 'Emitida');

SELECT * FROM Facturas_Electronicas;