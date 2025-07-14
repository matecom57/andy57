

.. _SPM_06_Scripting:

==========================
Tutorial de SPM n.° 6: Creación de scripts
==========================

----------

Descripción general
********

Después de preprocesar y configurar un modelo para una sola ejecución con un solo sujeto, deberá realizar los mismos pasos para todas las ejecuciones de todos los sujetos de su conjunto de datos. Esto puede parecer tedioso, pero es factible: solo tenemos veintiséis sujetos y dos ejecuciones por sujeto. Quizás piense que puede completarse en aproximadamente una semana; y siempre puede asignar la tarea a un par de asistentes de investigación.

Esta actitud es admirable, y si adoptas este enfoque, eventualmente podrás analizar todos los datos. Pero en algún momento te encontrarás con dos problemas:

1. Descubrirá que analizar manualmente cada ejecución no solo es tedioso, sino también propenso a errores, y la probabilidad de cometer un error aumenta significativamente a medida que aumenta el número de ejecuciones a analizar; y

2. Para conjuntos de datos más grandes (por ejemplo, ochenta sujetos con cinco ejecuciones cada uno), este enfoque rápidamente se vuelve impráctico.

Una alternativa es **guionizar** tu análisis. Así como un actor tiene un guion que le dice qué decir, dónde pararse y dónde moverse, tú también puedes escribir un guion que le indique a tu computadora cómo analizar tus conjuntos de datos. Esto tiene la doble ventaja de automatizar tus análisis y permitir analizar conjuntos de datos de cualquier tamaño: el código para analizar dos o doscientos sujetos es prácticamente idéntico.

Primero crearemos una plantilla que contenga el código necesario para analizar una sola ejecución y luego usaremos un bucle for.  ` para automatizar el análisis de todas las ejecuciones. La idea es simple; y aunque el código puede ser difícil de entender al principio, una vez que se familiarice con él, verá cómo puede aplicarlo a cualquier conjunto de datos.

.. nota::

  El siguiente tutorial complementa el tutorial de Unix sobre :ref:`automatizar el análisis
    "Te recomiendo leer ese capítulo si necesitas repasar los términos de Unix para scripts.

Creando la plantilla
*********************

Al analizar los datos de ``sub-08``, al hacer clic en cada botón de preprocesamiento de la interfaz gráfica de usuario de SPM, se abrió una ventana del **Editor de Lotes**. Para crear nuestra plantilla de script, comenzaremos con el Editor de Lotes y añadiremos cada uno de los **módulos** de preprocesamiento a nuestro lote. A continuación, completaremos las entradas necesarias para cada sección de preprocesamiento y modelado estadístico, tal como hicimos en los tutoriales anteriores, y convertiremos lo que vemos en la interfaz gráfica a código de Matlab.

Para comenzar, abra la interfaz gráfica de SPM y haga clic en el botón "Lote". En la parte superior de la ventana del Editor de lotes, haga clic en el menú "SPM" y seleccione los siguientes módulos en este orden:

::

  BasicIO -> Operaciones de archivo/directorio -> Operaciones de archivo -> Selector de archivos con nombre
  SPM -> Espacial -> Realinear -> Estimar y rebanar
  SPM -> Temporal -> Sincronización de segmentos
  SPM -> Espacial -> Coregistro: Estimación y reorganización
  SPM -> Espacial -> Segmento
  SPM -> Espacial -> Normalizar -> Escribir
  SPM -> Espacial -> Suave
  BasicIO -> Operaciones de archivo/directorio -> Operaciones de archivo -> División de conjunto de archivos
  SPM -> Estadísticas -> Especificación del modelo fMRI
  SPM -> Estadísticas -> Estimación del modelo
  SPM -> Estadísticas -> Administrador de contraste
  
Cuando haya terminado, el panel "Lista de módulos" debería verse así:

.. figure:: 06_ListaMódulos.png

Selección y división de archivos
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Quizás hayas notado dos módulos adicionales que no parecen estar relacionados directamente con el análisis de datos: el «Selector de archivos con nombre» y la «División de conjunto de archivos».

El primero, "Selector de Archivos con Nombre", requiere un nombre de entrada y conjuntos de archivos. Crearemos dos conjuntos de archivos e ingresaremos los archivos "run-1_bold.nii" y "run-2_bold.nii" para cada conjunto. Al llegar al primer módulo de preprocesamiento, Realineación, crearemos dos sesiones e ingresaremos los archivos correspondientes para cada una.

.. figure:: 06_NamedFileSelector.png

El módulo Suavizado solo acepta una sesión de imágenes; en nuestro ejemplo, las imágenes generadas por el módulo Normalización. Dado que el siguiente módulo de preprocesamiento, Especificación del Modelo, requiere un conjunto de archivos independiente para cada sesión, no podemos usar el conjunto de archivos del módulo Suavizado como **dependencia** (se explica con más detalle a continuación). El módulo División de Conjunto de Archivos permite dividir el conjunto de imágenes de salida del módulo Suavizado en dos conjuntos independientes, que luego podemos usar como dependencias en el módulo Especificación del Modelo.

Primero, etiquetamos el nombre del conjunto de archivos como ``run1run2FileSplit`` (este nombre es simplemente una etiqueta de referencia para los módulos posteriores). El conjunto de archivos de entrada son las imágenes suavizadas del módulo Suavizado y, al igual que con el módulo Selector de archivos con nombre, creamos dos conjuntos de archivos de salida. El índice de selección del primero es ``1`` y el del segundo es ``2``. Esto indica al módulo que divida las imágenes suavizadas en dos conjuntos separados, según cómo las etiquetó el módulo Selector de archivos con nombre anterior.

.. figure:: 06_FileSetSplit.png

Rellenando los módulos de preprocesamiento
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ahora deberá completar cada uno de los campos obligatorios, tal como hicimos en los capítulos anteriores. Esta será la parte más tediosa del tutorial, pero recuerde: si no programa su análisis, tendrá que hacerlo manualmente para *cada sujeto de su estudio*. El tiempo que esto tomaría, sumado al hecho de que la probabilidad de cometer un error aumenta con cada sujeto que analice manualmente, debería hacer que esta parte valga la pena.

A medida que avanza, puede que en algún momento se pregunte qué debe introducir en un paso posterior de preprocesamiento si aún no se han creado los datos necesarios. El Editor de Lotes le permite usar **Dependencias** de pasos anteriores, lo que indica que la entrada debe provenir de la salida del paso anterior. Por ejemplo, en el módulo Realinear, si hace clic en el botón "Dependencia" para la primera sesión, puede seleccionar la opción "Selector de archivos con nombre: run1run2Files(1)", y lo mismo para la segunda sesión. Debería verse así una vez completado:

.. figure:: 06_RealignDependency.png

Y lo mismo con el módulo Slice Timing:

.. figure:: 06_SliceTimingDependency.png

De igual forma, la Imagen de Referencia del paso de Coregistro puede utilizar la imagen funcional media generada durante la Realineación:

.. figure:: 06_CoregisterDependency.png

A esto le sigue la Segmentación, que utilizará los mismos parámetros que especificamos :ref:`earlier <04_SPM_Segmentation>`:

.. figure:: 06_SegmentDependency.png

El paso de preprocesamiento Normalizar requiere tanto los campos Deformación hacia adelante de Segmentación, como también las salidas de Sincronización de corte de las Sesiones 1 y 2 (que puede seleccionar manteniendo presionada la tecla Shift y haciendo clic):

.. figure:: 06_NormaliseDependency.png

El módulo Suavizar utilizará las imágenes generadas por Normalización:

.. figure:: 06_SmoothDependency.png

Y el módulo de Especificación del Modelo utilizará las imágenes creadas durante el Suavizado:

.. figure:: 06_ModelSpecificationDependency.png

El módulo Estimación del modelo analiza la salida de datos de la Especificación del modelo:

.. figure:: 06_ModelEstimationDependency.png

Y por último, el administrador de contraste cargará el archivo SPM.mat creado por el módulo Estimación del Modelo:

.. figure:: 06_ContrastDependency.png

Para el módulo de contraste, seleccionamos la opción "Replicar y escalar". Esto replicará los pesos de contraste en todas las sesiones de ese sujeto y los escalará en proporción inversa al número de sesiones. En este ejemplo, al haber dos sesiones, cada peso de contraste se escalará a 0,5 y -0,5, respectivamente.


Edición del archivo Matlab
************************

El módulo por lotes que acabamos de crear es específico para ``sub-08``: Hemos utilizado las imágenes y los archivos de cronometraje de sub-08, y los resultados solo se aplicarán a sub-08. Si hace clic en el botón verde "Ir", se ejecutarán todos los pasos de preprocesamiento y estimación del modelo de una sola vez. Sin embargo, con algunos ajustes, podemos adaptar este módulo a todos los demás sujetos de nuestro estudio.

Primero, necesitamos guardar los módulos en un script de Matlab. Haga clic en "Archivo -> Guardar lote y script" y etiquételo como "RunPreproc_1stLevel". Guárdelo en el directorio de Flanker que contiene todos sus temas. Esto creará un archivo de script de Matlab que podrá abrir en la ventana de Matlab.

Desde la terminal de Matlab, navegue hasta el directorio Flanker que contiene el script RunPreproc_1stLevel.m y escriba

::

  abrir RunPreproc_1stLevel_job.m
  
Para adaptar este archivo para que pueda analizar cualquier tema, necesitaremos realizar las siguientes ediciones:

1. Reemplace el número "08" con una variable que contenga un número de sujeto diferente en cada instancia de un bucle for; y
2. Reemplace el nombre de usuario (en este caso, "ajahn") con una variable que apunte al nombre de usuario de la máquina que se esté utilizando actualmente.

Estos dos cambios nos permitirán colocar el código existente en un bucle for que se ejecutará sobre un conjunto de números que indican cada sujeto en el estudio.

Al comienzo del script, escriba el siguiente código:

::

  sujetos = [01 02]; % Reemplazar con una lista de todos los sujetos que desea analizar

  usuario = getenv('USUARIO'); % Devolverá el nombre de usuario para los sistemas operativos OSX

  para sujeto=sujetos

  sujeto = num2str(sujeto, '%02d');

  si isfile(['/Usuarios/' usuario '/Escritorio/Flanker/sub-' asunto '/func/sub-' asunto '_task-flanker_run-1_bold.nii']) == 0
      display('La ejecución 1 no se ha descomprimido; se está descomprimiendo ahora')
      gunzip(['/Usuarios/' usuario '/Escritorio/Flanker/sub-' asunto '/func/sub-' asunto '_task-flanker_run-1_bold.nii.gz'])
  demás
      display('La ejecución 1 ya está descomprimida; no hace nada')
  fin

  si isfile(['/Usuarios/' usuario '/Escritorio/Flanker/sub-' asunto '/func/sub-' asunto '_task-flanker_run-2_bold.nii']) == 0
      display('Run 2 no ha sido descomprimido; se está descomprimiendo ahora')
      gunzip(['/Usuarios/' usuario '/Escritorio/Flanker/sub-' asunto '/func/sub-' asunto '_task-flanker_run-2_bold.nii.gz'])
  demás
      display('Run 2 ya está descomprimido; no hace nada')
  fin

  si isfile(['/Usuarios/' usuario '/Escritorio/Flanker/sub-' asunto '/anat/sub-' asunto '_T1w.nii']) == 0
      display('La imagen anatómica no ha sido descomprimida; se está descomprimiendo ahora')
      gunzip(['/Usuarios/' usuario '/Escritorio/Flanker/sub-' asunto '/anat/sub-' asunto '_T1w.nii.gz'])
  demás
      display('La imagen anatómica ya está descomprimida; no se hace nada')
  fin
  
  
También debe escribir la palabra «end» en la última línea del script para indicar que todo el código anterior es parte del bucle for.

El código anterior hace lo siguiente:

* Primero, se crea una matriz de números y se almacena en la variable **sujetos**. Los valores son ``01`` y ``02``; posteriormente, ampliaremos esta matriz para incluir todos los números de identificación de los sujetos en nuestro experimento.

* A continuación, la variable ``usuario`` toma el valor devuelto por el comando ``getenv('USER')``. Esto debería devolver el nombre de usuario del usuario actual de la computadora; en el ejemplo actual, "ajahn".

* A continuación, iniciamos un bucle for que se inicializa con el código ``for subject=subjects``. Esto significa que una nueva variable, "subject", asumirá el valor de cada entrada consecutiva en el array "subjects". En otras palabras, la primera instancia del bucle asignará el valor "01" a ``subject``; en la segunda instancia, asignará el valor "02", y así sucesivamente, hasta que el bucle llegue al final del array.

* Dado que un array elimina los ceros iniciales y necesitamos convertir los números del array a una cadena, la variable "subject" se convierte mediante el comando ``num2str``. El texto ``'%02d'`` es **código de formato de cadena** que indica que el valor actual que se está convirtiendo de número a cadena debe **rellenarse con ceros** hasta que el número tenga dos caracteres. (Puede encontrar más información sobre el formato de cadena aquí)
     `__.)

* Las declaraciones condicionales :ref:`
      ` busque si existen los archivos funcionales y anatómicos descomprimidos y, si no existen, los archivos se descomprimen utilizando el comando ``gunzip`` de Matlab.


Concatenación de cadenas
^^^^^^^^^^^^^^^^^^^^^

En el resto del código generado al guardar el módulo Batch como script de Matlab, tendremos que reemplazar cada instancia de ``08`` con la cadena ``subject``, y cada instancia de ``ajahn`` (o el nombre de usuario) con la variable ``user`` definida anteriormente. Esto se puede hacer usando la función de búsqueda y reemplazo, pero asegúrese de que no haya otras instancias de la cadena "08" que no estén asociadas a la cadena "sub-".

En el código de ejemplo anterior, usamos corchetes para **concatenar horizontalmente** cadenas con variables. Una línea de código como la siguiente:

::

  ['/Usuarios/' usuario '/Escritorio/Flanker/sub-' asunto '/anat/sub-' asunto '_T1w.nii']
  
Concatenará las cadenas entre apóstrofes individuales con las variables. Si la variable "usuario" contiene el valor "ajahn" y la variable "asunto" contiene el valor "08", el código anterior se expandiría a lo siguiente:

::

  '/Usuarios/ajahn/Escritorio/Flanker/sub-08/anat/sub-08_T1w.nii'
  
Deberá realizar estas sustituciones para el resto del script, procurando usar apóstrofes simples para separar las cadenas de las variables. Se requerirán corchetes para esta concatenación, incluso dentro de las **celdas** marcadas con llaves. (Las celdas son matrices que pueden contener varios tipos de datos, como cadenas y números).


Cargando los archivos de inicio
^^^^^^^^^^^^^^^^^^^^^^^

The last part of the script we have to edit is the onset times. In this experiment, each subject had different onset times for each condition. If the timing files have already been converted to a different format, then you can create a variable that contains the timing information and insert it into the "onset" field for the stats module. For example, the following code found around line 107 of the Matlab script can be changed from this, which contains onset times specific to sub-08:

::

  matlabbatch{9}.spm.stats.fmri_spec.sess(1).cond(1).onset = [0
                                                            10
                                                            20
                                                            52
                                                            88
                                                            130
                                                            144
                                                            174
                                                            248
                                                            260
                                                            274];
                                                            
To this:

::

  data_incongruent_run1 = load(['/Users/' user '/Desktop/Flanker/sub-' subject '/func/incongruent_run1.txt']);

  matlabbatch{9}.spm.stats.fmri_spec.sess(1).cond(1).onset = data_incongruent_run1(:,1);
  
In which the variable ``data_incongruent_run1`` stores the onset times for the subject in the current loop, and then enters those numbers into the onset field. Note that the code (:,1) indicates that only the first column of the variable should be read, which contains the onset times.

.. note::

  You will need to read the onset times for each session and each condition separately - i.e., you will need to create variables for the Incongruent and Congruent conditions for both run 1 and run 2.
  
  
Running the Script
******************
  
When you have finished editing the script, save it and return to the Matlab terminal. You can then execute the script by typing:

::

  RunPreproc_1stLevel_job
  
You will then see windows pop up as each preprocessing and statistical module is run, similar to what you would see if you executed each module manually through the GUI.


Next Steps
**********

The script should only take a few minutes to run for both sub-01 and sub-02. When you are finished, we will examine the output; and as you will see, there are still some issues that need to be resolved. To see what the problems are, and how to fix them, click the ``Next`` button.

A copy of this script can be found on Andy's github page located `here 
       `__. Note that the script is set up to analyze all 26 subjects in the dataset.


Video
*****

For a video tutorial of how to script your analysis in SPM, click `here 
        
         `__.
        
       
      
     
    
   

