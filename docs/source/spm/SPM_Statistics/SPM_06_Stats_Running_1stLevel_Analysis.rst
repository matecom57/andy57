

.. _SPM_06_Estadísticas_Ejecución_Análisis_1er_Nivel:

===========================================
Capítulo 6: Ejecución del análisis de primer nivel
===========================================

---------

Especificación del modelo
********************

Habiendo creado los archivos de tiempo en el capítulo anteriorPodemos usarlos junto con nuestros datos de imágenes para crear mapas paramétricos estadísticos. Estos mapas indican la fuerza de la correlación entre nuestra serie temporal ideal (que consiste en nuestros tiempos de inicio convolucionados con la HRF) y la serie temporal recopilada durante el experimento. La modulación de la HRF se representa mediante un peso beta, que a su vez se convierte en un estadístico t al crear contrastes con el gestor de contrastes SPM.

Para comenzar, desde la interfaz gráfica de SPM, haga clic en "Especificar 1.er nivel". Tenga en cuenta que el primer campo que debe completarse es "Directorio". Para organizar los resultados, acceda a la terminal de Matlab, navegue al directorio "sub-08" y escriba "mkdir 1stLevel". A continuación, haga doble clic en "Directorio" y seleccione el directorio "1stLevel" que acaba de crear. Todos los resultados del análisis de 1.er nivel se guardarán en esta carpeta.

A continuación, completaremos la sección Parámetros de tiempo. En "Unidades de diseño", seleccione "Segundos" e introduzca "2" en "Intervalo entre escaneos". A continuación, haga clic en "Datos y diseño" y, a continuación, haga doble clic en "Nuevo: Asunto/Sesión" para crear dos sesiones. Para los escaneos de la primera sesión, vaya al directorio "func" y utilice los campos Filtro y Marcos para seleccionar los 146 volúmenes de los datos funcionales deformados (es decir, los archivos que empiezan por "swar"). Haga lo mismo con los volúmenes de la segunda sesión.

Regrese al campo para la primera sesión. Hay dos condiciones en el experimento, y ambas se cumplen en cada ejecución. Haga clic en «Condiciones» y luego en «Nueva: Condición» dos veces para crear dos nuevos campos de condición. Para la primera condición, haga doble clic en «Nombre» y escriba «Inc».

Ahora necesitaremos los tiempos de inicio para cada ocurrencia de la condición incongruente. Desde la terminal de Matlab, navegue al directorio ``func`` y escriba:

::

  IncRun1 = importdata('incongruent_run1.txt');
  IncRun1(:,1)
  
Esto devolverá los tiempos de inicio para la condición incongruente de la ejecución 1. Haga doble clic en el campo "Inicios" y copie y pegue los tiempos de inicio en la ventana. Haga clic en "Listo".

En este experimento, cada prueba duró 2 segundos. Por lo tanto, podemos introducir el número «2» en el campo «Duraciones» y SPM asumirá que es la misma duración para cada prueba.

Ahora realice el mismo procedimiento para la condición Congruente de la ejecución 1 y las condiciones Incongruente y Congruente de la ejecución 2, recordando introducir un valor de duración de 2 para todas ellas. Aquí está el código para mostrar los tiempos de inicio de cada uno de los tiempos de inicio restantes que necesitará:

::

  ConRun1 = importdata('congruent_run1.txt');
  ConRun1(:,1)
  IncRun2 = importdata('incongruent_run2.txt');
  IncRun2(:,1)
  ConRun2 = importdata('congruent_run2.txt');
  ConRun2(:,1)

Puede utilizar los nombres "Inc" y "Con" para ambas ejecuciones si lo desea; los nombres se almacenarán en un archivo llamado "SPM.mat" que veremos más adelante con más detalle.

Al terminar, haz clic en el botón verde "Ir". La estimación del modelo solo tardará unos instantes. Al finalizar, verás algo como esto:

.. figura:: 05_06_Revisión_de_Diseño.png

  El Modelo Lineal General para un solo sujeto. Las dos primeras columnas muestran la serie temporal ideal para las condiciones incongruentes y congruentes de la primera sesión, mientras que las dos siguientes muestran la serie temporal ideal para las condiciones de la segunda sesión. Las dos últimas columnas son regresores de referencia que capturan la señal media de cada sesión. En esta representación, el tiempo se extiende de arriba a abajo, y los colores más claros representan mayor actividad.
  
  
Estimación del modelo
********************

Ahora que hemos creado nuestro GLM, necesitaremos **estimar** los pesos beta para cada condición. En la interfaz gráfica de SPM, haga clic en "Estimar" y, a continuación, haga doble clic en el campo "Seleccionar SPM.mat". Cambie la opción "Escribir residuos" a "Sí". Vaya al directorio "1stLevel", seleccione el archivo SPM.mat y, a continuación, haga clic en el botón verde "Ir". El proceso tardará unos minutos.

El administrador de contraste
********************

Una vez que haya terminado de estimar el modelo, estará listo para crear **contrastes**. Si, por ejemplo, estimamos un peso beta para la condición incongruente y otro para la condición congruente, podemos usar la diferencia entre ambos para calcular una **estimación de contraste** en cada vóxel del cerebro. Al hacerlo, se creará un **mapa de contraste** para cada vóxel.

Para crear estos contrastes, haga clic en el botón "Resultados" de la interfaz gráfica de usuario de SPM y seleccione el archivo SPM.mat generado tras estimar el modelo. Verá la matriz de diseño a la derecha del panel. Haga clic en "Definir nuevo contraste" y, en el campo "Nombre", escriba "Inc-Con". En la ventana del vector de contraste, escriba "0.5 -0.5 0.5 -0.5" y haga clic en "Enviar". Si el contraste es válido, debería ver un texto verde en la parte inferior de la ventana que indica "nombre definido, contraste definido". Asegúrese de que su administrador de contrastes se parezca a la figura siguiente y haga clic en "Aceptar" para crear el contraste.

.. figura:: 05_06_Contraste_Inc-Con.png

.. nota::

  Si olvidó qué columna corresponde a cada condición, mantenga pulsado el botón derecho mientras pasa el cursor sobre una de las columnas. Debería ver el texto que especifica a qué condición pertenece esa columna.
  Quizás también haya notado que usamos **ponderaciones de contraste** de 0,5 y -0,5. ¿Por qué esos números, en lugar de los tradicionales 1 y -1? En este caso, consideramos el número de ejecuciones de nuestro estudio. Para que nuestros resultados sean comparables con los de otros sujetos u otros estudios que puedan tener diferentes cantidades de ejecuciones, dividiremos nuestras ponderaciones de contraste de 1 y -1 entre el número de ejecuciones: p. ej., 1/2 = 0,5 y -1/2 = 0,5. Si usáramos un vector de contraste de [1 -1 1 -1], el estadístico t resultante sería el mismo, pero la estimación del contraste se inflaría proporcionalmente al número de ejecuciones de nuestro estudio.

Examinando la salida
********************

Haga doble clic en el contraste «Inc-Con» para abrir la ventana de Resultados. Primero deberá configurar algunas opciones:

1. **Aplicar enmascaramiento**: configure esto en "ninguno", ya que queremos examinar todos los vóxeles del cerebro y no queremos restringir nuestro análisis a una máscara.
  
2. **Ajuste del valor p para controlar**: Haga clic en "ninguno" y establezca el valor p sin corregir en 0,01. Esto evaluará cada vóxel individualmente con un umbral p de 0,01.
  
3. **Umbral de extensión {vóxeles}**: Establezca este valor en 10 por ahora, lo que solo mostrará grupos de 10 o más vóxeles contiguos. Actualmente, lo hacemos para eliminar las partículas de vóxeles que probablemente se encuentren en regiones ruidosas, como los ventrículos. Más adelante, aprenderemos a realizar la **corrección de grupos** a nivel de grupo para controlar adecuadamente el número de pruebas estadísticas individuales.
  

Cuando haya terminado de especificar las opciones, verá sus resultados en una representación gráfica. Esta representación muestra los resultados en un espacio estandarizado en tres planos ortogonales, donde los puntos oscuros representan los grupos de vóxeles que superaron nuestro umbral estadístico. En la esquina superior derecha encontrará una copia de su matriz de diseño y el contraste que está observando, y en la parte inferior, una tabla con las coordenadas y la significancia estadística de cada grupo. La primera columna, **nivel de conjunto**, indica la probabilidad de ver el número actual de grupos, *c*. La columna **nivel de grupo** muestra la significancia estadística de cada grupo (medida en número de vóxeles, o *kE*) utilizando diferentes métodos de corrección. La columna **nivel de pico** muestra las estadísticas t y z del vóxel pico dentro de cada grupo; los grupos principales están marcados en negrita y los subgrupos que se enumeran debajo del grupo principal están marcados en letra más clara. Por último, las coordenadas MNI del pico de cada grupo y subgrupo se muestran en la columna de la derecha.

Si hace clic izquierdo en las coordenadas de un grupo, estas se resaltarán en rojo y el cursor en la vista del cerebro de cristal saltará a ellas. Puede hacer clic y arrastrar la flecha roja en el cerebro de cristal si lo desea y, a continuación, hacer clic derecho en el cerebro y seleccionar cualquiera de las opciones para saltar al vóxel supraumbral más cercano o al máximo local más cercano.

.. figura:: 05_06_Ventana_de_Resultados_SPM.png

Para ver los resultados en una imagen distinta a la del cerebro de cristal, en la ventana de resultados de la esquina inferior izquierda (que contiene los campos "Valores p", "Multivariante" y "Visualización"), haga clic en "Superposiciones" y luego seleccione "Secciones". Vaya al directorio "spm12/canonical" y seleccione el cerebro T1 que desee. En este caso, seleccionaré el cerebro avg152.

Ahora verá los resultados como un mapa de calor en la plantilla. Puede hacer clic y arrastrar la cruceta como en la ventana de visualización. Si coloca la cruceta sobre un clúster específico y hace clic en el botón "Clúster actual" en la ventana de resultados, reaparecerá la tabla estadística, resaltando las coordenadas del clúster seleccionado.

.. figura:: 05_06_SPM_Results_Template.png

.. nota::

  Si desea volver a cargar rápidamente la visualización de los resultados en la plantilla cerebral, haga clic en ``superposiciones`` y seleccione ``secciones anteriores``.



Ceremonias
*********

1. Abra de nuevo la ventana del administrador de contraste haciendo clic en el botón "Resultados" y cree contrastes de "Con-Inc" (es decir, el contraste inverso de Inc-Con), un efecto simple de Incongruente (denominado "Inc") y un efecto simple de Congruente (denominado "Con"). Muestre los vectores de contraste utilizados y adjunte una captura de pantalla del administrador de contraste una vez creados todos los contrastes.


.. Con-Inc: [-0,5 0,5 -0,5 0,5]
  Inc: [0.5 0 0.5 0]
  En contra: [0 0.5 0 0.5]
  
Estimar el peso beta para cada condición individualmente será importante más adelante cuando hagamos el análisis de la región de interés para determinar qué impulsa nuestros contrastes.

Próximos pasos
*********

Una vez finalizado el preprocesamiento y los análisis de primer nivel, tendremos que ejecutarlos para cada sujeto de nuestro estudio. Para agilizar el proceso, aprenderemos sobre **scripting**, tema que abordaremos a continuación.


Video
*****

Para ver una demostración en video de cómo realizar un análisis de primer nivel en SPM, haga clic aquí
    `__.

    
   

