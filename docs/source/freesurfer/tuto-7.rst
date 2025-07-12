Tutorial de FreeSurfer n.° 7: El archivo FSGD
=====================================

---------------

.. nota::

  Antes de comenzar este tutorial, cree un directorio llamado ``FS`` dentro del directorio ``Cannabis``. Este directorio debe contener todos los directorios generados por recon-all. Ejecute los comandos de recon-all desde ese directorio o muévalos al directorio FS con el comando ``mv``.

Comparación de grupos
****************

Hasta ahora hemos revisado los comandos básicos de FreeSurfer: recon-all y freeview. Recon-all crea una serie de volúmenes y superficies a partir de una imagen anatómica ponderada en T1 y cuantifica el grosor y el volumen de la materia gris en diferentes regiones del cerebro. Las regiones corticales se denominan **parcelaciones** y las subcorticales, **segmentaciones**. Por ejemplo, la circunvolución frontal superior izquierda es una parcelación delineada por el atlas de Desikan-Killiany, y se calculan mediciones estructurales en esa región para cada sujeto. La amígdala derecha, en cambio, es una segmentación; dado que las regiones subcorticales no se expanden hasta formar una superficie, solo contienen mediciones del volumen de la materia gris, no del grosor.

En este punto, quizás esté pensando en cómo comparar las mediciones estructurales entre grupos y cómo representar esas diferencias en la superficie cerebral. El procedimiento es similar al análisis fMRI: al igual que comparamos vóxeles en fMRI, comparamos vértices en FreeSurfer. Si los vértices se encuentran en un espacio común, como MNI, podemos calcular las diferencias en el espesor de la materia gris en un vértice específico y comprobar si dicha diferencia es significativa. Esto genera mapas estadísticos que podemos superponer sobre una plantilla cerebral como mapa de superficie.


.. figura:: 07_Análisis_de_Grupo_FS.png
  :escala: 50%
  
  Ejemplo de un resultado de análisis de grupo asignado a la plantilla fsaverage. Los colores azules más claros representan estimaciones de contraste más negativas, mientras que los amarillos representan estimaciones de contraste más positivas.
  
  
El cerebro modelo que utilizamos, mencionado brevemente en los tutoriales anteriores, se llama «fsaverage». Se trata de un promedio de 40 sujetos que se combinaron mediante la técnica de promedio esférico descrita en «Fischl et al., 1999».`__. Las coordenadas de este cerebro se utilizan como un espacio estandarizado para el resto de los cerebros que se normalizan a la plantilla fsaverage.


Organizando los directorios
**************************

Primero, copiaremos la plantilla fsaverage a nuestro directorio actual. Vaya al directorio Cannabis, que contiene todos los temas (es decir, ``Cannabis/FS``), y escriba:

::

  cp -R $FREESURFER_HOME/temas/fsaverage .
  
Para copiar la plantilla fsaverage. Una vez hecho esto, configure la variable SUBJECTS_DIR en el directorio actual escribiendo ``export SUBJECTS_DIR=`pwd```. Esto colocará la salida de cualquier comando de análisis de grupo o recon-all en el directorio actual:

::

  setenv SUBJECTS_DIR `pwd`
  
.. nota::

  Las comillas invertidas que encierran ``pwd`` mostrarán la ruta absoluta al directorio actual; en otras palabras, reemplazarán ```pwd``` con el resultado de escribir el comando ``pwd``. Esta abreviatura será útil, así que practíquela siempre que pueda.
  
También crearemos dos directorios llamados ``FSGD`` y ``Contrasts``, que contendrán los archivos de texto necesarios para ejecutar nuestro análisis:

::

  mkdir FSGD Contrastes
  

Creación del archivo FSGD
**********************

El conjunto de datos de Cannabis incluye un archivo llamado ``participants.tsv`` que contiene etiquetas y covariables para cada sujeto: grupo, género, edad, inicio del consumo de cannabis, etc. Para crear un archivo de Descriptor de Grupo de FreeSurfer (FSGD), extraemos las covariables o etiquetas de grupo que nos interesan y las formateamos de forma que FreeSurfer las entienda. El archivo FSGD contendrá las covariables que queremos contrastar, y un archivo de contraste independiente indicará qué covariables contrastar y qué ponderaciones asignarles.


.. figura:: 07_Archivo_Participante.png

  Captura de pantalla de parte del archivo de participantes que se incluye en el conjunto de datos de cannabis. Nota: HC = Controles Saludables. Más abajo en el archivo de participantes, la etiqueta CB significa Consumidor de Cannabis.

Para mantener nuestros archivos organizados, copie el archivo participations.tsv en el directorio FSGD y cámbiele el nombre a ``CannabisStudy.tsv``:

::

  cp ../participantes.tsv FSGD/CannabisStudy.tsv.


Ahora, abra el archivo ``CannabisStudy.tsv`` en Excel. Lo reformatearemos como un archivo FSGD, organizado de forma que sea comprensible para los comandos de análisis de grupo que ejecutaremos más adelante. En la primera columna, escriba las siguientes cuatro líneas:

::

  Archivo descriptor de grupo 1
  Título CannabisStudy
  Clase HC
  Clase CB
  
Estas líneas se denominan **líneas de encabezado**, ya que se necesitan en la parte superior del documento e indican el formato del archivo FSGD. La primera línea, ``GroupDescriptorFile 1``, indica que el archivo está en formato FSGD; necesitará esta primera línea en cualquier archivo FSGD que cree. La segunda línea, ``Title CannabisStudy``, antepondrá la cadena "CannabisStudy" a los directorios que almacenan los resultados de sus análisis. Las dos líneas siguientes, ``Class HC`` y ``Class CB``, indican que el nombre del sujeto junto a una columna que contiene la cadena HC pertenece al grupo HC, y que el nombre del sujeto junto a una columna que contiene la cadena CB pertenece al grupo CB. Por ejemplo, después de nuestras líneas de encabezado, podríamos ver algo como esto:

::

  Entrada sub-202 HC
  Entrada sub-206 HC
  Entrada sub-207 HC
  Entrada sub-101 CB
  Entrada sub-103 CB
  Entrada sub-104 CB
  
La primera columna, ``Input``, indica que esta fila contiene un sujeto; la siguiente columna, ``sub-202`` a ``sub-104``, especifica el nombre del sujeto (que debe corresponder a los directorios de sujetos en la carpeta Cannabis); y la última columna, ``HC`` y ``HB``, indica a qué grupo pertenece ese sujeto. En este caso, los sujetos 202, 206 y 207 pertenecen al grupo HC, y los sujetos 101, 103 y 104 pertenecen al grupo CB. Nuestro objetivo es contrastar las mediciones estructurales entre los grupos, lo cual haremos en el siguiente capítulo. Más adelante, verá cómo agregar tantas covariables como desee, una para cada columna. Estas covariables se seleccionarán del archivo ``participants.tsv``.

Por ahora, guarde la hoja de cálculo como un archivo de texto delimitado por tabulaciones haciendo clic en "Archivo -> Guardar como" y seleccionando "Texto delimitado por tabulaciones" en el campo Formato de archivo. Esto creará un archivo llamado "CannabisStudy.txt". Asegúrese de guardarlo en el directorio FSGD. A continuación, abra una terminal, navegue hasta el directorio FSGD y escriba lo siguiente:

::

  tr '\r' '\n' < EstudioDeCannabis.txt > EstudioDeCannabis.fsgd
  
Esto eliminará los retornos de carro de DOS, que Unix no puede interpretar, y los reemplazará con caracteres de nueva línea. Esto evitará errores al usar el archivo FSGD con comandos de FreeSurfer.

.. nota::

  Aunque todavía no analizamos las covariables, tenga en cuenta que muchos investigadores optan por incluir el volumen intracraneal total estimado (eTIV) como covariable al comparar grupos. Consulte la nota en esta página.
    " en la sección "Modificación del archivo FSGD".


Creando el archivo de contraste
**************************

Nuestro siguiente paso es crear un archivo de contraste que especifique los pesos de contraste para cada regresor de nuestro modelo. Las variables de "Clase" que especificamos en el archivo FSGD son regresores de grupo: uno para el grupo de cannabis y otro para el grupo de control. Dado que solo tenemos dos regresores, solo necesitamos especificar dos pesos de contraste.

Para especificar estos pesos, navegue al directorio "Contrastes" y luego escriba:

::

  echo "1 -1" > HC-CB.mtx
  
Esto ingresa la cadena ``1 -1`` en un archivo etiquetado ``HC-CB.mtx``. (``.mxt`` significa "matriz", como en "matriz de contraste"; en diseños más complicados, el archivo de contraste puede ser una matriz de cualquier tamaño M x N). La etiqueta del archivo de contraste puede ser cualquier cosa que elija; en este ejemplo, hemos elegido una etiqueta que es compacta y fácil de entender.

Ahora crea otro archivo de contraste para el contraste opuesto, es decir:

::

  echo "-1 1" > CB-HC.mtx
  
Lo cual creará un archivo de contraste restando el grupo Control del grupo Cannabis.


Ceremonias
*********

Ahora que hemos creado los archivos necesarios para un análisis de grupo, el siguiente paso es ejecutarlo. Antes de continuar, pruebe los siguientes ejercicios para comprobar su comprensión de lo que acaba de leer.


1. Si quisiera crear un contraste que representara el efecto promedio entre los grupos, ¿qué ponderaciones de contraste usaría? ¿Cuál sería una buena etiqueta para el archivo de contraste?

2. Al analizar un conjunto de datos de acceso abierto diseñado para comparar grupos de personas mayores y jóvenes, se encuentra con este archivo FSGD:
  
::

  Archivo descriptor de grupo 1
  Título MyStudy
  Clase Vieja
  Clase joven
  Entrada sub-101 HighAge
  Entrada sub-102 HighAge
  Entrada sub-103 HighAge
  Entrada sub-201 LowAge
  Entrada sub-202 LowAge
  Entrada sub-203 LowAge
  
¿Qué problema tiene este archivo? ¿Qué partes cambiarías? (Pista: Hay una sección que *debes* cambiar para que el análisis se ejecute sin que FreeSurfer genere errores; otra sección se puede cambiar para describir mejor el análisis).


------------


Video
*****

Para ver una demostración en video de cómo crear el archivo FSGD, haga clic aquí
     `__.

     
    
   

