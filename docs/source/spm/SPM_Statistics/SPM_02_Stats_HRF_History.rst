

.. _SPM_02_Estadísticas_Historial_HRF:

=====================================
Capítulo 2: Historia de la señal BOLD
=====================================

Durante la década de 1980 y principios de la de 1990, los investigadores de neuroimagen midieron el contraste entre los tejidos cerebrales mediante métodos como la tomografía por emisión de positrones (TEP). Esta consiste en inyectar un trazador de glucosa radiactivo que las neuronas absorben al activarse. Al tomar imágenes del cerebro en diferentes condiciones experimentales, como ver un tablero de ajedrez parpadeante o resolver un problema cognitivo exigente, los investigadores pudieron determinar qué regiones eran más activas en comparación con otras.

Sin embargo, este método es invasivo, y la idea de ser inyectado con un trazador radiactivo disuadió a muchas personas de ser sujetos de tales experimentos. A principios de la década de 1990, una técnica de imagen alternativa llamada resonancia magnética (MRI) se había vuelto mucho más rápida y menos costosa, y los investigadores buscaban una manera de hacerla más común para uso clínico. En 1990, un investigador de Bell Laboratories llamado Seiji Ogawa descubrió que una mayor cantidad de sangre desoxigenada conduce a una disminución en la señal medida de una región del cerebro. Un aumento en la sangre oxigenada, por otro lado, aumenta la señal, y este aumento en la sangre oxigenada se correlacionó posteriormente con un aumento de la activación neuronal. Este cambio en la señal se conoce como señal dependiente del nivel de oxígeno en sangre (o señal BOLD).

Poco después, en 1992, Ken Kwong, investigador del Hospital General de Massachusetts, demostró que la señal BOLD podía utilizarse como medida indirecta de la actividad neuronal. Su experimento consistió en mostrar alternativamente al sujeto un tablero de ajedrez parpadeante y una pantalla negra durante un minuto cada vez. La señal BOLD se registró en cada condición, como se muestra en el siguiente vídeo:

.. figura:: 05_02_Kwong_fMRI_Video.gif

Este experimento fue importante y se convirtió en el modelo para muchos experimentos de neuroimagen funcional. Kwong había descubierto una manera de utilizar la sangre del cuerpo como marcador endógeno para obtener imágenes de la actividad cerebral en sujetos sanos, eliminando así la necesidad de inyecciones o radiación. Como resultado, los experimentos de fMRI se popularizaron y, a principios de la década de 2000, la fMRI se había convertido en el método de neuroimagen dominante.


La señal BOLD como medida indirecta de la activación neuronal
*******************************************************

Aunque los descubrimientos de Ogawa y Kwong fueron un gran impulso para los neuroimagenólogos que utilizan la resonancia magnética, existía una trampa: este nuevo método era una medición indirecta de la actividad cerebral, a pocos pasos de la activación neuronal real. Cuando se presenta un estímulo, como un destello de luz o un ruido repentino, los órganos sensoriales lo transducen en impulsos nerviosos, que a su vez estimulan la activación neuronal en el cerebro. Las neuronas que se activan requieren oxígeno, y este es suministrado por la sangre. Esa sangre oxigenada, a su vez, aumenta la señal del hidrógeno cercano en el agua del cuerpo, que es lo que se mide en el escáner.

Sin embargo, esta es la medida utilizada para inferir si una región determinada del cerebro está "activa" o no. Para realizar estas inferencias, necesitaremos analizar con más detalle la señal BOLD, los diseños experimentales y cómo integramos ambos con modelos matemáticos.

