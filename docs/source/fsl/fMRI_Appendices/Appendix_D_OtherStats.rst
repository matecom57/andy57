

.. _Apéndice_D_Otras estadísticas:

=========================
Apéndice D: Otros escenarios estadísticos
=========================

---------------------


Desempacando un contraste
********************

Una vez realizado un análisis de ROI para un contraste, deberá determinar qué lo **impulsa**. Por ejemplo, supongamos que tiene una tarea motora simple en la que el participante presiona un botón con el dedo izquierdo o el derecho. Recopila varios ensayos con el dedo izquierdo y con el derecho, y luego los contrasta. Para un contraste de izquierda a derecha, por ejemplo, encuentra una diferencia positiva significativa en la corteza motora derecha.

Lo primero que viene a la mente al observar una diferencia significativa es que la activación en la condición izquierda fue mayor que en la condición derecha (véase la figura a continuación, panel A). Esto podría ser así; pero también podría ser que la actividad en la condición izquierda fuera cercana a cero, y en la condición derecha, negativa (panel B). O podría ser una combinación de ambas (panel C). Incluso podría darse el caso de que ambas condiciones tuvieran una activación negativa con respecto al valor inicial, pero que la condición izquierda fuera simplemente menos negativa que la condición derecha.


.. figure:: ApéndiceD_UnpackContrast.png
  
  Las estimaciones de contraste extraídas del ROI de la corteza motora derecha muestran una diferencia significativa entre la actividad BOLD para la condición izquierda y la derecha (amarillo). Los tres paneles de la derecha representan tres escenarios que podrían causar la diferencia observada en el contraste. La única manera de determinar cuál de estos escenarios es el verdadero es extraer los pesos beta para cada condición por separado.
  
En este caso, necesitaríamos dos ROI para extraer. (También se podrían realizar disociaciones triples con tres condiciones y tres ROI, pero no las abordaremos aquí). Usando nuestra tarea Flanker"A modo de ejemplo, extraeremos pesos beta para las condiciones Congruente e Incongruente de dos ROI: una en la corteza prefrontal medial y otra en el giro frontal inferior izquierdo.
  
En AFNI
^^^^^^^

Primero crearemos nuestros ROI usando 3dUndump:

::
  # Crear el ROI de mPFC
  echo "0 20 44" | 3dUndump -orient LPI -master Congruent_betas+tlrc -srad 5 -prefix ConflictROI+tlrc -xyz -
  

Luego podemos extraer datos de cada uno de los ROI usando 3dmaskave, usando la redirección para guardar la salida en archivos de texto separados y luego uniéndolos con el comando ``pegar``:

::

  3dmaskave -quiet -mask ConflictROI+tlrc. Incongruent_betas+tlrc. > Inc_ConflictROI.txt
  3dmaskave -quiet -mask ConflictROI+tlrc. Congruent_betas+tlrc. > Con_ConflictROI.txt
  pegar Inc_ConflictROI.txt Con_ConflictROI.txt > mPFC_Inc_Con.txt
  echo -e "Inc_Conflict\tCon_Conflict\tInc_LIFG \tCon_LIFG" | cat - mPFC_Inc_Con.txt > tmp.txt #Añadir encabezados
  mv tmp.txt mPFC_Inc_Con.txt
  rm Inc*ROI.txt
  rm Con*ROI.txt

Si abre el archivo ``DoubleDissTest_mPFC_LIFG_Inc_Con.txt`` en Excel

Luego puede abrir el archivo ``DoubleDissTest_mPFC_LIFG_Inc_Con.txt`` en un paquete estadístico como R y graficar la siguiente interacción:



Disociaciones dobles
*******************

Analizar un contraste permite ver qué lo impulsa; pero ¿qué ocurre si se utilizan varias regiones de interés (ROI)? Podemos extender esta misma lógica de análisis de contraste a las ROI, examinando el patrón de actividad para cada condición dentro de cada ROI. Utilizando nuestro ejemplo anterior de pulsaciones de botón izquierdo y derecho, podemos observar una mayor activación para las pulsaciones del botón izquierdo en la corteza motora derecha, y una mayor activación para las pulsaciones del botón derecho en la corteza motora izquierda. Si observamos diferencias significativas entre las condiciones en ambas regiones y una interacción significativa entre condición y ROI, decimos que existe una **doble disociación**: la actividad es mayor en una región para una condición, mientras que se observa el patrón opuesto en la otra región.

Las disociaciones dobles son útiles para determinar la **selectividad** de una región para una condición en comparación con otra; en otras palabras, si configuramos un experimento que coincide con ambas condiciones excepto en un aspecto (en este ejemplo, qué botón presiona el sujeto), podemos determinar que la región se activa selectivamente para una condición *y no para otra estrechamente relacionada*. Las disociaciones dobles son relativamente raras de encontrar, pero son muy útiles para avanzar teorías sobre la función de regiones específicas del cerebro.

.. figure:: ApéndiceD_DobleDisociación.png



En AFNI
^^^^^^^

Primero crearemos nuestros ROI usando 3dUndump:

::

  # Crear el ROI de mPFC
  echo "0 20 44" | 3dUndump -orient LPI -master Congruent_betas+tlrc -srad 5 -prefix ConflictROI+tlrc -xyz -
  
  # Crear el ROI de LIFG
  eco "-44 -21 7" | 3dUndump -orient LPI -master Congruent_betas+tlrc -srad 5 -prefijo LIFG_ROI+tlrc -xyz -
  

Luego podemos extraer datos de cada uno de los ROI usando 3dmaskave, usando la redirección para guardar la salida en archivos de texto separados y luego uniéndolos con el comando ``pegar``:

::

  3dmaskave -quiet -mask ConflictROI+tlrc. Incongruent_betas+tlrc. > Inc_ConflictROI.txt
  3dmaskave -quiet -mask ConflictROI+tlrc. Congruent_betas+tlrc. > Con_ConflictROI.txt
  3dmaskave -quiet -mask LIFG_ROI+tlrc. Incongruentes_betas+tlrc. > Inc_LIFG_ROI.txt
  3dmaskave -quiet -mask LIFG_ROI+tlrc. Congruentes_betas+tlrc. > Con_LIFG_ROI.txt
  pegar Inc_ConflictROI.txt Con_ConflictROI.txt Inc_LIFG_ROI.txt Con_LIFG_ROI.txt > DoubleDissTest_mPFC_LIFG_Inc_Con.txt
  echo -e "Inc_Conflict\tCon_Conflict\tInc_LIFG \tCon_LIFG" | cat - DoubleDissTest_mPFC_LIFG_Inc_Con.txt > tmp.txt #Añadir encabezados
  mv tmp.txt DoubleDissTest_mPFC_LIFG_Inc_Con.txt
  rm Inc*ROI.txt tmp.txt
  rm Con*ROI.txt

Si abre el archivo ``DoubleDissTest_mPFC_LIFG_Inc_Con.txt`` en Excel

Luego puede abrir el archivo ``DoubleDissTest_mPFC_LIFG_Inc_Con.txt`` en un paquete estadístico como R y graficar la siguiente interacción:

   

