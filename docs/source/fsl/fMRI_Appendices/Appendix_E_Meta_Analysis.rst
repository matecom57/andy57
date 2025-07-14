

.. _Apéndice_E_Meta_Análisis:

=========================
Apéndice E: Metaanálisis
=========================

--------------------

Descripción general
********

Un metaanálisis mide la consistencia de los resultados. Por ejemplo, si analizáramos los resultados de diez estudios diferentes que investigaron el control cognitivo, y nueve de ellos encontraran una activación significativa en la corteza cingulada anterior dorsal, tendríamos mayor certeza de que esta corteza desempeña algún tipo de papel en el control cognitivo que si hubiéramos interpretado los resultados de un solo estudio.


Neurosynth
*********

Neurosynth permite generar instantáneamente mapas de metaanálisis para palabras clave de neuroimagen. Por ejemplo, al introducir la palabra "dolor", se generaría un mapa similar a este:

.. figure:: Apéndice_E_Dolor_Neurosynth.png

Los vóxeles resaltados en rojo muestran dónde es probable que haya una activación significativa, según los resultados de 516 estudios que usaron la palabra "dolor" para describir sus contrastes experimentales. La superposición de activación significativa entre todos los estudios se convierte en una puntuación z para cada vóxel. Los controles deslizantes de umbral en la esquina inferior derecha permiten al usuario mostrar solo los vóxeles que están por encima de una puntuación z específica (o por debajo de una puntuación z negativa específica), si desea eliminar del mapa los vóxeles menos significativos.




Mapas de uniformidad vs. mapas de asociación
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Neurosynth crea dos tipos de mapas de metaanálisis: de **Uniformidad** y de **Asociación**. La uniformidad es el concepto más intuitivo: representa la probabilidad de encontrar un resultado significativo en ese vóxel, dado el término de búsqueda (p. ej., "dolor"); es similar a calcular la superposición de los mapas estadísticos de todos los estudios que utilizaron "dolor" en su experimento. Un mapa de asociación, por otro lado, calcula en cada vóxel la probabilidad de encontrar una activación significativa dado el término de búsqueda, en comparación con los estudios que no lo utilizan. Por ejemplo, la corteza cingulada anterior dorsal se activa en respuesta a diversos tipos de estímulos y procesos cognitivos: conflicto, dolor, error de predicción, emoción y atención, entre otros. Controlar este nivel general de actividad basal mediante pruebas de asociación generará un metaanálisis más específico para cada condición, a costa de ser más conservador que una prueba de uniformidad.


Usando los mapas como ROI
^^^^^^^^^^^^^^^^^^^^^^

Una vez que haya descargado un mapa de metanálisis, puede usarlo como región de interés (ROI). Como vio en el capítulo sobre análisis sesgadosUsar un ROI sesgado puede generar estimaciones de parámetros infladas; por lo tanto, es necesario asegurarse de que el ROI sea imparcial. Esto significa que el ROI no debe generarse con base en los datos extraídos de la máscara.

Los mapas de metaanálisis de Neurosynth son excelentes candidatos para un ROI imparcial. Una vez descargados, tiene dos opciones para usarlos como máscara:

1. Establezca un umbral en el mapa para que solo se extraigan datos de una región en particular; o
2. Observe las coordenadas del vóxel máximo y luego utilice esas coordenadas para crear un ROI esférico.


La primera opción se puede realizar con cualquiera de las calculadoras de imágenes de AFNI, SPM o FSL. Por ejemplo, si descargo un mapa de asociación del dolor, podría crear una máscara que solo incluya vóxeles con una puntuación z de 10 o superior:

::

  3dcalc -prefix dolor_ROI_thresh_z10.nii -a prueba_de_asociación_de_dolor_z_FDR_0.01.nii.gz -expr 'paso(a-10)'
  
En este comando AFNI, la función ``step`` indica que la expresión entre paréntesis debe evaluarse, y cualquier vóxel que devuelva un valor positivo se establecerá en 1. La opción ``-a`` carga el mapa de Neurosynth descargado en una variable llamada ``a``, que luego se pasa a la función ``step``. A cada vóxel del mapa de metaanálisis se le resta 10; si el valor restante es positivo, ese vóxel se establece en 1.

Un comando equivalente con la calculadora de imágenes de FSL sería:

::

  fslmaths prueba de asociación de dolor_z_FDR_0.01.nii.gz -thr 10 -bin dolor_ROI_thresh_z10.nii
  

Tenga en cuenta que la opción ``thr`` establece el umbral de la imagen y ``bin`` biniza los vóxeles restantes; en otras palabras, los establece en 1.

En SPM, deberá usar la herramienta ``imcalc``, disponible en la interfaz gráfica de usuario de SPM. Haga clic en el botón ``ImCalc`` y cargue el mapa de metaanálisis descargado como imagen de entrada. Configure el nombre del archivo de salida como "pain_ROI_thresh_z10" y, en el campo "Expresión", escriba ``i1>10``. Esto establecerá el umbral de la imagen en 1 para los vóxeles con un valor de 10 o superior.

.. figure:: Apéndice_E_Imcalc.png

Otras características de Neurosynth
*************************

Conectividad funcional
^^^^^^^^^^^^^^^^^^^^^^^

Neurosynth es principalmente una herramienta de metaanálisis, pero también se puede utilizar para generar rápidamente conectividad funcional.
    Mapas de regiones semilla en un cerebro modelo. Si hace clic en la pestaña "Ubicaciones", se abrirá una nueva ventana con el nombre "Mapas de conectividad funcional y coactivación". Haga clic en cualquier coordenada del cerebro y luego en "¿Qué hay aquí?". Tras unos instantes, se generará un mapa de correlación basado en 1000 sujetos recopilados por Yeo et al. (2011). 
     `__. Puedes establecer un umbral en la imagen para que solo muestre correlaciones superiores a un valor determinado, y también puedes descargar el mapa de correlación para usarlo como máscara.

.. figure:: 01_Neurosynth_FuncConn_Demo.gif


Ceremonias
*********

1. Busca el término "conflicto" y crea una esfera de 5 mm alrededor de las coordenadas del pico de la máscara de asociación que descargaste.

     
    
   

