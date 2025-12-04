# Diseño conceptual de pipeline ETL para un escenario empresarial

## Escenario: 

Una cadena de tiendas minoristas quiere integrar datos de:

- Sistema de punto de venta (ventas por tienda, producto, hora)
- Sistema de inventario (stock por producto y ubicación)
- CRM (información de clientes y segmentación)
- Sitio web (comportamiento online de clientes)

## Tareas de diseño:

### Identificar fuentes de datos:

- Base de datos SQL del POS.
- API REST del sistema de inventario.
- Archivos CSV exportados del CRM.
- Logs del servidor web (JSON).

### Diseñar esquema destino:

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

### Planificar transformaciones:

- Convertir timestamps a fechas consistentes
- Calcular totales de venta (cantidad × precio)
- Enriquecer con información de cliente (segmento)
- Normalizar códigos de producto entre sistemas
- Detectar y manejar ventas duplicadas

### Definir frecuencia y estrategia:

- Ventas del POS: carga incremental cada hora
- Inventario: actualización completa diaria
- CRM: actualización semanal
- Web analytics: carga batch diaria


### ✅ Este ETL resuelve los siguientes problemas:

1. Cada fuente de datos usa formatos distinto:
    - En la fase de Extract (E) se define una capa de ingesta que permite capturar cada fuente respetando su formato nativo.
    - En la fase Transform (T), todos los dataset se convierten a un esquema tabular estandarizado, estructurado y comparable.

2. Inconsistencia de fechas y zonas horarias:
    -  Se estandarizan todos los timestamps para asegurar que las ventas, movimientos y eventos digitales sean comparables en el tiempo.

3. Códigos de producto diferentes entre sistemas:
    - POS, inventario y página web podrían tener códigos diferentes para productos. Por lo que este pipeline crea una tabla unificada con un identificador único para producto.
    - De esta forma, cada evento (ventas, stock, comportamiento online), se atribuyen correctamente al mismo producto.

4. Datos de clientes fragmentados entre CRM y POS/Web:
    - POS  puede registrar ventas de clientes, CRM contiene la segmentación e información del cliente y el sitio web el comportamiento del cliente.
    - Este pipeline enriquece las ventas con información del CRM. (uniones entre ventas y clientes, adición de segmento y u identificador único para cliente). Esto permite interpretar las ventas como interacciones dentro del ciclo de vida del cliente.

5. Registros duplicados de ventas:
    - El pipeline incluye el manejo de registros duplicados. De esta manera los datos de ventas son más confiables y no se inflan métricas del negocio.

6. Falta de integración entre ventas físcas y online:
    - Ventas de la tienda física y del e-commerce están en sistemas distintos.
    - El pipelina agrega en la tabbla destino: ``canal_venta = 'tienda' | 'online'``, lo que permite analizar las ventas como un único flujo.

7. Diferentes ritmos de actualización:
    - Cada fuente tiene su propio ciclo de actualización. Si no hay una estrategia definida, los datos podrían quedar desfasados.
    - Este diseño ETL define estratgias claras y estables de frecuencia de actualización, lo que permite mantener la integridad temporal y coherencia entre sí y que siempre estén sincronizados.

8. Falta de un lugar único para análisis:
    - Existen 4 sistemas distintos para consultar, sin embargo, la carga final de este pipeline produce una tabla de hechos consolidadas ``ventas_consolidadas``, con datos completos, limpios, consistentes y enriquecidos.


---

Verificación: Documenta cómo tu diseño ETL resuelve los problemas de datos fragmentados identificados al inicio.

Requerimientos:
- Conocimiento básico de SQL y Python (de semanas anteriores)
- Entorno Python con Pandas instalado
- Acceso a SQLite para ejemplos prácticos
- No se requieren instalaciones adicionales para este día conceptual