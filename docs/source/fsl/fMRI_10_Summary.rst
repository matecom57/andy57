

.. _fMRI_10_Resumen:

Tutorial de fMRI n.° 10: Resumen
==================

Hemos llegado al final de nuestro curso de fMRI. Es un buen momento para tomar un descanso y relajarse. Puede ser por unas horas o semanas; pero cuando te sientas listo, regresa y reflexiona sobre lo aprendido.

----------

Conceptos básicos de fMRI
*********

El conjunto de datos que analizamos es relativamente simple: tenía dos condiciones y ya teníamos una buena idea de dónde encontraríamos un resultado significativo.

Sin embargo, aprendiste muchos conceptos importantes aplicables a cualquier estudio de fMRI. Aquí tienes una lista de algunos:

1. Las imágenes fMRI, o **volúmenes**, se recopilan y se unen como cuentas en un collar para crear **series** de datos funcionales. Cada uno de estos volúmenes es una imagen tridimensional compuesta por pequeños cubos tridimensionales llamados **vóxeles**. La señal medida en cada vóxel a lo largo de toda la serie se denomina **serie temporal**, que es una medida indirecta de la actividad neuronal, indexada por la **señal BOLD**.

2. Al igual que las imágenes digitales que tomamos con un teléfono o una cámara, limpiamos nuestras imágenes de fMRI con **preprocesamiento**. Los pasos básicos del preprocesamiento incluyen la corrección de la sincronización de cortes, la corrección de movimiento, el suavizado y el filtrado temporal. Estos se trataron en el capítulo sobre preprocesamiento.`.

3. Tras depurar las imágenes, **ajustamos un modelo** a la serie temporal. Esto implicó crear un modelo, o **serie temporal ideal**, de cómo creíamos que debería verse la señal BOLD en un vóxel, dados nuestros **tiempos de inicio** que indican qué evento ocurrió en qué momento. Posteriormente, convolucionamos estos tiempos de inicio con una función matemática llamada **Función de Respuesta Hemodinámica**, un modelo de cómo creemos que la señal BOLD en el cerebro aumenta y disminuye en respuesta a un estímulo. Todo esto se trató en el capítulo sobre modelado estadístico.
    `.

4. Luego creamos un script para automatizar el análisis de todos nuestros sujetos. Esto requirió aprender bastante código Unix, pero el esfuerzo valió la pena: aprender un poco sobre scripting puede ahorrarte incontables horas de trabajo pesado.

5. Una vez preprocesado cada sujeto y ajustado el modelo estadístico a su serie temporal, pudimos realizar análisis de segundo y tercer nivel. El análisis de segundo nivel promedió las estimaciones de contraste dentro de cada sujeto, y el análisis de tercer nivel realizó un análisis a nivel de grupo para todas estas estimaciones de contraste promediadas.

6. Una vez completados los análisis de alto nivel, teníamos dos opciones: 1) Realizar un **análisis exploratorio**, en el que analizamos cada modelo en cada vóxel del cerebro y visualizamos los mapas cerebrales completos resultantes; o 2) Realizar un **análisis de ROI**, en el que nos centramos en un subconjunto de vóxeles del cerebro, extrayendo estimaciones de contraste para cada sujeto y, posteriormente, realizando un análisis estadístico de esas cifras. Ambos tipos de análisis pueden utilizarse en un mismo estudio para mostrar el alcance de los resultados cerebrales completos y centrarse en análisis confirmatorios más específicos.

------------

Tómate un tiempo para revisar cada uno de estos pasos e incluso puedes ejecutar todo el análisis desde cero. Ponte a prueba para ver si puedes hacerlo de memoria. Te recomiendo escribir o decir en voz alta por qué estás haciendo cada paso al hacerlo, para reforzar los conceptos de cada parte del análisis. Cuando te sientas más seguro analizando datos de fMRI por tu cuenta, prueba a analizar otro conjunto de datos en openneuro.org. El mayor y más gratificante reto, por supuesto, será aplicar estos conceptos a tus propios datos de fMRI.

¡Buena suerte!

    
   

