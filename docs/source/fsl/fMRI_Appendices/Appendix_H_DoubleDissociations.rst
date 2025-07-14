

.. _Apéndice_H_Dobles Disociaciones:

================================
Apéndice H: Disociaciones dobles
================================

------------------

Descripción general: asociaciones vs. disociaciones
****************************************

La mayoría de los estudios de neuroimagen informan que una condición experimental provocó la activación en una región cerebral específica. Este tipo de resultado se denomina **asociación**: dada la condición X, observamos activación en la región cerebral Y. Por eso, muchas publicaciones comienzan con la frase «Los correlatos neuronales de...», seguida del proceso cognitivo estudiado.

Este tipo de estudios puede ser interesante, pero si solo se reportan asociaciones, nuestra información sobre la arquitectura funcional del cerebro es limitada. Además, centrarse únicamente en las asociaciones puede ocultar diferencias importantes en la actividad cerebral dentro de una región dada en diferentes condiciones. En el apéndice anterior sobre inferencia inversa.Discutimos la inferencia de resultados mediante la observación de un estado final y la posterior conclusión sobre qué condujo a dicho resultado. Esto es especialmente común en estudios exploratorios de asociación, que no se basan en hipótesis y, por consiguiente, son más susceptibles a inferencias inversas erróneas; es decir, favorecer una causa específica debido a un sesgo propio, aunque existan otras causas potenciales que también podrían ser válidas. Un observador externo, ajeno al diseño del experimento, también tiene mayor probabilidad de ser persuadido por inferencias inversas erróneas si desconoce cómo se construyó el experimento.

En este capítulo, nos centramos en un artículo de Richard Henson (2006) que analiza cómo utilizar la **inferencia directa** para inferir **disociaciones**; es decir, adoptamos la perspectiva de quien diseña un estudio para utilizar una causa específica para obtener un efecto específico y descartar todas las demás alternativas posibles. Este enfoque implica supuestos, como la **inserción pura**, que supone que la inclusión de una condición no afecta a las demás. En realidad, es probablemente más complejo, con posibles efectos de interacción entre las condiciones; por ejemplo, la inclusión de una tarea de memoria de trabajo además de una tarea de Flanker podría provocar aumentos no lineales en el esfuerzo cognitivo general durante una sesión de escaneo, o efectos indirectos no deseados de una tarea a otra, como que una tarea de memoria de trabajo se vuelva más difícil si se realiza inmediatamente después de una tarea de Flanker. (Véase también, por ejemplo, el efecto Gratton).

Ejemplos de disociaciones
*************************

Uno de los ejemplos más famosos de disociación fue el del paciente HM, a quien se le extirparon grandes secciones del hipocampo y parahipocampo para aliviar sus ataques epilépticos. Tras la intervención, aún podía recordar recuerdos a largo plazo previos a la cirugía, pero no podía formar nuevos recuerdos episódicos posteriormente, lo que lleva a creer que el hipocampo desempeña un papel necesario en la formación de nuevos recuerdos, pero no en la retención de los ya formados.

Los estudios de lesiones del área de Broca y del área de Wernicke —que corresponden aproximadamente a la circunvolución frontal inferior izquierda y la circunvolución temporal posterosuperior izquierda— ilustran una **doble disociación**. En este caso, la lesión del área de Broca provoca una **afasia no fluente**, es decir, la incapacidad o dificultad extrema para hablar o escribir. La lesión del área de Wernicke, por otro lado, provoca una **afasia fluente**, en la que el paciente puede hablar y escribir, pero de forma desordenada y aleatoria. Esto ha llevado a los neurocientíficos a considerar que estas áreas contribuyen a funciones lingüísticas similares, pero distintas (es decir, la producción versus la comprensión del lenguaje), lo que enriquece nuestra comprensión de la arquitectura funcional del cerebro.

Diferencias cualitativas en los datos de fMRI
************************************

Sin embargo, en ausencia de estudios de lesiones, aún podemos establecer disociaciones mediante neuroimagen funcional. Según Richard Henson, esto se logra mejor midiendo **diferencias cualitativas**. En esta figura, extraída de su artículo, vemos que simplemente encontrar una diferencia en la respuesta BOLD entre dos condiciones (por ejemplo, Condición A > Condición B, en la Región R1) no sugiere en sí mismo que esta región sea selectiva para la Condición A y no para la Condición B; una prueba más sólida sería compararlas directamente mediante una prueba t de muestras pareadas. Y para reforzar aún más su afirmación, debería seleccionar una región contrastante o de control (llamémosla R2) y realizar las mismas pruebas. Si se obtiene el mismo patrón de resultados, esto sugiere que la activación de la Condición A es general (al menos en dos regiones) y, por lo tanto, impide cualquier conclusión sobre la selectividad de esa región; si, por el contrario, se encuentra el patrón opuesto en R2, esto constituye una evidencia más sólida de una **doble disociación**: el hallazgo de que dos regiones muestran patrones de actividad cualitativamente diferentes en respuesta a dos condiciones distintas. (Tenga en cuenta que esto también supone que las condiciones en su diseño son ortogonales, lo que se puede lograr utilizando un diseño factorial completo, por ejemplo). Por último, debe ejecutar una interacción Región x Condición; una interacción significativa proporciona evidencia estadística adicional de que la activación en cada región se activa por una condición específica en su diseño.

.. nota::

  Véase también el panel (c) de la Figura I, que muestra una interacción significativa entre la condición y la región, pero no muestra actividad significativa para ninguna condición en la región R2. Esta es una interacción genuina, pero trivial, que podría obtenerse utilizando una región sin materia gris, como los ventrículos.

En resumen, para afirmar que existe una doble disociación, sus datos deben cumplir los siguientes criterios:

1. Dentro de R1, hay un efecto positivo significativo de la Condición A, pero no de la Condición B;
2. Dentro de R2, hay un efecto positivo significativo de la Condición B, pero no de la Condición A;
3. Dentro de R1, la Condición A es significativamente mayor que la Condición B;
4. Dentro de R2, la Condición B es significativamente mayor que la Condición A;
5. Hay un término de interacción Región x Condición significativo.

Por ejemplo, Henson cita uno de sus estudios previos (Henson et al., 1999), que examinó las diferencias entre recordar y conocer palabras presentadas previamente en el experimento. Las palabras se consideraban "recordadas" si el sujeto podía recordar detalles sobre cuándo las vio; por otro lado, se consideraban "conocidas" si le resultaban familiares, pero el sujeto no podía recordar ningún detalle específico sobre cuándo las vio. Mediante resonancia magnética funcional, Henson y sus colegas observaron una activación significativamente mayor en la corteza cingulada posterior para las palabras recordadas, pero no para las conocidas, y una mayor actividad en la corteza prefrontal lateral o en las palabras conocidas, en comparación con las recordadas, junto con una interacción significativa entre región y condición. Como condición de control, también se presentaron palabras nuevas, y no se observó actividad significativa en ninguna de las regiones.

.. figure:: ApéndiceH_Henson1999.png

Otro ejemplo proviene de mi propia investigación sobre la disociación de los efectos cognitivos y dolorosos en la circunvolución cingulada anterior dorsal en comparación con el área motora presuplementaria, más dorsal. Utilizando regiones de interés independientes creadas a partir de las puntuaciones Z máximas de los metaanálisis de Neurosynth de los términos de búsqueda "Dolor", "Conflicto" y "Error de predicción", se extrajeron estimaciones de parámetros para las condiciones de Dolor, Conflicto y Error de predicción en el experimento. La región de interés más ventral mostró un efecto significativo del Dolor, pero no para los efectos cognitivos, mientras que se observó un patrón de actividad opuesto en las regiones de interés más dorsales. La interacción Condición x Región de interés también fue significativa, lo que respalda la hipótesis de que existe una doble disociación entre el dolor asociado con la actividad en la corteza cingulada dorsal, que se encuentra debajo del surco cingulado, y los efectos cognitivos asociados con la actividad en el área motora presuplementaria, que se encuentra por encima del surco cingulado.

.. figure:: ApéndiceH_Jahn2016.png

  Figura 5 de Jahn et al., 2016. Se dibujaron esferas de 5 mm alrededor del valor z máximo de los mapas de metaanálisis descargados de Neurosynth, utilizando las palabras clave "dolor", "conflicto" y "error de predicción". La interacción ROI x Condición fue significativa: F(4,100) = 11,33, p < 0,001.

Otras formas de informar disociaciones
**********************************

Si bien el procedimiento descrito por Henson seguirá siendo útil para establecer disociaciones dobles, otros métodos también se están popularizando para delinear la arquitectura funcional del cerebro. Por ejemplo, la estimulación magnética transcraneal (EMT) interrumpe temporalmente la actividad neuronal en un área restringida de la superficie cerebral, penetrando generalmente entre uno y dos centímetros en la corteza. Esto puede considerarse una lesión virtual, temporal y reversible, que nos permite afirmar qué parte de la corteza es responsable de ciertos tipos de percepción y procesos cognitivos. Queda por ver la profundidad constante que pueden alcanzar estas corrientes disruptivas, pero mientras tanto, la RMf permite establecer mejor las disociaciones tanto en las estructuras subcorticales como en las áreas corticales enclavadas en las circunvoluciones.

Considere también este artículo de de la Vega et al. (2016)
    `__, lo que proporcionó evidencia que sugiere una parcelación tripartita de la corteza frontal medial. Al aplicar un algoritmo de agrupamiento a los datos del metaanálisis de Neurosynth, los autores crearon gráficos de "preferencia funcional" que ilustran qué subregión de la corteza prefrontal medial era más activa en una condición dada. Por ejemplo, su procedimiento de agrupamiento dividió la corteza frontal medial en tres regiones anatómicamente distintas: la región posterior, la media y la anterior. La actividad motora y la mirada tuvieron mayor probabilidad de activar la región posterior, por ejemplo, mientras que la firma neuronal para condiciones como el conflicto y el dolor se localizó más en la región media. Finalmente, la región anterior mostró una mayor preferencia por condiciones como la toma de decisiones, la recompensa y las tareas sociales.

.. figure:: ApéndiceH_DeLaVega.png

  Figura 4 de de la Vega et al. (2016). Estos perfiles de preferencia funcional muestran qué condiciones presentan un mayor logaritmo de razón de probabilidades (LOR) dentro de una condición dada; un LOR más alto "indica que un tema psicológico predice la activación en un grupo determinado". Se utilizó la agrupación de K-medias para dividir la corteza prefrontal medial en regiones posterior, media y anterior diferenciadas.

Esta última figura es más informativa que un simple valor p que compara dos o más condiciones, ya que representa no solo la significancia estadística, sino también la magnitud del efecto y la muestra en múltiples condiciones. Este enfoque, que muestra tanto el estadístico como el tamaño del efecto, permite al lector evaluar la intensidad de los efectos en comparación con los demás, así como comprender que varias condiciones pueden mostrar efectos similares en la misma región, con solo una o dos alcanzando la significancia estadística. Para una discusión más detallada sobre la presentación de tamaños del efecto frente a los estadísticos t, véase esta página.
     `.





     
    
   

