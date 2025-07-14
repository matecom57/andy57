

.. _CONN_02_Descarga de datos:

================================
Capítulo n.° 2: Descarga de datos
================================

------------------

Descripción general
********

Los datos que utilizaremos para este tutorial provienen del repositorio de acceso abierto `Openneuro.org`__. Desde la página principal de Openneuro, haga clic en "Panel de Control" para cargar todos los conjuntos de datos disponibles. Seleccione el conjunto de datos "fMRI: estado de reposo y tarea aritmética", que debería aparecer en la primera página. Si no lo encuentra, utilice la barra de búsqueda para buscar "aritmética"; debería ser el primer resultado.

Haga clic en la carpeta ``sub-01`` y luego en ``anat``. Haga clic en el botón ``Descargar`` junto al archivo "sub-01_T1w.nii" para iniciar la descarga. A continuación, haga clic en la carpeta ``func`` para ver su contenido y descargar el archivo "sub-01_task-rest_bold.nii.gz".

Si estos archivos se han descargado en su carpeta "Descargas", abra una terminal de Matlab y escriba lo siguiente:

::

  cd ~/Escritorio
  mkdir CONN_Demo
  
Esto te llevará al Escritorio y creará una nueva carpeta llamada ``CONN_Demo``. Aquí almacenaremos nuestros datos y realizaremos nuestros análisis. Para organizar los datos en dos carpetas dentro del directorio CONN_Demo, escribe lo siguiente desde tu terminal de Matlab:

::

  cd CONN_Demo
  mkdir sub-01/func
  mkdir sub-01/anat
  
Esto creará las carpetas «func» y «anat» dentro de una carpeta llamada «sub-01». Para mover los archivos descargados a sus directorios correspondientes, escriba lo siguiente:

::

  movefile('~/Descargas/sub-01_task-rest_bold.nii.gz', 'sub-01/func')
  movefile('~/Descargas/sub-01_T1w.nii', 'sub-01/anat')
  
Escriba ``ls sub-01/anat`` y ``ls sub-01/func`` para asegurarse de que los datos funcionales se encuentren en el directorio `func` y los anatómicos en el directorio `anat`. De ser así, ya puede empezar a usar la caja de herramientas CONN, que veremos a continuación.


Video
*****

Haga clic aquí`__ para una demostración en video de cómo descargar los datos.

   

