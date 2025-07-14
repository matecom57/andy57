

.. _SPM_08_Análisis de grupo:

===============================
Tutorial de SPM n.° 8: Análisis de grupo
===============================

--------

Descripción general
********

Nuestro objetivo al analizar este conjunto de datos es generalizar los resultados a la población de la que se extrajo la muestra. En otras palabras, si observamos cambios en la actividad cerebral en nuestra muestra, ¿podemos afirmar que estos cambios probablemente también se observarían en la población?

Para comprobarlo, realizaremos un **análisis a nivel de grupo** (también conocido como **análisis de segundo nivel**). En SPM, esto significa calcular el error estándar y la media de una estimación de contraste y, a continuación, comprobar si la estimación promedio es estadísticamente significativa. Realizaremos este análisis a nivel de grupo mediante un enfoque de **estadística de resumen** que ignora la variabilidad en las estimaciones de los parámetros y realiza una prueba t sobre la media de las estimaciones de los parámetros de cada sujeto.


Especificación del análisis de segundo nivel
*********************************

Una vez finalizados todos los análisis de primer nivel, cree un nuevo directorio para almacenar los resultados de segundo nivel. Desde la terminal de Matlab, navegue al directorio Flanker que contiene todos los sujetos y escriba ``mkdir 2ndLevel_Inc-Con``.

Desde la interfaz gráfica de usuario de SPM, haga clic en el botón "Especificar segundo nivel". La prueba predeterminada que se realizará es una prueba t de una muestra, y solo se deben completar dos campos: el directorio de salida de los resultados y los escaneos en los que se realizará la prueba; es decir, las imágenes de contraste creadas durante cada análisis de primer nivel.

Haga doble clic en el campo "Directorio" y seleccione la carpeta "2ndLevel_Inc-Con" que acaba de crear. Para el campo "Escaneos", navegue al directorio "1stLevel" del sub-01 y seleccione la imagen de contraste "Incongruente-Congruente" ("con_0001.nii"). Navegue a los directorios "1stLevel" de los demás sujetos y seleccione la imagen "con_0001.nii" para cada uno. La animación a continuación muestra un par de maneras de agilizar este proceso. Cuando haya terminado de seleccionar la imagen "con_0001.nii" para los 26 sujetos, haga clic en el botón verde "Ir".

.. figure:: 08_SelectConImages.gif

.. nota::

  Si olvida qué imagen de contraste corresponde a qué condiciones se contrastan, puede averiguarlo mediante uno de los siguientes métodos. Una opción es cargar el archivo SPM.mat a través de la interfaz gráfica de resultados de un sujeto de muestra y ver qué contraste numérico corresponde a las imágenes "con" generadas en la carpeta de cada sujeto. La otra opción es usar la terminal de Matlab para navegar a la carpeta de resultados de primer nivel de un sujeto de muestra y escribir "load SPM.mat". Esto cargará la **estructura** de SPM en memoria, que contiene información sobre todos los datos introducidos en el análisis de primer nivel. Si escribe "SPM.xCon.name", Matlab devolverá la etiqueta de cada contraste.
  
  
Estimación del análisis de segundo nivel
**********************************

Especificar el modelo solo le llevará un segundo. Una vez finalizado, deberá estimarlo, tal como hizo con los análisis de primer nivel. En la interfaz gráfica de usuario de SPM, haga clic en el botón "Estimar". Seleccione el archivo SPM.mat del directorio 2ndLevel_Flanker que creó y haga clic en el botón verde "Ir".


Visualización de los resultados
*******************

Al igual que con los análisis de primer nivel, ahora podemos ver los resultados haciendo clic en el botón "Resultados" de la interfaz gráfica de usuario de SPM. Seleccione el archivo SPM.mat del directorio 2ndLevel_Inc-Con y haga clic en Listo. Verá otra ventana de contrastes, con una ligera diferencia: mientras que los análisis de primer nivel tenían una matriz de diseño que contenía todos los regresores del modelo, esta matriz de diseño tiene el aspecto de un recuadro blanco. Esto indica que solo se debe probar un regresor: la activación media en todas las imágenes de contraste individuales incluidas en el modelo.

Haga clic en "Definir nuevo contraste...", llámelo "Inc-Con" y asígnele un peso de contraste de "1". Al terminar, debería verse así:

.. figure:: 08_2ndLevel_Inc-Con_Contrast.png


Haga clic en "Aceptar" y, a continuación, en "Listo". Se le harán las mismas preguntas que antes sobre el enmascaramiento, los valores de umbralización del conglomerado y la extensión del conglomerado. Para este análisis de grupo, seleccione lo siguiente:

::

  aplicar enmascaramiento -> ninguno
  Ajuste del valor p para controlar -> ninguno
  umbral {valor T o p} -> 0,001
  & umbral de extensión {vóxeles} -> 20
  
Esto establecerá el umbral de la imagen para mostrar únicamente los grupos compuestos por vóxeles individuales que superen un umbral de 0,001. Más adelante, aprenderemos a determinar qué umbral definidor de grupo nos da una tasa de falsos positivos de 0,05.

Cuando haya terminado, debería ver un resultado como este, que muestra un grupo significativo en la corteza prefrontal medial dorsal:

.. figure:: 08_GroupLevelResult_Inc-Con.png


Resultados de segundo nivel para incongruentes y congruentes
***********************************************

Si solo le interesa saber dónde existen diferencias significativas entre las condiciones incongruentes y congruentes, los pasos anteriores son todo lo que necesita hacer. Como verá en un capítulo posterior sobre el análisis de ROI.` Sin embargo, es útil examinar la actividad en cada condición por separado para ver qué impulsa el efecto de Incongruente-Congruente.

Para prepararse para ese análisis, navegue al directorio Flanker y cree dos nuevos directorios de segundo nivel, uno para el efecto simple de cada contraste:

::

  mkdir 2doNivel_Incongruente
  mkdir 2doNivel_Congruente
  
Using the same procedure above for determining which contrast is located in the SPM.mat file, we find out that the Incongruent contrasts are located in the con_0003.nii file for each subject, and the Congruent contrast are located in the con_0004.nii file for each subject. Starting with the Incongruent contrast images, click on the ``Specify 2nd-Level`` button on the SPM GUI, and for the Directory input, select the ``2ndLevel_Incongruent`` folder. Using a similar method as above, select the ``con_0003.nii`` images for each subject. Estimate the model, and load the SPM.mat file into the Results GUI. Label the contrast ``Incongruent``, and assign it a contrast weight of 1. Use the same options as you did for the Inc-Con contrast.

As an exercise, create a second-level result for the Congruent contrasts. If you examine the Incongruent and Congruent results at the same threshold, do you see what you would expect given the Inc-Con contrast that you viewed above?

.. note::

  How can you determine what the cluster threshold needs to be in order to determine whether a cluster is significant? The table underneath the glass brain shows a list of clusters that pass the thresholds you specified, and the column ``pFWE-corr`` displays the p-value associated with that cluster ("cluster-level") or individual voxel ("peak-level"). In other words, any clusters that have a corresponding pFWE-corr value of 0.05 or less can be considered statistically significant.
  The actual threshold for determining the p=0.05 cluster threshold is at the very bottom of the table, next to the string ``FWEc:``. Write down the number in that field, and then rerun your Results using that threshold. The clusters that remain should all be statistically significant.
  For alternative methods of estimating a cluster threshold, see :ref:`Appendix A 
    `, specifically the section "SPM's Cluster Correction".

When you have finished creating all of the second-level analyses, try the remaining exercises to test your understanding of what you have just learned.


Exercises
*********

1. Display the results on one of the MNI template brains using the "sections" option. Make the table show only the cluster in the dorsal medial prefrontal cortex (roughly the coordinates 5, 20, 50) by navigating to those coordinates and clicking "current cluster." Take a snapshot of those results.

2. Go back to the Results GUI, and create a contrast that tests for voxels showing significant activation for Congruent-Incongruent. Use an uncorrected p-threshlold of 0.05 and a cluster extent threshold of 20, display the results on a template brain, go to coordinates 0 32 1, and take a snapshot of your results.



Video
*****

For a video overview of group-level analysis, click `here 
     `__.

     
    
   

