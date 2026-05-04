DROP DATABASE IF EXISTS incubadora_palenque;
CREATE DATABASE incubadora_palenque;
USE incubadora_palenque;



CREATE TABLE Rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL
);

CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    nombre_usuario VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_prod VARCHAR(100) NOT NULL,
    descripcion VARCHAR(250),
    precio_venta DECIMAL(10,2) NOT NULL
);

CREATE TABLE ProductoProveedor (
    id_producto INT,
    id_proveedor INT,
    precio_compra DECIMAL(10,2),
    tiempo_entrega INT,
    PRIMARY KEY (id_producto, id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

CREATE TABLE Inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    cantidad_disponible INT NOT NULL,
    fecha_actualizacion DATETIME,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_venta DATETIME NOT NULL,
    total DECIMAL(10,2),
    estado_pago ENUM('pendiente','pagado','cancelado'),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE DetalleVenta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    total_pago DECIMAL(10,2),
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Factura (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    fecha_emision DATETIME,
    tipo_factura VARCHAR(50),
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta)
);

CREATE TABLE MovimientoInventario (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    id_usuario INT,
    tipo ENUM('entrada','salida'),
    cantidad INT,
    fecha DATETIME,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

SHOW TABLES;

-- ======================
-- INSERT DE PRUEBA
-- ======================

INSERT INTO Rol (nombre_rol) VALUES
('Administrador'),
('Empleado'),
('Cliente');

INSERT INTO Usuario (id_rol, nombre_usuario, correo, password_hash) VALUES
(1, 'admin_palenque', 'admin@palenque.com', 'hash_admin'),
(2, 'empleado_ventas', 'ventas@palenque.com', 'hash_emp'),
(3, 'cliente_juan', 'juan@gmail.com', 'hash_cliente'),
(3, 'cliente_maria', 'maria@gmail.com', 'hash_cliente');

INSERT INTO Cliente (id_usuario, nombre, telefono, direccion) VALUES
(3, 'Juan Pérez', '3001234567', 'Bogotá'),
(4, 'María Gómez', '3117654321', 'Medellín');

SELECT * FROM Usuario;
SELECT * FROM Cliente;

