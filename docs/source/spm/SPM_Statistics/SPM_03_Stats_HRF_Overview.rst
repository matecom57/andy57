

.. _SPM_03_Estadísticas_HRF_Resumen:

==================================================
Capítulo 3: La función de respuesta hemodinámica (HRF)
==================================================

--------------

De la Respuesta AUDAZ al HRF
*********************************

En el capítulo anterior, leyó sobre varias suposiciones sobre la representación de la señal BOLD; otra suposición que hacemos es cómo se ve la respuesta BOLD. Esto es importante no solo para modelar la relación entre la actividad neuronal y el flujo sanguíneo, y de ahí a la señal observada, sino también para definir un **modelo** que permita evaluar qué regiones cerebrales muestran un cambio significativo en su respuesta BOLD a un estímulo dado.

En la década de 1990, estudios empíricos de la señal BOLD demostraron que, tras la presentación de un estímulo al sujeto, cualquier parte del cerebro que respondiera a dicho estímulo (por ejemplo, la corteza visual en respuesta a un estímulo visual) mostraba un aumento en la señal BOLD. La señal BOLD también parecía seguir una forma constante, alcanzando su punto máximo alrededor de los seis segundos y luego descendiendo a su valor basal durante los segundos siguientes. Esta forma se puede modelar con una función matemática denominada **Distribución Gamma**. Cuando la Distribución Gamma se crea con parámetros que se ajustan mejor a la respuesta BOLD observada en la mayoría de los estudios empíricos, la denominamos Función de Respuesta Hemodinámica Canónica o **HRF**.

Cuando se aplica a datos de fMRI, la distribución gamma se denomina **función base**. La llamamos función base porque es el elemento fundamental, o base, del modelo que crearemos y ajustaremos a la serie temporal de datos. Además, si conocemos la forma de la distribución en respuesta a un estímulo muy breve, podemos predecir cómo debería ser en respuesta a estímulos de duración variable, así como a cualquier combinación de estímulos presentados a lo largo del tiempo. A continuación, se ilustra cada caso.

La HRF para un estímulo de impulso único
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Si la duración de un estímulo es muy corta, como un chasquido de dedos, podemos decir que es un **estímulo impulsivo**; es decir, no tiene duración. Como se puede observar en la siguiente figura, la forma de la señal BOLD se asemeja a una distribución gamma típica, con un pico cerca del inicio del eje temporal (es decir, el eje x) y una cola larga a la derecha.

.. figura:: 05_03_HRF_SingleStim.png
  :escala: 30%

  La frecuencia cardíaca (HRF) generada por un único estímulo de impulso. En esta figura, el estímulo ocurre en el punto 0 del eje x.
  
El HRF para un estímulo de un solo vagón
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Aunque muchos estudios utilizan estímulos que duran solo un segundo o menos, algunos presentan estímulos durante periodos más largos. Por ejemplo, imaginemos que el sujeto observa un tablero de ajedrez parpadeante durante quince segundos. En este caso, la forma de la frecuencia de resonancia magnética (HRF) será más dispersa, con un pico sostenido proporcional a la duración del estímulo, que volverá a la línea base solo después de que este haya finalizado. Este estímulo se denomina **estímulo de vagón de tren**, porque se asemeja a un vagón de tren.

En este caso, la distribución gamma se **convoluciona** con el estímulo de vagón. La convolución consiste en promediar dos funciones a lo largo del tiempo; como resultado, la distribución gamma se amplía al promediarse con el estímulo de vagón y vuelve a su valor inicial al retirarse el estímulo.

.. nota::

  En el caso de un solo impulso, la distribución gamma también se convoluciona con un estímulo. Dado que un estímulo de impulso es infinitesimalmente pequeño, se representa como una línea vertical en el eje del tiempo. Por eso a veces se le denomina **función de varilla**.


.. figura:: 05_03_HRF_DurationStim.png
  :escala: 70%
  
  Ilustración de la frecuencia de pulso (HRF) generada por un estímulo de tipo vagón de carga que dura quince segundos. Observe que la señal BOLD comienza a descender a la línea base alrededor de los quince segundos.


¿Qué pasa si los HRF se superponen?
^^^^^^^

Hemos visto cómo se ve la señal BOLD tras la presentación de un estímulo y cómo la HRF modela la forma de dicha señal. Pero ¿qué ocurre si se presenta otro estímulo antes de que la respuesta BOLD del estímulo anterior haya vuelto a la línea base?
  
En ese caso, las HRF individuales se suman. Esto crea una respuesta BOLD, que es un promedio móvil de las HRF individuales, y la forma de la señal BOLD se vuelve más compleja a medida que se presentan más estímulos próximos entre sí.

.. figura:: 05_03_HRF_Sum.png
  :escala: 30%
  
  Convolución de las HRF para estímulos individuales. La respuesta general en negrita (azul) es una media móvil de las HRF individuales, delineadas en negro, rojo y verde. Las líneas negras verticales en el eje x representan los estímulos impulsivos. Figura creada por Bob Cox de AFNI.

Juntándolo todo: animaciones de cada caso
*********

Para ayudarte a comprender lo que acabas de leer, mira la siguiente animación un par de veces. Mostrará cómo se desarrolla cada uno de los casos descritos a lo largo del tiempo, lo que facilitará tu comprensión.

.. figura:: 05_03_HRF_Demo.gif

  Animaciones creadas originalmente por Bob Cox de AFNI.
  
---------


Ceremonias
*********

En este capítulo, los términos "función de respuesta hemodinámica" y "señal BOLD" se utilizaron para representar ideas similares, pero distintas. ¿Cómo definiría cada uno de estos términos con sus propias palabras?

2. Utilice `este subprograma`__ para practicar la convolución de diferentes formas. Para replicar la convolución de la función de impulso con el HRF, por ejemplo, configure la señal de entrada como "Impulso de Dirac" y la señal de salida como "personalizada" y trace la forma de una función gamma con el ratón. Pruebe también a configurar la señal de entrada como "Rectángulo" e intente ampliar y reducir la forma.


.. nota::

  Los conceptos que acaba de aprender probablemente sean más difíciles de comprender que los que ya ha aprendido en este curso. Incluso si no comprende del todo la HRF y la convolución, continúe con el resto del módulo. Después de leer los capítulos restantes y realizar los ejercicios prácticos, vuelva a este capítulo para ver si le resulta más claro.



