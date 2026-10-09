-- == SECCIÓN 0: CREACION DE LA BD ==

CREATE DATABASE Ventas_Tech_DB;

USE Ventas_Tech_DB;

-- == SECCIÓN 1: DROP TABLES ==
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS geografia;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;


-- == SECCIÓN 2: CREATE TABLES ==

CREATE TABLE categorias (
id_categoria INT PRIMARY KEY,
nombre_categoria VARCHAR(50) NOT NULL,
descripcion VARCHAR(200)
);

CREATE TABLE clientes (
id_cliente INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
ciudad VARCHAR(50),
fecha_registro DATE NOT NULL,
estado TINYINT(1) DEFAULT 1,
segmento VARCHAR(30)
);

CREATE TABLE productos (
id_producto	INT	PRIMARY KEY,
nombre_producto	VARCHAR(100) NOT NULL,
descripcion_producto VARCHAR(200),
id_categoria INT,
precio DECIMAL(10,2) NOT NULL,
costo DECIMAL(10,2) NOT NULL,
stock INT DEFAULT 0,
activo TINYINT(1) DEFAULT 1,
CONSTRAINT fk_categoria_producto
FOREIGN KEY (id_categoria)
REFERENCES categorias(id_categoria)
);

CREATE TABLE geografia (
id_ubicacion INT PRIMARY KEY,
region VARCHAR(50),
provincia_estado VARCHAR(50) NOT NULL
);

CREATE TABLE ventas (
id_venta INT PRIMARY KEY,
id_cliente INT,
id_producto INT,
id_ubicacion INT,
cantidad INT NOT NULL,
precio_unitario DECIMAL(10, 2) NOT NULL,
costo_unitario DECIMAL(10, 2) NOT NULL,
fecha_venta DATE NOT NULL,
CONSTRAINT fk_venta_cliente
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente),
CONSTRAINT fk_venta_producto
FOREIGN KEY (id_producto)
REFERENCES productos(id_producto),
CONSTRAINT fk_venta_ubicacion
FOREIGN KEY (id_ubicacion)
REFERENCES geografia(id_ubicacion)
);


-- == SECCIÓN 3: INSERT DATA ==

INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
  (1, 'Computación',    'Laptops, PCs y monitores'),
  (2, 'Accesorios',     'Periféricos y complementos'),
  (3, 'Audio',          'Auriculares y parlantes'),
  (4, 'Almacenamiento', 'Discos y memorias');

INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro, estado, segmento) VALUES
  (1, 'María López',  'maria@mail.com',  'Buenos Aires', '2024-01-05', 1, 'Corporativo'),
  (2, 'Carlos Ruiz',  'carlos@mail.com', 'Córdoba',      '2024-01-10', 1, 'Individual'),
  (3, 'Ana Gómez',    'ana@mail.com',    'Rosario',      '2024-02-01', 1, 'Pyme'),
  (4, 'Pedro Sanz',   'pedro@mail.com',  'Mendoza',      '2024-02-15', 1, 'Individual'),
  (5, 'Laura Torres', 'laura@mail.com',  'Tucumán',      '2024-03-01', 1, 'Corporativo'),
  (6, 'Gabriel Vega', 'gabriel@mail.com','Salta',        '2024-03-05', 1, 'Pyme');

INSERT INTO productos (id_producto, nombre_producto, descripcion_producto, id_categoria, precio, costo, stock, activo) VALUES
  (1, 'Laptop Pro 15',     'Laptop de alto rendimiento con pantalla de 15 pulgadas y procesador potente', 1, 1200.00, 850.00, 15, 1),
  (2, 'Mouse Inalámbrico', 'Mouse ergonómico inalámbrico con sensor óptico de alta precisión',            2,   28.00,  15.00, 80, 1),
  (3, 'Monitor 4K 27',     'Monitor Ultra HD de 27 pulgadas con panel IPS e idóneo para diseño',         1,  450.00, 300.00, 12, 1),
  (4, 'Auriculares BT Pro','Auriculares bluetooth over-ear con cancelación activa de ruido',               3,  120.00,  75.00, 35, 1),
  (5, 'SSD Externo 1TB',   'Unidad de estado sólido portátil de 1TB con conexión USB-C rápida',           4,  130.00,  80.00, 18, 1),
  (6, 'Teclado Mecánico',  'Teclado mecánico retroiluminado RGB con switches táctiles',                   2,   95.00,  55.00, 40, 1),
  (7, 'Webcam Full HD',    'Cámara web 1080p con micrófono estéreo integrado para videollamadas',        2,   65.00,  40.00, 25, 1);

INSERT INTO geografia (id_ubicacion, provincia_estado, region) VALUES
  (1, 'Buenos Aires', 'Pampa'),
  (2, 'Córdoba',      'Centro'),
  (3, 'Santa Fe',     'Litoral'),
  (4, 'Mendoza',      'Cuyo'),
  (5, 'Tucumán',      'NOA'),
  (6, 'Salta',        'NOA');

INSERT INTO ventas (id_venta, id_cliente, id_producto, id_ubicacion, cantidad, precio_unitario, costo_unitario, fecha_venta) VALUES
  ( 1, 1, 1, 1, 2, 1200.00, 850.00, '2024-03-05'),
  ( 2, 2, 2, 1, 5,   28.00,  15.00, '2024-03-06'),
  ( 3, 3, 3, 3, 1,  450.00, 300.00, '2024-03-07'),
  ( 4, 1, 4, 4, 2,  120.00,  75.00, '2024-03-08'),
  ( 5, 4, 5, 2, 3,  130.00,  80.00, '2024-03-10'),
  ( 6, 2, 6, 3, 4,   95.00,  55.00, '2024-03-11'),
  ( 7, 5, 1, 3, 1, 1200.00, 850.00, '2024-03-12'),
  ( 8, 3, 2, 5, 8,   28.00,  15.00, '2024-03-13'),
  ( 9, 4, 4, 1, 1,  120.00,  75.00, '2024-03-14'),
  (10, 5, 3, 1, 2,  450.00, 300.00, '2024-03-15');

-- == SECCIÓN 4: VALIDACIÓN ==

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
SELECT * FROM geografia;
