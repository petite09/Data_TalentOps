# Construir pipeline ETL completo con manejo robusto de errores y logging

Ejercicio práctico para aplicar los conceptos aprendidos.

1. **Configurar logging estructurado**:
    
```python
import logging
import pandas as pd
import sqlite3
import time
from pathlib import Path

# Configurar logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('etl_pipeline.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger('etl_pipeline')

```

``logging`` es un módulo de la librería estándar de Python. Sirve para registrar eventos, errores y actividades de una aplicación de forma estructurada, ayudando a depurar, monitorear y auditar el código.
- Info general: ``INFO``
- Advertencias: ``WARNING``
- Errores: ``ERROR``
- Mensajes de depuración: ``DEBUG``
- Permite guardar los mensajes en un archivo y/o verlos en consola.
- ``logging.basicConfig(...)``: configura cómo se va a comportar el sistema de logging.
- ``level=logging.INFO,``: Esto indica que a partir del nivel INFO hacia arriba se registran mensajes (los DEBUG no se mostrarán).

>[!NOTE]
> Recordar los niveles de severidad: DEBUG < INFO < WARNING < ERROR < CRITICAL.

``time`` es un módulo para funciones de timpo.

``pathlib.Path`` es una clase para trabajar con rutas de archivos más cómoda que con strings.

``handlers=[...]`` define dónde se enviarán los logs:
    - ``logging.FileHandler('etl_pipeline.log')``: guarda todos los logs en el archivo etl_pipeline.log.
    - ``logging.StreamHandler()``: los muestra en la consola.

``logger = logging.getLogger('etl_pipeline')`` Crea (o recupera) un logger con nombre 'etl_pipeline'.

>[!NOTE]
> Logger es un objeto que se usa para registrar mensajes dentro de lo que está pasando en este programa, viene del módulo ``logging``. En este caso, permite escribir mensajes con distintos niveles de severidad.

2. **Crear clase de pipeline robusto**:

```python
class RobustETLPipeline:
    def __init__(self, db_path='etl_database.db'):
        self.db_path = db_path
        self.logger = logging.getLogger('etl_pipeline')
        self.metrics = {'processed': 0, 'errors': 0, 'start_time': None}

    def run_pipeline(self):
        self.metrics['start_time'] = pd.Timestamp.now()
        self.logger.info("=== INICIANDO PIPELINE ETL ROBUSTO ===")

        try:
# Fase 1: Extracción con reintentos
            data = self.extract_with_retry()

# Fase 2: Transformación con validaciones
            transformed_data = self.transform_with_validation(data)

# Fase 3: Carga con transacciones
            self.load_with_transaction(transformed_data)

            self.report_success()

        except Exception as e:
            self.report_failure(e)
            raise

    def extract_with_retry(self):
        """Extracción con estrategia de reintentos"""
        max_retries = 3

        for attempt in range(max_retries):
            try:
                self.logger.info(f"Intento de extracción #{attempt + 1}")

# Simular extracción (reemplazar con lógica real)
                data = pd.DataFrame({
                    'id': range(1, 101),
                    'valor': [x * 1.1 for x in range(1, 101)],
                    'categoria': ['A', 'B', 'C'] * 33 + ['A']
                })

                self.logger.info(f"Extracción exitosa: {len(data)} registros")
                return data

            except Exception as e:
                self.logger.warning(f"Intento #{attempt + 1} falló: {e}")
                if attempt == max_retries - 1:
                    raise e
                time.sleep(1)# Esperar antes de reintentar

```

>[!IMPORTANT]
> Una clase es un molde para crear objetos que agrupa:
> 
> - datos (atributos)
> 
> - comportamiento (métodos).

Acá la clase representa un pipeline ETL completo con logs y manejo de errores.

``__init__`` es un método que se ejecuta automáticamente cuando sea crea el objeto.

``db_path='etl_database.db'`` es un parámetro con valor por defecto:
- si no se le pasa nada, utiliza ``'etl_database.db'``.
- si se le da el parámetro, usará el indicado.

``self`` es "este mismo objeto". Es una forma de guardar cosas dentro del objeto. Es una referencia a la instancia actual de una clase. Actúa como primer parámetro obligatorio en los métodos de instancia para acceder a los atributos y otros métodos de ese objeto específico.

- ``self.db_path``: ruta al archivo SQLite.

- ``self.logger``: el logger del pipeline (con nombre 'etl_pipeline').

- ``self.metrics``: diccionario para métricas del pipeline.

``run_pipeline`` es una espectie de "orquestador" del ETL.

``pd.Timestamp.now()``: guarda el momento exacto en que comenzó el pipeline y sirve para calcular la duración.

``self.logger.info(...)``: registra un mensaje de inicio del pipeline.

El bloque ``try/except`` busca manejar errores.

``try`` intenta ejecutar el pipeline completo en 3 fases:

- Extracción con reintentos ``data = self.extract_with_retry()``
- Transformación con validaciones ``transformed_data = self.transform_with_validation(data)``
- Carga con transacciones ``self.load_with_transaction(transformed_data)``

Y si todo sale bien: ``self.report_success()``

``except Exception as e``: si ocurre cualquier error, en cualquiera de las 3 fases, se entra en esta parte del código.

``e`` es el error concreto con su mensaje.

``self.report_failure(e)`` registra en el log que el pipeline falló y se registra con qué error. Esto no detiene el programa. Es informativo, no de control de flujo.

Luego, ``raise`` vuelve a lanzar el error. Detiene la ejecución del progama y propaga el error hacia arriba. Se usa para control de flujo.

La función ``extract_with_retr`` se usa para hacer extracción con reintentos.

``max_retries = 3`` define que la extracción se intentará hasta 3 veces si falla.

Luego se describe el loop de intentos en ``for attempt in range(max_retries):``, donde en ``self.logger.info(f"Intento de extracción #{attempt + 1}")`` se usa ``attempt + 1`` porque attempt empieza en 0.

Posteriormente se simula la extracción y para eso se crea un DataFrame con ``id`` de 1 al 100, la columna ``valor`` que crea una lista de valores de acuerdo a la fórmula descrita dentro de los corchetes y  finalmente la columna ``categoria`` con categorías 'A', 'B' o 'C'.

``self.logger.info(f"Extracción exitosa: {len(data)} registros")`` es el log que indica el éxito en la extracción y ``len(data)`` devuelve la cantidad de filas del DataFrame (100). 

``return data`` termina el método y entrega el DataFrame a ``run_pipeline``.

Si esto falla, nuevamente hay un ``except`` y un reintento.

``logger.warning(...)`` registra  un mensaje de advertencia donde se indica el número de intento y en qué falló.

``if attempt == max_retries - 1``: importante recordar que esto representa el índice del último intento. Si ya es el último intento y falla, ya no se reintenta, se lanza el error.

``time.sleep(1)``del módulo time: pausa el programa 1 segundo antes de volver a intentar.

3. **Implementar transformación con validaciones**:
    
```python
    def transform_with_validation(self, data):
        """Transformación con validaciones y logging detallado"""
        self.logger.info("Iniciando transformación")
        original_count = len(data)

        try:
# Validación 1: Datos no nulos
            if data.isnull().any().any():
                null_counts = data.isnull().sum()
                self.logger.warning(f"Valores nulos encontrados: {null_counts[null_counts > 0].to_dict()}")

# Transformación 1: Limpiar datos
            data_clean = data.dropna()

# Transformación 2: Crear nuevas columnas
            data_clean = data_clean.copy()# Evitar SettingWithCopyWarning
            data_clean['valor_cuadrado'] = data_clean['valor'] ** 2
            data_clean['categoria_normalizada'] = data_clean['categoria'].str.upper()

# Validación 2: Resultados razonables
            if (data_clean['valor_cuadrado'] < 0).any():
                raise ValueError("Valores cuadrados negativos detectados")

            self.logger.info(f"Transformación exitosa: {original_count} -> {len(data_clean)} registros")
            return data_clean

        except Exception as e:
            self.logger.error(f"Error en transformación: {e}")
            raise

```
    
4. **Implementar carga con transacciones**:
    
```python
    def load_with_transaction(self, data):
        """Carga con soporte transaccional y rollback"""
        self.logger.info("Iniciando carga a base de datos")

        with sqlite3.connect(self.db_path) as conn:
            try:
# Iniciar transacción
                conn.execute('BEGIN TRANSACTION')

# Crear tabla si no existe
                conn.execute('''
                    CREATE TABLE IF NOT EXISTS datos_transformados (
                        id INTEGER PRIMARY KEY,
                        valor REAL,
                        categoria TEXT,
                        valor_cuadrado REAL,
                        categoria_normalizada TEXT
                    )
                ''')

# Limpiar datos previos (estrategia replace)
                conn.execute('DELETE FROM datos_transformados')

# Insertar datos
                data.to_sql('datos_transformados', conn, index=False, if_exists='append')

# Commit transacción
                conn.commit()

                self.logger.info(f"Carga exitosa: {len(data)} registros insertados")

            except Exception as e:
# Rollback automático por context manager
                self.logger.error(f"Error en carga, ejecutando rollback: {e}")
                raise

```
    
5. **Implementar reporting y ejecutar pipeline**:
    
```python
    def report_success(self):
        """Reportar métricas de éxito"""
        duration = pd.Timestamp.now() - self.metrics['start_time']
        self.logger.info("=== PIPELINE ETL COMPLETADO EXITOSAMENTE ===")
        self.logger.info(f"Duración total: {duration}")
        self.logger.info(f"Registros procesados: {self.metrics.get('processed', 0)}")

    def report_failure(self, error):
        """Reportar detalles de fallo"""
        duration = pd.Timestamp.now() - self.metrics['start_time']
        self.logger.error("=== PIPELINE ETL FALLÓ ===")
        self.logger.error(f"Duración hasta fallo: {duration}")
        self.logger.error(f"Error: {error}")

# Ejecutar pipeline
if __name__ == "__main__":
    pipeline = RobustETLPipeline()
    pipeline.run_pipeline()

# Verificar resultados
    with sqlite3.connect('etl_database.db') as conn:
        result = pd.read_sql('SELECT COUNT(*) as registros FROM datos_transformados', conn)
        print(f"Registros en base de datos: {result.iloc[0,0]}")

```

![registros-bbdd](IMG-P5/registros-bbdd.PNG)


**Verificación**: Ejecuta el pipeline completo y verifica que el logging capture todas las fases correctamente, incluyendo cómo se manejan errores y se reportan métricas.

**Requerimientos:**

- Python con Pandas, sqlite3, y logging (incluidos en instalación estándar)
- Espacio para archivos de log
- Conocimiento de clases y manejo de excepciones en Python