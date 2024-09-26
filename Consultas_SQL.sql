USE proyecto_facturacion_game;
GO
--##########################################
-- Consultas SQL
--##########################################

-- Listar todos los clientes:
SELECT * FROM Clientes;

-- Total de ventas por cliente:
SELECT C.Nombre, SUM(V.Monto_Total) AS Total_Ventas
FROM Ventas V
JOIN Clientes C ON V.ID_Cliente = C.ID
GROUP BY C.Nombre;


-- Ventas pendientes:
SELECT * FROM Ventas
WHERE Estado_Venta = 'Pendiente';


--##########################################
-- Funciones SQL
--##########################################

--Función para calcular el subtotal:
---------------------------------------------
CREATE FUNCTION CalcularSubtotal (@cantidad INT, @precioUnitario DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @cantidad * @precioUnitario;
END;

SELECT * FROM Detalles_Venta;
-------------------------------------------------
--Función para obtener el total de ventas:
CREATE FUNCTION TotalVentas (@idCliente INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @total DECIMAL(10, 2);
    SELECT @total = SUM(Monto_Total)
    FROM Ventas
    WHERE ID_Cliente = @idCliente;
    RETURN ISNULL(@total, 0);
END;



--##########################################
-- Procedimientos Almacenados
--##########################################

--Procedimiento para agregar un nuevo cliente:

CREATE PROCEDURE AgregarCliente
    @Nombre VARCHAR(100),
    @Dirección VARCHAR(200),
    @Teléfono CHAR(10),
    @Correo_Electrónico VARCHAR(100),
    @Tipo_Cliente VARCHAR(20),
    @Número_Identificación VARCHAR(50)
AS
BEGIN
    INSERT INTO Clientes (Nombre, Dirección, Teléfono, Correo_Electrónico, Tipo_Cliente, Número_Identificación)
    VALUES (@Nombre, @Dirección, @Teléfono, @Correo_Electrónico, @Tipo_Cliente, @Número_Identificación);
END;


--Procedimiento para realizar una venta:
CREATE PROCEDURE RealizarVenta
    @ID_Cliente INT,
    @Monto_Total DECIMAL(10, 2),
    @Tipo_Venta VARCHAR(10)
AS
BEGIN
    INSERT INTO Ventas (ID_Cliente, Fecha_Venta, Monto_Total, Estado_Venta, Tipo_Venta)
    VALUES (@ID_Cliente, GETDATE(), @Monto_Total, 'Pendiente', @Tipo_Venta);
END;

SELECT * FROM Ventas;

--Consultar ventas por categoría de producto:
SELECT P.Categoría, SUM(D.Cantidad) AS Total_Vendido
FROM Detalles_Venta D
JOIN Productos P ON D.ID_Producto = P.ID
GROUP BY P.Categoría;


--Obtener clientes que no han realizado compras:
SELECT C.*
FROM Clientes C
LEFT JOIN Ventas V ON C.ID = V.ID_Cliente
WHERE V.ID IS NULL;

--Actualizar el stock de un producto:
UPDATE Productos
SET Stock = Stock - 5
WHERE ID = 1; -- Cambia el ID según sea necesario

SELECT * FROM Productos;

--Contar el número de facturas emitidas por mes:
SELECT MONTH(Fecha_Emisión) AS Mes, COUNT(*) AS Total_Facturas
FROM Facturas_Electronicas
GROUP BY MONTH(Fecha_Emisión);

--Listar detalles de una venta específica:
SELECT D.*, P.Nombre_Producto
FROM Detalles_Venta D
JOIN Productos P ON D.ID_Producto = P.ID
WHERE D.ID_Venta = 1; -- Cambia el ID según sea necesario

--Obtener la venta más alta:
SELECT TOP 1 * 
FROM Ventas
ORDER BY Monto_Total DESC;

SELECT * FROM Ventas;

--Calcular el promedio de ventas por cliente:
SELECT ID_Cliente, AVG(Monto_Total) AS Promedio_Ventas
FROM Ventas
GROUP BY ID_Cliente;
