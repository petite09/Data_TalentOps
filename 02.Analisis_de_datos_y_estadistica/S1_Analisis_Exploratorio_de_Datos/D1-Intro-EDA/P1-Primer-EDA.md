# Ejercicio: Primer EDA en dataset de ventas de e-commerce

## Carga y configuración inicial:

```python
import pandas as pd
import numpy as np

# Crear dataset de ejemplo de e-commerce
np.random.seed(42)
n_orders = 1000

df = pd.DataFrame({
    'order_id': range(1, n_orders + 1),
    'customer_id': np.random.randint(1, 201, n_orders),
    'product_id': np.random.randint(1, 51, n_orders),
    'quantity': np.random.randint(1, 5, n_orders),
    'unit_price': np.round(np.random.uniform(10, 500, n_orders), 2),
    'order_date': pd.date_range('2023-01-01', periods=n_orders, freq='h')[:n_orders],
    'payment_method': np.random.choice(['Credit Card', 'Debit Card', 'PayPal', 'Cash'], n_orders),
    'customer_age': np.random.normal(35, 10, n_orders).clip(18, 80).astype(int),
    'shipping_region': np.random.choice(['North', 'South', 'East', 'West'], n_orders)
})

# Introducir algunos valores faltantes
mask = np.random.random(n_orders) < 0.05
df.loc[mask, 'customer_age'] = np.nan

print("Dataset cargado exitosamente")
```
![dataset-cargado](IMG-P1/dataset-cargado.PNG)



## Inspección inicial sistemática:

```python
# Dimensiones y estructura
print(f"Dataset shape: {df.shape}")
print(f"\nColumnas: {list(df.columns)}")
print(f"\nTipos de datos:\n{df.dtypes}")
```
![dimensiones-estructura](IMG-P1/dimensiones-estructura.PNG)

```python
# Primeras y últimas filas
print("\nPrimeras 5 filas:")
print(df.head())

print("\nÚltimas 5 filas:")
print(df.tail())
```

![head-tail](IMG-P1/head-tail.PNG)

## Análisis de calidad de datos:

```python
# Valores faltantes
print("Valores faltantes por columna:")
print(df.isnull().sum())

print(f"\nPorcentaje de completitud: {(1 - df.isnull().sum() / len(df)) * 100}")
```

![valores-faltantes](IMG-P1/valores-faltantes.PNG)

```python
# Valores únicos por columna
print("\nValores únicos por columna:")
for col in df.select_dtypes(include=['object']).columns:
    print(f"{col}: {df[col].nunique()} valores únicos")
```

![valores-unicos](IMG-P1/valores-unicos.PNG)

```python
# Estadísticos básicos para numéricas
print("\nEstadísticos básicos de variables numéricas:")
print(df.select_dtypes(include=[np.number]).describe())
```

![estadisticos-basicos](IMG-P1/estadisticos-basicos.PNG)

## Preguntas exploratorias iniciales:

```python
# Distribución por región
print("Distribución de pedidos por región:")
print(df['shipping_region'].value_counts())

# Método de pago más popular
print(f"\nMétodo de pago más usado: {df['payment_method'].value_counts().index[0]}")

# Rango de fechas
print(f"\nPeríodo de datos: {df['order_date'].min()} a {df['order_date'].max()}")

# Edad promedio de clientes
edad_promedio = df['customer_age'].mean()
print(f"\nEdad promedio de clientes: {edad_promedio:.1f} años")
```

![preguntas-exploratorias](IMG-P1/preguntas-exploratorias.PNG)



---

Verificación: Confirma que has identificado las dimensiones del dataset, tipos de datos, valores faltantes, y generado preguntas iniciales basadas en los datos observados.

Requerimientos:
Python con Pandas y NumPy instalados
Jupyter Notebook para exploración interactiva
Dataset de ejemplo o datos para analizar
matplotlib opcional para primeras visualizaciones