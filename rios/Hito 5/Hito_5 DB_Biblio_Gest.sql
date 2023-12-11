Create database DB_Biblio_Gest
use DB_Biblio_Gest

CREATE TABLE Libros (
    Id_Libro INT PRIMARY KEY IDENTITY(1,1),
    Titulo VARCHAR(255) NOT NULL,
    Id_Autor INT NOT NULL,
    Id_Editorial INT NOT NULL,
    Año_Publicacion INT NOT NULL,
    FOREIGN KEY (Id_Autor) REFERENCES Autores(Id_Autor),
    FOREIGN KEY (Id_Editorial) REFERENCES Editoriales(Id_Editorial)
);

CREATE TABLE Autores (
    Id_Autor INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Nacionalidad VARCHAR(100) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Biografia TEXT NOT NULL
);

CREATE TABLE Editoriales (
    Id_Editorial INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Usuarios (
    Id_Usuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Prestamos (
    Id_Prestamo INT PRIMARY KEY IDENTITY(1,1),
    Id_Usuario INT NOT NULL,
    Id_Libro INT NOT NULL,
    Fecha_Prestamo DATE NOT NULL,
    Fecha_Devolucion DATE NOT NULL,
    FOREIGN KEY (Id_Usuario) REFERENCES Usuarios(Id_Usuario),
    FOREIGN KEY (Id_Libro) REFERENCES Libros(Id_Libro)
);

CREATE TABLE Categorias (
    Id_Categoria INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT NOT NULL,
    Area VARCHAR(100) NOT NULL,
    Especialidad VARCHAR(100) NOT NULL
);

CREATE TABLE Libros_Categorias (
    Id_Libro INT NOT NULL,
    Id_Categoria INT NOT NULL,
    Fecha_Asignacion DATE NOT NULL,
    Comentarios TEXT NOT NULL,
    Importancia INT NOT NULL,
    FOREIGN KEY (Id_Libro) REFERENCES Libros(Id_Libro),
    FOREIGN KEY (Id_Categoria) REFERENCES Categorias(Id_Categoria),
    PRIMARY KEY (Id_Libro, Id_Categoria)
);

CREATE TABLE Empleados (
    Id_Empleado INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Puesto VARCHAR(100) NOT NULL,
    Fecha_Contratacion DATE NOT NULL,
    Salario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Eventos (
    Id_Evento INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT NOT NULL,
    Fecha DATE NOT NULL,
    Ubicacion VARCHAR(255) NOT NULL
);

CREATE TABLE Participaciones (
    Id_Evento INT NOT NULL,
    Id_Usuario INT NOT NULL,
    Rol VARCHAR(100) NOT NULL,
    Feedback TEXT NOT NULL,
    Fecha_Participacion DATE NOT NULL,
    FOREIGN KEY (Id_Evento) REFERENCES Eventos(Id_Evento),
    FOREIGN KEY (Id_Usuario) REFERENCES Usuarios(Id_Usuario),
    PRIMARY KEY (Id_Evento, Id_Usuario)
);

CREATE TABLE Proveedores (
    Id_Proveedor INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Compras (
    Id_Compra INT PRIMARY KEY IDENTITY(1,1),
    Id_Proveedor INT NOT NULL,
    Id_Libro INT NOT NULL,
    Cantidad INT NOT NULL,
    Fecha_Compra DATE NOT NULL,
    FOREIGN KEY (Id_Proveedor) REFERENCES Proveedores(Id_Proveedor),
    FOREIGN KEY (Id_Libro) REFERENCES Libros(Id_Libro)
);

CREATE TABLE Ventas_Libros (
    Id_Venta INT PRIMARY KEY IDENTITY(1,1),
    Id_Libro INT NOT NULL,
    Id_Usuario INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10, 2) NOT NULL,
    Fecha_Venta DATE NOT NULL,
    FOREIGN KEY (Id_Libro) REFERENCES Libros(Id_Libro),
    FOREIGN KEY (Id_Usuario) REFERENCES Usuarios(Id_Usuario)
);

CREATE TABLE Almacen (
    Id_Inventario INT PRIMARY KEY IDENTITY(1,1),
    Id_Libro INT NOT NULL,
    Cantidad_Disponible INT NOT NULL,
    Cantidad_Total INT NOT NULL,
    FOREIGN KEY (Id_Libro) REFERENCES Libros(Id_Libro)
);

CREATE TABLE Ingresos (
    Id_Ingreso INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(255) NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    Fecha_Ingreso DATE NOT NULL,
    Id_Venta INT,
    FOREIGN KEY (Id_Venta) REFERENCES Ventas_Libros(Id_Venta)
);

CREATE TABLE Sueldo (
    Id_Sueldo INT PRIMARY KEY IDENTITY(1,1),
    Id_Empleado INT NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    Mes INT NOT NULL,
    Año INT NOT NULL,
    FOREIGN KEY (Id_Empleado) REFERENCES Empleados(Id_Empleado)
);

CREATE TABLE Gastos (
    Id_Gasto INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(255) NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    Fecha_Gasto DATE NOT NULL,
    Id_Sueldo INT,
    Id_Compra INT,
    FOREIGN KEY (Id_Sueldo) REFERENCES Sueldo(Id_Sueldo),
    FOREIGN KEY (Id_Compra) REFERENCES Compras(Id_Compra)
);

--Registros

INSERT INTO Autores (Nombre, Nacionalidad, Fecha_Nacimiento, Biografia)
VALUES 
  ('Gabriel García Márquez', 'Colombiana', '1927-03-06', 'Autor de Cien Años de Soledad.'),
  ('J.K. Rowling', 'Británica', '1965-07-31', 'Autora de Harry Potter.'),
  ('Haruki Murakami', 'Japonesa', '1949-01-12', 'Autor de Kafka en la Orilla.'),
  ('Isabel Allende', 'Chilena', '1942-08-02', 'Autora de La Casa de los Espíritus.'),
  ('George Orwell', 'Británica', '1903-06-25', 'Autor de 1984.');

INSERT INTO Editoriales (Nombre, Direccion, Telefono, Email)
VALUES 
  ('Editorial Planeta', 'Calle Falsa 123', '555-1234', 'contacto@planeta.com'),
  ('Penguin Random House', 'Avenida Siempre Viva 456', '555-5678', 'contacto@penguinrandom.com'),
  ('Alfaguara', 'Diagonal 789', '555-9012', 'contacto@alfaguara.com'),
  ('Anagrama', 'Ruta 10 km 11', '555-3456', 'contacto@anagrama.com'),
  ('Acantilado', 'Bulevar de los Sueños 987', '555-7890', 'contacto@acantilado.com');

INSERT INTO Libros (Titulo, Id_Autor, Id_Editorial, Año_Publicacion)
VALUES 
  ('Cien años de soledad', 1, 1, 1967),
  ('Harry Potter y la piedra filosofal', 2, 2, 1997),
  ('Kafka en la orilla', 3, 3, 2002),
  ('La casa de los espíritus', 4, 4, 1982),
  ('1984', 5, 5, 1949);

INSERT INTO Usuarios (Nombre, Direccion, Telefono, Email)
VALUES 
  ('Juan Pérez', 'Calle Luna 111', '555-6543', 'juanperez@mail.com'),
  ('Ana López', 'Avenida Sol 222', '555-6789', 'analopez@mail.com'),
  ('Carlos Gómez', 'Calle Estrella 333', '555-9876', 'carlosgomez@mail.com'),
  ('Lucía Rodríguez', 'Boulevard Cometa 444', '555-1230', 'luciarodriguez@mail.com'),
  ('Miguel Ángel Torres', 'Calle Planeta 555', '555-4567', 'miguelangel@mail.com');

INSERT INTO Prestamos (Id_Usuario, Id_Libro, Fecha_Prestamo, Fecha_Devolucion)
VALUES 
  (1, 1, '2023-01-10', '2023-01-20'),
  (2, 2, '2023-02-15', '2023-02-25'),
  (3, 3, '2023-03-12', '2023-03-22'),
  (4, 4, '2023-04-08', '2023-04-18'),
  (5, 5, '2023-05-05', '2023-05-15');

INSERT INTO Categorias (Nombre, Descripcion, Area, Especialidad)
VALUES 
  ('Literatura', 'Libros de ficción y no ficción.', 'Artes', 'Literatura General'),
  ('Ciencia Ficción', 'Libros de ciencia ficción y fantasía.', 'Artes', 'Narrativa Fantástica'),
  ('Historia', 'Libros de historia y biografías.', 'Ciencias Sociales', 'Historia Universal'),
  ('Ciencia', 'Libros de ciencia y tecnología.', 'Ciencias', 'Divulgación Científica'),
  ('Filosofía', 'Libros de filosofía y pensamiento.', 'Humanidades', 'Filosofía Contemporánea');

INSERT INTO Libros_Categorias (Id_Libro, Id_Categoria, Fecha_Asignacion, Comentarios, Importancia)
VALUES 
  (1, 1, '2023-03-01', 'Clásico de la literatura latinoamericana', 5),
  (2, 2, '2023-03-02', 'Bestseller internacional', 4),
  (3, 1, '2023-03-03', 'Obra maestra de Murakami', 5),
  (4, 1, '2023-03-04', 'Importante obra de Isabel Allende', 4),
  (5, 2, '2023-03-05', 'Clásico de la literatura distópica', 5);

INSERT INTO Empleados (Nombre, Puesto, Fecha_Contratacion, Salario)
VALUES 
  ('Luisa Fernández', 'Gerente', '2019-05-01', 3500.00),
  ('Marco Antonio Solís', 'Bibliotecario', '2020-06-15', 2500.00),
  ('Rosa Martínez', 'Administrativa', '2018-07-10', 2200.00),
  ('Pedro Jiménez', 'Mantenimiento', '2021-01-20', 1800.00),
  ('Ana Maria López', 'Cajera', '2022-03-05', 2000.00);

INSERT INTO Eventos (Nombre, Descripcion, Fecha, Ubicacion)
VALUES 
  ('Feria del Libro', 'Evento anual de libros y autores', '2023-04-15', 'Centro de Convenciones'),
  ('Encuentro de Jóvenes Escritores', 'Reunión de nuevos talentos literarios', '2023-06-20', 'Biblioteca Municipal'),
  ('Charla sobre Literatura Contemporánea', 'Conferencia sobre tendencias literarias actuales', '2023-08-10', 'Universidad Nacional'),
  ('Exposición de Libros Antiguos', 'Muestra de libros raros y antiguos', '2023-10-05', 'Museo de la Ciudad'),
  ('Taller de Escritura Creativa', 'Curso de escritura para aficionados', '2023-11-15', 'Centro Cultural');

INSERT INTO Participaciones (Id_Evento, Id_Usuario, Rol, Feedback, Fecha_Participacion)
VALUES 
  (1, 1, 'Asistente', 'Muy interesante', '2023-04-15'),
  (2, 2, 'Ponente', 'Excelente experiencia', '2023-06-20'),
  (3, 3, 'Organizador', 'Gran participación', '2023-08-10'),
  (4, 4, 'Expositor', 'Evento muy bien organizado', '2023-10-05'),
  (5, 5, 'Instructor', 'Taller muy interactivo', '2023-11-15');

INSERT INTO Proveedores (Nombre, Direccion, Telefono, Email)
VALUES 
  ('Libros y Libros S.A.', 'Calle de los Libreros 123', '555-1122', 'contacto@libroslibros.com'),
  ('Distribuidora Nacional', 'Avenida Central 456', '555-3344', 'ventas@distribuidoranacional.com'),
  ('Papelera del Norte', 'Diagonal 78', '555-5566', 'info@papeleranorte.com'),
  ('Impresiones Rápidas Ltda.', 'Ruta 5 km 12', '555-7788', 'servicios@impresionesrapidas.com'),
  ('Editorial Digital', 'Bulevar Virtual 101', '555-9900', 'ebooks@editorialdigital.com');

INSERT INTO Compras (Id_Proveedor, Id_Libro, Cantidad, Fecha_Compra)
VALUES 
  (1, 1, 50, '2023-03-01'),
  (2, 2, 30, '2023-03-10'),
  (3, 3, 20, '2023-04-15'),
  (4, 4, 25, '2023-05-20'),
  (5, 5, 15, '2023-06-30');

INSERT INTO Ventas_Libros (Id_Libro, Id_Usuario, Cantidad, Precio_Unitario, Fecha_Venta)
VALUES 
  (1, 1, 1, 20.00, '2023-01-15'),
  (2, 2, 2, 15.00, '2023-02-20'),
  (3, 3, 1, 25.00, '2023-03-25'),
  (4, 4, 1, 30.00, '2023-04-30'),
  (5, 5, 2, 10.00, '2023-05-05');

INSERT INTO Almacen (Id_Libro, Cantidad_Disponible, Cantidad_Total)
VALUES 
  (1, 20, 50),
  (2, 10, 30),
  (3, 15, 20),
  (4, 10, 25),
  (5, 5, 15);

INSERT INTO Ingresos (Descripcion, Monto, Fecha_Ingreso, Id_Venta)
VALUES 
  ('Venta de Cien años de soledad', 20.00, '2023-01-15', 1),
  ('Venta de Harry Potter y la piedra filosofal', 30.00, '2023-02-20', 2),
  ('Venta de Kafka en la orilla', 25.00, '2023-03-25', 3),
  ('Venta de La casa de los espíritus', 30.00, '2023-04-30', 4),
  ('Venta de 1984', 20.00, '2023-05-05', 5);

INSERT INTO Sueldo (Id_Empleado, Monto, Mes, Año)
VALUES 
  (1, 3500.00, 1, 2023),
  (2, 2500.00, 2, 2023),
  (3, 2200.00, 3, 2023),
  (4, 1800.00, 4, 2023),
  (5, 2000.00, 5, 2023);

Truncate table Gastos

INSERT INTO Gastos (Descripcion, Monto, Fecha_Gasto, Id_Sueldo, Id_Compra)
VALUES 
  ('Pago de sueldo a Luisa Fernández', 3500.00, '2023-01-31', 1, NULL),
  ('Compra de libros a Libros y Libros S.A.', 3500.00, '2023-03-01', NULL, 1),
  ('Pago de sueldo a Marco Antonio Solís', 2500.00, '2023-02-28', 2, NULL),
  ('Compra de libros a Distribuidora Nacional', 2500.00, '2023-03-10', NULL, 2),
  ('Pago de sueldo a Rosa Martínez', 2200.00, '2023-03-31', 3, NULL),
  ('Compra de libros a Libros y Libros S.A.', 1500.00, '2023-03-05', NULL, 3),
  ('Pago de sueldo a Pedro Jiménez', 1800.00, '2023-04-30', 4, NULL),
  ('Compra de libros a Editorial Digital', 2000.00, '2023-06-15', NULL, 5),
  ('Pago de sueldo a Ana Maria López', 2000.00, '2023-05-31', 5, NULL),
  ('Compra de libros a Papelera del Norte', 1200.00, '2023-06-20', NULL, 4);



--Consultas SQL que maneja JOINS
SELECT L.Titulo, A.Nombre
FROM Libros L
JOIN Autores A ON L.Id_Autor = A.Id_Autor;

SELECT L.Titulo, A.Nombre AS Autor, E.Nombre AS Editorial
FROM Libros L
JOIN Autores A ON L.Id_Autor = A.Id_Autor
JOIN Editoriales E ON L.Id_Editorial = E.Id_Editorial;

SELECT P.Fecha_Prestamo, P.Fecha_Devolucion, U.Nombre AS Usuario, L.Titulo AS Libro
FROM Prestamos P
JOIN Usuarios U ON P.Id_Usuario = U.Id_Usuario
JOIN Libros L ON P.Id_Libro = L.Id_Libro;

SELECT V.Fecha_Venta, U.Nombre AS Comprador, L.Titulo AS Libro
FROM Ventas_Libros V
JOIN Usuarios U ON V.Id_Usuario = U.Id_Usuario
JOIN Libros L ON V.Id_Libro = L.Id_Libro;

SELECT E.Nombre, S.Monto, G.Descripcion, G.Fecha_Gasto
FROM Empleados E
JOIN Sueldo S ON E.Id_Empleado = S.Id_Empleado
JOIN Gastos G ON S.Id_Sueldo = G.Id_Sueldo;

--Funciones de Agregación

SELECT COUNT(*) as NumEmpleados FROM Empleados;
SELECT AVG(Salario) FROM Empleados;
SELECT MAX(Precio_Unitario) as PrecioMAX FROM Ventas_Libros ;
SELECT SUM(Monto) Total_Ingresos FROM Ingresos;
SELECT MIN(Cantidad_Disponible) as MenorCant FROM Almacen


--Funciones de Agregación con Manejo con 3 tablas

-- Cuantas ganacias genero cada autor
SELECT A.Nombre AS Autor, L.Titulo AS Libro, V.Cantidad, SUM(V.Precio_Unitario * V.Cantidad) AS Total_Ventas
FROM Ventas_Libros V
JOIN Libros L ON V.Id_Libro = L.Id_Libro
JOIN Autores A ON L.Id_Autor = A.Id_Autor
GROUP BY A.Nombre, L.Titulo, V.Cantidad;

--Cuantas ganacias se genero por mes 
SELECT YEAR(I.Fecha_Ingreso) AS Año, MONTH(I.Fecha_Ingreso) AS Mes, SUM(I.Monto) As Monto_Mensual
FROM Ingresos I
JOIN Ventas_Libros V ON I.Id_Venta = V.Id_Venta
JOIN Libros L ON V.Id_Libro = L.Id_Libro
GROUP BY YEAR(I.Fecha_Ingreso), MONTH(I.Fecha_Ingreso);

-- Muestra los libros adquiridos, el provedor, la editorial y la cantidad de libros adquiridos
SELECT L.Titulo, PR.Nombre AS Proveedor, E.Nombre AS Editorial, SUM(C.Cantidad) AS Total_Compras
FROM Compras C
JOIN Libros L ON C.Id_Libro = L.Id_Libro
JOIN Proveedores PR ON C.Id_Proveedor = PR.Id_Proveedor
JOIN Editoriales E ON L.Id_Editorial = E.Id_Editorial
GROUP BY L.Titulo, PR.Nombre, E.Nombre;

--Muestra cuanto vendio las categorias de los libros
SELECT CAT.Nombre AS Categoria, SUM(I.Monto) AS Total_Ingresos
FROM Ingresos I
JOIN Ventas_Libros V ON I.Id_Venta = V.Id_Venta
JOIN Libros L ON V.Id_Libro = L.Id_Libro
JOIN Libros_Categorias LC ON L.Id_Libro = LC.Id_Libro
JOIN Categorias CAT ON LC.Id_Categoria = CAT.Id_Categoria
GROUP BY CAT.Nombre;

--Muestra cuanto gano cada empleado y en que mes
SELECT YEAR(G.Fecha_Gasto) AS Año, MONTH(G.Fecha_Gasto) AS Mes, E.Puesto, SUM(G.Monto) AS Total_Sueldos
FROM Gastos G
JOIN Sueldo S ON G.Id_Sueldo = S.Id_Sueldo
JOIN Empleados E ON S.Id_Empleado = E.Id_Empleado
WHERE G.Id_Sueldo IS NOT NULL
GROUP BY YEAR(G.Fecha_Gasto), MONTH(G.Fecha_Gasto), E.Puesto;

--Funciones
--1ra Calcula el Total de Ingresos
CREATE FUNCTION CalcularTotalIngresos ()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalIngresos DECIMAL(10, 2);
    SELECT @TotalIngresos = SUM(Monto)
    FROM Ingresos;
    RETURN @TotalIngresos;
END;

-- Declara una variable para almacenar el resultado
DECLARE @ResultadoTotalIngresos DECIMAL(10, 2);

-- Ejecuta la función y almacena el resultado en la variable @ResultadoTotalIngresos
SET @ResultadoTotalIngresos = dbo.CalcularTotalIngresos();

-- Imprime el resultado
PRINT 'El total de ingresos es: $' + CAST(@ResultadoTotalIngresos AS VARCHAR);


--2da Calcula el Total de Gastos 
CREATE FUNCTION CalcularTotalGastos ()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalGastos DECIMAL(10, 2);
    SELECT @TotalGastos = SUM(Monto)
    FROM Gastos;
    RETURN @TotalGastos;
END;

-- Declara una variable para almacenar el resultado
DECLARE @ResultadoTotalGastos DECIMAL(10, 2);

-- Ejecuta la función y almacena el resultado en la variable @ResultadoTotalGastos
SET @ResultadoTotalGastos = dbo.CalcularTotalGastos();

-- Imprime el resultado
PRINT 'El total de gastos es: $' + CAST(@ResultadoTotalGastos AS VARCHAR);

--3ra Calcula el Balance
CREATE FUNCTION CalcularBalance ()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Balance DECIMAL(10, 2);
    SET @Balance = dbo.CalcularTotalIngresos() - dbo.CalcularTotalGastos();
    RETURN @Balance;
END;

-- Declara una variable para almacenar el resultado
DECLARE @ResultadoBalance DECIMAL(10, 2);

-- Ejecuta la función y almacena el resultado en la variable @ResultadoBalance
SET @ResultadoBalance = dbo.CalcularBalance();

-- Imprime el resultado
PRINT 'El balance es: $' + CAST(@ResultadoBalance AS VARCHAR);



     Select* From Almacen
     Select* From Autores
     Select* From Categorias
     Select* From Compras
     Select* From Editoriales
     Select* From Empleados
     Select* From Eventos
     Select* From Gastos
     Select* From Ingresos
     Select* From Libros
     Select* From Libros_Categorias
     Select* From Participaciones
     Select* From Prestamos
     Select* From Proveedores
     Select* From Sueldo
     Select* From Usuarios
     Select* From Ventas_Libros