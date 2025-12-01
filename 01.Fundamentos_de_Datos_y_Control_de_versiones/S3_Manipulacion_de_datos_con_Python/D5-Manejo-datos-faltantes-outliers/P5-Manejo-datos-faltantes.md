# Pipeline completo de manejo de datos faltantes y outliers

> [!IMPORTANT]
> Se deben instalar las librerías ``scipy`` y ``missingno``. 

## Crear dataset con problemas realistas:

```
import pandas as pd
import numpy as np
from scipy import stats

# Crear dataset con missing values y outliers
np.random.seed(42)
n = 1000

datos = pd.DataFrame({
    'id': range(1, n+1),
    'edad': np.random.normal(35, 10, n).clip(18, 80),  # Normal con límites
    'salario': np.random.lognormal(10, 0.5, n),  # Distribución log-normal
    'horas_trabajo': np.random.normal(40, 5, n).clip(20, 60),
    'satisfaccion': np.random.randint(1, 6, n),
    'departamento': np.random.choice(['IT', 'Ventas', 'Marketing', 'HR'], n)
})

# Introducir missing values
mask_missing = np.random.random(n) < 0.1  # 10% missing
datos.loc[mask_missing, 'salario'] = np.nan

mask_missing_horas = np.random.random(n) < 0.05  # 5% missing
datos.loc[mask_missing_horas, 'horas_trabajo'] = np.nan

# Introducir outliers
outlier_indices = np.random.choice(n, 20, replace=False)
datos.loc[outlier_indices[:10], 'salario'] = datos.loc[outlier_indices[:10], 'salario'] * 10  # Salarios extremos altos
datos.loc[outlier_indices[10:], 'horas_trabajo'] = np.random.choice([80, 90, 100], 10)  # Horas imposibles

print(f"Dataset creado: {datos.shape}")
print(f"Valores faltantes por columna:\n{datos.isnull().sum()}")
```

- ``np.random.seed(42)``: es una función de la biblioteca NumPy que inicializa el generador de números aleatorios para que siempre produzca la misma secuencia de números aleatorios. Se hace estableciendo un valor de semilla (en este caso 42) para que los resultados sean reproducibles cada vez que se ejecuta el código.
- ``n =1000``: indica que el dataset tendrá 1000 filas.

Primero se crea un DataFrame con lo siguiente:

- ``id``: de 1 a 1000.
- ``edad``: distribución normal centrada en 35, desviación 10, con límites entre 18 y 80 (``np.random.normal(35, 10, n).clip(18, 80)``). Esto obliga que los valores queden dentro de ese rango. En este caso, tiene sentido limitar el rango dado que la columna representa la edad, por lo tanto, es poco probable que haya empleados menores de 18 o mayores de 80. La idea es tener un dataset realista para practicar.
- ``salario``: distribución log-normal, típica para salarios (cola larga hacia valores altos)
- ``horas_trabajo``: distribución normal, alrededor de 40 horas, con rango limitado entre 20 y 60 (``np.random.normal(40, 5, n).clip(20, 60)``).
- ``satisfaccion``: valores enteros entre 1 y 5.
-  ``departamento``: elige un departamento al azar (``np.random.choice(['IT', 'Ventas', 'Marketing', 'HR'], n)``). El np.random.choice permite seleccionar uno o varios elementos de una lista, arreglo o rango de manera aleatoria. 

Luego se introducen valores faltantes al dataset.

- ``mask_missing``: representa qué filas deben tener datos faltantes (en base a la condición ``np.random.random(n) < 0.1``). Esto genera un arreglo con números aleatorios entre 0 y 1.     
    - Si es <= 0.1 → True → habrá un NaN.
    - Si es > 0.1 False → se deja el valor original. 

- ``datos.loc[mask_missing, 'salario'] = np.nan``: ``.loc`` permite seleccionar filas y columnas usando etiquetas o condiciones. En este caso, significa que en el DataFrame, en las filas donde mask_missing sea True, reemplaza el valor de la columna ``'salario'`` por NaN.

Esto genera un 10% de datos faltantes en ``'salario''``.

Para el caso de la horas de trabajo, se hace algo similar, excepto que ahora aproximadamente el 5% de los datos de ``'horas_trabajo`` quedan como NaN (``np.random.random(n) < 0.05``).


![valores-faltantes](IMG-P5/valores-faltantes.PNG)

Se puede observar que el DataFrame entregado contiene 1000 filas y 6 columnas. Al hacer el recuento de valores faltantes por columna (``datos.isnull().sum()``), se ve que en la columna ``'salario'`` hay 95 valores faltantes y en la columna ``horas_trabajo`` hay 46 valores faltantes.


## Analizar datos faltantes:

```
# Análisis detallado de missing values
print("Porcentaje de datos faltantes:")
print((datos.isnull().sum() / len(datos) * 100).round(2))

# Patrón de missing values
import missingno as msno
# msno.matrix(datos)  # Visualización (requiere instalar missingno)

# Análisis por departamento
print("\nMissing values por departamento:")
print(datos.groupby('departamento').apply(lambda x: x.isnull().sum()))

#Imputación de valores faltantes:

# Imputación por media para horas_trabajo
media_horas = datos['horas_trabajo'].mean()
datos['horas_trabajo'] = datos['horas_trabajo'].fillna(media_horas)

# Imputación por mediana para salario (más robusto a outliers)
mediana_salario = datos['salario'].median()
datos['salario'] = datos['salario'].fillna(mediana_salario)

# Verificar que no queden missing values
print(f"\nValores faltantes después de imputación: {datos.isnull().sum().sum()}")
```



## Detección de outliers:

```
# Función para detectar outliers usando IQR
def detectar_outliers_iqr(data, columna):
    Q1 = data[columna].quantile(0.25)
    Q3 = data[columna].quantile(0.75)
    IQR = Q3 - Q1
    limite_inferior = Q1 - 1.5 * IQR
    limite_superior = Q3 + 1.5 * IQR
    return (data[columna] < limite_inferior) | (data[columna] > limite_superior)

# Detectar outliers en salario y horas
outliers_salario = detectar_outliers_iqr(datos, 'salario')
outliers_horas = detectar_outliers_iqr(datos, 'horas_trabajo')

print(f"\nOutliers detectados:")
print(f"Salario: {outliers_salario.sum()} ({outliers_salario.mean()*100:.1f}%)")
print(f"Horas trabajo: {outliers_horas.sum()} ({outliers_horas.mean()*100:.1f}%)")
```

## Manejo de outliers:

```
# Para horas_trabajo: cap at reasonable maximum
max_horas_normales = 60
datos.loc[datos['horas_trabajo'] > max_horas_normales, 'horas_trabajo'] = max_horas_normales

# Para salario: transformar usando log (más robusto)
datos['salario_log'] = np.log1p(datos['salario'])

# Comparar estadísticas antes y después
print(f"\nEstadísticas de salario original:")
print(datos['salario'].describe().round(2))

print(f"\nEstadísticas de salario transformado (log):")
print(datos['salario_log'].describe().round(2))

# Verificar reducción de outliers
outliers_salario_log = detectar_outliers_iqr(datos, 'salario_log')
print(f"\nOutliers en salario log-transformado: {outliers_salario_log.sum()}")
```

Verificación: Compara las estadísticas y distribuciones antes y después del procesamiento para confirmar que los datos están más limpios y apropiados para análisis.

Requerimientos:
Python con Pandas y NumPy
Opcional: scipy para estadísticas avanzadas
Dataset con missing values y outliers para practicar
Conocimiento de operaciones básicas de Pandas