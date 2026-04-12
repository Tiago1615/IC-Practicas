# Sesion 5

Este directorio contiene el notebook `Sesion_5.ipynb` y los ficheros de datos utilizados en la sesion:

- `S_10.TXT`
- `S_20.TXT`
- `S_30.TXT`
- `S_40.TXT`
- `S_50.TXT`

Tambien se incluye `env.yml`, que define el entorno de Python necesario para ejecutar el notebook.

## Recomendacion de instalacion

Para trabajar con este material se recomienda instalar Anaconda o Miniconda. Con ello podras crear el entorno de forma reproducible a partir del fichero `env.yml`.

### Crear el entorno desde el `.yml`

Desde una terminal de Anaconda o desde PowerShell, situate en esta carpeta y ejecuta:

```bash
conda env create -f env.yml
```

El entorno se creara con el nombre `IC`, que es el definido en el propio fichero.

Para activarlo:

```bash
conda activate IC
```

Si quieres verificar que el entorno se ha creado correctamente, puedes listar los entornos disponibles con:

```bash
conda env list
```

## Que hace el notebook

El notebook `Sesion_5.ipynb` realiza un analisis de datos de un sensor a partir de varias mediciones tomadas a distintas distancias. El flujo general es el siguiente:

1. Carga los ficheros de medida y convierte el voltaje a voltios.
2. Realiza un analisis exploratorio con graficas de voltaje frente a tiempo para todas las distancias.
3. Genera boxplots para comparar la distribucion de las medidas.
4. Elimina un outlier evidente en la serie de 50 cm.
5. Construye una tabla resumen con el voltaje medio, la desviacion tipica y el numero de muestras por distancia.
6. Ajusta polinomios de grado 1, 2, 3 y 4 para modelar la relacion entre voltaje medio y distancia.
7. Estima la linealidad del sensor usando el ajuste lineal y calcula el error absoluto maximo y el porcentaje de error relativo sobre el rango.

## Estructura del notebook

Las secciones principales del notebook son:

- Lectura de ficheros
- Analisis exploratorio de datos
- Eliminacion de outlier claro para 50 cm
- Tabla final
- Ajuste a polinomio de grado n
- Estimar linealidad

## Requisitos

- Anaconda o Miniconda
- Python y las librerias incluidas en `env.yml`

## Uso rapido

1. Crear y activar el entorno.
2. Abrir `Sesion_5.ipynb` en Jupyter Notebook, JupyterLab o VS Code.
3. Ejecutar las celdas en orden.

## Nota

El notebook no crea ningun entorno ni modifica el contenido de los ficheros de datos. Solo los lee para hacer el analisis y las representaciones graficas.