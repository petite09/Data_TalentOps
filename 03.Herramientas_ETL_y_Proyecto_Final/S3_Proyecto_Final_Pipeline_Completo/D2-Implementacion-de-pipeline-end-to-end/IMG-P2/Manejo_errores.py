#Script práctico de ejemplo de manejo de errores

import time
import logging
from typing import Callable, Dict

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s"
)
logger = logging.getLogger("pipeline")

class ValidationError(Exception):
    """Error de datos (no transitorio)."""

def ejecutar_con_reintento(func: Callable[[], None], max_reintentos: int = 3, espera_seg: float = 1.0):
    for intento in range(1, max_reintentos + 1):
        try:
            return func()
        except TimeoutError as e:
            # ejemplo de error transitorio
            logger.warning(f"Timeout (intento {intento}/{max_reintentos}): {e}")
            if intento == max_reintentos:
                raise
            time.sleep(espera_seg * intento)  # backoff simple
        except Exception:
            # si NO es transitorio, no reintentes a ciegas
            raise

def ejecutar_pipeline_con_errores(pipeline: Dict[str, str]):
    for paso, descripcion in pipeline.items():
        logger.info(f"Ejecutando {paso}: {descripcion}")

        try:
            if paso == "paso_1":
                # Simula un caso transitorio (descomenta para probar)
                # raise TimeoutError("API no responde")
                pass

            elif paso == "paso_2":
                # Simula un error de datos (persistente)
                raise ValidationError("Error de validación: campo 'email' vacío")

            elif paso == "paso_3":
                # Simula guardado OK
                pass

            logger.info(f"{paso} ✅ OK")

        except ValidationError as e:
            logger.error(f"{paso} ❌ FALLÓ (abort por datos inválidos): {e}")
            # Recovery típico: registrar, notificar, mandar a cuarentena, etc.
            raise  # aborta la ejecución completa

        except TimeoutError as e:
            logger.warning(f"{paso} falló por timeout. Se reintentará: {e}")

            def tarea():
                # aquí re-ejecutarías la lógica real
                return None

            ejecutar_con_reintento(tarea, max_reintentos=3, espera_seg=1.0)
            logger.info(f"{paso} OK tras reintento")

        except Exception as e:
            logger.exception(f"{paso} FALLÓ (error inesperado): {e}")
            raise

if __name__ == "__main__":
    pipeline_simple = {
        "paso_1": "Capturar datos de API",
        "paso_2": "Validar y limpiar datos",
        "paso_3": "Guardar en base de datos",
    }

    ejecutar_pipeline_con_errores(pipeline_simple)
