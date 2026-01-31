# Ejercicio: Crear documentación para un componente simple

## Componente a documentar:

```python
def validar_datos_ventas(datos):
    """Valida que los datos de ventas cumplan criterios básicos"""
    errores = []
    
    for i, fila in enumerate(datos):
        if fila.get('precio', 0) <= 0:
            errores.append(f"Fila {i}: precio inválido")
        if not fila.get('fecha'):
            errores.append(f"Fila {i}: fecha faltante")
    
    return {
        'valido': len(errores) == 0,
        'errores': errores,
        'total_filas': len(datos)
    }
```

## Crear documentación completa:

```python
# Validador de Datos de Ventas

## Propósito
Valida la calidad de datos de ventas antes del procesamiento.

## Parámetros
- `datos`: Lista de diccionarios con datos de ventas

## Retorna
- `valido`: Boolean indicando si todos los datos son válidos
- `errores`: Lista de errores encontrados
- `total_filas`: Número total de filas procesadas

## Reglas de Validación
- Precio debe ser mayor a 0
- Fecha no puede estar vacía
- Campos requeridos: precio, fecha

## Ejemplo de Uso
datos_ventas = [
    {'precio': 100, 'fecha': '2024-01-01'},
    {'precio': -50, 'fecha': '2024-01-02'}
]
resultado = validar_datos_ventas(datos_ventas)
# resultado = {'valido': False, 'errores': ['Fila 1: precio inválido'], 'total_filas': 2}
```


## Crear resumen ejecutivo:

```python
resumen_ejecutivo = {
    'proyecto': 'Pipeline de Analytics de Ventas',
    'objetivo': 'Automatizar reportes de ventas semanales',
    'solucion_implementada': 'ETL pipeline con validaciones de calidad',
    'beneficios': [
        'Reducción de tiempo de reporte: 3 días → 2 horas',
        'Mejora en calidad de datos: 95% de precisión',
        'Ahorro anual estimado: €50,000'
    ],
    'metricas_clave': {
        'tiempo_procesamiento': '2 horas',
        'precision_datos': '95%',
        'disponibilidad': '99.5%'
    }
}
```

--- 
Verificación: ¿Cómo adaptarías una presentación técnica para diferentes audiencias? ¿Qué elementos son más importantes en la documentación: código comentado, README, o diagramas?

Requerimientos:
Conocimiento básico de documentación
Familiaridad con presentaciones
Comprensión de comunicación técnica
