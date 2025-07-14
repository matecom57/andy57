

.. _ResumenEstadísticas:

==============================
Apéndice A: Resumen estadístico
==============================

-----------

Para una prueba t de muestras pareadas en SPM, tiene dos opciones:

1. Introduzca cada par de imágenes (p. ej., peso beta A y peso beta B) para cada sujeto para el análisis de segundo nivel. Desde la interfaz gráfica de usuario de SPM, si hace clic en "Especificar segundo nivel" y, a continuación, en el menú "Diseño", selecciona "Prueba t pareada", se le pedirá que seleccione un par de imágenes para cada sujeto.

.. figure:: SPM_PairedTtest_Standard.png

2. Puede utilizar el método **Estadísticas de Resumen**, que realiza una prueba t de una muestra sobre el contraste de cada par para cada sujeto. Esto implica tomar el contraste entre cada par de pesos beta para obtener una única imagen de contraste por par y, a continuación, realizar una prueba t de una muestra sobre esas estimaciones de contraste. Si la varianza entre los pesos beta es idéntica (o al menos muy similar), este método es válido. El método de estadísticas de resumen es robusto frente a violaciones de este supuesto de varianza igual.

.. figure:: SPM_PairedTtest_SummaryStatistics.png

