Tutorial de FreeSurfer n.º 14: Puntos de control y normalización de la intensidad
===================================================================

---------------

Descripción general
********

Durante el preprocesamiento, FreeSurfer realizará un paso llamado **normalización de intensidad**. Esto se refiere a la homogeneización de la intensidad de la señal de la sustancia blanca y gris para distinguir mejor los tipos de tejido y facilitar la segmentación del cerebro.

Las fallas en la normalización de la intensidad suelen indicarse por una superficie de sustancia blanca inexacta. En ese caso, añadiremos **puntos de control** para especificar qué partes de la corteza deben clasificarse como sustancia blanca. Estos puntos de control actúan como pequeñas lámparas que iluminan su entorno inmediato; al aumentar la intensidad de la señal de los vóxeles cercanos, aumentan la probabilidad de que el área se clasifique como sustancia blanca.

Identificación de errores de normalización de intensidad
*******************************************

Los errores de normalización de la intensidad suelen ocurrir en áreas que son susceptibles a la pérdida de señal, como la corteza frontal ventral y las áreas ventrales del lóbulo temporal.

En el sujeto 128, podemos ver bolsas de materia blanca que no son capturadas por las superficies reconstruidas:

::

  freeview -v mri/brainmask.mgz mri/T1.mgz -f surf/lh.pial:edgecolor=rojo surf/rh.pial:edgecolor=rojo \
  surf/izq.blanco:colorborde=amarillo surf/der.blanco:colorborde=amarillo
  
  
En este caso particular, se han extirpado partes de la corteza frontal. Esto no se debe a una extracción excesiva del cráneo, como podría pensarse; más bien, se ha desidentificado al sujeto mediante la extirpación del rostro, lo que, lamentablemente, también ha eliminado partes del polo frontal.

.. figura:: 14_FaceRemoval.png
  :escala: 50%

Sin embargo, intentaremos mejorar las estimaciones de superficie estableciendo puntos de control y juzgar si es mejor o no.

Configuración de los puntos de control
**************************

Cambie a la vista coronal y amplíe la zona frontal del cerebro. Los errores de normalización de intensidad comienzan alrededor del corte 121. En el menú, haga clic en «Archivo -> Nuevo conjunto de puntos» y escriba el nombre «control.dat». Seleccione el archivo «brainmask.mgz» como conjunto de datos de plantilla.

Puede agregar un punto de control haciendo clic con el botón izquierdo del ratón en los vóxeles que parecen pertenecer a la sustancia blanca, pero que no están encapsulados por su superficie. Use la ubicación de los puntos de control con moderación: no los coloque dentro de la línea amarilla ni en vóxeles que sean claramente materia gris. Basta con dos o tres para cubrir un área de tamaño moderado. Recuerde que su influencia también se extenderá a los vóxeles cercanos.

.. figura:: 14_ControlPoints.png

.. nota::

  Si necesita eliminar un punto de control, puede deshacerlo presionando ``cmd+z`` o manteniendo presionada la tecla ``Shift`` y haciendo clic izquierdo en el punto de control que desea eliminar.
  
  Además, para otras consideraciones sobre dónde establecer los puntos de control, consulte el tutorial de normalización de intensidad de FreeSurfer`__.

Cuando termine de configurar los puntos de control, haga clic en «Archivo -> Guardar conjunto de puntos» y guarde el archivo como «control.dat» en el directorio «tmp» del sujeto. A continuación, cierre Freeview y escriba lo siguiente desde el directorio del sujeto:

::

  recon-all -autorecon2-cp -autorecon3 -subjid sub-128_ses-BL_T1w


Video
*****

Para ver una descripción general en video sobre cómo establecer puntos de control, haga clic aquí
    `__.

    
   

