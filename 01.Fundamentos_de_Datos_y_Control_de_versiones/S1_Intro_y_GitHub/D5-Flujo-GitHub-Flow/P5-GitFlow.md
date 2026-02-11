# Implementa GitHub Flow completo con convenciones profesionales

## Crear feature branch descriptiva:
```
git checkout -b feature/dashboard-ventas-v1
Hacer cambios con commits descriptivos:
```

![crear-feature-branch](IMG-P5/crear-feature-branch.PNG)

Se crea una nueva rama que representa una nueva funcionalidad: un dashboard de ventas.

## Modificar código
```
echo "import matplotlib.pyplot as plt" >> analisis_ventas.py
```
![hacer-cambios](IMG-P5/hacer-cambios.PNG)

``echo`` imprime el texto ``"import matplotlib.pyplot as plt"`` en el ``archivo.py`` (indicado por ``>>``, se agrega al final del archivo).

Entonces, si ``analisis_ventas.py`` existe, el comando añade esta línea:
``"import matplotlib.pyplot as plt"``.
Si no existe, el comando crea el archivo y escribe esa línea.

## Commit con convención

```
git add analisis_ventas.py
git commit -m "feat: Agregar visualización básica de ventas

- Importar matplotlib para gráficos
- Preparar estructura para dashboard de ventas
- Configurar colores corporativos por defecto"

```
![hacer-cambios](IMG-P5/hacer-cambios.PNG)

> [!TIP]
> Recordar commits con convención:
> 
>feat: → nueva funcionalidad
>
> fix: → correcciones
> 
> chore: → tareas menores
> 
> docs: → documentación
> 
> refactor: → reestructura de código

## Push y crear Pull Request:

```
git push -u origin feature/dashboard-ventas-v1
```

Esto permite subir la rama al repositorio remoto.
- ``u`` sirve para luego hacer git push o git pull sin tener que indicar la rama cada vez.

![rama-subida](IMG-P5/rama-subida.PNG)

# En GitHub:

Crear PR desde la branch


Título: "feat: Dashboard básico de análisis de ventas"

Descripción detallada del cambio y su impacto

Solicitar revisión a compañeros (en este caso a lolalina)

![pull-request](IMG-P5/pull-request.PNG)

Finalmente tenemos el PR creado.
![PR-creado](IMG-P5/PR-creado.PNG)


## Simular revisión y merge:


Agregar comentarios en el PR *(Desde cuenta lolalolina).*

![solicitud-cambios](IMG-P5/solicitud-cambios.PNG)


Hacer cambios solicitados en el archivo local y luego hacer git push de la modificación. *(Desde cuenta que realizó el PR).*

![cambios-realizados](IMG-P5/cambios-realizados.PNG)


*(Desde cuenta lolalolina).*

Comprobar cambios en el PR

![cambios.incorporados](IMG-P5/cambios-incorporados.PNG)

Aprobar y mergear el PR 
![merge-pr](IMG-P5/merge-pr.PNG)

Seleccionar **Merge pull request** y luego escribir el mensaje del commit:

![commit-merge](IMG-P5/commit-merge.PNG)

Confirmar el merge.

![pr-exitoso](IMG-P5/pr-exitoso.PNG)

Luego del merge, se procede a eliminar la branch:

![branch-deleted](IMG-P5/branch-deleted.PNG)


---

Verificación: Confirma que el flujo completo funciona y que el historial refleja un proceso profesional de colaboración.

Requerimientos:
- Git y GitHub configurados completamente (de días anteriores)
- Repositorio con historial de trabajo
- Conocimiento básico de branches y merges (del día 4)