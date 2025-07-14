

.. _CONN_ApéndiceE_Conectividad dinámica:

================================
Apéndice E: Conectividad dinámica
================================

-------

Descripción general
********

Los análisis de conectividad que hemos realizado hasta ahora, tanto en reposo como basados en tareas, utilizan una serie temporal por vóxel, o el promedio de una serie temporal sobre todos los vóxeles dentro de una ROI. Además, la herramienta CONN permite realizar **Conectividad Dinámica**, en la que una serie temporal se subdivide en componentes más pequeños, o se extraen múltiples componentes independientes de una serie temporal dada. Este tipo de análisis mide la variabilidad temporal de una serie temporal, en lugar de utilizarla como una única medida.

Análisis de ventana deslizante
***********************

El tipo más sencillo de conectividad dinámica es el **Análisis de Ventana Deslizante**. Esta técnica divide la serie temporal en segmentos más pequeños, cuyo número es especificado por el usuario. Por ejemplo, si tomamos los datos en estado de reposo de ``sub-01`` y cargamos los datos funcionales completamente preprocesados, podemos especificar el número de segmentos en la sección ``Condiciones`` de la pestaña ``Configuración``. Asegúrese de que la condición ``resto`` esté seleccionada, así como la opción ``la condición abarca toda la(s) sesión(es) seleccionada(s)``. A continuación, en la parte inferior de la ventana, haga clic en el menú desplegable ``Descomposición tiempo-frecuencia`` y seleccione ``descomposición temporal (ventana deslizante)``.


.. figure:: ApéndiceE_SlidingWindowSetup.png

Haga clic en el botón Listo en la esquina inferior izquierda de la pestaña Configuración, dejando los valores predeterminados. Al igual que en el análisis de un escaneo típico en reposo, utilice también los valores predeterminados para la eliminación de ruido. Al llegar a la pestaña Análisis de primer nivel, haga clic en Listo y deje los valores predeterminados. Esto pasará a los resultados de segundo nivel y mostrará un error que indica que el análisis a nivel de grupo no se puede realizar con un solo sujeto. Ignórelo por ahora y haga clic en la pestaña Análisis (primer nivel) para volver a la ventana anterior.

Tenga en cuenta que ahora dispone de varias Semillas diferentes (p. ej., ROI) para seleccionar, lo que actualizará un mapa de correlación en el lado derecho. Puede seleccionar diferentes ventanas de conectividad para ver cómo cambia la conectividad con el tiempo:

.. figure:: ApéndiceE_SlidingWindowResults.png

Estos resultados se encuentran en el directorio conn_project01/results/firstlevel/SBC_01. Por ejemplo, el archivo corr_Subject001_Condition012_Source134.nii mostrará el mapa de correlación de la ventana temporal 12 para la Fuente 134 (en este ejemplo, 134 corresponde a la amígdala derecha). A continuación, puede extraer valores de correlación transformados en z de estos mapas, por ejemplo, en AFNI:

.. figure:: ApéndiceE_VisualizaciónDeResultadosAFNI.png

Los parámetros predeterminados de la ventana deslizante son intervalos de 100 segundos para cada ventana, separados por 25 segundos. Por ejemplo, si tiene una serie temporal de 300 segundos, el vector de la ventana deslizante se vería así:

::

  [0 25 50 75 100 125 150 175 200 225 250 275]
  
El inicio de cada uno de estos puntos temporales tiene una ventana de 100 segundos tras cada uno, con una superposición de 75 segundos para cada ventana. Para nuestros datos, crearemos un vector de inicios de 100 segundos para cada ventana, con una superposición de 25 segundos:

::

  [0 75 150 225 300 375 450 525 600]
  
Esto creará 11 regresores nuevos: uno para cada ventana especificada y un regresor de promedio temporal y uno de variabilidad temporal. Haga clic en "Listo" y ejecute también la eliminación de ruido como de costumbre.

Cuando llegue a la pestaña de Análisis de primer nivel,


ICA dinámica
***********

.. nota::

  Esta sección aún está en construcción.
  
El ICA dinámico es una extensión de las interacciones psicofisiológicas generalizadas: dado un conjunto de ROI, este análisis mide cómo cambia la intensidad y el signo de la conectividad con un componente dado. Los datos en estado de reposo se descomponen en varios componentes independientes, y el ICA dinámico mide cómo cambia su conectividad con cada par de ROI.

Para ejecutar un análisis dyn-ICA, desde la pestaña "Análisis" de primer nivel, pase el ratón sobre el panel "Análisis" y haga clic en "Nuevo" en la parte inferior. Seleccione "dyn-ICA" y haga clic en "Listo". Esto generará un nuevo análisis en el panel "Análisis" llamado "DYN_01". Puede especificar el número de factores o componentes independientes, así como el kernel de suavizado temporal, en segundos. Al igual que con un análisis de conectividad basado en semillas o entre ROI, puede seleccionar tantas semillas como desee; en este caso, seleccione solo las semillas con el prefijo "networks" y desmarque el resto. A continuación, haga clic en "Listo".

.. figure:: ApéndiceE_DynICA_Setup.png
  
En nuestro ejemplo actual, usamos el valor predeterminado de 20 factores y un kernel de modulación temporal de 30 segundos. Esto ejecutará 20 análisis separados para extraer ese número de componentes y, a continuación, detectar qué ROI presentan una variabilidad temporal similar en sus series temporales. Al finalizar los análisis, verá una pestaña "Resumen" en Resultados (segundo nivel), que muestra una matriz de correlación NxN para cada componente extraído. Algunos componentes pueden parecer más ruidosos y menos interpretables, mientras que otros presentan una mayor estructura. Por ejemplo, el componente espacial n.º 3 muestra una alta puntuación de componente para las ROI sensoriomotoras y visuales, lo que sugiere que estos pares de ROI presentan una variabilidad temporal similar en un kernel de suavizado temporal de 30 segundos.

.. figure:: ApéndiceE_DynICA_Summary.png

Los otros dos botones en la esquina inferior izquierda, "Componentes espaciales" y "Componentes temporales", hacen clic en "Componentes espaciales" y verá una ventana de resultados similar al análisis de conectividad basado en semillas que realizó en capítulos anteriores. Por ejemplo, seleccione "Circuit_3" y haga clic en "Mostrar resultados".

.. figure:: ApéndiceE_DynICA_GroupAnalysis.png


.. figure:: ApéndiceE_DynICA_DisplayResults.png

