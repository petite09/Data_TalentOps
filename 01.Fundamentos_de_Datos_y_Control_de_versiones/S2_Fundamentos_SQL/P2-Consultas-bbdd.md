#  Consultas básicas en base de datos de ventas

## Configurar datos de ejemplo:

```
-- Crear y poblar tabla de productos
CREATE TABLE productos (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    precio REAL NOT NULL,
    categoria TEXT,
    stock INTEGER DEFAULT 0
);

INSERT INTO productos VALUES
(1, 'Laptop Dell', 1200.00, 'Electrónica', 15),
(2, 'Mouse Logitech', 25.50, 'Accesorios', 50),
(3, 'Teclado Mecánico', 89.99, 'Accesorios', 30),
(4, 'Monitor 24"', 199.99, 'Electrónica', 12),
(5, 'Audífonos Sony', 149.50, 'Audio', 25);
```

## Consultas básicas

```
-- Seleccionar productos con precio > 100
SELECT nombre, precio FROM productos WHERE precio > 100;

-- Productos de categoría 'Electrónica' ordenados por precio descendente
SELECT nombre, precio, categoria FROM productos
WHERE categoria = 'Electrónica'
ORDER BY precio DESC;

-- Productos con stock entre 10 y 40, ordenados por stock ascendente
SELECT nombre, stock, precio FROM productos
WHERE stock BETWEEN 10 AND 40
ORDER BY stock ASC;

-- Nombres que contienen 'a' ordenados alfabéticamente
SELECT nombre, precio FROM productos
WHERE nombre LIKE '%a%'
ORDER BY nombre ASC;
```

## Experimentar variaciones:

1. Cambiar condiciones WHERE:

2. Probar diferentes columnas en ORDER BY

3. Cominar múltiples condiciones con AND/OR

