

.. _fMRI_08_Análisis de 3er Nivel:

Tutorial de fMRI n.° 8: Análisis de tercer nivel
====================================

-------------

Descripción general
********

Nuestro objetivo al analizar este conjunto de datos es generalizar los resultados a la población de la que se extrajo la muestra. En otras palabras, si observamos cambios en la actividad cerebral en nuestra muestra, ¿podemos afirmar que estos cambios probablemente también se observarían en la población?

Para comprobarlo, realizaremos un **análisis de tercer nivel**. En FSL, un análisis de tercer nivel es un análisis a nivel de grupo: calculamos el error estándar y la media de una estimación de contraste y, a continuación, comprobamos si la estimación promedio es estadísticamente significativa.

FSL solo puede ejecutar un modelo a la vez. En este ejemplo, ejecutaremos un análisis de tercer nivel para el contraste de Incongruente-Congruente (etiquetado como "cope3" del análisis de segundo nivel, ya que fue el tercer contraste especificado). Como ejercicio al final de este capítulo, se le pedirá que ejecute análisis de tercer nivel para las estimaciones individuales de contraste de Incongruente y Congruente.

Cargando los datos
*********

Desde el directorio Flanker, abra la interfaz gráfica de usuario de FEAT. Al igual que con el análisis de segundo nivel, seleccione «Análisis de nivel superior». Ahora, en lugar de seleccionar directorios FEAT, elija «Las entradas son imágenes de corte 3D de los directorios FEAT» y cambie el número de entradas a 26. El análisis de segundo nivel generó un contraste promedio de la estimación de parámetros (o **cope**) para cada sujeto y para cada contraste especificado en nuestro modelo. Al igual que al seleccionar los directorios FEAT durante el análisis de segundo nivel, podemos copiar y pegar una lista de las imágenes de corte: haga clic en «Seleccionar imágenes de corte» y, a continuación, en el botón «Pegar». En la Terminal, navegue al directorio «Flanker_2ndLevel.gfeat/cope3.feat/stats» y escriba «ls $PWD/cope* | sort -V». Esto listará todas las imágenes de corte en orden numérico, aunque no se completen con ceros. Copie y pegue la lista en la ventana "Datos de entrada" presionando "Ctrl+Y". Después de hacer clic en "Aceptar", etiquete el directorio de salida como "Flanker_Level3_inc-con".

Creando el GLM
****************

Haga clic en la pestaña "Estadísticas". Para un análisis de tercer nivel, utilizaremos Efectos Mixtos. Este modelo modela la varianza para que nuestros resultados sean generalizables a la población de la que se extrajo la muestra. FLAME 1 (Análisis Local de Efectos Mixtos de FSL) proporciona estimaciones precisas de los parámetros utilizando información sobre la variabilidad intra e intersujetos; FLAME 1+2 se considera aún más preciso, pero el beneficio adicional suele ser mínimo y el proceso lleva mucho más tiempo.

La última opción, «Randomise», utiliza un enfoque no paramétrico, válido cuando no se cumplen los supuestos de normalidad. Más adelante, analizaremos por qué esto es apropiado en algunos casos.

.. figura:: 3rdLevelAnalysis_StatsTab.png
  :escala: 50%

Dado que usamos un diseño simple, podemos crear rápidamente un GLM con el botón "Asistente de configuración del modelo". Ya hemos calculado el contraste para cada sujeto, así que podemos seleccionar "Promedio de un solo grupo". Al hacer clic en "Procesar", debería ver una representación del modelo similar a esta:

.. figura:: 3rdLevelAnalysis_Model.png
  :escala: 50%


La pestaña de estadísticas posteriores
******************

Ahora finalmente discutimos la pestaña ``Estadísticas posteriores``. Los únicos valores predeterminados que probablemente desee considerar cambiar son las opciones de Umbral. ``Ninguno`` no realizará ningún umbral (es decir, mostrará la estimación del parámetro en cada vóxel, independientemente de la significancia); ``Sin corregir`` permitirá que cualquier vóxel individual pase el umbral especificado en el umbral Z (por ejemplo, aquí solo mostraríamos vóxeles que tengan un valor mayor que 3,1); ``Vóxel`` realizará un tipo de umbral de altura máxima basado en la teoría del campo aleatorio gaussiano, que es menos conservadora que una prueba de Bonferroni; y por último ``Clúster``, que usa un umbral definidor de clúster (CDT) para determinar si un clúster de vóxeles es significativo. La lógica detrás de este enfoque es que los vóxeles vecinos no son independientes entre sí, y estos grados de libertad reducidos se tienen en cuenta al estimar la significancia.

Por ejemplo, si dejamos nuestro umbral Z en 3,1 y nuestro umbral p de clúster en 0,05, buscaremos clústeres compuestos por vóxeles que superen individualmente un umbral z de 3,1. FSL realiza simulaciones para ver con qué frecuencia se obtienen clústeres de ciertos tamaños, donde cada uno de sus vóxeles constituyentes supera dicho umbral z, y crea una distribución de tamaños de clúster para esa CDT (similar a lo que ocurre cuando calculamos una distribución t basada en grados de libertad). Los tamaños de clúster que aparecen menos del 5 % del tiempo en las simulaciones para esa CDT se consideran significativos.

.. figura:: 3rdLevelAnalysis_PostStatsTab.png


Para la mayoría de los análisis, el valor predeterminado de un análisis de corrección de conglomerados con un CDT de z = 3,1 y un umbral de conglomerados de p = 0,05 es adecuado. Para una comparación detallada de las tasas de falsos positivos entre los diferentes paquetes de software y las distintas configuraciones de corrección de conglomerados, consulte el artículo original de Eklund et al. de 2016.`__; para ver una descripción general en video de algunos problemas potenciales con la corrección de clúster, haga clic `aquí 
    `__.

Ahora haz clic en "Ir". Tardará entre 5 y 10 minutos, dependiendo de la potencia de tu ordenador.


Revisando la salida
********************

En la salida HTML de FEAT, verá la imagen con el estadístico z umbralizado superpuesta a una plantilla de cerebro MNI. Estos cortes axiales ofrecen una visión general rápida de la ubicación de los grupos significativos.

.. figura:: 3rdLevelAnalysis_FEAT_Output.png


Para examinar los resultados con más detalle, abra ``fsleyes`` y cargue una plantilla estándar, como ``MNI152_T1_1mm_brain``. A continuación, cargue la imagen ``thresh_zstat1.nii.gz``, ubicada en ``Flanker_3rdLevel_inc-con.gfeat/cope1.feat``. Esta imagen solo muestra los clústeres considerados significativos según los criterios especificados en la pestaña Estadísticas posteriores.

Para que los resultados se vean más nítidos, cambie el esquema de colores a "Rojo-Amarillo" y el valor "Mín." a 3.1. También puede hacer clic en el icono del engranaje y modificar la interpolación para que los resultados se vean más suaves. Por último, haga clic en un grupo en el área de la corteza prefrontal medial dorsal y desactive la cruceta haciendo clic en el icono de la cruceta. (Estas son opciones estéticas y puede modificarlas a su gusto). Después, puede tomar una instantánea de este montaje con el icono de la cámara e incluir la imagen como figura en su manuscrito.

.. figura:: 3rdLevelAnalysis_ThresholdedStatsMontage.png

  El resultado final: una imagen que muestra los grupos significativos del análisis.
  

------

Ceremonias
*********

1. En la pestaña "Estadísticas posteriores", configure el umbral en "Ninguno" y vuelva a ejecutar el análisis (cambiando el directorio de salida a uno que indique que no se utiliza ningún umbral). Examine los resultados en fsleyes. ¿Cómo se comparan con los resultados corregidos por conglomerados?

2. Repita el mismo procedimiento del ejercicio anterior, esta vez con un umbral "Sin corrección". Luego, repita el procedimiento con un umbral "Vóxel". Observe las diferencias entre estos resultados y los generados con la corrección por conglomerados. Explique con sus propias palabras por qué los resultados son diferentes.

------

Video
*****

Haga clic aquí
     `__ para una demostración de cómo configurar y analizar un análisis a nivel de grupo en FSL.

     
    
   

