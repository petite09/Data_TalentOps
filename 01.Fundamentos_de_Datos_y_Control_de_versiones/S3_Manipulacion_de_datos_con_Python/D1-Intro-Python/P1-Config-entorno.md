# Configurar entorno completo de análisis de datos

> [!NOTE]  
>En la carpeta de Descargas se creó una carpeta de proyecto llamada ``practica_python`` y en esta carpeta se creó el entorno virtual.

## Instalar Python y crear entorno virtual:

```
# Verificar instalación existente
python --version
```

![version-python](IMG-P1/01-python-version.PNG)

```
# Crear entorno virtual
python -m venv analisis_datos_env

# Activar entorno
source analisis_datos_env/bin/activate  # En Windows: analisis_datos_env\Scripts\activate`
```

![crear-env](IMG-P1/02-crear-env.PNG)

## Instalar bibliotecas esenciales:

```
# Instalar NumPy primero (base de todo)
pip install numpy
```

![instalar-numpy](IMG-P1/03-install-numpy.PNG)

```
# Instalar Pandas
pip install pandas
```

![instalar-pandas](IMG-P1/04-install-pandas.PNG)

```
# Instalar Matplotlib para visualización
pip install matplotlib
```

![instalar-matplotlib](IMG-P1/05-install-matplotlib.PNG)

```
# Instalar Jupyter para notebooks
pip install jupyter
```

![instalar-jupyter1](IMG-P1/06-install-jupyter1.PNG)

![intsalar-jupyter2](IMG-P1/07-install-jupyter2.PNG)


## Verificar instalación:

```
# Verificar versiones
python -c "import numpy as np; import pandas as pd; import matplotlib.pyplot as plt; print('NumPy:', np.__version__); print('Pandas:', pd.__version__); print('Matplotlib:', plt.__version__)"
```

![verificar-versiones](IMG-P1/08-verificar-versiones.PNG)

```
# Probar Jupyter
jupyter --version
```

![jupyter-version](IMG-P1/09-jupyter-version.PNG)

Con esto se confirma que todas las bibliotecas se instalaron correctamente ✅.

## Primer script de prueba:

Este primer script se creó en vs code y se guardó en la carpeta ``practica_python`` para poder ejecutarlo.

```
# Crear archivo test_analisis.py
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Crear datos de ejemplo
datos = {'x': np.random.randn(100), 'y': np.random.randn(100)}
df = pd.DataFrame(datos)

# Análisis básico
print("Estadísticas básicas:")
print(df.describe())

# Gráfico simple
plt.scatter(df['x'], df['y'])
plt.title('Primer gráfico con Python')
plt.savefig('primer_grafico.png')
print("Gráfico guardado como primer_grafico.png")
```

## Ejecutar y verificar:

```
python test_analisis.py
```

![primer-script](IMG-P1/10-primer-script.PNG)

El script se ejecutó sin errores y se generó el siguiente gráfico que se guardó como imagen en la carpeta ``practica_python``.

![alt text](IMG-P1/11-primer-grafico.png)


Verificación: Confirma que todas las bibliotecas se instalaron correctamente, el script se ejecutó sin errores, y se generó el archivo de imagen.

Requerimientos:
Sistema operativo: Windows, macOS, o Linux
Conexión a internet para descargar paquetes
Permisos para instalar software (especialmente en macOS/Linux)
Espacio en disco: ~1GB para bibliotecas y entornos virtuales