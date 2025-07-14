

.. _Apéndice_I_Eliminación_de_ruido_ICA:

==================================================================
Apéndice I: Análisis de componentes independientes (ICA) con FSL y FIX
==================================================================

------------------

.. nota::

    Los métodos de este tutorial provienen del sitio web de FSL ICA, que se puede encontrar aquí.`__. También me he beneficiado de los ejemplos proporcionados por Carline Nettekoven en su blog`__.

Descripción general: ¿Qué es el análisis de componentes independientes?
**************************************************

El Análisis de Componentes Independientes (ICA) es un método para descomponer una señal compleja en partes más simples. Por ejemplo, una señal convolucional de curso temporal puede descomponerse en una serie de ondas sinusoidales que, al combinarse, recrearían la señal original.

Otro ejemplo de ICA es el uso de software auditivo para separar diferentes fuentes de ruido. Al grabar una entrevista en medio de una sala llena de gente, por ejemplo, el software puede identificar diferentes fuentes de ruido individuales de la grabación original, como voces de otras personas, ruido de fondo y cualquier ruido inducido por el equipo de grabación. Estas fuentes pueden filtrarse de la señal original, lo que resulta en una señal más limpia que se centra en una sola fuente.

Conceptualmente, este es el mismo enfoque que se utiliza al aplicar ICA a datos de fMRI. Estos conjuntos de datos tienen componentes temporales y espaciales, y cada uno de ellos puede extraerse de los datos originales. Dado que los datos de fMRI también contienen ruido de diversas fuentes, como ruido fisiológico, artefactos de movimiento y artefactos del escáner, ICA puede utilizarse para separarlos de la señal BOLD que nos interesa.

Este tutorial se centrará en el análisis de un conjunto de datos con ICA y el posterior filtrado de los componentes de ruido mediante FIX, otra herramienta de FSL. Esto puede ser especialmente útil para depurar datos de poblaciones con alta movilidad, como niños y ciertas poblaciones de pacientes. Para un buen ejemplo de cómo se puede combinar FIX con la regresión de interferencias, como la FD, consulte este artículo.`__ por Jolinda Smith et al. (2022).


Análisis de datos con ICA
***************************

Para ilustrar cómo utilizar ICA, utilizaremos este conjunto de datos
    `__, que contiene datos en estado de reposo de adultos jóvenes y mayores. Para los datos de entrenamiento, me centraré en sujetos con valores inferiores a 1015 a 1024, si desea descargar solo esos sujetos en particular.

Si desea combinar el preprocesamiento y el ICA, puede navegar al directorio principal del conjunto de datos (que contiene todos los temas) y escribir ``Melodic_gui``. Esto abre la interfaz gráfica de usuario de MELODIC, que contiene las mismas pestañas que una canalización FEAT típica: Datos, Preestadísticas, Estadísticas y Postestadísticas. En este caso, sin embargo, la pestaña Estadísticas ofrece opciones para diferentes tipos de ICA.

Podemos analizar todos nuestros sujetos a la vez, en lugar de ejecutar una instancia independiente de la interfaz gráfica de usuario, como hacíamos con FEAT, para cada ejecución de datos funcionales. Recopile todos los datos funcionales de sus sujetos escribiendo:

::

  ls $PWD/sub-*/func/*.nii.gz

Luego, péguelos en la pestaña Datos. Para ello, cambie el número de entradas a 10 y haga clic en "Seleccionar datos 4D" y luego en "Pegar". Luego, haga clic en Aceptar.

En este punto, puede especificar un directorio de salida. Si lo deja en blanco, se creará un directorio etiquetado con el nombre del sujeto y un archivo ``.ica`` adjunto. Lo dejaremos en blanco por ahora y pasaremos a la pestaña Registro, manteniendo los valores predeterminados en la pestaña Pre-Estadísticas.

Descifre sus imágenes con el método que prefiera. Suponiendo que los cerebros descifrados tengan la extensión ``_brain.nii.gz``, puede obtenerlos desde la línea de comandos escribiendo:

::

  ls $PWD/sub-*/anat/*_brain.nii.gz

Luego, péguelos en el campo "Seleccionar imágenes estructurales principales". Haga clic en Aceptar y modifique la configuración de registro si lo desea; por ejemplo, "Búsqueda completa" y "12 grados de libertad".

En la pestaña Estadísticas, deje la opción del menú desplegable "ICA de sesión única". Si lo desea, puede dejar marcada la opción "Estimación automática de dimensionalidad", que intentará estimar un número exhaustivo de componentes. En nuestro caso, desmarquemos la casilla y cambiemos el número de "Componentes de salida" a 60. A continuación, haga clic en "Ir".

El preprocesamiento y la estimación del ICA tomarán un tiempo, quizás alrededor de una hora para todos los sujetos. Al finalizar, dentro del directorio ``.ica`` de cada sujeto, hay otro directorio llamado ``filtered_func_data.ica``. Este contiene los componentes del ICA que ahora podemos etiquetar como ruido o señal.

Etiquetado de los componentes
***********************

Para ver estos componentes, navegue al directorio ``.ica`` que contiene el directorio filtered_func_data.ica y escriba:

::

  fsleyes --scene melódica -ad filtered_func_data.ica

Se abrirá una nueva ventana fsleyes con múltiples cortes axiales y uno de los componentes superpuesto. La ventana inferior izquierda muestra la evolución temporal de ese componente, y la inferior derecha, un espectro de potencia para diferentes frecuencias.

Etiquete cada componente como «Ruido desconocido» o «Señal». Si no está seguro, escriba «Desconocido». Aquí tiene algunas características que puede usar para distinguir entre señal y ruido:

  La señal suele ser:

  -Frecuencia más baja
  -Tiene un curso temporal más suave.
  -Tiene cargas de componentes que son suaves, continuas, dentro de la materia gris y, a menudo, bilaterales.

  El ruido suele ser:

  -Frecuencia más alta
  -Tiene un curso temporal más irregular y discontinuo.
  Presenta cargas en la sustancia blanca, el LCR o en regiones como los globos oculares o el polígono de Willis. Las cargas que rodean el borde del cerebro también indican artefactos de movimiento.

Una vez que haya etiquetado todos los componentes, guárdelos en un archivo llamado "hand_labels_noise.txt", colocando este archivo dentro del directorio ``.ica`` que contiene la carpeta filtered_func_data.ica (*no* la carpeta filtered_func_data.ica en sí).


Entrenamiento FIX en tus datos
*************************

Nuestro siguiente paso es entrenar un clasificador con los componentes etiquetados. Primero, usaremos el comando ``fix`` para extraer las características de nuestros conjuntos de datos ICA. Por ejemplo, podría ejecutar este código desde el directorio de su experimento:

::

  para i en sub-10{15..24}; hacer cd $i/func; arreglar -f *.ica; cd ../..; hecho

Una vez que esto termine, puedes entrenar tu modelo escribiendo:

::

  corrección -t mymodel -l `ls -d $PWD/sub-10{15..24}/func/*.ica`

Esto creará un nuevo modelo, mymodel.pyfix_model, que luego puede usarse para limpiar cualquiera de los sujetos en su conjunto de datos:

::

  Corregir sub-1015/func/sub-1015_task-rest_dir-AP_run-01_bold.ica mymodel.pyfix_model 20

El último parámetro es el umbral de clasificación. En general, los umbrales de entre 5 y 20 son moderados, mientras que menos de 5 es más liberal (es decir, permite más componentes, incluso si son ruido) y más de 20 es más conservador.

Una vez ejecutado este comando, aparecerá un nuevo archivo en la carpeta ``.ica`` llamado ``filtered_func_data_clean.nii.gz``. Compárelo con el archivo original filtered_func_data.nii.gz y compruebe si se eliminan diferentes artefactos. También puede ser útil ejecutar un análisis de correlación basado en semillas a través de la interfaz gráfica de FSLeyes en una región de red robusta para compararlo antes y después de la limpieza.

    
   

