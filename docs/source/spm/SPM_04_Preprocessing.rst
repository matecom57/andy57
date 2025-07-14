

.. _SPM_04_Preprocesamiento:

==============================
Tutorial de SPM n.° 4: Preprocesamiento
==============================

-----------

.. nota::
  Muchos de los ejemplos se ejecutan desde el directorio ``Flanker/sub-08``; recomiendo navegar a ese directorio en la Terminal de Matlab antes de leer el resto del capítulo.
  
   
Descripción general
********

Ahora que sabemos dónde están nuestros datos y cómo se ven, realizaremos el primer paso del análisis fMRI: **Preprocesamiento**.

Piensa en el preprocesamiento como la limpieza de las imágenes. Al tomar una foto con una cámara, por ejemplo, hay varias cosas que puedes hacer para mejorarla:

* Eliminar los ojos rojos;
* Aumentar la saturación del color;
*Eliminar sombras.

.. figure:: 04_Antes_Después_Edición.png

  Una foto que tomamos con una cámara puede ser oscura, borrosa o con ruido (panel izquierdo). Tras editar la imagen mejorando el contraste, reduciendo el desenfoque y aumentando el brillo, obtenemos una imagen más definida y nítida.

De manera similar, cuando preprocesamos datos fMRI, limpiamos las imágenes tridimensionales que adquirimos cada :ref:`TRUn volumen fMRI contiene no solo la señal que nos interesa (cambios en la sangre oxigenada), sino también fluctuaciones que no nos interesan, como el movimiento de la cabeza, las desviaciones aleatorias, la respiración y los latidos del corazón. A estas fluctuaciones las llamamos **ruido**, ya que queremos separarlas de la señal que nos interesa. Algunas de estas fluctuaciones pueden eliminarse de los datos mediante su modelado (lo cual se explica en el capítulo sobre ajuste de modelos), y otras pueden reducirse o eliminarse mediante preprocesamiento.

Para comenzar a preprocesar los datos de sub-08, lea los siguientes capítulos. Comenzaremos con la **Realineación** y la **Corrección de Sincronización de Corte**, que corrigen desalineaciones y errores de sincronización en las imágenes funcionales, antes de pasar al **Corregistro** y la **Normalización**, que alinean las imágenes funcionales y estructurales y las trasladan a un espacio estandarizado. Finalmente, las imágenes se **Suavizan** para aumentar la señal y eliminar el ruido. La secuencia típica de pasos de preprocesamiento se muestra en la imagen a continuación:

.. figure:: SPM_GUI_Steps.png

.. toctree::
   :maxdepth: 1
   :caption: Pasos de preprocesamiento

   SPM_04_Preprocessing/01_SPM_Realign_Unwarp
   SPM_04_Preprocessing/02_SPM_SliceTiming
   SPM_04_Preprocessing/03_SPM_Coregistration
   SPM_04_Preprocessing/04_SPM_Segmentation
   SPM_04_Preprocessing/05_SPM_Normalize
   SPM_04_Preprocessing/06_SPM_Smoothing
   

.. nota::
  Los distintos paquetes de software realizan estos pasos en un orden ligeramente distinto; por ejemplo, FSL normaliza los mapas estadísticos tras el ajuste del modelo. También existen análisis que omiten ciertos pasos; por ejemplo, quienes realizan análisis de patrones multivóxel no suavizan sus datos. En cualquier caso, la lista anterior representa los pasos más comunes que se realizan en un conjunto de datos típico.

---------

Video
*****

Una vez que haya terminado de revisar todos los pasos de preprocesamiento, haga clic aquí
    `__ para un video que muestra cómo realizar todos los pasos después de la realineación.
  
  

    
   

