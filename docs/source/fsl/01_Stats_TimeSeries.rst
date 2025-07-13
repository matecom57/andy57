Capítulo 1: Las series temporales
***********

Para comprender cómo funciona el ajuste de modelos, primero debemos revisar la composición de los datos de fMRI. Recuerde que los conjuntos de datos de fMRI contienen varios **volúmenes** unidos como cuentas en un collar; a esta cadena concatenada de volúmenes la llamamos **serie** de datos. La señal que se mide en cada vóxel a lo largo de toda la serie se denomina **serie temporal**.

.. nota::

  En SPM, una ejecución se denomina **sesión**. Algunos términos no se han estandarizado en los paquetes de análisis, pero para los fines de este curso, seguiré con la definición de ejecución anterior.

Para ilustrar cómo se ve esto, abra el visor fsleyes y cargue el conjunto de datos ``filtered_func_data.nii.gz``. En la esquina inferior derecha se encuentra una ventana denominada ``Ubicación``, con un campo llamado ``Volumen``. Este indica el volumen actual en la serie temporal que se muestra en la ventana de visualización. Haga clic en la flecha hacia arriba junto al campo para mostrar el siguiente volumen de la serie temporal, observando cómo hay cambios pequeños pero perceptibles de un volumen a otro.

.. nota::
  Para ver la actualización de la serie temporal de forma más rápida y continua, haga clic en el icono del carrete de película. Puede modificar la velocidad de actualización haciendo clic en el icono de la llave inglesa.

A continuación, haga clic en el menú "Ver" en la parte superior de la pantalla y seleccione "Series temporales". Se abrirá otra ventana que muestra los cambios en la señal a lo largo de toda la serie temporal, con el número de volumen en el eje x. El eje y se mide en unidades arbitrarias de la señal fMRI que captura el escáner; estas unidades serán interpretables después de normalizarlas para cada exploración y comparar esta señal normalizada entre las condiciones.

.. figura:: TimeSeriesDemo.gif


La serie temporal representa la señal que se mide en cada vóxel, pero ¿de dónde proviene? En el siguiente capítulo, repasaremos brevemente la historia de la fMRI y cómo generamos la señal que se ve en el visor.




