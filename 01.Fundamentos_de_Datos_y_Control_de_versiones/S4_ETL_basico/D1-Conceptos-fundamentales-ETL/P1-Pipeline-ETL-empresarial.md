# Diseño conceptual de pipeline ETL para un escenario empresarial

Escenario: Una cadena de tiendas minoristas quiere integrar datos de:

Sistema de punto de venta (ventas por tienda, producto, hora)
Sistema de inventario (stock por producto y ubicación)
CRM (información de clientes y segmentación)
Sitio web (comportamiento online de clientes)
Tareas de diseño:

Identificar fuentes de datos:

Base de datos SQL del POS
API REST del sistema de inventario
Archivos CSV exportados del CRM
Logs del servidor web (JSON)
Diseñar esquema destino:

```
-- Tabla unificada de hechos de ventas
CREATE TABLE ventas_consolidadas (
    id_venta INTEGER PRIMARY KEY,
    fecha_venta DATE,
    id_tienda INTEGER,
    id_cliente INTEGER,
    id_producto INTEGER,
    cantidad INTEGER,
    precio_unitario DECIMAL(10,2),
    total_venta DECIMAL(10,2),
    canal_venta VARCHAR(20), -- 'online', 'tienda'
    segmento_cliente VARCHAR(20)
);
```

Planificar transformaciones:

Convertir timestamps a fechas consistentes
Calcular totales de venta (cantidad × precio)
Enriquecer con información de cliente (segmento)
Normalizar códigos de producto entre sistemas
Detectar y manejar ventas duplicadas
Definir frecuencia y estrategia:

Ventas del POS: carga incremental cada hora
Inventario: actualización completa diaria
CRM: actualización semanal
Web analytics: carga batch diaria
Verificación: Documenta cómo tu diseño ETL resuelve los problemas de datos fragmentados identificados al inicio.

Requerimientos:
Conocimiento básico de SQL y Python (de semanas anteriores)
Entorno Python con Pandas instalado
Acceso a SQLite para ejemplos prácticos
No se requieren instalaciones adicionales para este día conceptual