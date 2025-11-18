# Consultas con joins en esquema de ventas

Crear esquema relacional completo:

```
-- Tabla de clientes
CREATE TABLE clientes (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT UNIQUE,
    ciudad TEXT
);

-- Tabla de pedidos
CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    fecha_pedido DATE NOT NULL,
    total REAL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Insertar datos de ejemplo
INSERT INTO clientes VALUES
(1, 'Ana García', 'ana@email.com', 'Madrid'),
(2, 'Carlos López', 'carlos@email.com', 'Barcelona'),
(3, 'María Rodríguez', 'maria@email.com', 'Madrid');

INSERT INTO pedidos VALUES
(1, 1, '2024-01-15', 150.50),
(2, 1, '2024-01-20', 89.99),
(3, 2, '2024-01-18', 299.99);
Consultas con diferentes tipos de joins:

-- INNER JOIN: Solo clientes con pedidos
SELECT c.nombre, p.fecha_pedido, p.total
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;

-- LEFT JOIN: Todos los clientes, con pedidos si existen
SELECT c.nombre, COUNT(p.id) as num_pedidos, SUM(p.total) as total_compras
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre;

-- Clientes de Madrid con sus pedidos
SELECT c.nombre, c.ciudad, p.fecha_pedido, p.total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE c.ciudad = 'Madrid';
```

# Analizar resultados

1. Compara cuántas filas devuelve cada tipo de join
2. Observa cómo NULL aparece en LEFT JOIN
3. Verifica integridad referencial