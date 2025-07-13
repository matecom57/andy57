

.. _fMRI_01_Descarga de datos:

==============
Tutorial de fMRI n.° 1: Descarga de datos
==============


Descripción general
--------------

En este curso, analizaremos un conjunto de datos de fMRI que utilizó la tarea Flanker. El conjunto de datos se puede encontrar aquí.`__ en el `OpenNeuro 
    `__ sitio web, un repositorio en línea de datos de neuroimagen. (En caso de que el enlace de descarga en esa página web no funcione, vaya `aquí 
     `__ y haga clic en el enlace "todos los datos de los sujetos").


.. figure:: OpenNeuro_Flanker.png

    La página de OpenNeuro para el conjunto de datos Flanker incluye un árbol de archivos del conjunto de datos, que incluye las carpetas «anat» (que contiene la imagen anatómica) y «func» (que contiene las imágenes funcionales y las horas de inicio de cada ejecución). Hay archivos adicionales que contienen datos del sujeto, como sexo y edad («participants.tsv») y parámetros de escaneo («task-flanker_bold.json»). Un árbol de directorios estandarizado como este facilita enormemente la creación de scripts, como veremos en un tutorial posterior.
    
    
Descargue el conjunto de datos haciendo clic en el botón "Descargar" en la parte superior de la página. El conjunto de datos ocupa aproximadamente 2 GB y viene en una carpeta comprimida. Extráigalo haciendo doble clic en la carpeta y luego muévalo a su escritorio.

.. figure:: OpenNeuro_DownloadButton.png


Después de haber descargado y descomprimido el conjunto de datos, haga clic en el botón Siguiente para obtener una descripción general de la tarea experimental utilizada en este estudio.

Opciones de descarga alternativas
****************************

Si el botón de descarga no funciona, intente utilizar `Amazon Web Services (AWS)
     Opción `__. Ir a `esta página 
     `__ y descargue el cliente de AWS adecuado para su sistema operativo. Una vez instalado, abra una terminal, vaya al escritorio y escriba lo siguiente:

::

    sincronización de aws s3: sin solicitud de firma s3://openneuro.org/ds000102 ds000102-download/

La descarga debería tardar aproximadamente media hora.


Video
******

Para ver un video tutorial sobre cómo descargar los datos, haga clic aquí
     `__. (El video se titula "Tutorial AFNI n.° 1", pero como es básicamente lo mismo que harás para FSL, decidí usar el mismo video para ambos tutoriales).

     
    
   

