

.._SPM_PPI:

=========================================================
Apéndice B: Interacciones psicofisiológicas (PPI) en SPM
=========================================================

----------


.. nota::

  En esta página actualmente estoy tomando notas sobre cómo hacer un PPI a nivel de grupo en SPM y aún está en construcción.
  

Descargar
********
  
Los datos provienen de la base de datos del Proyecto Conectoma Humano.`__; haga clic en el menú desplegable junto a Datos de HCP de WU-Minn - 1200 sujetos y seleccione `sujetos con datos de sesión de RM 3T`.


Estructura de datos
**************

Dentro de cada directorio de temas (con IDs de tema como 100206), hay un directorio llamado `MNINonLinear/Results`. Este contiene dos directorios con datos funcionales: tfMRI_SOCIAL_LR y tfMRI_SOCIAL_RL. Los datos han sido preprocesados, excepto el paso de suavizado; deberá aplicarlo usted mismo.

Antes de comenzar, cree los siguientes directorios en la carpeta de cada tema con el comando ``mkdir`` de Matlab:

::

  1er nivel_Concat
  IPP

Preparación para el análisis del PPI
******************************

Una vez suavizados los datos, los directorios contendrán los archivos "stfMRI_SOCIAL_LR.nii" y "stfMRI_SOCIAL_RL.nii". Los combinaremos en un único conjunto de datos, ya que la función PPI de SPM no puede procesar conjuntos de datos con más de una ejecución. Para tener en cuenta que combinamos todos los datos en una sola ejecución y que la señal puede ser sistemáticamente diferente entre ejecuciones, incluiremos *ambos* en nuestro análisis de primer nivel.

Concatenando los regresores del movimiento
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Los regresores de movimiento también deberán concatenarse verticalmente en un solo archivo. Acceda al directorio tfMRI_SOCIAL_LR y escriba:

::

  gato Movimiento_Regresores.txt ../tfMRI_SOCIAL_RL/Movimiento_Regresores.txt > todosMovimiento_Regresores.txt
  
  
Creación del lote de especificaciones del modelo
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

En este estudio, el TR es de 0,72 y cada ejecución tiene 274 volúmenes. Esto significa que cada ejecución tiene una duración de 0,72 * 274 = **197,28 segundos**. Por lo tanto, sumaremos 197,28 a los tiempos de la segunda ejecución para generar los siguientes tiempos de inicio para una sola ejecución concatenada:

Mental:
8.21
122.056
205.476
243.287
319.336

Ronda:
46.008
84.032
160.081
281.311
357.36

Cada tiempo de inicio dura 23 segundos (es decir, se trata de un diseño de bloques). Puede haber discrepancias de algunas milésimas de segundo entre sujetos, pero al ser un diseño de bloques, este esquema de tiempo puede utilizarse para todos los sujetos.

Abra la interfaz gráfica de SPM, haga clic en "Lote" y, en el menú, seleccione "SPM -> Estadísticas -> Especificación del modelo fMRI". Agregue los siguientes módulos, también en el menú SPM -> Estadísticas: "Estimación del modelo" y "Administrador de contraste".

En el módulo de especificación del modelo fMRI, seleccione la carpeta ``1stLevel_Concat`` como Directorio. Cambie las Unidades de diseño a ``Segundos`` y el Intervalo entre escaneos a ``0.72``. Haga clic en ``Datos y Diseño`` y luego seleccione ``Nuevo: Asunto/Sesión``. Haga doble clic en el botón ``Escaneos`` y seleccione primero los archivos stfMRI_SOCIAL_LR.nii y, a continuación, los archivos stfMRI_SOCIAL_RL.nii (este orden es importante). En la ventana de selección, introduzca ``^s.*`` en el campo Filtro para ver solo los archivos que empiezan por 's' y, en el campo Fotogramas, escriba ``1:274`` para ampliar el número de volúmenes a 274. Repita este proceso para cada directorio LR y RL.

.. cifra::

  SPM_PPI_SelectFiles.png
  

Ahora haga clic en "Condiciones" y luego dos veces en "Nueva:Condición". Cambie el nombre de la primera condición a "Mental" y el de la segunda a "Rnd". Especifique una duración de "23" para ambas y, en el campo "Inicios", copie y pegue los tiempos anteriores para cada condición correspondiente.

Para tener en cuenta el efecto del bloqueo, haga clic en "Regresores" y seleccione "Nuevo: Regresor". Asigne el nombre a "bloque1" y haga doble clic en "Valor". En el campo "Valor", escriba lo siguiente:

::

  kron([1 0]',ones(274,1))
  
Esto creará un vector columna con 274 unos, seguidos de 274 ceros. Estos representan el primer y el segundo bloque, respectivamente.

Finalmente, haga clic en "Regresores múltiples" y cargue el archivo "allMovement_Regressors.txt" que creó anteriormente. Al terminar, la especificación de su modelo debería verse así:

.. figure:: SPM_PPI_ModelSpecification.png


Ahora terminaremos de editar los demás módulos de nuestro lote. Haga clic en "Estimación del modelo" en la ventana izquierda, seleccione "Seleccionar SPM.mat" con el ratón y, a continuación, haga clic en "Dependencia". Seleccione el archivo SPM.mat del paso de especificación del modelo fMRI.

.. figure:: SPM_PPI_ModelEstimation.png

A continuación, haga clic en el módulo ``Administrador de Contraste``. Nuevamente, resalte ``Seleccionar SPM.mat`` con el mouse y luego haga clic en ``Dependencia``. Elija el archivo SPM.mat del paso de *estimación* del modelo. Luego haga clic en ``Sesiones de Contraste`` y haga clic en ``Nuevo: T-contraste`` para crear tres nuevos T-contrastes. Etiquete el primero como ``Mental``, el segundo como ``Rnd`` y el tercero como ``Mental-Rnd``. Para el contraste Mental, especifique un vector de [1 0]; para el contraste Rnd, especifique un vector de [0 1]. Para el contraste Mental-Rnd, especifique un vector de [1 -1]. Dado que solo hay una ejecución, no necesita Replicar y Escalar los pesos de contraste, pero hacerlo tampoco afectará su análisis.

.. figure:: SPM_PPI_ContrastManager.png


Ahora guarde el lote y el script haciendo clic en "Archivo -> Guardar lote y script". Etiquete la salida como "Sample_Concatenated_1stLevel". A continuación, haga clic en el botón verde "Reproducir" en la esquina superior izquierda de la interfaz gráfica para ejecutar el lote. Debería tardar entre 15 y 20 minutos. Al finalizar, la matriz de diseño debería verse como la siguiente:

.. figure:: SPM_PPI_DesignMatrix.png


La interfaz PPI
^^^^^^^^^^^^^^^^^

Ya estamos listos para comenzar nuestro análisis de PPI. Antes de empezar, asegúrese de tener una región de interés (o ROI, también conocida como máscara) para usar. Estas se pueden crear con Marsbar u otro software, como 3dUndump de AFNI o fslmaths de FSL. En nuestro ejemplo, supongamos que ha creado una ROI llamada dmPFC centrada en la corteza prefrontal dorsomedial. Estas ROI se almacenarán en el directorio que contiene todos los directorios temáticos.

Para comenzar, abra la interfaz gráfica de usuario de SPM y haga clic en el botón "PPIs". Se le pedirá que seleccione un archivo SPM.mat; seleccione el que acaba de crear, ubicado en el directorio "1stLevel_Concat". A continuación, se le pedirá que seleccione un tipo de análisis: elija "interacción psicofisiológica" y luego "VOI_dmPFC.mat". Incluya "Mental" y "Rnd" cuando se le solicite, y asígneles pesos de 1 y -1, respectivamente. Etiquete el PPI de salida como "PPI".

Luego verá una ventana que muestra las respuestas hemodinámicas y neuronales estimadas (después de que se haya deconvolucionado la respuesta hemodinámica) y los tiempos de inicio de los bloques de su experimento, convolucionados con la HRF.

.. figure:: SPM_PPI_SummaryPage.png

Esto creará una variable en su espacio de trabajo llamada "PPI". Puede cargarla desde la línea de comandos escribiendo "load PPI". Esto permite usar varios campos de la variable PPI, incluyendo:

::

  PPI.P: Los tiempos de inicio convolucionados
  PPI.Y: La serie temporal extraída del VOI
  PPI.ppi: El término de interacción creado por el análisis del PPI
  
Nuestro objetivo ahora es incluir estas tres variables en otro GLM, lo que nos permitirá estimar un peso beta en cada vóxel para el PPI utilizando un VOI (en este caso, el dmPFC).


Configuración del análisis de PPI
***************************

Primero, habilite el uso de los campos PPI escribiendo lo siguiente en el indicador de Matlab:

::

  cargar PPI_PPI.mat

Debería ver la variable "PPI" en su espacio de trabajo.

Ahora, abra la interfaz gráfica de usuario de SPM y haga clic en el botón "Lote". Como antes, en el menú, haga clic en "SPM -> Estadísticas -> Especificación del modelo fMRI". Agregue los siguientes módulos, también en el menú SPM -> Estadísticas: "Estimación del modelo" y "Administrador de contraste".

En el módulo de especificación del modelo fMRI, configure el modelo como se indicó anteriormente: Unidades de tiempo en segundos y TR de 0,72, y los mismos escaneos. Seleccione la carpeta "PPI" como directorio de salida. A continuación, haga clic en "Datos y Diseño" y, a continuación, en "Nuevo: Sujeto/Sesión". En lugar de condiciones, esta vez introduciremos regresores, ya que ya se han convolucionado con la función de respuesta hemodinámica. Cree cuatro nuevos regresores y asígneles los siguientes nombres y valores:

::

  Regresor 1: Nombre=PPI_Interaction / Valor=PPI.ppi
  Regresor 2: Nombre=dmPFC_BOLD / Valor=PPI.Y
  Regresor 3: Nombre=Mental-Rnd / Valor=PPI.P
  Regresor 4: Nombre=bloque1 / Valor=kron([1 0]',ones(274,1))
  
También haga doble clic en "Regresores múltiples" y especifique el archivo allMovement_Regressors.txt. Al terminar, la ventana de especificación del modelo debería verse así:

.. figure:: SPM_PPI_Model_Specification_PPI.png

Establezca el archivo SPM de estimación del modelo como una dependencia que recurra a la salida del módulo de especificación del modelo fMRI y especifique el archivo SPM en el Gestor de Contraste como la salida de dependencia del módulo de estimación del modelo. En el módulo Gestor de Contraste, cree un contraste T y asígnele el nombre ``dmPFC_PPI_Interaction``. Asígnele un vector de ponderación de ``1``. A continuación, guarde el lote y el script como ``Run_dmPFC_PPI`` en el directorio de resultados, que contiene las carpetas 1stLevel_Concat y PPI. A continuación, pulse el botón verde "Reproducir" para ejecutar el análisis.
  

