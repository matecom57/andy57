

.. _Apéndice_G_Inferencia Inversa:

=============================
Apéndice G: Inferencia inversa
=============================

------------------

Descripción general
********

Imagina que ves un mapa de activación fMRI similar al siguiente:

.. figure:: ApéndiceG_ActividadMotriz.png

Suponiendo que este es el único grupo que mostró actividad BOLD significativa, y sin conocer el experimento del que provienen estos datos, ¿qué asumiría que estaba haciendo el sujeto en ese momento? ¿Asumiría que estaba escuchando un audiolibro o que estaba mirando un tablero de ajedrez parpadeante? ¿Cuál sería su mejor estimación?

La mayoría de los neuroimagenólogos pensarían que el sujeto estaba realizando algún tipo de movimiento con la mano o los dedos. De hecho, esta imagen proviene de un contraste entre las pulsaciones del botón izquierdo y el derecho, una forma fiable de obtener una actividad cerebral intensa en la corteza motora derecha. Por supuesto, esta no es la única condición que podría crear un mapa de contraste de este tipo; podría ser que el sujeto simplemente imaginara hacer algo con la mano izquierda, o podría ser que sintiera algún tipo de estimulación en esa mano, y debido a una normalización imperfecta y a un núcleo de suavizado grande, el grupo podría solaparse con la corteza motora y las cortezas somatosensoriales. En este caso, sin embargo, el rango de posibilidades es relativamente pequeño y las probabilidades de acertar son bastante altas.

Ahora imaginemos que vemos un mapa de contraste en NEGRITA que se ve así:

.. figure:: ApéndiceG_PainActivity.png

¿Qué supondría ahora sobre lo que el sujeto estaba haciendo o experimentando? Esto se vuelve más difícil, ya que se trata de un patrón que podría obtenerse en muchos escenarios diferentes: Se sabe que la coactivación de la corteza cingulada anterior dorsal y la ínsula anterior bilateral se activa en respuesta al control cognitivo, el dolor, la prominencia, la sorpresa y otros fenómenos psicológicos comunes que se estudian mediante fMRI.

Al suponer que uno de estos estímulos condujo al mapa de activación cerebral que observamos, utilizamos una técnica llamada **inferencia inversa**; es decir, se nos presenta un resultado o un estado final e inferimos la causa a partir de los datos que recibimos. Este tipo de deducciones se realizan en la vida cotidiana: vemos a alguien toser y estornudar, y asumimos que está resfriado, aunque existen otras posibilidades, como una alergia. Nos despertamos y descubrimos que el suelo está mojado, y concluimos que debió de llover anoche, aunque también podría ser que el sistema de riego estuviera activado.

Al aplicarlo a la neuroimagen, este problema se vuelve más complejo, tanto por el ruido inherente de los datos como porque muchas regiones del cerebro muestran una actividad BOLD significativa en más de una condición. Además, hay mucho en juego, ya que la neuroimagen es una tecnología costosa: las instituciones de investigación suelen facturar entre 500 y 1000 dólares por hora, y eso antes de la inflación. Además, existe un creciente interés en el uso de la fMRI como herramienta para leer la mente, es decir, decodificar, a partir de los patrones de activación cerebral, lo que una persona pensaba o sentía. Por ejemplo, un tema que surge con frecuencia es si las imágenes de fMRI pueden utilizarse como herramienta para la detección de mentiras y si deberían ser admisibles en los tribunales.

En general, la inferencia directa proporciona conclusiones más sólidas, ya que controlamos las condiciones que experimenta el sujeto y, si el experimento está bien diseñado, consideramos cualquier posible factor de confusión, lo que nos permite descartar explicaciones alternativas. La inferencia inversa, por otro lado, es más susceptible a interpretaciones sesgadas si no somos cuidadosos.

Por ejemplo, un estudio de Nam et al. (2020) correlacionó el volumen de materia gris de la amígdala con la probabilidad de participar en una protesta. Un mayor volumen de la amígdala se asoció con una menor probabilidad de participar en una protesta política, y la razón es de interpretación abierta. Sin embargo, si se midiera la amígdala de un individuo y se observara que es excepcionalmente pequeña, no se podría concluir que la persona participó en una protesta política; intervienen demasiadas otras variables potenciales, y la capacidad explicativa de la materia gris de la amígdala, por sí sola, es bastante baja.

Usos de la inferencia inversa
*************************

Entonces, ¿cuándo se justifica la inferencia inversa y cuándo es sospechosa? Russ Poldrack abordó estas preguntas en su artículo de 2006.`__ en *Tendencias en Ciencias Cognitivas*. En resumen, siempre es necesario tener en cuenta la **tasa base** de activación para una región determinada. La corteza cingulada anterior, por ejemplo, tiene una tasa base de activación del 20 %: es decir, el 20 % de los estudios han encontrado activación en esta región, y dentro de este 20 % de estudios, se observó una amplia gama de diseños experimentales. Si se utiliza esto como probabilidad previa, existe una alta probabilidad de que la actividad en esa región represente algo distinto de lo que se cree.

Sin embargo, sus conclusiones pueden ser más precisas al analizar otras evidencias. Si contara con una medida conductual, como el tiempo de reacción o el seguimiento ocular, podría argumentar de forma más convincente una inferencia que otra. Por ejemplo, la respuesta galvánica de la piel de un participante suele ser mucho mayor ante estímulos dolorosos y estresantes que, por ejemplo, ante un estímulo nuevo que no es ni doloroso ni estresante. Si observara una respuesta galvánica de la piel constantemente alta mientras el sujeto exhibía una mayor actividad de BOLD en la corteza cingulada anterior, podría afirmar con mayor contundencia que el sujeto probablemente experimentaba dolor o estrés.

Esto nos lleva a una idea relacionada llamada **selectividad**: si una región cerebral está activa solo para una condición, y para ninguna otra, entonces es selectiva. Cuantas más condiciones o procesos cognitivos activen una región dada, menos selectiva será para cualquier proceso en particular. Esto es importante para comprender la arquitectura funcional del cerebro, incluyendo si puede haber redundancias y por qué, y si una región es necesaria para un proceso dado. Generalmente, la única forma infalible de determinar si una región cerebral es necesaria para un proceso dado es mediante estudios de lesiones o mediante un proceso que interrumpa temporalmente la actividad neuronal en una región localizada, por ejemplo, mediante estimulación magnética transcraneal. Sin embargo, a falta de este tipo de estudios, necesitamos utilizar estudios bien diseñados y controlados, y también podemos utilizar conjuntos de datos a gran escala para realizar mejores predicciones sobre la tasa base de activación para una región dada. Esto también tiene sus inconvenientes, ya que ciertos términos pueden estar sobrerrepresentados debido a las tendencias en el campo o usarse indiscriminadamente. En otra parte, Russ Poldrack ha abogado por una ontología cognitiva, un tipo de diccionario que utiliza términos específicos para distinguir entre diferentes procesos cognitivos; sin embargo, esto no parece haber encontrado aún mucho apoyo.

En cualquier caso, ¿qué debería hacer al interpretar sus resultados y escribir lo que significan en la sección de discusión de su artículo? Primero, tenga alguna perspectiva sobre la tasa base de la región y el término que está mirando. Si encuentra un efecto significativo en la amígdala para su estudio, por ejemplo, escriba ese término en un paquete de metaanálisis como Neurosynth. El mapa resultante mostrará dónde la mayoría de los estudios informan la activación de la amígdala; luego, haga clic en el centro de masa para el mapa de metaanálisis y haga clic en el botón ``Estudios``. Verá una lista de todos los estudios que se utilizaron para crear este mapa de metaanálisis; tenga en cuenta que dentro de los primeros diez estudios que se muestran (de más de 1500), vemos una gama de diferentes diseños de tareas que obtuvieron efectos en esta región, como valencia positiva y negativa, caras emocionales, miedo y confiabilidad de las caras. Otros que podrían enumerarse incluyen disgusto, saliencia y novedad. Claramente, si se hace una afirmación sólida sobre el efecto que representa el estudio, se necesitará un diseño de estudio lo suficientemente sólido como para descartar todas las alternativas. De lo contrario, cualquier inferencia *post hoc* probablemente estará sesgada por la narrativa que se considere más convincente, una falacia común en todos los campos de la ciencia y en nuestra vida cotidiana.

.. figure:: ApéndiceG_EstudiosDeLaAmígdala.png

  Lista de estudios de Neurosynth.org asociados con el término de búsqueda "amígdala". De más de 1500 estudios, solo los primeros cinco de la lista muestran que diversos estudios pueden provocar la activación de la amígdala.

Recomendaciones
***************

Con todas estas posibles falacias, conviene estar en guardia contra las explicaciones que parecen demasiado pulcras, demasiado fáciles y demasiado evidentes en consonancia con la hipótesis del investigador. Una cosa es concluir tentativamente que un resultado podría significar una cosa entre muchas explicaciones posibles; otra muy distinta es hacer afirmaciones generalizadas sobre lo que representa un mapa cerebral, generalmente resumidas en un solo término, sin considerar ninguna de las alternativas. Al llegar a la sección de discusión de un artículo, como siempre, hay que preguntarse: ¿Esta conclusión está respaldada por la evidencia? ¿Qué otras explicaciones posibles existen? ¿El estudio se diseñó para descartar estas alternativas? ¿Es cierto que esta mancha que veo en esta figura respalda la hipótesis del autor y nada más?

Asimismo, al escribir su propio manuscrito, tómese su tiempo para reflexionar sobre los inconvenientes mencionados anteriormente. En algunos casos, podría no ser posible distinguir entre dos posibles causas, ya sea por el diseño del estudio o porque no se recopilaron otras mediciones de comportamiento; sea franco al respecto e informe la mayor cantidad de datos relevantes. (También puede resultarle útil destacar todos los efectos de un mapa determinado, a la vez que se describen los estadísticamente significativos; véase Taylor et al. (2023))
    `__ para obtener instrucciones sobre cómo hacerlo.) Y si va a afirmar la selectividad de una región, asegúrese de diseñar su estudio de forma que pueda realizar disociaciones dobles, lo que demuestra que una condición es significativa en una región específica pero no en otra, y viceversa para una condición distinta. El método para hacerlo, junto con los criterios para afirmar una disociación doble, se puede encontrar en este artículo de `Richard Henson (2006) 
     `__.

.. figure:: ApéndiceG_Henson_DobleDisociación.png

  Figura I de Henson, 2006, que ilustra diferentes tipos de disociaciones dobles, junto con pistas falsas que no son disociaciones dobles verdaderas. Por ejemplo, el panel C es técnicamente una disociación con un efecto de interacción, pero dado que las condiciones C1 y C2 prácticamente no tienen señal, es una disociación trivial; piense en usar los ventrículos como región de control, por ejemplo. Los tres paneles en la parte inferior (D, E y F) muestran diferentes patrones de disociaciones dobles, que generalmente incluyen: 1) Un efecto de C1 en la región R1; 2) un efecto de C2 en la región R2; 3) Una diferencia significativa de C1>C2 en R1; 4) Una diferencia significativa de C2>C1 en R2; y 5) Un término de interacción Condición x Región. Las disociaciones dobles son una herramienta eficaz para delinear la arquitectura funcional del cerebro.

Epílogo: ¿Qué métodos son más adecuados para la decodificación neuronal?
**************************************************************

De cara al futuro, los enfoques multivariados podrían ser una mejor manera de realizar inferencias más sólidas sobre lo que una persona estaba pensando o haciendo en un momento determinado. Estos enfoques, como el análisis de patrones multivóxel o MVPA, utilizan patrones de actividad para clasificar los estados cerebrales. Por ejemplo, en el artículo de 2001 de Haxby et al., se descubrió que se podían utilizar patrones distintivos de actividad neuronal para distinguir entre los mapas BOLD adquiridos cuando el sujeto miraba una cara y otras categorías, como gatos, sillas y casas. Desde entonces, este método se ha perfeccionado y ampliado para clasificar con precisión los estímulos naturalistas, como la parte de una película que estaba viendo el sujeto. Esta área de investigación aún está en desarrollo, pero muestra indicios prometedores de convertirse en las herramientas que utilizan los neuroimagenólogos para decodificar lo que un sujeto estaba pensando o haciendo.

     
    
   

