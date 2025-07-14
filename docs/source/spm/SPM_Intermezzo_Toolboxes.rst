

.. _SPM_Intermezzo_Cajas de herramientas:


=========================
SPM Intermezzo: Cajas de herramientas
=========================

---------

.. nota::

  El conjunto completo de cajas de herramientas disponibles para SPM se puede encontrar aquí`__.

Descripción general
********

Aunque SPM incluye una extensa biblioteca para analizar datos de fMRI, carece de algunas de las herramientas necesarias para análisis más avanzados, como los análisis de **región de interés** que se tratan en el siguiente capítulo. Para satisfacer esta necesidad, programadores e investigadores han creado **extensiones** de SPM (también conocidas como **cajas de herramientas**) que permiten al usuario realizar análisis específicos.

Por ejemplo, la mayoría de los investigadores de fMRI utilizan algún tipo de **atlas**, o una división del cerebro en regiones funcionales o anatómicas diferenciadas. Los datos de fMRI se pueden extraer de una partición específica, o región de interés, y se realizan estadísticas para determinar si existe un efecto significativo en dicha región. Para crear estas regiones anatómicas de interés, descargaremos e instalaremos la caja de herramientas **WFU Pickatlas**, un popular generador de atlas y regiones de interés.

Para descargar esta caja de herramientas, haga clic en este enlace`__ y luego haga clic en el botón Descargar (una flecha hacia abajo, justo debajo del menú de selección). Si aún no tiene una cuenta en el NITRC (Laboratorio de Herramientas e Investigación de Neuroimagen, un repositorio de código y herramientas), deberá crear una. Acepte los términos y continúe con la descarga.

Una vez descargada la caja de herramientas, descomprímela y escribe el siguiente código:

::

  movefile ~/Descargas/WFU_PickAtlas_3.0.5b/* ~/spm12/toolbox
  
Esto moverá todas las carpetas necesarias a la carpeta de la caja de herramientas de SPM12, donde se leerán cada vez que abra SPM.

Ahora abra SPM, haga clic en el menú "Caja de herramientas" y debería ver la caja de herramientas wfupickatlas como una opción.


Instalación de Marsbar
******************

Marsbar es otra herramienta popular de SPM, utilizada principalmente para el análisis del ROI. Para descargarla, haga clic en este enlace.`__ y haga clic en el botón Descargar.

Una vez descargado el paquete, descomprímalo. Desde la terminal de Matlab, navegue al directorio de la caja de herramientas spm12 y cree un directorio llamado marsbar:

::

  cd ~/spm12/caja de herramientas
  mkdir marsbar
  
Y luego mueva los archivos necesarios de la descarga de marsbar a la carpeta marsbar:

::

  movefile ~/Descargas/marsbar-0.44/* ~/spm12/toolbox/marsbar
  
La próxima vez que abra SPM, debería ver "marsbar" como una opción cuando haga clic en el menú Caja de herramientas.

Video
******

Para ver una descripción general en video de las cajas de herramientas y cómo instalarlas, haga clic aquí`__.

Próximos pasos
*********

Después de haber instalado las cajas de herramientas WFU PickAtlas y Marsbar, estará listo para realizar un análisis de la región de interés, que abordaremos a continuación.

   

