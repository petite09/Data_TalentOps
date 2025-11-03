# 📄 Instrucciones Generales
Elegir un repositorio público de GitHub de Análisis de Datos o Tutorial de Pandas, examinar la estructura y responder las preguntas planteadas.

# ✍ Desarrollo

El repositorio elegido para esta actividad fue el siguiente:

https://github.com/owid/covid-19-data

Este repositorio es de Our World in Data, una iniciativa que busca hacer que el conocimiento sea accesible y comprensible para empoderar a quienes trabajan por un mundo mejor a través de los datos.
En este contexto, este repositorio reúne, procesa y publica datos sobre la pandemia de COVID-19 proveniente de diversas fuentes oficiales. Su objetivo es mantener un flujo actualizado y transparente de información global sobre casos, vacunaciones y mortalidad, mediante una estructura que permite la actualización constante del dataset final disponible públicamente.

- ¿Cuántos commits tiene el historial?
El historial tiene 31.320 commits.

- ¿Cuántas ramas hay?
El repositorio tiene 16 ramas.

- ¿Cuándo fue el último commit?
El último commit fue el 23 de Agosto de 2024.

- ¿Quiénes son los contribuidores principales?
En la pestaña **Insights -> Contributors** se observa un gráfico de barras que muestra la cantidad de Commits en el tiempo (desde el 7 de marzo de 2020 hasta el 1 de noviembre de 2025). También hay un listado de usuarios con mayor número de aportes. En este caso, los principales 5 contribuidores son:
    - owidbot: 19.687 commits
    - edomt: 4.848 commits
    - lucasrodes: 2.843 commits
    - camappel: 483 commits
    - danielgavrilov: 221 commits


- ¿Hay documentación (README.md)?
Sí, hay documentación extensa. El archivo README.md contiene información sobre cómo acceder a los datasets, detalla la estructura del proyecto y ofrece enlaces a documentación técnica adicional.
Describe dos directorios principales:
    - `public/data`: contiene los datasets finales. Dirigido a quienes estén interesados en el uso y análisis de los datos.
    - `scripts`: Contiene todo el código y los archivos intermedios necesarios para generar el conjunto de datos finales. Dirigido principalmente a contribuidores y desarrolladores.

    También hay un enlace para dirigirse al dataset final y otro para tener más información sobre la documentación técnica.

- ¿Están los datos separados del código?
Sí. Se puede ver que en el archivo README.md hay un apartado donde se describen dos directorios separados: el de datos (`public/data`) y el de código (`scripts`).

- ¿Hay scripts de automatización?
Sí. El repositorio incluye scripts de automatización en distintos niveles, algunos ejemplos son:
    - La carpeta `.github/workflows/` contiene un archivo encargado de automatizar la sincronización de los datos procesados hacia un almacenamiento en la nube.
    - Por ejemplo, el archivo `scripts/cases_deaths.py` se encarga de generar el dataset combinado de casos y muertes, como parte del flujo de transformación de datos. 
    - El usuario owidbot (que tiene la mayor cantidad de commits) actúa como agente automatizado que ejecuta procesos y los publica en el repositorio.

Cabe destacar que, según la sección **Discussions** del repositorio, el proyecto dejó de recibir actualizaciones directas desde el 19 de agosto de 2024, debido a la migración de los datos al nuevo sistema ETL de Our World in Data (centralizado). Este cambio refleja una evolución en la gestión del pipeline de datos, pasando de un proceso basado en GitHub a una infraestructura automatizada y escalable que centraliza la extracción, transformación y carga de información. Aun así, el repositorio se mantiene disponible como archivo histórico y referencia pública del trabajo realizado durante la pandemia.

### 💡 Pregunta Reflexiva 
¿Cómo crees que Git ayuda en proyectos colaborativos de análisis de datos?

En proyectos colaborativos de análisis de datos, Git y Github permiten coordinar y versionar el trabajo de múltiples analistas y desarrolladores de manera controlada y trazable. Estas herramientas facilitan la colaboración simultánea, el seguimiento de cambios, la revisión de código y la integración continua de scripts y datos. Además, también permiten recuperar versiones anteriores, lo que mejora la seguridad y reproducibilidad de resultados.
Dominar este tipo de herramientas es fundamental para proyectos de datos, ya que permiten experimentar sin grandes riesgos (probar nuevos algoritmos sin afectar el código estable), trabajar en paralelo entre distintos miembros del equipo y realizar análisis en simultáneo y mantener un respaldo permanente del progreso del proyecto.

