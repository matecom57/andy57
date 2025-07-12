Apéndice B: PETSurfer
=====================

--------------

.. nota::

  Estos pasos se toman de la página PETSurfer de FreeSurfer`__; Los estoy adaptando para usarlos con otro conjunto de datos. Tenga en cuenta que PETSurfer solo está disponible en FreeSurfer versión 6.0 o posterior.
  Al 5 de enero de 2021, esta página aún se encuentra en revisión; es posible que vuelva a consultarla si parece haber demanda.

Descripción general
********

Esta sección contiene algunas notas sobre cómo ejecutar PETSurfer, un conjunto de herramientas dentro del paquete `FreeSurfer`.
    `__. En otras palabras, si ya has descargado e instalado FreeSurfer, podrás usar PETSurfer.

Si ha recopilado datos de Tomografía por Emisión de Positrones (PET), también necesitará una imagen anatómica del mismo sujeto. Los siguientes pasos segmentarán la imagen PET, la corregistrarán con la imagen anatómica y, a continuación, aplicarán la corrección de volumen parcial (CVP). El último paso, la CVP, es necesario para evitar los efectos de volumen parcial (EVP), en los que un solo vóxel puede contener señales de múltiples tipos de tejido o diferentes circunvoluciones. Sin ella, no sería posible determinar si la señal medida en el vóxel proviene de la sustancia gris, la sustancia blanca o una combinación de ambas.


.. nota::

  PETSurfer contiene los siguientes métodos:

  * Matriz de transferencia geométrica simétrica (SGTM): se utiliza principalmente para análisis de ROI
  * Método Meltzer: se utiliza para análisis vóxel por vóxel.
  * Método Muller-Gartner (MG): también se utiliza para análisis vóxel por vóxel.
  
  Nos referiremos a ellos utilizando cada una de estas siglas.
  
  
Preparación de los datos: ejecución de recon-all
**************************************

El primer paso será reconstruir la imagen anatómica con ``recon-all``. Las instrucciones para hacerlo se encuentran en ``este capítulo``. Dondequiera que esté ejecutando el análisis con su imagen anatómica, asegúrese de navegar a ese directorio y apuntarlo con ``SUBJECTS_DIR``.

::

  SUBJECTS_DIR=`pwd`
  recon-all -s T1_ANAT -i T1_ANAT.nii.gz -todos
  
Esto tardará unas horas en procesarse, dependiendo de la velocidad de su ordenador. Una vez finalizado, asegúrese de ejecutar las comprobaciones de calidad descritas en este capítulo.
    `.


Segmentación de los datos
*******************

Si la imagen anatómica reconstruida parece satisfactoria, puedes segmentarla usando ``gtmseg``:

::

  gtmseg --s T1_ANAT
  
Esto tardará aproximadamente una hora. Al finalizar, verá una nueva imagen llamada ``gtmseg.mgz`` ubicada en la carpeta ``T1_ANAT/mri``. Puede verla en Freeview escribiendo:

::

  freeview -v T1_ANAT/mri/gtmseg.mgz:colormap=lut
  
Esto mostrará la imagen anatómica segmentada con el mapa de colores "lut" (tabla de consulta) superpuesto. Al pasar el ratón sobre los diferentes colores, se mostrará cuál corresponde a cada segmentación.

.. figure:: Apéndice_B_gtm_LUT.png


Registro de los datos PET en la imagen anatómica
*************************************************

Tiene tres opciones para corregistrar sus datos: si solo tiene una imagen PET, úsela como plantilla. Si, por el contrario, tiene varias imágenes PET, puede promediarlas para crear una plantilla o extraer una sola imagen. En este tutorial, utilizaremos el método de una sola imagen:

::

  mri_convert PET.nii.gz --marco 0 plantilla.nii.gz
  
Y luego usa esto para el registro conjunto:

::

  mri_coreg --s T1_ANAT --mov plantilla.nii.gz --reg plantilla.reg.lta
  
El registro conjunto se puede comprobar con ``tkregisterfv``:

::

  tkregisterfv --mov plantilla.nii.gz --reg plantilla.reg.lta --surfs
  
Debería ver un contorno claro del límite entre la materia gris y la materia blanca, resaltado en amarillo:

.. figure:: Apéndice_B_corregistro.png


Aplicación de corrección de volumen parcial
**********************************


    
   

