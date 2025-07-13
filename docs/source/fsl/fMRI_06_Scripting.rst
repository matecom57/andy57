

.. _fMRI_06_Scripting:

Tutorial de fMRI n.° 6: Creación de scripts
===============
  
-----------

Descripción general
********

Después de preprocesar y configurar un modelo para una sola ejecución con un solo sujeto, deberá realizar los mismos pasos para todas las ejecuciones de todos los sujetos de su conjunto de datos. Esto puede parecer tedioso, pero es factible: solo tenemos veintiséis sujetos y dos ejecuciones por sujeto. Quizás piense que puede completarse en aproximadamente una semana; y siempre puede asignar la tarea a un par de asistentes de investigación.

Sin embargo, en algún momento te encontrarás con dos problemas:

1. Descubrirá que analizar manualmente cada ejecución no solo es tedioso, sino también propenso a errores, y la probabilidad de cometer un error aumenta significativamente a medida que aumenta el número de ejecuciones a analizar; y

2. Para conjuntos de datos más grandes (por ejemplo, ochenta sujetos con cinco ejecuciones cada uno), este enfoque rápidamente se vuelve impráctico.

Una alternativa es **guionizar** tu análisis. Así como un actor tiene un guion que le dice qué decir, dónde pararse y dónde moverse, tú también puedes escribir un guion que le indique a tu computadora cómo analizar tus conjuntos de datos. Esto tiene la doble ventaja de automatizar tus análisis y permitir analizar conjuntos de datos de cualquier tamaño: el código para analizar dos o doscientos sujetos es prácticamente idéntico.

Primero crearemos una plantilla que contenga el código necesario para analizar una sola ejecución y luego usaremos un bucle for.  ` para automatizar el análisis de todas las ejecuciones. La idea es simple; y aunque el código puede ser difícil de entender al principio, una vez que se familiarice con él, verá cómo puede aplicarlo a cualquier conjunto de datos.

.. nota::

  El siguiente tutorial complementa el tutorial de Unix sobre :ref:`automatizar el análisis
    "Te recomiendo leer ese capítulo si necesitas repasar los términos de Unix para scripts.

Creando la plantilla
*******

Al analizar la primera ejecución de ``sub-08``, se creó un directorio llamado ``run1.feat``. Dentro de este directorio, hay varios archivos y subdirectorios. Uno de estos archivos, ``design.fsf``, contiene todo el código transcrito desde la interfaz gráfica de FEAT a un archivo de texto. Este es el código que FSL ejecuta para realizar cada paso de preprocesamiento y modelado. Si abre el archivo design.fsf en un editor de texto y la interfaz gráfica de FEAT que utilizó para crearlo y los compara, podrá ver dónde se escriben en el archivo design.fsf los datos introducidos en la interfaz gráfica de FEAT.


.. figura:: FEAT_Design_File.png


Si abre la GUI de FEAT, hace clic en el botón «Cargar» en la parte inferior de la pantalla y selecciona el archivo design.fsf en el directorio run1.feat, cambiará todas las configuraciones a las que había ingresado en la GUI cuando guardó el script.

En los tutoriales anteriores, ejecutamos FEAT por separado para el preprocesamiento y el ajuste del modelo. Ahora crearemos una plantilla que combine ambos pasos seleccionando "Análisis completo" en el menú desplegable de la interfaz gráfica de FEAT.

Primero, elimine el directorio actual run1.feat escribiendo ``rm -r run1.feat``. A continuación, abra la interfaz gráfica de FEAT escribiendo ``Feat_gui`` desde la línea de comandos. En lugar de hacerlo en dos sesiones separadas, lo ejecutaremos como un solo análisis dejando seleccionada la opción "Análisis completo" en el menú desplegable. Siguiendo los tutoriales anteriores, complete todos los campos obligatorios para el preprocesamiento y el ajuste del modelo.

Una vez completados todos los campos, en lugar de hacer clic en el botón "Ir", haga clic en "Guardar" y asigne al archivo el nombre "design_run1". Esto guardará varios archivos con extensiones como "con", "mat" y "png", pero será el archivo design_run1.fsf el que usaremos para nuestro script.

Ahora repita el mismo procedimiento para la segunda ejecución, cargando los archivos de datos funcionales y de sincronización correspondientes. Guarde el archivo como design_run2.fsf.

.. nota::

  El resto del proceso de creación de scripts asume que ya está familiarizado con los bucles for.
     `, :ref:`declaraciones condicionales 
      `, y los conceptos básicos de :ref:`scripting 
       ` así como :ref:`sed 
        
         De lo contrario, revise esos tutoriales antes de continuar. Abra design_run1.fsf en un editor de código como TextWrangler.
         `__ y revise todas las opciones que se han completado. (Nota: Si usa TextWrangler, para abrir el archivo .fsf, haga clic en el botón "Opciones" y seleccione "Mostrar elementos ocultos"). Nuestro objetivo es crear una plantilla que pueda ejecutarse para cualquier asignatura, con pequeñas modificaciones que se modificarán en un bucle for. En este caso, solo necesitamos cambiar el nombre de la asignatura; el resto de las opciones serán las mismas para todas. Ejecución del script ********** Mueva los archivos design_run1.fsf y design_run2.fsf al directorio que contiene sus asignaturas (es decir, ``mv design*.fsf ..`` y luego ``cd ..``). A continuación, descargue el script `run_1stLevel_Analysis.sh`. 
         
          `__ and move it to the Flanker directory. The script is reprinted here: :: #!/bin/bash # Generate the subject list to make modifying this script # to run just a subset of subjects easier. for id in `seq -w 1 26` ; do subj="sub-$id" echo "===> Starting processing of $subj" echo cd $subj # If the brain mask doesn’t exist, create it if [ ! -f anat/${subj}_T1w_brain_f02.nii.gz ]; then echo "Skull-stripped brain not found, using bet with a fractional intensity threshold of 0.2" # Note: This fractional intensity appears to work well for most of the subjects in the # Flanker dataset. You may want to change it if you modify this script for your own study. bet2 anat/${subj}_T1w.nii.gz \ anat/${subj}_T1w_brain_f02.nii.gz -f 0.2 fi # Copy the design files into the subject directory, and then # change “sub-08” to the current subject number cp ../design_run1.fsf . cp ../design_run2.fsf . # Note that we are using the | character to delimit the patterns # instead of the usual / character because there are / characters # in the pattern. sed -i '' "s|sub-08|${subj}|g" \ design_run1.fsf sed -i '' "s|sub-08|${subj}|g" \ design_run2.fsf # Now everything is set up to run feat echo "===> Starting feat for run 1" feat design_run1.fsf echo "===> Starting feat for run 2" feat design_run2.fsf echo # Go back to the directory containing all of the subjects, and repeat the loop cd .. done echo This script uses all of the commands and concepts you learned in the Unix tutorials. It begins with a shebang and some comments describing what exactly the script does; and then backticks are used to expand ``seq -w 1 26`` in order to create a loop that will run the body of the code over all of the subjects. The script uses a conditional to check whether the skull-stripped anatomical exists, and if it doesn't, the skull-stripped image is generated. Then the template design*.fsf file is edited to replace the string ``sub-08`` with the current subject's name. The *.fsf files are run with the command ``feat``, which is like running the FEAT GUI from the command line. Echo commands are used throughout the script to let the user know when a new step is being run. You can run the script by simply typing ``bash run_1stLevel_Analysis.sh`` from the Flanker directory. The echo commands will print text to the Terminal when a new step is run, and HTML pages will track the progress of the preprocessing and statistics. .. note:: The script will loop over all of the subjects in the Flanker dataset and do the preprocessing and statistical analysis for each run. The time this will take depends on how fast your machine is, but it should take around 2-4 hours. Be sure to do quality checks for each subject just as you did during the :ref:`Preprocessing tutorials 
          
           `. --------- Video ********* Click `here 
           
            `__ para un video que muestra cómo descargar y ejecutar el script anterior. Es el mismo video que resume el capítulo final de Unix.
            
             `, para mostrar la convergencia entre los dos cursos.
            
           
          
         
        
       
      
     
    
   

