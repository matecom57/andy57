

.. _06_Estadísticas_Ejecución_Análisis_1er_Nivel:

Capítulo 6: Ejecución del análisis de primer nivel
================

---------

La pestaña de estadísticas
***************

Dirígete al directorio ``sub-08`` y escribe ``fsl`` desde la línea de comandos. Abre la interfaz gráfica de FEAT y, en el menú desplegable de la esquina superior derecha de la pestaña Datos, cambia "Análisis completo" a "Estadísticas". Esto desactivará las pestañas Preestadísticas y Registro. También verás un nuevo botón llamado "La entrada es un directorio FEAT". Haz clic en él y selecciona el directorio FEAT ``run1.feat`` que creaste en el módulo anterior. Haz clic en Aceptar e ignora la advertencia sobre la carga de la información de diseño desde el archivo design.fsf; aún no hemos configurado un modelo, así que no se sobrescribirá nada.

A continuación, haga clic en la pestaña "Estadísticas". Hay muchas opciones, pero solo nos centraremos en un par. Haga clic en "Configuración completa del modelo" y cambie el número de **Velocidades Variables Originales** (o **Variables Explicativas**, término que FSL utiliza para los regresores) a 2. Esto creará dos pestañas, una para cada regresor. En el campo "Nombre de la Ve" del regresor 1, escriba "incongruente". Haga clic en el menú desplegable junto a "Forma básica" y seleccione "Personalizado (formato de 3 columnas)". Se abrirá un campo llamado "Nombre de archivo"; haga clic en el icono de la carpeta para seleccionar el archivo de temporización "incongruent_run1.txt". Desmarque la opción "Añadir derivada temporal". (Esto facilita la comprensión de la matriz de diseño; añadiremos las derivadas más adelante). Haga clic en la pestaña "2" y repita estos pasos, esta vez seleccionando el archivo de temporización "congruent_run1.txt".

Cuando haya terminado de configurar el modelo, haga clic en la pestaña «Contrastes y pruebas F». Aquí podrá especificar los mapas de contraste que desea crear tras estimar los pesos beta de cada condición. En este experimento, nos interesan tres contrastes:

1. El peso beta promedio para la condición Incongruente comparado con la línea base;
2. El peso beta promedio para la condición congruente en comparación con la línea base; y
3. La diferencia de los pesos beta promedio entre las condiciones Incongruentes y Congruentes.

Establezca el número de contrastes en 3 y escriba los siguientes nombres de contraste en cada fila, junto con los siguientes **pesos de contraste** en las columnas EV1 y EV2:

1. incongruente [1 0];
2. congruente [0 1];
3. incongruente-congruente [1 -1].

Nota: En la clase de estadística, quizás hayas aprendido que los pesos de un contraste deben sumar 0. Esto es cierto si deseas que el contraste sea ortogonal, y es cierto que los dos primeros contrastes mencionados no lo son. Sin embargo, los usaremos más adelante para determinar qué impulsa el efecto en nuestro tercer contraste, mediante una técnica llamada **análisis de la región de interés**. Esto se explicará en detalle en un capítulo posterior.

.. nota::

  En FSL, las ponderaciones beta se denominan **estimaciones de parámetros** o **pe**, y los contrastes entre ponderaciones beta se denominan **contrastes de estimaciones de parámetros** o **cope**. Al examinar los datos de salida, verá dos archivos de estimación de parámetros (uno para cada condición) y tres archivos de contraste de estimaciones de parámetros (uno para cada contraste). Los números de contraste 1 y 2 anteriores serán idénticos a los archivos de estimación de parámetros; puede parecer redundante recrearlos posteriormente, pero verá más adelante que FSL requerirá que los archivos se etiqueten como cope para un análisis de alto nivel.

Haga clic en el botón "Listo" para abrir la ventana **Matriz de Diseño**. La columna de la izquierda representa el **filtro paso alto**, que elimina las frecuencias que superan la longitud de la barra roja (es decir, se eliminan las frecuencias bajas y se permite el paso de las frecuencias altas). Las dos columnas de la derecha representan la serie temporal ideal para ambos regresores y corresponden al orden en que se ingresaron los archivos de tiempo; es decir, la primera columna es la serie temporal ideal para la condición incongruente y la segunda, la serie temporal ideal para la condición congruente.

.. figura:: Design_Matrix.png

La línea roja representa cómo creemos que debería verse la serie temporal del vóxel si responde a ese regresor. Observará que las barras blancas representan la HRF que se convoluciona con el inicio de cada prueba para esa condición. Revise los archivos de tiempo de cada condición y compruebe si la correspondencia entre los tiempos de inicio y la matriz de diseño es coherente. A continuación, haga clic en "Ir" para ejecutar el modelo.

.. figura:: 1stLevelAnalysis_Demo.gif

La pestaña de estadísticas posteriores
***************

La última pestaña de la interfaz gráfica de FEAT se llama "Estadísticas posteriores". Aquí hay muchas opciones, y las únicas que probablemente modifique son las denominadas "Umbral Z" y "Umbral P del grupo", que determinan qué vóxeles son estadísticamente significativos para cada contraste. Las dejaremos por ahora y las revisaremos al realizar un análisis a nivel de grupo.`__.

La serie temporal ideal y el GLM
***************

Tras hacer clic en "Ir", se abrirán varias páginas HTML para seguir el progreso del ajuste del modelo, que tardará entre 5 y 10 minutos. Mientras espera, veamos cómo se relaciona el modelo que acabamos de crear con el GLM. Recuerde que cada vóxel tiene una serie temporal en negrita (nuestra medida de resultado), que representamos con Y. También tenemos nuestros dos regresores, que representaremos con x1 y x2. Estos regresores constituyen nuestra matriz de diseño, que representamos con una X grande.

Hasta el momento, se conocen todas estas variables: Y se mide a partir de los datos, y x1 y x2 se obtienen mediante la convolución de la HRF y los inicios temporales. Dado que se utiliza álgebra matricial para configurar la matriz de diseño y estimar los pesos beta, las orientaciones se han invertido noventa grados: normalmente, pensamos que el eje temporal va de izquierda a derecha, pero en su lugar se representa de arriba a abajo. En otras palabras, el inicio de la ejecución comienza en la parte superior del recorrido temporal.

La siguiente parte de la ecuación GLM son los pesos beta, que representamos con B1 y B2. Estos representan nuestra estimación del grado en que la HRF debe escalarse para cada regresor para que coincida mejor con los datos originales en Y; de ahí el nombre "pesos beta". El último término de esta ecuación es E, que representa los residuos, o la diferencia entre nuestro modelo ideal de series temporales y los datos tras estimar los pesos beta. Si el modelo se ajusta bien, los residuos disminuirán y es más probable que uno o más de los pesos beta sean estadísticamente significativos. La correspondencia del GLM con el modelo fMRI que creó se ilustra en la animación a continuación.

.. figura:: GLM_fMRI_Data_FSL.gif


Examinando la salida
**************

Al finalizar la estimación del modelo, haga clic en el enlace "Estadísticas" para ver la matriz de diseño. Esta es la misma que acabamos de revisar; a continuación, encontrará otra figura titulada "Matriz de covarianza y eficiencia del diseño". Por ahora, tenga en cuenta que es razonable que los cambios porcentuales de la señal necesarios para detectar cada contraste sean inferiores al 2 %.

Haga clic en el enlace "Estadísticas posteriores" para ver un **mapa con umbral** para cada contraste. Este muestra en cada mapa de contraste los vóxeles que superaron el umbral de significancia especificado en la pestaña "Estadísticas posteriores" de la interfaz gráfica de FEAT.


-------

Ceremonias

-------

Video


Haga clic aquí
    `__ para una demostración de cómo configurar el modelo de primer nivel para una sola ejecución.

    
   

