-- PixelLoot: esquema inicial en espanol para MySQL/MariaDB (XAMPP).
-- Los datos de demostracion no representan ventas, usuarios ni licencias reales.

CREATE DATABASE IF NOT EXISTS pixel_loot
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE pixel_loot;

CREATE TABLE IF NOT EXISTS usuarios (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombres VARCHAR(80) NOT NULL,
  apellidos VARCHAR(80) NOT NULL,
  correo VARCHAR(190) NOT NULL,
  hash_contrasena VARCHAR(255) NOT NULL,
  rol ENUM('cliente', 'vendedor') NOT NULL DEFAULT 'cliente',
  idioma_preferido ENUM('es', 'en', 'pt') NOT NULL DEFAULT 'es',
  activo TINYINT(1) NOT NULL DEFAULT 1,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_usuarios_correo (correo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS categorias (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  slug VARCHAR(110) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_categorias_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS productos (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  vendedor_id INT UNSIGNED NULL COMMENT 'NULL para productos demo del catalogo central',
  categoria_id INT UNSIGNED NOT NULL,
  nombre VARCHAR(180) NOT NULL,
  slug VARCHAR(200) NOT NULL,
  descripcion TEXT NOT NULL,
  tipo_producto ENUM('periferico', 'licencia_digital') NOT NULL,
  precio DECIMAL(12,2) NOT NULL,
  precio_original DECIMAL(12,2) NOT NULL,
  porcentaje_descuento DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  cantidad_disponible INT UNSIGNED NOT NULL DEFAULT 0,
  ruta_imagen VARCHAR(500) NULL,
  estado ENUM('borrador', 'activo', 'agotado', 'inactivo') NOT NULL DEFAULT 'activo',
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_productos_slug (slug),
  KEY idx_productos_categoria_estado (categoria_id, estado),
  KEY idx_productos_vendedor (vendedor_id),
  CONSTRAINT fk_productos_vendedor FOREIGN KEY (vendedor_id) REFERENCES usuarios(id) ON DELETE SET NULL,
  CONSTRAINT fk_productos_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id),
  CONSTRAINT chk_productos_precios CHECK (precio >= 0 AND precio_original >= precio),
  CONSTRAINT chk_productos_descuento CHECK (porcentaje_descuento BETWEEN 0 AND 50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS promociones (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(160) NOT NULL,
  descripcion VARCHAR(500) NULL,
  porcentaje_descuento DECIMAL(5,2) NOT NULL,
  inicia_en DATETIME NULL,
  termina_en DATETIME NULL,
  activa TINYINT(1) NOT NULL DEFAULT 1,
  creada_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT chk_promociones_descuento CHECK (porcentaje_descuento BETWEEN 0 AND 50),
  CONSTRAINT chk_promociones_fechas CHECK (termina_en IS NULL OR inicia_en IS NULL OR termina_en > inicia_en)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS productos_promociones (
  producto_id INT UNSIGNED NOT NULL,
  promocion_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (producto_id, promocion_id),
  CONSTRAINT fk_productos_promociones_producto FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
  CONSTRAINT fk_productos_promociones_promocion FOREIGN KEY (promocion_id) REFERENCES promociones(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS direcciones (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  usuario_id INT UNSIGNED NOT NULL,
  nombre_destinatario VARCHAR(160) NOT NULL,
  telefono VARCHAR(40) NULL,
  direccion_linea VARCHAR(240) NOT NULL,
  ciudad VARCHAR(100) NOT NULL,
  departamento VARCHAR(100) NULL,
  codigo_postal VARCHAR(24) NULL,
  pais VARCHAR(80) NOT NULL DEFAULT 'Colombia',
  creada_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_direcciones_usuario (usuario_id),
  CONSTRAINT fk_direcciones_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS pedidos (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  usuario_id INT UNSIGNED NOT NULL,
  direccion_id INT UNSIGNED NULL,
  estado_pedido ENUM('pendiente_pago', 'pagado', 'preparando', 'enviado', 'entregado', 'canjeado', 'cancelado', 'reembolsado') NOT NULL DEFAULT 'pendiente_pago',
  estado_pago ENUM('pendiente', 'aprobado', 'rechazado', 'reembolsado') NOT NULL DEFAULT 'pendiente',
  modo_pago ENUM('simulado') NOT NULL DEFAULT 'simulado',
  correo_cliente VARCHAR(190) NOT NULL,
  direccion_envio_copia TEXT NULL,
  subtotal DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  descuento_total DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  costo_envio DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  total DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_pedidos_usuario_fecha (usuario_id, creado_en),
  KEY idx_pedidos_estado (estado_pedido),
  CONSTRAINT fk_pedidos_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  CONSTRAINT fk_pedidos_direccion FOREIGN KEY (direccion_id) REFERENCES direcciones(id) ON DELETE SET NULL,
  CONSTRAINT chk_pedidos_totales CHECK (subtotal >= 0 AND descuento_total >= 0 AND costo_envio >= 0 AND total >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS detalle_pedido (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  pedido_id INT UNSIGNED NOT NULL,
  producto_id INT UNSIGNED NULL,
  vendedor_id INT UNSIGNED NULL,
  nombre_producto_copia VARCHAR(180) NOT NULL,
  tipo_producto_copia ENUM('periferico', 'licencia_digital') NOT NULL,
  precio_unitario DECIMAL(12,2) NOT NULL,
  cantidad INT UNSIGNED NOT NULL,
  porcentaje_descuento DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  total_linea DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (id),
  KEY idx_detalle_pedido_pedido (pedido_id),
  CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
  CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE SET NULL,
  CONSTRAINT fk_detalle_pedido_vendedor FOREIGN KEY (vendedor_id) REFERENCES usuarios(id) ON DELETE SET NULL,
  CONSTRAINT chk_detalle_pedido_cantidad CHECK (cantidad > 0),
  CONSTRAINT chk_detalle_pedido_descuento CHECK (porcentaje_descuento BETWEEN 0 AND 50),
  CONSTRAINT chk_detalle_pedido_precios CHECK (precio_unitario >= 0 AND total_linea >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS pagos_simulados (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  pedido_id INT UNSIGNED NOT NULL,
  estado ENUM('pendiente', 'aprobado', 'rechazado', 'reembolsado') NOT NULL DEFAULT 'pendiente',
  codigo_referencia VARCHAR(80) NULL,
  monto DECIMAL(12,2) NOT NULL,
  simulado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_pagos_simulados_pedido (pedido_id),
  CONSTRAINT fk_pagos_simulados_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
  CONSTRAINT chk_pagos_simulados_monto CHECK (monto >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS recompensas (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  codigo VARCHAR(50) NOT NULL,
  nombre VARCHAR(160) NOT NULL,
  descripcion VARCHAR(500) NOT NULL,
  tipo_recompensa ENUM('descuento', 'envio_gratis', 'puntos', 'periferico') NOT NULL,
  porcentaje_descuento DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  puntos_otorgados INT UNSIGNED NOT NULL DEFAULT 0,
  probabilidad_porcentaje DECIMAL(5,2) NOT NULL,
  color_ruleta CHAR(7) NOT NULL,
  activa TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uq_recompensas_codigo (codigo),
  CONSTRAINT chk_recompensas_descuento CHECK (porcentaje_descuento BETWEEN 0 AND 50),
  CONSTRAINT chk_recompensas_probabilidad CHECK (probabilidad_porcentaje BETWEEN 0 AND 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS giros_ruleta (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  usuario_id INT UNSIGNED NOT NULL,
  recompensa_id INT UNSIGNED NOT NULL,
  puntos_gastados INT UNSIGNED NOT NULL DEFAULT 100,
  saldo_puntos_despues INT UNSIGNED NOT NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_giros_ruleta_usuario_fecha (usuario_id, creado_en),
  CONSTRAINT fk_giros_ruleta_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  CONSTRAINT fk_giros_ruleta_recompensa FOREIGN KEY (recompensa_id) REFERENCES recompensas(id),
  CONSTRAINT chk_giros_ruleta_costo CHECK (puntos_gastados = 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS canjes_recompensas (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  giro_id INT UNSIGNED NOT NULL,
  usuario_id INT UNSIGNED NOT NULL,
  recompensa_id INT UNSIGNED NOT NULL,
  codigo_canje VARCHAR(80) NULL,
  estado ENUM('disponible', 'canjeado', 'vencido') NOT NULL DEFAULT 'disponible',
  vence_en DATETIME NULL,
  canjeado_en DATETIME NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_canjes_recompensas_giro (giro_id),
  UNIQUE KEY uq_canjes_recompensas_codigo (codigo_canje),
  CONSTRAINT fk_canjes_recompensas_giro FOREIGN KEY (giro_id) REFERENCES giros_ruleta(id) ON DELETE CASCADE,
  CONSTRAINT fk_canjes_recompensas_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  CONSTRAINT fk_canjes_recompensas_recompensa FOREIGN KEY (recompensa_id) REFERENCES recompensas(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS movimientos_puntos (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  usuario_id INT UNSIGNED NOT NULL,
  pedido_id INT UNSIGNED NULL,
  tipo_movimiento ENUM('compra', 'giro', 'premio', 'reembolso', 'ajuste_demo') NOT NULL,
  cambio_puntos INT NOT NULL COMMENT 'Positivo acredita puntos; negativo los descuenta',
  descripcion VARCHAR(300) NOT NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_movimientos_puntos_usuario_fecha (usuario_id, creado_en),
  KEY idx_movimientos_puntos_pedido (pedido_id),
  CONSTRAINT fk_movimientos_puntos_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  CONSTRAINT fk_movimientos_puntos_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE SET NULL,
  CONSTRAINT chk_movimientos_puntos_no_cero CHECK (cambio_puntos <> 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS codigos_licencia_digital (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  producto_id INT UNSIGNED NOT NULL,
  detalle_pedido_id INT UNSIGNED NULL,
  usuario_asignado_id INT UNSIGNED NULL,
  codigo_licencia VARCHAR(120) NOT NULL,
  estado ENUM('disponible', 'asignada', 'canjeada', 'anulada') NOT NULL DEFAULT 'disponible',
  enviado_email_en DATETIME NULL,
  canjeado_en DATETIME NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_codigos_licencia_digital_codigo (codigo_licencia),
  KEY idx_codigos_licencia_digital_inventario (producto_id, estado),
  CONSTRAINT fk_codigos_licencia_digital_producto FOREIGN KEY (producto_id) REFERENCES productos(id),
  CONSTRAINT fk_codigos_licencia_digital_detalle FOREIGN KEY (detalle_pedido_id) REFERENCES detalle_pedido(id) ON DELETE SET NULL,
  CONSTRAINT fk_codigos_licencia_digital_usuario FOREIGN KEY (usuario_asignado_id) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Catalogo ficticio para la demostracion del esquema.
INSERT IGNORE INTO categorias (nombre, slug) VALUES
  ('Audio', 'audio'),
  ('Teclados', 'teclados'),
  ('Accesorios', 'accesorios'),
  ('Licencias digitales', 'licencias-digitales');

INSERT IGNORE INTO productos
  (vendedor_id, categoria_id, nombre, slug, descripcion, tipo_producto, precio, precio_original, porcentaje_descuento, cantidad_disponible, estado)
SELECT NULL, c.id, 'Auriculares Nova X', 'auriculares-nova-x', 'Producto ficticio de demostracion.', 'periferico', 189900, 229900, 17, 12, 'activo' FROM categorias c WHERE c.slug = 'audio';
INSERT IGNORE INTO productos
  (vendedor_id, categoria_id, nombre, slug, descripcion, tipo_producto, precio, precio_original, porcentaje_descuento, cantidad_disponible, estado)
SELECT NULL, c.id, 'Teclado mecanico K68', 'teclado-mecanico-k68', 'Producto ficticio de demostracion.', 'periferico', 249900, 299900, 17, 7, 'activo' FROM categorias c WHERE c.slug = 'teclados';
INSERT IGNORE INTO productos
  (vendedor_id, categoria_id, nombre, slug, descripcion, tipo_producto, precio, precio_original, porcentaje_descuento, cantidad_disponible, estado)
SELECT NULL, c.id, 'Mouse gamer Pulse', 'mouse-gamer-pulse', 'Producto ficticio de demostracion.', 'periferico', 119900, 139900, 14, 18, 'activo' FROM categorias c WHERE c.slug = 'accesorios';
INSERT IGNORE INTO productos
  (vendedor_id, categoria_id, nombre, slug, descripcion, tipo_producto, precio, precio_original, porcentaje_descuento, cantidad_disponible, estado)
SELECT NULL, c.id, 'Licencia creativa Pro', 'licencia-creativa-pro', 'Licencia ficticia para demostracion academica.', 'licencia_digital', 89900, 109900, 18, 30, 'activo' FROM categorias c WHERE c.slug = 'licencias-digitales';
INSERT IGNORE INTO productos
  (vendedor_id, categoria_id, nombre, slug, descripcion, tipo_producto, precio, precio_original, porcentaje_descuento, cantidad_disponible, estado)
SELECT NULL, c.id, 'Control inalambrico Arc', 'control-inalambrico-arc', 'Producto ficticio de demostracion.', 'periferico', 179900, 179900, 0, 5, 'activo' FROM categorias c WHERE c.slug = 'accesorios';
INSERT IGNORE INTO productos
  (vendedor_id, categoria_id, nombre, slug, descripcion, tipo_producto, precio, precio_original, porcentaje_descuento, cantidad_disponible, estado)
SELECT NULL, c.id, 'Licencia Office Plus', 'licencia-office-plus', 'Licencia ficticia para demostracion academica.', 'licencia_digital', 129900, 159900, 19, 25, 'activo' FROM categorias c WHERE c.slug = 'licencias-digitales';

INSERT INTO recompensas (codigo, nombre, descripcion, tipo_recompensa, porcentaje_descuento, puntos_otorgados, probabilidad_porcentaje, color_ruleta) VALUES
  ('coupon-5', 'Cupon de 5 %', 'Cupon de demostracion para la proxima compra; el canje requiere backend.', 'descuento', 5, 0, 40, '#20B58B'),
  ('coupon-10', 'Cupon de 10 %', 'Cupon de demostracion para la proxima compra; el canje requiere backend.', 'descuento', 10, 0, 25, '#3286E8'),
  ('points-50', '50 puntos de vuelta', 'Recompensa de puntos de demostracion.', 'puntos', 0, 50, 20, '#8F61E8'),
  ('free-shipping', 'Envio gratis', 'Beneficio de envio de demostracion; el canje requiere backend.', 'envio_gratis', 0, 0, 10, '#F0A12C'),
  ('surprise-gear', 'Periferico sorpresa', 'Premio fisico ficticio para la demostracion academica.', 'periferico', 0, 0, 5, '#E64F77')
ON DUPLICATE KEY UPDATE
  nombre = VALUES(nombre), descripcion = VALUES(descripcion), tipo_recompensa = VALUES(tipo_recompensa),
  porcentaje_descuento = VALUES(porcentaje_descuento), puntos_otorgados = VALUES(puntos_otorgados),
  probabilidad_porcentaje = VALUES(probabilidad_porcentaje), color_ruleta = VALUES(color_ruleta), activa = 1;
