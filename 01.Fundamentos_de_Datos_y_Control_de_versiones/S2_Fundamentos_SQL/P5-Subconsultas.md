# Consultas avanzadas con subconsultas en base de datos completa

## Crear datos adicionales para análisis complejo:

```
-- Tabla de categorías
CREATE TABLE categorias (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    descripcion TEXT
);

-- Agregar categoría a productos
ALTER TABLE productos ADD COLUMN categoria_id INTEGER REFERENCES categorias(id);

INSERT INTO categorias VALUES
(1, 'Electrónica', 'Productos electrónicos y tecnología'),
(2, 'Accesorios', 'Accesorios para computadoras'),
(3, 'Audio', 'Productos de audio y sonido');

UPDATE productos SET categoria_id = 1 WHERE nombre LIKE '%Laptop%' OR nombre LIKE '%Monitor%';
UPDATE productos SET categoria_id = 2 WHERE nombre LIKE '%Mouse%' OR nombre LIKE '%Teclado%';
UPDATE productos SET categoria_id = 3 WHERE nombre LIKE '%Audífonos%';
```

## Subconsultas en WHERE:

```
-- Clientes que han comprado productos de Electrónica
SELECT DISTINCT c.nombre, c.email
FROM clientes c
WHERE c.id IN (
    SELECT DISTINCT p.cliente_id
    FROM pedidos p
    JOIN detalle_pedidos dp ON p.id = dp.pedido_id
    JOIN productos prod ON dp.producto_id = prod.id
    JOIN categorias cat ON prod.categoria_id = cat.id
    WHERE cat.nombre = 'Electrónica'
);

-- Productos con precio por encima del promedio de su categoría
SELECT p.nombre, p.precio, cat.nombre as categoria
FROM productos p
JOIN categorias cat ON p.categoria_id = cat.id
WHERE p.precio > (
    SELECT AVG(p2.precio)
    FROM productos p2
    WHERE p2.categoria_id = p.categoria_id
);
```

## Subconsultas correlacionadas:

```
-- Para cada cliente, mostrar su pedido más reciente
SELECT c.nombre, p.fecha_pedido, p.total
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha_pedido = (
    SELECT MAX(p2.fecha_pedido)
    FROM pedidos p2
    WHERE p2.cliente_id = c.id
);
```

## Uso de EXISTS:

```
-- Clientes que tienen pedidos con productos caros (>200)
SELECT c.nombre, c.ciudad
FROM clientes c
WHERE EXISTS (
    SELECT 1
    FROM pedidos p
    JOIN detalle_pedidos dp ON p.id = dp.pedido_id
    WHERE p.cliente_id = c.id
    AND dp.precio_unitario > 200
);
```