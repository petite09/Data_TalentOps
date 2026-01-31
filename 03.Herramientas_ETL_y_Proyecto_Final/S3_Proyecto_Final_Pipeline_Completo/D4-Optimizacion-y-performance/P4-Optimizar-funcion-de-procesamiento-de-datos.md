# Ejercicio: Optimizar una función de procesamiento de datos

## Función original (lenta):

```python
def procesar_datos_lento(datos):
    """Procesamiento ineficiente"""
    resultado = []
    for fila in datos:
        # Procesamiento secuencial
        fila_procesada = fila.copy()
        fila_procesada['total'] = fila['precio'] * fila['cantidad']
        resultado.append(fila_procesada)
    return resultado
```

## Función optimizada:

```python
def procesar_datos_rapido(datos):
    """Procesamiento optimizado con comprensión de listas"""
    return [
        {**fila, 'total': fila['precio'] * fila['cantidad']}
        for fila in datos
    ]
Comparar performance:

import time

datos_prueba = [{'precio': i, 'cantidad': i%10} for i in range(10000)]

# Medir versión lenta
inicio = time.time()
procesar_datos_lento(datos_prueba)
tiempo_lento = time.time() - inicio

# Medir versión rápida
inicio = time.time()
procesar_datos_rapido(datos_prueba)
tiempo_rapido = time.time() - inicio

print(f"Lento: {tiempo_lento:.3f}s, Rápido: {tiempo_rapido:.3f}s")
print(f"Mejora: {tiempo_lento/tiempo_rapido:.1f}x más rápido")
```

---
Verificación: ¿Cuándo deberías optimizar performance? ¿Qué trade-offs considerar entre velocidad y complejidad?

Requerimientos:
Conocimiento básico de Python
Familiaridad con conceptos de performance
Comprensión de algoritmos básicos