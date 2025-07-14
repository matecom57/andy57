

.. _SPM_09_Análisis de ROI:

=============================
Tutorial de SPM n.° 9: Análisis del ROI
=============================

---------

Descripción general
********

Acaba de completar un análisis a nivel de grupo e identificar qué regiones del cerebro muestran una diferencia significativa entre las condiciones incongruentes y congruentes del experimento. Para algunos investigadores, esto podría ser todo lo que desean hacer.

Este tipo de análisis se denomina análisis **de cerebro completo** o **exploratorio**. Este tipo de análisis es útil cuando el experimentador no tiene una hipótesis sobre dónde podría estar la diferencia; el resultado se utilizará como base para futuras investigaciones.

Sin embargo, cuando se han realizado muchos estudios sobre un tema específico, podemos empezar a formular hipótesis más específicas sobre dónde deberíamos encontrar nuestros resultados en las imágenes cerebrales. Por ejemplo, el control cognitivo se ha estudiado durante muchos años, y se han publicado numerosos estudios de fMRI al respecto utilizando diferentes paradigmas que comparan tareas cognitivamente más exigentes con tareas cognitivamente menos exigentes. A menudo, se observan aumentos significativos en la señal BOLD durante condiciones cognitivamente exigentes en una región del cerebro conocida como **corteza prefrontal medial dorsal**, o dmPFC para abreviar. Para el estudio Flanker, entonces, podríamos restringir nuestro análisis a esta región y solo extraer datos de los vóxeles dentro de ella. Esto se conoce como análisis de **región de interés (ROI)**. Un nombre general para un análisis en el que se elige analizar una región seleccionada antes de ver los resultados de todo el cerebro se llama **análisis confirmatorio**.

Los mapas cerebrales completos pueden ocultar detalles importantes sobre los efectos que estudiamos. Podríamos encontrar un efecto significativo de incongruencia-congruencia, pero la razón podría ser que la incongruencia sea mayor que la congruencia, que la congruencia sea mucho más negativa que la congruencia, o que exista una combinación de ambas. La única manera de determinar la causa del efecto es mediante el análisis del ROI, lo cual es especialmente importante al trabajar con interacciones y diseños más sofisticados.


Uso de atlases
************

Una forma de crear una región para nuestro análisis ROI es utilizar un **atlas**, o un mapa que divide el cerebro en regiones anatómicamente distintas.

La caja de herramientas WFU PickAtlas que instalaste en el último tutorial` contiene varios atlas diferentes: dos atlas humanos, dos atlas de monos y un atlas de ratón. Seleccione la opción ``ATLAS HUMANO`` para abrir un atlas de **Áreas de Brodmann**, parcelaciones corticales basadas en su estructura tisular y organización celular. De estudios previos de control cognitivo, esperaríamos que nuestro estudio muestre actividad BOLD significativa en la región **cingulada anterior dorsal** (dACC), correspondiente al Área 32 de Brodmann. Haga clic en la región ``área de Brodmann 32`` en el menú de la izquierda y luego haga clic en el botón ``AGREGAR->`` cerca de la parte superior de la pantalla. Los cortes axiales que ve en el centro de la pantalla representan un cerebro plantilla, y los vóxeles que pertenecen a la región de trabajo que seleccionó se resaltarán en rojo. Haga clic en las flechas arriba y abajo a la derecha del cerebro para ver la extensión de la región que seleccionó.

Podría pensar que los vóxeles predeterminados de esa región están pintados en una porción de corteza demasiado delgada para capturar adecuadamente su región de interés. En ese caso, puede introducir un número en el campo "DILATE" y hacer clic en los botones "2D" o "3D" para dilatar la máscara según el número de vóxeles que especifique, ya sea en dos o tres dimensiones. Introduzca un valor de "1" y haga clic en "3D"; observe cómo cambia el tamaño y la extensión de la máscara.

.. figura:: 09_WFU_PickAtlas.png

.. nota::

	Puede agregar tantas regiones como desee a su ROI. Por ejemplo, si desea cubrir toda la región cingulada anterior, puede seleccionar las áreas de Brodmann 32 y 24. Ambos conjuntos de vóxeles se resaltarán en rojo y pertenecerán a la misma máscara al guardarlos.

Cuando esté satisfecho con la máscara generada, haga clic en el botón "GUARDAR MÁSCARA" cerca de la parte inferior de la pantalla. Etiquete la máscara como "BA_32" y guárdela en el directorio de Flanker que contiene todos sus sujetos. (Si desea organizar mejor sus datos, puede crear otro directorio llamado "Máscaras" y guardar la máscara en esa carpeta).
  

Extracción de datos de la máscara anatómica
****************************************

Una vez creada la máscara, se pueden extraer las estimaciones de contraste de cada sujeto. Hay dos maneras de extraer el contraste de interés incongruente-congruente:

1. Extraiga la estimación de contraste Incongruente-Congruente de nuestro archivo de estadísticas; o
2. Extraiga los pesos beta individuales para Incongruente y Congruente por separado, y luego tome la diferencia entre los dos.

Como veremos, la opción n.° 2 permite determinar qué impulsa el efecto; en otras palabras, si un efecto significativo se debe a que ambas ponderaciones beta son positivas, pero las ponderaciones beta incongruentes son más positivas, a que ambas ponderaciones son negativas, pero las betas congruentes son más negativas, o a una combinación de ambas. Solo extrayendo ambos conjuntos de ponderaciones beta podemos determinar esto.

Primero, haga clic en el botón Resultados en la interfaz gráfica de usuario de SPM y cargue el archivo SPM.mat de la carpeta "2ndLevel_Incongruent". Seleccione el contraste "Incongruente" y, para "Aplicar enmascaramiento", seleccione "Imagen". Cargue la imagen BA_32.nii que creó con la caja de herramientas PickAtlas de WFU y seleccione "Inclusivo" cuando se le pregunte la naturaleza de la máscara. Esto restringirá el análisis a los vóxeles dentro de la máscara, en lugar de analizar solo los vóxeles excluidos. (Esta última opción puede ser útil si tiene una máscara de un área lesionada, por ejemplo). Seleccione "No" para "Análisis de ROI" y "Ninguno" para el ajuste del valor p.

Para el umbral de valor p sin corregir, establezca el valor en "1" y el umbral de extensión en 0: esto, en efecto, no generará ningún umbral, por razones que veremos en un momento.

El cerebro de cristal ahora muestra vóxeles resaltados en la máscara BA_32 que seleccionamos. Haga clic derecho en cualquiera de los paneles del cerebro de cristal y seleccione "Ir al máximo global". Esto resaltará la ROI actual que ha creado. A continuación, haga clic derecho de nuevo y seleccione "Extraer datos -> Blanqueado y filtrado -> Este clúster". Esto generará en la terminal de Matlab una lista de cada estimación de contraste para cada sujeto, para cada vóxel de la máscara. Para que esta lista de números sea más manejable e interpretable, escriba lo siguiente:

::

	Inc = media(y,2)

Esto devuelve un conjunto de 26 números que representan la estimación del contraste para cada sujeto, promediada sobre todos los vóxeles de la ROI. A continuación, aplicaremos el mismo procedimiento para los contrastes congruentes: cargaremos el archivo SPM.mat desde el directorio ``2ndLevel_Congruent`` y seleccionaremos las mismas opciones que las anteriores. Una vez mostrados los resultados en la ROI BA_32, extraiga los datos y escriba:

::

	Con = media(y,2)
	
Ahora tenemos un par de 26 números, un par por sujeto. Podemos introducir este par en una prueba t de muestras pareadas con lo siguiente:

::
	
	[h, p, ci, estadísticas] = ttest(Inc,Con)
	
Esto devolverá cuatro variables, que representan diferentes partes de la prueba de hipótesis:

::

	h: ¿Es significativo el resultado? (0 = No; 1 = Sí)
	p: El valor p para la prueba de hipótesis
	ci: El intervalo de confianza para la estimación del contraste
	estadísticas: Estadísticas adicionales, incluyendo la estadística t, los grados de libertad y la desviación estándar
	
.. figura:: 09_Ttest_results.png

.. nota::

	Como ejercicio, realice el mismo procedimiento para los resultados de 2ndLevel_Inc-Con. Después de extraer los datos y colocarlos en una variable denominada "Inc_Con", compare los valores con el resultado obtenido al escribir "Inc-Con" (observe la diferencia entre el guion bajo y el guion). ¿Qué observa? ¿Tiene sentido?
  	
  
Extraer datos de una esfera
*****************************

Quizás haya notado que los resultados del análisis de ROI con la máscara anatómica no fueron significativos. Esto podría deberse a que la máscara ACC cubre una región muy extensa; aunque el ACC se etiqueta como una sola región anatómica, es posible que estemos extrayendo datos de varias áreas funcionales distintas. Por lo tanto, este podría no ser el mejor enfoque para el ROI.

Otra técnica se denomina enfoque de ROI esférico. En este caso, una esfera de un diámetro determinado se centra en un triplete de coordenadas x, y y z especificadas. Estas coordenadas suelen basarse en la activación máxima de otro estudio que utiliza el mismo diseño experimental o uno similar al suyo. Esto se considera un análisis **independiente**, ya que el ROI se define con base en un estudio aparte.

La siguiente animación muestra la diferencia entre las ROI anatómicas y esféricas:

.. figura:: 09_ROI_Análisis_Anatómico_Esférico.gif

Para crear este ROI, necesitaremos encontrar las coordenadas pico de otro estudio; escojamos al azar un artículo, como Jahn et al., 2016. En la sección Resultados, encontramos que hay un efecto de Conflicto para una tarea de Stroop (un diseño experimental distinto pero relacionado, también destinado a aprovechar el control cognitivo) con una estadística t máxima en las coordenadas MNI 0, 20, 44.

Para crear la esfera, utilizaremos la caja de herramientas **Marsbar** que instalamos en el capítulo anterior.
    `. Desde la GUI de SPM, haga clic en ``Caja de herramientas -> Marsbar``.

Marsbar te permite crear un ROI utilizando varios métodos diferentes, como:

1. Una esfera (que haremos en este tutorial);
2. El clúster de un resultado que usted genere;
3. Una caja con las dimensiones que usted especifique.

Para crear una esfera, haga clic en "Definición de ROI -> Construir". En el menú desplegable "Tipo de ROI", seleccione "Esfera" e introduzca las coordenadas "0 20 44". Introduzca un radio de esfera de 5 y, para los campos "Descripción de ROI" y "Etiqueta de ROI", introduzca "dACC_Sphere". Guarde el archivo en su directorio de Flanker como "dACC_Sphere_roi".

.. nota::

	En el artículo, el pico de activación se localizó técnicamente en una región denominada área motora presuplementaria o pre-SMA. Aún existe debate sobre la ubicación de estas activaciones de control cognitivo, pero para este tutorial he optado por utilizar el término dACC.

Ahora tenemos un archivo .mat que contiene la información necesaria para construir nuestra ROI esférica. Antes de generar la ROI como archivo NIFTI, haga clic en «Definición de ROI» y seleccione «Ver». Haga clic en el archivo «dACC_Sphere_roi.mat» recién creado y asegúrese de que esté ubicado en la región correcta.

.. figura:: 09_Check_ROI.png

	Examinando el ROI creado por Marsbar.
	
If the sphere is in the right place, go back to the marsbar ROI and select ``ROI definition -> Export``. In the ``Export ROI(s) to`` dropdown menu, select ``image``; from the selection menu, click on the ``dACC_Sphere_roi.mat`` file. Leave the ``Space for ROI image`` as the default (i.e., Base space for ROIs), and select the Flanker directory as the output folder. Label the image as ``dACC_Sphere``.

We now have a mask that we can use for our ROI analysis, and we can use the same method as we did in the above section on extracting data from the anatomical mask. If you do it correctly, you should get a p-value of 0.04 for a t-test of the Incongruent-Congruent contrast.

.. note::
	
	Marsbar is also capable of ROI analyses using the marsbar GUI. This procedure involves many steps, and will not be covered in this tutorial. For those interested in learning more about it, see `this blog post 
     `__.
	
	
Using the Command Line for ROI Analysis
***************************************

If you already have a mask and a contrast that you are extracting from, you can do an ROI analysis using Matlab code and SPM's spm_get_data command. The following script (which can also be downloaded `here 
      `__) requires an ROI and a contrast as arguments:

::

	function ROI_data = Extract_ROI_Data(ROI, Contrast)

	    Y = spm_read_vols(spm_vol(ROI),1);
	    indx = find(Y>0);
	    [x,y,z] = ind2sub(size(Y),indx);

	    XYZ = [x y z]';

	    ROI_data = nanmean(spm_get_data(Contrast, XYZ),2);

	end
	
The ``Contrast`` argument can be a path pointing to a contrast, such as "con_0001.nii" that was generated during either the 1st- or 2nd-level analysis. Alternatively, you can navigate into a 2nd-level directory and type ``load SPM``. This will load the SPM structure, and it contains a field called ``SPM.xY.P``: a cell array with paths to each of the contrasts that went into the 2nd-level analysis.

In our current example, navigate to the folder ``2ndLevel_Inc-Con``. Save the above code into a .m file and call it ``Extract_ROI_Data``. Then type the following:

::

	load SPM
	Extract_ROI_Data('BA_32.nii', SPM.xY.P)
	
It should return the same values as when you did the anatomical ROI analysis above for the BA32 mask.

.. note::

	The default voxel resolution is 2x2x2mm for masks created with either the wfupickatlas or marsbar toolbox. In order to use the script above, this voxel resolution needs to match the resolution of the data you are extracting from. For example, if you specified a resampling resolution of 3x3x3 during the normalization preprocessing step, you will need to `resample 
       `__ the mask so that the voxel dimensions match. The following image shows how to use SPM's ``Coregister (Reslice)`` command to resample the BA_32 ROI. The resliced image will have an "r" prepended to it:
	
.. figure:: 09_ROI_Reslice.png
	
	
Biased Analyses
***************

When performing an ROI analysis, make sure that the ROI isn't **biased**, or artificially inflating the parameter estimates that you extract. In a nutshell, a biased analysis uses an ROI that is defined by the data that you are analyzing - for example, it only consists of voxels that pass a high statistical threshold. An unbiased ROI (also known as an **independent ROI**) is not defined by the data in your study, and can either be created from an atlas or by the results of another study. For more details on the difference between the two types of analyses, see :ref:`Appendix B 
        
         `. A demonstration of how to do a biased analysis in SPM may help you better understand this concept. Load the 2nd-level results for the Inc-Con contrast, and use the previous thresholds of an uncorrected voxel-wise threshold of p=0.001 and a cluster threshold of 20. When the results are displayed, drag the crosshair to the cluster in the dACC and click the ``current cluster`` button. (This will snap the crosshairs to the peak voxel within this cluster; if you did it correctly, the peak coordinates should be about ``6, 23, 53``.) Click on the ``save`` dropdown menu, and select ``current cluster``. Call the output file ``dACC_001``. Now use this file as a mask for an ROI analysis, following the steps you completed earlier. How does the significance of the contrast estimates from this cluster compare to the significance of the data you extracted using an anatomical approach? A spherical ROI approach? Why? To help you with articulating the reason for the large difference in the results, reread Appendix B and also watch `this video 
         
          `__. .. nota:: El mismo enfoque de ROI sesgado puede implementarse sin crear una máscara; simplemente puede umbralizar el contraste como lo haría normalmente al realizar un análisis de cerebro completo, resaltar el grupo de interés y extraer los datos como de costumbre. El propósito de guardar el grupo umbralizado como máscara fue familiarizarlo con las funciones de guardado de SPM y tener las máscaras disponibles en caso de que desee usarlas con otro programa, como AFNI. ------- Ejercicios ********* 1. Cree una máscara anatómica de una región de su elección y compruebe si el contraste de Inc-Con es significativo dentro de esa ROI. Muestre una figura que muestre la ROI y los resultados del comando ttest. (NB: Al evaluar el valor p, tenga en cuenta cuántas ROI está utilizando para probar el mismo contraste: a medida que aumenta el número de pruebas, su valor p debe volverse proporcionalmente más conservador. Una buena guía a seguir es utilizar la corrección de Bonferroni en función del número de ROI que pruebe; p. ej., si prueba dos ROI, divida el valor p por 2, para un nivel alfa corregido de 0,025). 2. Utilice el código proporcionado en la sección sobre análisis de ROI esférico para crear una esfera con un radio de 7 mm ubicada en las coordenadas MNI 36, -2, 48 y extraiga los datos para el contraste "Inc-Con" de esta región. Incluya una figura que muestre la ROI que utilizó, ya sea con la función Display de SPM o con la función "View ROI" de Marsbar. Muestre los datos que se extrajeron de esta ROI (es decir, una lista de la estimación de contraste promedio por cada sujeto, utilizando el código "mean(y,2)" anterior). 3. Realice un análisis de ROI sesgado creando una máscara cingulada anterior dorsal a partir del contraste Inc-Con, con un umbral por vóxel de p = 0,0005 y un umbral de clúster de 20. Guarde la máscara como ``dACC_0005``. Al extraer los datos, ¿cómo se comparan con su análisis sesgado anterior, utilizando una máscara con un umbral de p = 0,001? ¿Por qué? Muestre el código que utilizó y copie y pegue el resultado de su prueba t (p. ej., con el código: ``[h, p, ci, stats] = ttest(Inc_Con_0005)``, por ejemplo). -------- Vídeo ***** Para ver un tutorial en vídeo sobre el análisis de ROI en SPM, haga clic aquí.
          
           `__.
          
         
        
       
      
     
    
   

