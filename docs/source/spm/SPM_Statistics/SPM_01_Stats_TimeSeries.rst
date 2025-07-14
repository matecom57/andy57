

.. _SPM_01_Estadísticas_Series_de_Tiempo:

Capítulo 1: Las series temporales
**************************

Para comprender cómo funciona el ajuste de modelos, primero debemos revisar la estructura de los datos de fMRI. Recuerde que los conjuntos de datos de fMRI contienen varios **volúmenes** unidos como cuentas en un collar; a esta cadena concatenada de volúmenes la llamamos **serie** de datos. La señal que se mide en cada vóxel a lo largo de toda la serie se denomina **serie temporal**. Por lo tanto, hay tantas series temporales como vóxeles en el conjunto de datos.

.. nota::

  En SPM, una ejecución se denomina **sesión**. Algunos términos no se han estandarizado en los paquetes de análisis, pero para este curso, seguiré con la definición de ejecución anterior.

Lamentablemente, en SPM no existe una forma sencilla de visualizar la serie temporal de un volumen. (Ampliaremos este tema más adelante; quizás podamos hablar de una solución alternativa con spm_vol).


Ahora comprende mejor cómo la serie temporal representa la señal medida en cada vóxel, pero ¿de dónde proviene esa señal? En el siguiente capítulo, repasaremos brevemente la historia de la fMRI y cómo generamos la señal que se ve en el visor.

