

.. _MRtrix_02_Descarga de datos:

===========================================
Tutorial n.º 2 de MRtrix: Cómo descargar el conjunto de datos
===========================================

--------------

Para este curso, analizaremos un conjunto de datos de openneuro.org llamado 'BTC preop`__. Incluye datos de pacientes con gliomas, pacientes con meningiomas y un grupo de control. Compararemos los grupos entre sí y realizaremos análisis de correlación con las covariables incluidas en el archivo ``participants.tsv`` del conjunto de datos.

Para descargar los datos, haga clic en este enlace
    `__ y luego haga clic en el botón ``Descargar``.

.. figura:: 02_Descargar_BTC.png


Cuando finalice la descarga, descomprima la carpeta, abra una Terminal y cámbiele el nombre a BTC_preop:

::

  mv ~/Descargas/ds001226-00001 ~/Escritorio/BTC_preop
  
Esto supone que el conjunto de datos se guardó en el directorio "Descargas". El comando colocará el directorio renombrado en su escritorio.
  
.. nota::

  Si no tiene espacio para todos los datos, puede comenzar con los de un solo sujeto. Haga clic en la carpeta ``sub-CON02`` para expandir el contenido y descargar cada archivo por separado. Luego, cree las siguientes subcarpetas en su directorio BTC_preop; para ello, navegue hasta ese directorio y escriba ``mkdir -p sub-CON02/ses-preop/anat sub-CON02/ses-preop/dwi sub-CON02/ses-preop/func``. Después, mueva las imágenes descargadas a su directorio correspondiente; es decir, las imágenes anatómicas irán a la carpeta anat, las imágenes de difusión a la carpeta dwi, y así sucesivamente.
  
  
Entonces estará listo para comenzar a mirar los datos en el próximo capítulo.


Video
*****

Haga clic aquí
     `__ para obtener una guía sobre cómo descargar el conjunto de datos.

     
    
   

