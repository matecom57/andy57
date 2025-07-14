

.. _SPM_05_Creación_de_archivos_de_sincronización:

================================
Capítulo 5: Creación de archivos de sincronización
================================

---------

La serie temporal ideal y la serie temporal ajustada
*********

Acabamos de ver cómo podemos usar varios regresores, o variables independientes, para estimar una medida de resultado como el promedio de calificaciones (GPA). Conceptualmente, hacemos lo mismo al usar varios regresores para estimar la actividad cerebral, que es nuestra medida de resultado con datos de fMRI: estimamos la amplitud promedio de la señal BOLD en respuesta a cada condición en nuestro modelo.

En la animación a continuación, los diferentes colores de las respuestas BOLD representan diferentes condiciones (como Congruente e Incongruente), y la línea gris representa la evolución temporal de nuestros datos preprocesados. Esto muestra cómo se estima la amplitud de cada condición para ajustarse mejor a los datos; para la condición de la izquierda, es relativamente alta, mientras que para la condición de la derecha, es relativamente baja. También puede imaginar una señal BOLD de una condición que no sea significativamente diferente de cero, o incluso negativa.

.. figura:: 05_05_GLM_fMRI_Data.gif

Las líneas roja y verde que representan las HRF se denominan **serie temporal ideal**. Esta es la serie temporal que esperamos, dada la temporalidad de cada estímulo en nuestro experimento. Al estimar los pesos beta para ajustar esta serie temporal ideal a los datos, el resultado se denomina **serie temporal ajustada**, que se muestra en la animación como una línea azul.

.. nota::

  Dado que cada vóxel tiene su propia serie temporal, aplicamos el procedimiento anterior a cada vóxel del cerebro. Esto se conoce como análisis univariante de masas, ya que estimamos los pesos beta para la serie temporal de cada vóxel. Dado que un conjunto de datos típico de fMRI contiene decenas o cientos de miles de vóxeles, posteriormente tendremos que realizar correcciones para todas las pruebas realizadas. Esto se abordará en un capítulo posterior sobre análisis de grupos.


Creando la serie temporal ideal
*********

Nuestro objetivo es crear la serie temporal ajustada para poder utilizar los pesos beta estimados en un análisis a nivel de grupo. Para ello, primero necesitamos crear nuestra serie temporal ideal.

Analicemos el conjunto de datos Flanker. Dentro del directorio "func" de cada sujeto se encuentran los archivos "events.tsv". Estos archivos contienen tres datos necesarios para crear nuestros **archivos de tiempo** (también conocidos como **archivos de inicio**):

1. El nombre de la condición;
2. Cuándo se produjo cada prueba de la condición, en segundos, en relación con el inicio del escaneo; y
3. La duración de cada prueba.

Estos deben extraerse de los archivos events.tsv y formatearse de forma que el software SPM pueda leerlos. En este caso, crearemos un archivo de cronometraje para cada condición y lo dividiremos según la ejecución en la que se realizó la condición. En total, crearemos cuatro archivos de cronometraje:

1. Tiempos de los ensayos incongruentes que ocurrieron durante la primera ejecución (a la que llamaremos incongruent_run1.txt);
2. Tiempos de los ensayos incongruentes que ocurrieron durante la segunda ejecución (incongruent_run2.txt);
3. Tiempos de los ensayos congruentes que ocurrieron durante la primera ejecución (congruent_run1.txt);
4. Tiempos de los ensayos congruentes que ocurrieron durante la segunda ejecución (congruent_run2.txt).

Cada uno de estos archivos de sincronización tendrá el mismo formato que consta de dos columnas, en el siguiente orden:

1. Tiempo de inicio, en segundos, con respecto al inicio del escaneo; y
2. Duración del juicio, en segundos.

  
.. figura:: 05_05_TimingFiles_Example.png
  
  El archivo Run-1_events.tsv en OpenNeuro.org (A). Al descargarlo y consultarlo en la terminal de Matlab, se ve como el texto en la ventana (B). Luego, reformateamos el archivo de eventos para crear un archivo de cronometraje para cada ejecución con dos columnas: hora de inicio y duración.
  
Para formatear los archivos de sincronización, descargue este script`__. (Puede descargarlo haciendo clic en el botón "Raw", luego haciendo clic derecho en la ventana que se abre y seleccionando "Guardar como"). No entraremos en detalles sobre su funcionamiento, pero solo necesita colocarlo en la carpeta experimental que contiene los sujetos y, desde ese directorio, escribir "convertOnsetTimes". Esto creará archivos de cronometraje para cada ejecución y los almacenará en el directorio "func" correspondiente a cada sujeto. Para consultar el resultado de un archivo individual (por ejemplo, los tiempos de inicio de los ensayos incongruentes de la ejecución 1), escriba "importdata(sub-08/func/incongruent_run1.txt)". Debería ver números similares a los de la figura anterior.

Una vez creados los archivos de sincronización, podrá usarlos para ajustar un modelo a los datos de fMRI. Para ver cómo hacerlo, haga clic en el botón Siguiente.


   

