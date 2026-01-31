# Ejercicio: Diseñar arquitectura básica para un sistema de analytics

## Identificar componentes principales:

```python
# Arquitectura simplificada para retail analytics
arquitectura_retail = {
    'fuentes': [
        'API de ventas', #Como transacciones, devoluciones 
        'Base de datos de inventario' # stock, quiebres, reposición
        ],
    'ingesta': [
        'Extracción batch', # definir periodicidad
        'Validación de esquema', #tipos de datos, nulos
    ]
    'procesamiento': [
        'Limpieza de datos', # eliminar duplicados, manejo de datos faltantes
        'Transformación', # enriquecimiento de datos, normalización de formatos
        'Cálculo de métricas' #métricas que responden a preguntas de negocio, como ingresos totales, ticket promedio, margen, etc.
        ],
    'almacenamiento': [
        'PostgreSQL para datos limpios',
        'Tablas por dominio' #para ventas,inventario, productos, tiendas
        'Cloud u on premise' #definir tipo de almacenamiento de datos
        ],
    'consumo': [
        'Dashboard de ventas', #KPIs, tendencias, ranking
        'Reportes diarios'] # resúmenes por tienda o categoría
    'operaciones': [
        'Monitoreo y alertas' # fallos, retrasos, calidad de datos
        'Backup y control de accesos'
    ]
    
}
```

## Documentar decisiones clave:

```python
decisiones = {
    'base_datos': 'PostgreSQL - madurez y facilidad de uso',
    'orquestacion': 'Airflow - estándar de industria para pipelines, permite scheduling, dependencia, reintentos y observabilidad',
    'visualizacion': 'Tableau - intuitivo para negocio, rápida para construir dashboards y compartir insights'
    'modo_ingesta': 'Batch (inicial): reduce complejidad operativa; se puede evolucionar a near-real-time si el negocio lo requiere'.
    'modelo_datos': 'Modelo curado (tablas limpias) para asegurar consistencia en KPIs y trazabilidad.'
}
```

## Reflexiones finales

¿Qué factores considerarías al elegir entre una arquitectura simple vs compleja? 

Es necesario considerar diferentes criterios:

- Volumen y velocidad: cuántos datos y en cuánto tiempo se estarán procesando en tiempo real?
- Criticidad del negocio: si las decisiones dependen "en vivo", aumenta la complejidad al requerir streaming y baja latencia.
- SLA y disponibilidad: si se requiere una disponibilidad del 99.9% y tiempos de respuesta estrictos, es probable que se requieran más componentes y  por lo tanto que el sistema sea más complejo.
- Evolución esperada: si el sistema crecerá rápido, es recomendable considerar un diseño modular desde el inicio.
- Costo total: más componentes implica mayor mantenimiento, lo que se refleja en mayores costos.
- Seguridad y cumplimiento: dependiendo del rubro del negocio, los datos sensibles pueden exigir controles extra de protección, lo que podría complejizar el sistema.


¿Cómo comunicarías decisiones arquitectónicas a un equipo técnico vs stakeholders de negocio?

A un equipo técnico:

- Diagrama por capas y un flujo de datos.
- Decisiones con sus respectivas justificaciones.
- Requisitos técnicos y operativos: como frecuencia, volumen, reintentos, monitoreo, backups, permisos, roles.
- Riesgos y mitigaciones: idenfiticar posibles problemas del pipeline y explicar las consideraciones tomadas para reducir su impacto en la arquitectura. Por ejemplo para el caso de la mala calidad de los gatos, el impacto podría generar KPIs incorrectos y decisiones de negocio equivocadas. Para mitigar esto, se debe explicar las validaciones y reglas de calidad consideradas en el pipeline.


A stakeholders: es importante envocarse en el valor y los resultados.

- Definir problema, solución e impacto.
- Uso de dashboards o reportes y definir la periodicidad de estos con KPIs claves del negocio.
- Explicar qué es lo que asegura confianza: como por ejemplo que los datos sean validados, trazables y monitoreados.

---- 
Verificación: ¿Qué factores considerarías al elegir entre una arquitectura simple vs compleja? 

¿Cómo comunicarías decisiones arquitectónicas a un equipo técnico vs stakeholders de negocio?

Requerimientos:
Conocimiento básico de sistemas de datos
Comprensión de requisitos de negocio
Familiaridad con tecnologías cloud y on-premise