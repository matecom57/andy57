Analisis imagenes con SPM
=========================

Introducción a SPM

Descarga e instalación de SPM

Después de haber establecido la ruta, escriba lo siguiente desde la terminal de Matlab:

.. code:: Bash

   spm

Tutorial de SPM n.° 1: Descarga de datos



Tutorial de SPM n.º 2: La tarea de flanqueo



Tutorial de SPM n.º 3: Análisis de los datos

Primero, renombremos el conjunto de datos con un nombre claro e informativo. Si el conjunto de datos se ha descargado en el directorio de Descargas, 
use la terminal de Matlab para navegar al Escritorio y escriba lo siguiente:

.. code:: Bash

   movefile('~/Descargas/ds000102_0001/', 'Flanker')

Inspección de la imagen anatómica

Para empezar, veamos la imagen anatómica en la carpeta “anat” para “sub-08”. Si aún no ha abierto SPM, navegue a la carpeta sub-08 y escriba

.. code:: Bash

   spm fmri

.. code:: Bash

   gunzip('*.gz')

SPM lee la información del encabezado al cargar un archivo. La versión de línea de comandos se llama spm_vol. Desde la terminal de Matlab, navegue al 
directorio sub-01/func, asegúrese de que los datos estén descomprimidos y escriba lo siguiente:

.. code:: Bash

   run1 = spm_vol('sub-01_task-flanker_run-1_bold.nii')
   run1.fname

Tutorial de SPM n.° 4: Preprocesamiento

Para comenzar a preprocesar los datos de sub-08, lea los siguientes capítulos. Comenzaremos con la Realineación y la Corrección de la Temporización de 
Corte , que corrigen desalineaciones y errores de sincronización en las imágenes funcionales, antes de pasar al Corregistro y la Normalización , que 
alinean las imágenes funcionales y estructurales y las trasladan a un espacio estandarizado. Finalmente, las imágenes se suavizan para aumentar la 
señal y eliminar el ruido. La secuencia típica de pasos de preprocesamiento se muestra en la imagen a continuación:


Capítulo 1: Realinear y corregir la distorsión de los datos

El primer paso del preprocesamiento es realinear las imágenes funcionales.

El volumen de referencia se define en el campo "Número de pasadas", que permite especificar si los volúmenes se alinearán con la media de todos los 
volúmenes o con el primero. Para este tutorial, deje este valor predeterminado y los demás valores predeterminados sin modificar.Realign (Estimate & 
Reslice)EstimateReslice

Cargando las imágenes

En este experimento, se realizaron dos ejecuciones de datos por sujeto (SPM se refiere a cada ejecución como una sesión ). Si hace clic en el 
Datacampo, verá una opción para agregar más sesiones. Haga clic en para agregar otra sesión. Verá un a la derecha de cada campo de sesión, lo que 
indica que debe completarse antes de ejecutar el programa.New: Session<-X

Haga doble clic en la primera sesión para abrir la ventana de selección de imágenes. Navegue hasta el funcdirectorio y seleccione el archivo 
sub-08_task-flanker_run-1_bold.nii,1. El símbolo ,1al final del nombre del archivo indica que solo se puede seleccionar el primer fotograma o volumen. 
Para seleccionar todos los volúmenes de esa sesión, necesitaremos aumentar el número de fotogramas disponibles. En el Framescampo (debajo del 
Filtercampo), escriba 1:146y presione Intro.

Capítulo 2: Corrección de la sincronización de segmentos

A diferencia de una fotografía, donde la imagen completa se toma en un solo instante, el volumen de fMRI se adquiere en cortes. Cada uno de estos 
cortes tarda en adquirirse, desde decenas hasta cientos de milisegundos.

Corrección de tiempos de corte en SPM

Similar a lo que hicimos con Realignment , primero haremos clic en el botón en la interfaz gráfica de usuario de SPM. Haga clic en el campo y cree dos 
nuevas sesiones. Haga doble clic en la primera sesión y, en la columna Filtro, escriba . En el campo Fotogramas, presione Intro; seleccione todos los 
fotogramas que se muestran y haga clic en . Repita el mismo procedimiento para los archivos de ejecución 2 de la segunda sesión.Slice 
TimingData^rsub-08_task-flanker_run-1.*1:146Done


Para el campo, necesitamos averiguar cuántas porciones hay en cada volumen de nuestro conjunto de datos. Desde la terminal de Matlab, navegue al 
directorio y escriba:Number of Slicessub-08/func

.. code:: Bash

   V = spm_vol('sub-08_task-flanker_run-1_bold.nii')

Esto cargará el encabezado de la imagen en una variable llamada V. Si escribe Vy pulsa Intro, verá que contiene los siguientes campos:

Capítulo 3: Corregistro


