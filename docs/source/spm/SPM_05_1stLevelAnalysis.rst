

.. _SPM_05_Análisis de 1er Nivel:

========================================
Tutorial de SPM n.° 5: Estadísticas y modelado
========================================

-----------

Descripción general
********

Ahora que la primera ejecución funcional ha sido preprocesada, podemos **ajustar un modelo** a los datos. Para comprender cómo funciona el ajuste de modelos, necesitamos repasar algunos fundamentos como el Modelo Lineal General, la respuesta BOLD y qué es una serie temporal. Cada uno de estos temas se aborda en el siguiente índice.

Después de revisar estos conceptos, estará listo para realizar un análisis de primer nivel. La figura a continuación ilustra cómo ajustaremos un modelo a los datos.

.. figure:: 05_1erNivelAnálisis_Pipeline.png

   Tras construir un modelo que indica cómo debería ser la respuesta BOLD (A), dicho modelo se ajusta a la serie temporal en cada vóxel (B). El grado de ajuste del modelo (también conocido como **bondad de ajuste**) se puede representar en el cerebro mediante mapas estadísticos, donde las intensidades más brillantes indican un mejor ajuste. Estos mapas estadísticos se pueden umbralizar para mostrar solo los vóxeles con un ajuste estadísticamente significativo (C).

.. toctree::
   :maxdepth: 1
   :caption: Análisis de primer nivel

   SPM_Statistics/SPM_01_Stats_TimeSeries
   SPM_Statistics/SPM_02_Stats_HRF_History
   SPM_Statistics/SPM_03_Stats_HRF_Overview
   SPM_Statistics/SPM_04_Stats_General_Linear_Model
   SPM_Statistics/SPM_05_Creating_Timing_Files
   SPM_Statistics/SPM_06_Stats_Running_1stLevel_Analysis
   



.. nota::

   Comprender el ajuste de modelos y el análisis de primer nivel puede ser un desafío. No se desanime si no comprende todo la primera vez que lea los capítulos; persevere y los conceptos se aclararán con el tiempo y la práctica.

