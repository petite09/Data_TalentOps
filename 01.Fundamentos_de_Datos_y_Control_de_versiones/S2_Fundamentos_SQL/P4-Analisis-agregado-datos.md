# Análisis agregado de datos de ventas

## Crear tabla de detalles de pedidos:

```
-- Tabla de detalles de pedidos
CREATE TABLE detalle_pedidos (
    id INTEGER PRIMARY KEY,
    pedido_id INTEGER,
    producto_id INTEGER,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Insertar datos de ejemplo
INSERT INTO detalle_pedidos VALUES
(1, 1, 1, 1, 1200.00),
(2, 1, 2, 2, 25.50),
(3, 2, 3, 1, 89.99),
(4, 3, 4, 1, 199.99),
(5, 3, 5, 1, 149.50);
```

## Consultas de agregación básica:

```
-- Ventas totales por producto
SELECT producto_id, SUM(cantidad) as total_vendido, SUM(cantidad * precio_unitario) as ingresos_totales
FROM detalle_pedidos
GROUP BY producto_id;

-- Estadísticas por pedido
SELECT pedido_id, COUNT(*) as items_diferentes, SUM(cantidad) as cantidad_total, AVG(precio_unitario) as precio_promedio
FROM detalle_pedidos
GROUP BY pedido_id;
```

## Consultas con HAVING:

```
-- Productos con más de 1 unidad vendida total
SELECT producto_id, SUM(cantidad) as total_vendido
FROM detalle_pedidos
GROUP BY producto_id
HAVING SUM(cantidad) > 1;

-- Pedidos con valor total > 150
SELECT pedido_id, SUM(cantidad * precio_unitario) as valor_total
FROM detalle_pedidos
GROUP BY pedido_id
GROUP BY pedido_id
HAVING SUM(cantidad * precio_unitario) > 150;
```

## Análisis combinado con joins:

```
-- Ventas por ciudad usando JOIN + GROUP BY
SELECT c.ciudad, COUNT(p.id) as num_pedidos, SUM(dp.cantidad * dp.precio_unitario) as ingresos_ciudad
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
LEFT JOIN detalle_pedidos dp ON p.id = dp.pedido_id
GROUP BY c.ciudad
HAVING SUM(dp.cantidad * dp.precio_unitario) > 0;
```

