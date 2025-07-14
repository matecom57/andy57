

.. _Apéndice C_Modulación Paramétrica:

=================================
Apéndice C: Modulación paramétrica
=================================

------------------

Descripción general
********

Este tutorial le mostrará cómo configurar un análisis de modulación paramétrica en SPM. Puede encontrar una reseña de la modulación paramétrica, así como del conjunto de datos que analizaremos, aquí.`. Este tutorial se centrará en el preprocesamiento de los datos y el uso de los moduladores paramétricos en el modelo lineal general.

Preprocesamiento de los datos
**********************

------------------

Creación de los archivos de sincronización
^^^^^^^^^^^^^^^^^^^^^^^^^

Primero, crearemos archivos de tiempo que contengan los inicios de la apuesta, el valor paramétrico de la ganancia potencial y el valor paramétrico de la pérdida potencial para cada ejecución; en total, crearemos nueve regresores.

Puede descargar un script para convertir los tiempos a un formato que SPM entienda haciendo clic aquí
    `__, haciendo clic en el botón ``Raw``, haciendo clic derecho en cualquier parte de la pantalla y seleccionando ``Guardar como``. Guarda el archivo como un script de shell en el directorio ``Gambles``. Una vez descargado, accede a ese directorio con una terminal y ejecuta el script escribiendo ``bash make_FSL_Timings_Gambles.sh``. Deberías ver nueve archivos de texto en cada directorio ``func``:

.. figure:: Apéndice_F_Onsets.png

Creación del script de preprocesamiento
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Similar a la sección de scripts :ref:`
     En el tutorial de SPM, crearemos un script por lotes que se puede usar en un bucle for para analizar todos nuestros sujetos. Suponiendo que ya conoce los detalles del preprocesamiento, no explicaremos cómo completar cada campo; sin embargo, para este conjunto de datos, tenga en cuenta que los datos funcionales y anatómicos del sujeto 01 deben reorientarse para normalizar el cerebro correctamente. Desde la terminal de Matlab, acceda a los directorios ``anat`` y ``func`` y descomprima los archivos con:

::

  gunzip *.gz
  
A continuación, abra la interfaz gráfica de usuario de SPM, haga clic en el botón "Mostrar" y seleccione "sub-01_task-mixedgambletask_run-01_bold.nii". Las imágenes de este sujeto están inclinadas hacia adelante en la orientación de inclinación; para deshacer esta corrección, escriba "6" en el campo "inclinación (rad)" y establezca el origen en la comisura anterior. Haga clic en "Reorientar" y aplique estas transformaciones a todas las imágenes funcionales. A continuación, abra la imagen anatómica en la misma ventana de visualización y establezca el origen en la comisura anterior. El resto de los pasos deberían ejecutarse sin errores.

Para preparar los datos para un análisis de modulación paramétrica, crearemos una secuencia de preprocesamiento similar a la que usamos para el conjunto de datos de ejemplo :ref:`aquí
      Si aún no lo ha hecho, consulte el tutorial con el conjunto de datos Flanker; allí encontrará los detalles de cada paso de preprocesamiento y análisis estadístico, que no analizaremos aquí en profundidad. Los módulos de corregistro, corrección de tiempos de corte y normalización son prácticamente idénticos. La única diferencia importante radica en la configuración del modelo, que tiene una condición por ejecución (aquí denominada "Gamble") y dos moduladores paramétricos: Gain y Loss. Establecemos la expansión polinomial en primer orden y cambiamos la opción "Ortogonalizar modulaciones" de "Sí" a "No". Este último paso es importante; el valor predeterminado "Sí" ortogonalizará todos los moduladores paramétricos con respecto al primero, lo que dificulta enormemente (y artificialmente) generar un resultado significativo para cualquier modulador que no sea el primero. Para una explicación detallada de por qué esto sucede, consulte este artículo. 
       `__ de Jeanette Mumford.

En este punto, deberá guardar el archivo Batch y editar el script de Matlab para convertirlo en un bucle for; ya se ha creado un script editado `aquí`.
        
         `__, que puede descargar haciendo clic en ``Raw``, haciendo clic derecho en cualquier parte de la pantalla y seleccionando ``Guardar como``. Guárdelo en su directorio ``Gambles``, eliminando la extensión ".txt". Luego, desde la terminal de Matlab, asegúrese de estar en el directorio ``Gambles`` y escriba: :: run1stLevelAnalysis_job_PM. Esto iniciará el preprocesamiento y el análisis de todos los sujetos, y tardará entre tres y cuatro horas. Configuración del análisis de segundo nivel ************************************ Para nuestro análisis grupal, crearemos dos directorios: uno para la modulación paramétrica de la ganancia y otro para la modulación paramétrica de la pérdida. Desde la terminal de Matlab, escriba: :: mkdir 2ndLevel_GainPM mkdir 2ndLevel_LossPM Luego, haga clic en ``Especificar 2do nivel`` desde la GUI de SPM, y para el campo ``Directorio`` seleccione ``2ndLevel_GainPM``. Dentro de ``Escaneos``, use el campo de filtro para seleccionar ``con_0001.nii``, que es el contraste para el modulador de ganancia, y luego haga clic en el botón ``Ir``. Estime el modelo y luego haga clic en ``Resultados``; escriba ``GainPM`` para el nombre y asígnele un peso de contraste de +1. Haga clic en ``Aceptar`` y configure los siguientes parámetros: :: Aplicar enmascaramiento -> ninguno ajuste del valor p al control -> ninguno -> 0.001 umbral de extensión (vóxeles) -> 50 Estos umbrales se han elegido ad hoc, pero deberían estar cerca de brindarle una tasa de falsos positivos de conglomerado de p = 0,05. Haga clic en ``superposiciones -> secciones`` y seleccione una plantilla del directorio ``canónico`` de su carpeta SPM. Debería ver un mapa de activación como este, con grupos significativos dentro del estriado ventral: .. figure:: ApéndiceC_GainPM.png Ahora haga el mismo procedimiento para los moduladores paramétricos de pérdida, que deberían ser la imagen con_0002.nii. En la ventana ``Resultados``, asígnele un peso de -1, usando los mismos parámetros que antes. Compare ambos resultados con Tom et al., 2007, y observe si hay un patrón similar. .. figure:: ApéndiceC_LossPM.png .. figure:: Apéndice_F_Tom_Results.png Los resultados originales de Tom et al., 2007. Próximos pasos ********** Es posible que haya notado que el alcance de los resultados no es el mismo que en el artículo original de Tom et al. Una opción para mejorar los resultados es usar la Mejora de Clústeres sin Umbral (TFCE), como se describe en este capítulo. Si tiene instalado FSL, puede fusionar todas las imágenes con_0001.nii, por ejemplo, escribiendo: :: fslmerge -t allCon_0001s.nii.gz `ls $PWD/sub-??/1stLevel/con_0001*`. Luego, ejecute randomise con la opción TFCE: :: randomise -i allCon_0001s.nii.gz -o allCon_0001s_randomise -1 -T -n 5000. Luego, puede cargar el archivo ``allZs_randomise_tfce_corrp_tstat1`` en fsleyes y cambiar el umbral ``Mín.`` a 0,95. Esto mostrará todos los clústeres TFCE con un umbral alfa de p=0,05. Observe cuántos clústeres adicionales hay y cómo se ocultaron con el enfoque SPM tradicional. Vídeo ***** Para ver una captura de pantalla sobre cómo configurar un análisis de modulación paramétrica en SPM, haga clic aquí.
         
          `__.
         
        
       
      
     
    
   

