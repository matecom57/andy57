

.. _fMRI_04_Preprocesamiento:


=============
Tutorial de fMRI n.° 4: Preprocesamiento
=============


.. nota::
  Muchos de los ejemplos se ejecutan desde el directorio ``Flanker/sub-08``; recomiendo navegar a ese directorio con su Terminal antes de leer el resto del capítulo.
  
   
Descripción general
-------------

Ahora que sabemos dónde están nuestros datos y cómo se ven, realizaremos el primer paso del análisis fMRI: **Preprocesamiento**.

Piensa en el preprocesamiento como la limpieza de las imágenes. Al tomar una foto con una cámara, por ejemplo, hay varias cosas que puedes hacer para mejorarla:

* Eliminar los ojos rojos;
* Aumentar la saturación del color;
*Eliminar sombras.

.. figura:: Antes_Después_De_Edición.png

  Una foto que tomamos con una cámara puede ser oscura, borrosa o con ruido (panel izquierdo). Tras editar la imagen mejorando el contraste, reduciendo el desenfoque y aumentando el brillo, obtenemos una imagen más definida y nítida.

De manera similar, cuando preprocesamos datos fMRI, limpiamos las imágenes tridimensionales que adquirimos cada :ref:`TRUn volumen fMRI contiene no solo la señal que nos interesa (cambios en la sangre oxigenada), sino también fluctuaciones que no nos interesan, como el movimiento de la cabeza, las desviaciones aleatorias, la respiración y los latidos del corazón. A estas fluctuaciones las llamamos **ruido**, ya que queremos separarlas de la señal que nos interesa. Algunas de estas fluctuaciones pueden eliminarse de los datos mediante su modelado (lo cual se explica en el capítulo sobre ajuste de modelos), y otras pueden reducirse o eliminarse mediante preprocesamiento.

Para comenzar a preprocesar los datos del sub-08, lea las siguientes descripciones de cada paso.

.. toctree::
   :maxdepth: 1
   :caption: Pasos de preprocesamiento

   Preprocessing/Skull_Stripping
   Preprocessing/FEAT_GUI
   Preprocessing/Motion_Correction
   Preprocessing/Slice_Timing_Correction
   Preprocessing/Smoothing
   Preprocessing/Registration_Normalization
   Preprocessing/Checking_Preprocessing
   Preprocessing/Checkpoint


---------

Video
*********

Cuando hayas terminado todos los capítulos, haz clic aquí
    `__ para una lista de reproducción que contiene todos los videos utilizados para demostrar los pasos de preprocesamiento.

.. nota::
  Los distintos paquetes de software realizan estos pasos en un orden ligeramente distinto; por ejemplo, FSL normaliza los mapas estadísticos tras el ajuste del modelo. También existen análisis que omiten ciertos pasos; por ejemplo, quienes realizan análisis de patrones multivóxel no suavizan sus datos. En cualquier caso, la lista anterior representa los pasos más comunes que se realizan en un conjunto de datos típico.
  
  

    
   

