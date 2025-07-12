Descripción general de SPM
============================

**¿Qué es SPM?**

SPM (Mapeo Paramétrico Estadístico) es un paquete de software de análisis fMRI que se ejecuta en Matlab . Además del análisis fMRI, SPM incluye herramientas para realizar morfometría basada en volumen y conectividad efectiva.
../_images/spm12_logo.png

Los siguientes tutoriales le mostrarán cómo analizar un conjunto de datos de muestra con SPM. Comenzará aprendiendo los fundamentos del preprocesamiento de fMRI y luego creará un modelo estadístico para estimar la actividad cerebral en respuesta a diferentes condiciones. Tras aprender sobre los resultados a nivel de grupo y cómo programar su análisis, finalizaremos aprendiendo sobre los diferentes tipos de análisis de grupo y cómo realizar análisis de región de interés (ROI).

**Análisis de principio a fin con SPM**

    * Introducción a SPM
    * Tutorial de SPM n.° 1: Descarga de datos
    * Tutorial de SPM n.° 2: La tarea de flanqueo
    * Tutorial de SPM n.º 3: Análisis de los datos
    * Tutorial de SPM n.° 4: Preprocesamiento
    * Tutorial de SPM n.° 5: Estadísticas y modelado
    * Tutorial de SPM n.° 6: Creación de scripts
    * Tutorial de SPM n.° 7: Establecer el origen
    * Tutorial de SPM n.° 8: Análisis de grupo
    * SPM Intermezzo: Cajas de herramientas
    * Tutorial de SPM n.° 9: Análisis del ROI
    * Apéndice A: Resumen estadístico
    * Apéndice B: Interacciones psicofisiológicas (PPI) en SPM
    * Apéndice C: Modulación paramétrica
    * Apéndice D: Optimización del diseño


Introducción a SPM
-------------------

Este curso le mostrará cómo analizar un conjunto de datos fMRI de principio a fin. Comenzaremos descargando un conjunto de datos de muestra e inspeccionando las imágenes anatómicas y funcionales de cada sujeto. Luego, preprocesaremos los datos , lo que elimina el ruido y mejora la señal en las imágenes. Una vez preprocesadas las imágenes, crearemos un modelo que represente cómo creemos que debería verse la señal BOLD , una medida de la actividad neuronal, en nuestras imágenes. Durante el ajuste del modelo , comparamos este modelo con la señal en diferentes áreas de la imagen. Este ajuste del modelo es una medida de la intensidad de la señal en diferentes condiciones; por ejemplo, podemos tomar la diferencia de la señal entre las condiciones A y B del experimento para ver qué condición conduce a una respuesta BOLD mayor.

Una vez creado un modelo para cada sujeto y estimada la respuesta BOLD para cada condición, podemos realizar cualquier tipo de análisis de grupo: pruebas t pareadas, pruebas t intergrupales, interacciones, etc. El objetivo de este curso es calcular un contraste intrasujeto simple entre dos condiciones y comprobar su significancia entre sujetos. También aprenderá a crear figuras que muestren análisis de cerebro completo, similares a las publicadas en revistas de neuroimagen, y a realizar un análisis de región de interés (ROI).

Este curso está diseñado para desarrollar su confianza al trabajar con datos de fMRI, mejorar su dominio de los términos básicos del análisis de fMRI y ayudarle a tomar decisiones informadas en cada paso. Algunos capítulos incluyen ejercicios para ayudarle a practicar lo aprendido y prepararle para el siguiente capítulo. Una vez que domine los fundamentos de este curso, podrá aplicarlos a otros conjuntos de datos de su elección.

Descarga e instalación de SPM
------------------------------

A diferencia de AFNI o FSL, SPM puede ejecutarse en cualquier sistema operativo siempre que tenga instalado Matlab. Matlab es un software propietario bastante caro, pero si eres estudiante o empleado universitario, puedes obtener una copia gratuita. Una vez instalado Matlab, el sitio web de SPM contiene instrucciones sobre cómo instalar el paquete de software. Haz clic en el botón "Descargar" para completar tus datos personales, como tu puesto y el uso que le darás al software, lo que te permitirá descargarlo.

Una vez descargado el paquete SPM, colóquelo en su directorio personal. Abra Matlab, haga clic en la pestaña "Inicio" y luego en el botón "Establecer ruta". Seleccione el spm12directorio y haga clic en "Agregar con subcarpetas". Haga clic en el botón "Guardar" para asegurarse de que la ruta se configure cada vez que abra Matlab y cierre la ventana.
../../_images/SPM_SetPath.png

Después de haber establecido la ruta, escriba lo siguiente desde la terminal de Matlab:

.. code:: Bash

   spm

Lo cual abrirá la siguiente ventana:
../../_imagenes/Tipo_SPM.png

Haga clic en el botón fMRI para abrir la GUI de fMRI de SPM.

**Nota**

Suponiendo que solo está utilizando la parte fMRI del paquete SPM, puede escribir desde la línea de comando para abrir la GUI de análisis fMRI.spm fmri

Ya está listo para descargar el conjunto de datos Flanker, al que nos referiremos ahora.

**Nota**

Este curso no profundizará en la física de la resonancia magnética. Para un repaso de este tema, recomiendo los capítulos 1 a 5 del libro " Functional Magnetic Resonance Imaging" (Imágenes por Resonancia Magnética Funcional) , de Huettel, Song y McCarthy (3.ª edición). Consulte también el excelente sitio web MRI Questions de Allen Elster para obtener ejemplos útiles de conceptos de resonancia magnética.

**Video**

Para obtener una descripción general de SPM y cómo descargarlo e instalarlo, vea este video .


Tutorial de SPM n.° 1: Descarga de datos
----------------------------------------

**Descripción general**

En este curso, analizaremos un conjunto de datos de fMRI que utilizó la tarea Flanker. El conjunto de datos se puede encontrar aquí , en el sitio web de OpenNeuro , un repositorio en línea de datos de neuroimagen.
../../_images/OpenNeuro_Flanker2.png

La página de OpenNeuro para el conjunto de datos Flanker incluye un árbol de archivos del conjunto de datos, que incluye las carpetas anat(que contiene la imagen anatómica) y func(que contiene las imágenes funcionales y los tiempos de inicio de cada ejecución). Hay archivos adicionales que contienen datos del sujeto, como sexo y edad ( participants.tsv) y parámetros de escaneo ( task-flanker_bold.json). Estos datos están en un formato llamado BIDS (Estructura de Datos de Imágenes Cerebrales). Un árbol de directorios estandarizado como este facilita enormemente la creación de scripts, como veremos en un tutorial posterior.

Descargue el conjunto de datos haciendo clic en el botón "Descargar" en la parte superior de la página. El conjunto de datos ocupa aproximadamente 2 GB y viene en una carpeta comprimida. Extráigalo haciendo doble clic en la carpeta.
../../_images/OpenNeuro_DownloadButton2.png

Después de haber descargado y descomprimido el conjunto de datos, haga clic en el botón Siguiente para obtener una descripción general de la tarea experimental utilizada en este estudio.

**Opciones de descarga alternativas**

Si el botón de descarga no funciona, prueba con la opción de Amazon Web Services (AWS) . Visita esta página y descarga el cliente de AWS adecuado para tu sistema operativo. Una vez instalado, abre una terminal, ve al escritorio y escribe lo siguiente:

.. code:: Bash

   aws s3 sync --no-sign-request s3://openneuro.org/ds000102 ds000102-download/

La descarga debería tardar aproximadamente media hora.

**Video**

Para ver un videotutorial sobre cómo descargar los datos, haga clic aquí . (El video se titula "Tutorial AFNI n.° 1", pero como es básicamente lo mismo que hará para SPM, he decidido usar el mismo video para ambos tutoriales).


Tutorial de SPM n.° 2: La tarea de flanqueo
-------------------------------------------

El conjunto de datos que descargaste utiliza la tarea Flanker, diseñada para aprovechar un proceso mental conocido como control cognitivo. En este curso, definiremos el control cognitivo como la capacidad de ignorar estímulos irrelevantes para realizar una tarea correctamente.

En la tarea Flanker, las flechas apuntan a la izquierda o a la derecha, y se le indica al sujeto que presione uno de los dos botones que indican la dirección de la flecha central. Si apunta a la izquierda, el sujeto presiona el botón "izquierda"; si apunta a la derecha, el botón "derecha". La flecha central está flanqueada por otras flechas que apuntan en la misma dirección o en la dirección opuesta.
../../_images/02_Flanker_Example1.png

Un ejemplo de las dos condiciones de la tarea Flanqueador. En la condición Incongruente, la flecha central (en la que se centra el sujeto) apunta en dirección opuesta a las flechas flanqueantes; en la condición Congruente, la flecha central apunta en la misma dirección que las flechas flanqueantes. En este ejemplo, la respuesta correcta en la condición Incongruente sería pulsar el botón "izquierda", y la respuesta correcta en la condición Congruente sería pulsar el botón "derecha". Para realizar una versión de la tarea Flanqueador, haga clic aquí .

Como puede imaginar, la tarea es más fácil si la flecha central apunta en la misma dirección que la flecha lateral, y más difícil si apunta en la dirección opuesta. Llamaremos a la primera condición "Congruente" y a la segunda "Incongruente". Los sujetos suelen ser más lentos y menos precisos en la condición Incongruente, y más rápidos y precisos en la condición Congruente. Dado que la diferencia en los tiempos de reacción es robusta y fiable, en nuestros datos de fMRI también deberíamos observar una diferencia notable en la señal BOLD .
../../_images/02_Flanker_Design1.png

Ilustración de la tarea de Flanker para este estudio, adaptada de Kelly et al. (2008). Se muestra al sujeto una cruz de fijación para que enfoque el centro de la pantalla, y luego se presenta una prueba de Flanker congruente o incongruente durante 2000 ms. Durante la prueba, el sujeto presiona el botón izquierdo o derecho. A continuación, se produce un intervalo de fluctuación que dura entre 8000 ms y 14 000 ms. (Tenga en cuenta que los intervalos de fluctuación suelen aumentar en segundos; en este caso, la fluctuación para una prueba dada sería una selección aleatoria de uno de los siguientes: 8000 ms, 9000 ms, 10 000 ms, 11 000 ms, 12 000 ms, 13 000 ms y 14 000 ms). Se presenta otra cruz de fijación para comenzar la siguiente prueba.

Nuestro objetivo es estimar la magnitud de la señal BOLD para cada condición y luego contrastar (es decir, tomar la diferencia de) las dos condiciones para ver si son significativamente diferentes entre sí.

**Nota**

Esta descripción de la tarea plantea un punto importante sobre las buenas prácticas para diseñar estudios de fMRI: si puede diseñar una tarea conductual que produzca un efecto fuerte y confiable, aumentará sus probabilidades de encontrar un efecto en sus datos de imágenes. Los datos de fMRI son notoriamente ruidosos: si no ve un efecto conductual en su estudio, lo más probable es que tampoco encuentre un efecto en sus datos de imágenes.

**Video**

Para ver un video resumen de la tarea Flanker, haga clic aquí . (El título del video dice "Tutorial AFNI n.° 2", pero los principios de la tarea Flanker son los mismos independientemente del paquete que utilice).


Tutorial de SPM n.º 3: Análisis de los datos
--------------------------------------------

**Descripción general: la interfaz gráfica de usuario de SPM**

Ahora que ha descargado el conjunto de datos, querrá mirar sus datos ; por ejemplo, querrá saber si hay algún artefacto o problema con sus datos y si estos pueden aliviarse mediante el preprocesamiento .

Primero, renombremos el conjunto de datos con un nombre claro e informativo. Si el conjunto de datos se ha descargado en el directorio de Descargas, use la terminal de Matlab para navegar al Escritorio y escriba lo siguiente:

.. code:: Bash

   movefile('~/Downloads/ds000102_0001/', 'Flanker')

Esto cambiará el nombre de la carpeta Flankery la colocará en su escritorio.

Como se vio en la página anterior de Descarga de Datos , el conjunto de datos tiene una estructura estandarizada: cada carpeta de sujeto contiene un directorio anatómico y un directorio funcional denominados anaty func, que a su vez contienen las imágenes anatómicas y funcionales recopiladas durante el experimento. (El funcdirectorio también contiene las horas de inicio o las marcas de tiempo de cuándo el sujeto se sometió a una prueba congruente o incongruente). Este formato se conoce como BIDS (Estructura de Datos de Imágenes Cerebrales), lo que facilita la organización y el análisis de los datos.
../../_images/03_Flanker_DataStructure1.png

Ejemplo del formato BIDS. Tenga en cuenta que el funcdirectorio contiene datos funcionales (en este caso, dos ejecuciones de datos funcionales) y los archivos "events.tsv" correspondientes, que contienen los inicios o marcas de tiempo de la condición en la que se produjo cada momento. Puede abrirlos como archivo de texto o como hoja de cálculo. Los usaremos más adelante al crear nuestro modelo lineal general.

Para ver e inspeccionar los datos, utilizaremos la interfaz gráfica de usuario (GUI) de SPM. Puede abrir la GUI abriendo una nueva terminal de Matlab, escribiendo desde la línea de comandos y pulsando Intro.spm fmri

**Inspección de la imagen anatómica**

Al descargar datos de imágenes, revise las imágenes anatómicas y funcionales para detectar artefactos (picos en el escáner, orientación incorrecta, contraste deficiente, etc.). Aprender a identificar estos problemas llevará tiempo, pero con la práctica será más rápido y fácil.

Para empezar, veamos la imagen anatómica en la anatcarpeta sub-08. Si aún no ha abierto SPM, navegue a la carpeta sub-08 y escriba

.. code:: Bash

   spm fmri

Y pulse Intro para abrir la interfaz gráfica de usuario de SPM. Si hace clic en el Displaybotón, se le pedirá que seleccione una imagen.

**Nota**

SPM puede leer cualquier imagen que esté en formato NIFTI, pero no se pueden comprimir; es decir, si los conjuntos de datos terminan con una .gzextensión, primero deberá descomprimirlos navegando al directorio que contiene las imágenes y luego escribir

.. code:: Bash

   gunzip('*.gz')

Lo que ampliará las imágenes y eliminará la .gzextensión.
../../_images/03_Inspección_Anatómica1.png

La imagen anatómica mostrada en el visor SPM en vistas axial, sagital y coronal. Puede cerrar cualquiera de las ventanas si solo desea centrarse en un subconjunto de las vistas.

Inspeccione la imagen haciendo clic en una de las ventanas de visualización. Observe cómo cambian las demás ventanas y la cruceta. Esto se debe a que los datos de resonancia magnética se recopilan como una imagen tridimensional, y al desplazarse por una de las dimensiones, también cambian las demás ventanas.

**Nota**

Quizás haya notado que a este sujeto parece faltarle el rostro. Esto se debe a que los datos de OpenNeuro.org han sido desidentificados : no solo se ha eliminado del encabezado información como el nombre y la fecha del escaneo, sino que también se han borrado los rostros. Esto se hace para garantizar el anonimato del sujeto.

A medida que continúe inspeccionando la imagen, hay dos cosas que debe tener en cuenta:

1. Líneas que parecen ondas en un estanque. Estas ondas pueden deberse a que el sujeto se mueve demasiado durante el escaneo y, si son lo suficientemente grandes, pueden provocar fallos en los pasos de preprocesamiento, como la extracción cerebral o la normalización.

../../_images/03_Gibbs1.png

Crédito de la foto: Sundar Amartur

2. Diferencias anormales de intensidad en la sustancia gris o blanca. Estas pueden indicar patologías como aneurismas o cavernomas, y deben reportarse a su radiólogo de inmediato. Asegúrese de familiarizarse con los protocolos de su laboratorio para reportar artefactos. Para ver una galería de patologías que puede observar en una imagen de resonancia magnética, haga clic aquí .

**Inspección de las imágenes funcionales**

Cuando haya terminado de ver la imagen anatómica, haga clic en el Displaybotón nuevamente, navegue hasta el funcdirectorio y seleccione la run-1imagen funcional.

Se mostrará una nueva imagen en las ventanas de visualización ortogonales. Esta imagen también se asemeja a un cerebro, pero no está tan claramente definida como la imagen anatómica. Esto se debe a una menor resolución . Es habitual que un estudio recopile una imagen ponderada en T1 de alta resolución (es decir, anatómica) e imágenes funcionales de menor resolución, que, en parte, tienen una resolución menor debido a su rápida obtención. Una de las disyuntivas en la investigación con imágenes es la que existe entre la resolución espacial y la resolución temporal: las imágenes obtenidas con una mayor resolución temporal tendrán una menor resolución espacial, y viceversa.
../../_images/03_Inspección_Funcional1.png

Muchos de los controles de calidad de la imagen funcional son los mismos que los de la imagen anatómica: Preste atención a las manchas extremadamente brillantes o extremadamente oscuras en la sustancia gris o blanca, así como a las distorsiones de la imagen, como estiramientos o deformaciones anormales. Un lugar donde es común observar una ligera distorsión es en la región orbitofrontal del cerebro, justo por encima de los globos oculares. Hay maneras de reducir esta distorsión , pero por ahora la ignoraremos.

Otra comprobación de calidad consiste en asegurar que no haya movimiento excesivo. Las imágenes funcionales suelen recopilarse como series temporales; es decir, se concatenan varios volúmenes en un único conjunto de datos. Para ver la serie temporal de volúmenes en rápida sucesión, haga clic en el botón y cargue los datos. Esto mostrará un único volumen en tres planos: coronal, sagital y axial. Haga clic derecho en cualquiera de los planos y haga clic en el botón. Se le pedirá que seleccione una imagen; haga clic en el archivo seleccionado para eliminarlo y, a continuación, introduzca la cadena en los campos Filtro y Fotogramas. Seleccione todas las imágenes resultantes y haga clic en .Check Regsub-01_task-flanker_run-1_bold.niiBrowserun-11:146Done

Ahora verá una barra de desplazamiento horizontal en la parte inferior de la ventana. Al hacer clic en las flechas derecha o izquierda, avanzará o retrocederá un volumen; también puede hacer clic y arrastrar la barra de desplazamiento para ver los volúmenes más rápidamente. Al hacer clic en el >botón de la esquina inferior derecha, se iniciará el modo de película , que recorre los volúmenes rápidamente. Al volver a hacer clic en el botón, se detendrá la película. Para ver un gráfico de la activación de la serie temporal en el vóxel bajo la cruceta, haga clic derecho de nuevo en cualquiera de los planos, seleccione "Examinar" y, a continuación, "Perfil de visualización". Esto abrirá otra figura que podrá ver simultáneamente mientras recorre los volúmenes.
../../_images/03_SPM_ViewTimeSeries.gif

Además, durante el preprocesamiento de Realineación, se generará un archivo de parámetros de movimiento que muestra el movimiento entre cada volumen. Para comenzar a aprender sobre los pasos de preprocesamiento, haga clic en el botón Siguiente .

**Ceremonias**

1. Visualice la serie temporal de los run-2datos de [número] sub-08siguiendo los pasos descritos anteriormente. ¿Observa algún cambio repentino en el movimiento? Visualice la serie temporal de [número] run-1y compárela con [número run-2]. ¿Qué volúmenes, si los hay, muestran cambios repentinos en el movimiento?

2. Examine algunas de las demás exploraciones anatómicas y funcionales de otros sujetos, asegurándose de descomprimir las imágenes antes de cargarlas en el visor. ¿Cómo cambian el contraste y el brillo al arrastrar la cruz por diferentes secciones de la imagen? ¿Qué cree que afecta el brillo de una sección determinada?

3. Si está visualizando una de las imágenes funcionales con el Displaybotón, al hacer clic derecho en cualquiera de los paneles de visualización, se mostrará un menú con el nombre del archivo actual en la parte superior. Coloque el cursor sobre el nombre del archivo y observe los valores que se presentan en un submenú a la derecha. ¿Cómo se comparan con los valores que ve en la mitad inferior de la ventana de visualización?

4. SPM lee la información del encabezado al cargar un archivo. La versión de línea de comandos se llama spm_vol. Desde la terminal de Matlab, navegue al directorio sub-01/func, asegúrese de que los datos estén descomprimidos y escriba lo siguiente:

.. code:: Bash

   run1 = spm_vol('sub-01_task-flanker_run-1_bold.nii')

Tenga en cuenta que esta estructura devuelve varios campos, como fname, dim y dt. Puede examinar el contenido de cada uno escribiendo, por ejemplo,

.. code:: Bash

   run1.fname

En este caso, ¿por qué se devuelven 146 respuestas? ¿Cuál de los campos contiene las dimensiones de los vóxeles de cada volumen? ¿Cuál de los campos contiene las dimensiones del volumen total (es decir, ancho, largo y alto)? ¿Cuántos volúmenes se devolverían si se aplicara el spm_volcomando a la imagen anatómica? ¿Por qué?

5. Abra la imagen anatómica para menores de 08 años en el visor de imágenes y haga clic derecho en cualquiera de los tres paneles. Seleccione y seleccione el archivo funcional . La imagen funcional se superpondrá a la imagen anatómica y se mostrará en un mapa de calor rojo-naranja, mostrando una alineación inicial relativamente buena entre las imágenes.Overlay -> Add Image -> This Imagesub-08_task-flanker_run-1_bold.nii

../../_images/03_ImageOverlay.png

Ahora realice el mismo procedimiento para las imágenes anatómicas y funcionales para sub-01, lo que debería darle una figura como la siguiente:
../../_images/03_ImageOverlay_sub01.png

¿Qué observas? Esta desalineación entre las imágenes se abordará en un capítulo posterior sobre cómo establecer el origen .

**Video**

Para ver una descripción general en video sobre cómo verificar la calidad de sus datos, haga clic aquí .


Tutorial de SPM n.° 4: Preprocesamiento
----------------------------------------

**Nota**

Muchos de los ejemplos se ejecutan desde el Flanker/sub-08directorio; recomiendo navegar a ese directorio en la Terminal de Matlab antes de leer el resto del capítulo.

**Descripción general**

Ahora que sabemos dónde están nuestros datos y cómo se ven, realizaremos el primer paso del análisis fMRI: preprocesamiento .

Piensa en el preprocesamiento como la limpieza de las imágenes. Al tomar una foto con una cámara, por ejemplo, hay varias cosas que puedes hacer para mejorarla:

* Eliminar ojos rojos;

* Aumentar la saturación del color;

* Eliminar sombras.

../../_images/04_Antes_Después_Edición1.png

Una foto que tomamos con una cámara puede ser oscura, borrosa o con ruido (panel izquierdo). Tras editar la imagen mejorando el contraste, reduciendo el desenfoque y aumentando el brillo, obtenemos una imagen más definida y nítida.

De forma similar, al preprocesar datos de fMRI, se depuran las imágenes tridimensionales que se adquieren en cada TR . Un volumen de fMRI contiene no solo la señal que nos interesa (cambios en la sangre oxigenada), sino también fluctuaciones que no nos interesan, como el movimiento de la cabeza, las desviaciones aleatorias, la respiración y los latidos cardíacos. A estas fluctuaciones las llamamos ruido , ya que queremos separarlas de la señal que nos interesa. Algunas de estas fluctuaciones pueden eliminarse de los datos mediante su modelado (lo cual se explica en el capítulo sobre ajuste de modelos), y otras pueden reducirse o eliminarse mediante el preprocesamiento.

Para comenzar a preprocesar los datos de sub-08, lea los siguientes capítulos. Comenzaremos con la Realineación y la Corrección de la Temporización de Corte , que corrigen desalineaciones y errores de sincronización en las imágenes funcionales, antes de pasar al Corregistro y la Normalización , que alinean las imágenes funcionales y estructurales y las trasladan a un espacio estandarizado. Finalmente, las imágenes se suavizan para aumentar la señal y eliminar el ruido. La secuencia típica de pasos de preprocesamiento se muestra en la imagen a continuación:
../../_images/SPM_GUI_Steps.png

Pasos de preprocesamiento

* Capítulo 1: Realinear y corregir la distorsión de los datos
* Capítulo 2: Corrección de la sincronización de segmentos
* Capítulo 3: Corregistro
* Capítulo 4: Segmentación
* Capítulo 5: Normalización
* Capítulo 6: Suavizado

**Nota**

Los distintos paquetes de software realizan estos pasos en un orden ligeramente distinto; por ejemplo, FSL normaliza los mapas estadísticos tras el ajuste del modelo. También existen análisis que omiten ciertos pasos; por ejemplo, quienes realizan análisis de patrones multivóxel no suavizan sus datos. En cualquier caso, la lista anterior representa los pasos más comunes que se realizan en un conjunto de datos típico.

**Video**

Una vez que haya terminado de revisar todos los pasos de preprocesamiento, haga clic aquí para ver un video que muestra cómo realizar todos los pasos después de la realineación.

Capítulo 1: Realinear y corregir la distorsión de los datos
-----------------------------------------------------------

El primer paso del preprocesamiento es realinear las imágenes funcionales. Si consideramos una serie temporal como una baraja de cartas, con cada volumen como una carta independiente, la realineación colocará todas las cartas en la misma orientación y hará que sus lados se alineen, de forma similar a lo que ocurre después de barajar una baraja.

Al hacer clic en el botón , se abre una ventana con las opciones para realinear y redividir los datos. Esta sección se refiere a la estimación del grado de desalineación de cada volumen con respecto a un volumen de referencia e indica que estas estimaciones se utilizarán para ajustar cada volumen a su nivel de referencia. El volumen de referencia se define en el campo "Número de pasadas", que permite especificar si los volúmenes se alinearán con la media de todos los volúmenes o con el primero. Para este tutorial, deje este valor predeterminado y los demás valores predeterminados sin modificar.Realign (Estimate & Reslice)EstimateReslice
../../../_images/01_Realign_Menu.png

Este menú aparecerá después de hacer clic en el botón “Realinear: Estimar y rebanar”.

**Nota**

En este paso de preprocesamiento y en los siguientes, dejaremos la mayoría de los valores predeterminados tal como están. Estos valores se han calculado para obtener los mejores resultados para una amplia gama de campos de visión de imagen, tamaños de vóxel, etc. No obstante, puede resultarle útil cambiar los valores predeterminados del prefijo de archivo, por ejemplo, a uno que le resulte más comprensible. Si decide cambiar alguna de las demás opciones, al hacer clic en ellas se abrirá un archivo de ayuda que se muestra en el cuadro de información en la parte inferior de la pantalla del editor de lotes.

**Cargando las imágenes**

En este experimento, se realizaron dos ejecuciones de datos por sujeto (SPM se refiere a cada ejecución como una sesión ). Si hace clic en el Datacampo, verá una opción para agregar más sesiones. Haga clic en para agregar otra sesión. Verá un a la derecha de cada campo de sesión, lo que indica que debe completarse antes de ejecutar el programa.New: Session<-X

Haga doble clic en la primera sesión para abrir la ventana de selección de imágenes. Navegue hasta el funcdirectorio y seleccione el archivo sub-08_task-flanker_run-1_bold.nii,1. El símbolo ,1al final del nombre del archivo indica que solo se puede seleccionar el primer fotograma o volumen. Para seleccionar todos los volúmenes de esa sesión, necesitaremos aumentar el número de fotogramas disponibles. En el Framescampo (debajo del Filtercampo), escriba 1:146y presione Intro.

**Nota**

Si desconoce cuántos fotogramas hay en el conjunto de datos actual, puede establecer el límite superior en un número arbitrario, por ejemplo, 1:10000. La lista de archivos se llenará con el número de fotogramas disponibles, lo que garantizará que no se pierda ninguno.

Sin embargo, notará que se han seleccionado todos los fotogramas de la ejecución 1 y la ejecución 2, aunque solo queremos los fotogramas de la ejecución 1. Podría simplemente hacer clic y arrastrar desde el fotograma 1 al 146 para la ejecución 1, pero se arriesga a incluir otros fotogramas por error. Por otro lado, para restringir nuestra selección de archivos solo a los fotogramas que nos interesan, podemos usar el Filtercampo. Este campo usa expresiones regulares , un tipo de abreviatura de codificación para indicar qué caracteres incluir en una cadena. En este caso, a la izquierda de los .*caracteres que ya están en el campo, escriba run-1y presione Enter. Esto actualizará la pantalla para mostrar solo los fotogramas que incluyen la cadena run-1. Haga clic y arrastre para seleccionar todas las imágenes, o haga clic derecho en la ventana de selección y haga clic en .Select All
../../../_imagenes/01_SelectFrames.png

Pantalla de selección de figuras. Si siguió las instrucciones anteriores, la ventana debería verse así. Tenga en cuenta que al introducir la cadena 1:146en el Framescampo, se expandirá automáticamente a .[1 2 3 4 5 ... 146]

Al terminar, haga clic en Done. Repita el mismo procedimiento para la segunda sesión, usando el Filtercampo para restringir la búsqueda a los fotogramas que contengan la cadena run-2.
../../../_images/01_FrameSelect_Run2.png

Ahora que ha completado todos los campos con un símbolo <-Xjunto a ellos, el botón "Reproducir" en la esquina superior izquierda de la pantalla ha cambiado de gris a verde. Haga clic en el botón para comenzar el preprocesamiento de Realineación.
../../../_images/01_Realign_Demo.gif

**Nota**

Las expresiones regulares permiten crear filtros muy específicos. Por ejemplo, si escribe la cadena run-1.*en el campo Filtro, la ventana de archivos mostrará solo los archivos que contengan la cadena "run-1" en su nombre. Al escribir la cadena, ^sub-08_task-flanker_run-1se mostrarán todos los archivos que comiencen con la cadena "run-1" (indicada por el símbolo de intercalación, ^).

**Ceremonias**

1. En el campo Filtro, $se puede usar el símbolo de dólar ( ) para devolver archivos que terminan con una cadena específica. Por ejemplo, al escribir, run-1_bold.*$se devolverían los archivos que terminan con la cadena "run-1_bold". Use el campo Filtro para devolver solo los archivos que terminan con run-2_bold. Después de ejecutar la realineación, use el campo Filtro para devolver los archivos que empiezan con rsub-08. Use el campo Marcos para seleccionar los marcos del 10 al 20. Haga una captura de pantalla de lo que ingresó en el campo Marcos y de los archivos filtrados resultantes.

2. Vuelva a ejecutar el paso de realineación solo en las imágenes de la ejecución 1, cambiando el valor del campo Calidad de 0,9 a 0,5. Al seleccionar el campo Calidad, lea el texto de ayuda en la parte inferior de la ventana. ¿Cómo cree que este cambio afectará la calidad de su realineación? Para mantener estos archivos separados del resto de la salida, cambie el prefijo del nombre de archivo a qual_05. Revise la salida en la ventana "Comprobar registro" cargando una imagen representativa de los archivos rsub-08_task-flanker_run-1 y una imagen de los archivos qual_05 que acaba de crear. ¿Observa alguna diferencia entre ellos? ¿Por qué cree que hay o no diferencia?

3. Repita el paso de realineación cambiando el número de pases de "Registrar como medio" a "Registrar como primero". Consulte el archivo de ayuda y determine las ventajas y desventajas. ¿Cuál preferiría usar como predeterminado para su análisis y por qué?

4. Lea los archivos de ayuda de cada opción del módulo. Imagine dos escenarios: 1) Que prioriza la velocidad de finalización de la realineación en lugar de la calidad; y 2) Que prioriza la calidad sobre la velocidad. ¿Qué opciones debería cambiar en los escenarios 1 y 2? Indique qué opciones modificó, junto con una captura de pantalla de una imagen de muestra de los volúmenes realineados. (Pista: No es necesario modificar todas las opciones. El suavizado, por ejemplo, puede permanecer igual).Realign: Estimate & Reslice

**Video**

Para ver una introducción en video sobre el preprocesamiento y cómo realizar la realineación, haga clic aquí .

**Próximos pasos**

Este tutorial ha cubierto los conceptos básicos del uso de los diferentes menús de la interfaz gráfica de usuario de SPM, incluyendo cómo cambiar opciones y seleccionar fotogramas. Utilizaremos estos mismos métodos para el resto de los pasos de preprocesamiento, continuando con la corrección de la temporización de cortes .


Capítulo 2: Corrección de la sincronización de segmentos
----------------------------------------------------------

**Fondo**

A diferencia de una fotografía, donde la imagen completa se toma en un solo instante, el volumen de fMRI se adquiere en cortes. Cada uno de estos cortes tarda en adquirirse, desde decenas hasta cientos de milisegundos.

Los dos métodos más comunes para crear volúmenes son la adquisición secuencial y la intercalada de cortes. La adquisición secuencial de cortes adquiere cada corte adyacente consecutivamente, ya sea de abajo a arriba o de arriba a abajo. La adquisición intercalada de cortes adquiere cada corte de por medio y luego rellena los espacios vacíos en la segunda pasada. Ambos métodos se ilustran en el video a continuación.
../../../_images/04_02_SliceTimingCorrection_Demo1.gif

**Nota**

Para ver otra ilustración de cómo funciona la sincronización de segmentos mediante interpolación lineal , consulte la página de Matthew Brett .

Como se verá más adelante, al modelar los datos en cada vóxel, asumimos que todos los cortes se adquirieron simultáneamente. Para que esta suposición sea válida, la serie temporal de cada corte debe retrocederse en el tiempo según el tiempo que tardó en adquirirse. Sladky et al. (2011) también demostraron que la corrección temporal de los cortes puede generar aumentos significativos en la potencia estadística en estudios con TR más largos (p. ej., 2 s o más), especialmente en las regiones dorsales del cerebro.

Aunque la corrección del tiempo de corte parece razonable, existen algunas objeciones:

1. En general, es mejor no interpolar (es decir, editar) los datos a menos que sea necesario;

2. Para TR cortos (por ejemplo, alrededor de 1 segundo o menos), la corrección del tiempo de corte no parece conducir a ninguna ganancia significativa en potencia estadística; y

3. Muchos de los problemas abordados mediante la corrección del tiempo de corte se pueden resolver utilizando una derivada temporal en el modelo estadístico (que se analiza más adelante en el capítulo sobre ajuste del modelo).

Por ahora, haremos una corrección del tiempo de corte, usando el primer corte como referencia.

**Corrección de tiempos de corte en SPM**

Similar a lo que hicimos con Realignment , primero haremos clic en el botón en la interfaz gráfica de usuario de SPM. Haga clic en el campo y cree dos nuevas sesiones. Haga doble clic en la primera sesión y, en la columna Filtro, escriba . En el campo Fotogramas, presione Intro; seleccione todos los fotogramas que se muestran y haga clic en . Repita el mismo procedimiento para los archivos de ejecución 2 de la segunda sesión.Slice TimingData^rsub-08_task-flanker_run-1.*1:146Done

Para el campo, necesitamos averiguar cuántas porciones hay en cada volumen de nuestro conjunto de datos. Desde la terminal de Matlab, navegue al directorio y escriba:Number of Slicessub-08/func

.. code:: Bash

   V = spm_vol('sub-08_task-flanker_run-1_bold.nii')

Esto cargará el encabezado de la imagen en una variable llamada V. Si escribe Vy pulsa Intro, verá que contiene los siguientes campos:

.. code:: Bash

   fname
   dim
   dt
   pinfo
   mat
   n
   descrip
   private

fnamees el nombre del archivo y dimcontiene las dimensiones de cada volumen del archivo. (No analizaremos los demás campos por ahora; solo necesita saber que contienen información adicional del encabezado que SPM necesita para leer el archivo). Si escribe

.. code:: Bash

   V(1).dim

Devolverá las dimensiones del primer volumen de la serie temporal en las direcciones x, y y z. Debería ver algo como esto:

.. code::

   64 64 40

Esto significa que el primer volumen de la serie temporal tiene unas dimensiones de 64x64x40 vóxeles, siendo 40 el número de cortes en las dimensiones z. Supondremos que las dimensiones de cada imagen y el número de cortes serán los mismos para todos los volúmenes de los datos funcionales del sujeto.

Ahora regrese a la ventana del Editor por lotes, haga doble clic en , ingrese un valor de y haga clic en .Number of Slices40OK

Para el TR, introduzca 2; para el TA, siga la fórmula de la ventana de ayuda e introduzca 2-(2/40). Para el orden de corte, introduzca , y para el corte de referencia, introduzca un valor de . Deje el prefijo del nombre de archivo como está, ya que añadirá una a los archivos generados. Repita este mismo procedimiento para la ejecución 2. Al finalizar, la ventana de preprocesamiento debería verse así:[1:2:40 2:2:40]1a
../../../_images/04_02_SliceTimingWindow.png

Cuando se hayan corregido los tiempos de corte de las imágenes, estará listo para registrar conjuntamente los datos funcionales con los datos anatómicos; en otras palabras, alinearemos los dos conjuntos de imágenes lo mejor que podamos.

**Ceremonias**

1. A veces, los cortes se adquieren de abajo hacia arriba del volumen, sin intercalar. ¿Cómo modificarías el código para que el orden de los cortes refleje esto? Muestra el vector que usarías en este caso.

    Ahora realice las mismas modificaciones, pero para los cortes intercalados desde la parte superior del volumen hasta la inferior. Muestre el vector.

    Descargue otra ejecución funcional de un estudio aleatorio en openneuro.org y úsela spm_volpara determinar cuántas porciones hay. Repita los ejercicios 1 y 2 para este nuevo conjunto de datos. Incluya el código y el resultado de [insertar fecha] spm_vol, junto con los vectores que usaría.

------------------------------------------------------------------------------------

Capítulo 3: Corregistro
Descripción general

Aunque el cerebro de la mayoría de las personas es similar (por ejemplo, todos tenemos una circunvolución cingulada y un cuerpo calloso), también existen diferencias en el tamaño y la forma cerebrales. Por lo tanto, si queremos realizar un análisis grupal, debemos asegurarnos de que cada vóxel de cada sujeto corresponda a la misma parte del cerebro. Si medimos un vóxel en la corteza visual, por ejemplo, debemos asegurarnos de que la corteza visual de cada sujeto esté alineada.

Esto se hace mediante el registro y la normalización de las imágenes. Tal como doblarías la ropa para que quepa dentro de una maleta, cada cerebro necesita ser transformado para tener el mismo tamaño, forma y dimensiones. Hacemos esto normalizando (o deformando ) a una plantilla . Una plantilla es un cerebro que tiene dimensiones y coordenadas estándar: estándar, porque la mayoría de los investigadores han acordado usarlas al informar sus resultados. De esa manera, si normalizas tus datos a esa plantilla y encuentras un efecto en las coordenadas X = 3, Y = 20, Z = 42, alguien más que haya deformado sus datos a la misma plantilla puede comparar sus resultados con los tuyos. Las dimensiones y coordenadas del cerebro plantilla también se conocen como espacio estandarizado .
../../../_images/04_03_MNI_Template1.png

Un ejemplo de una plantilla de uso común es el cerebro MNI152 . Se trata de un promedio de 152 cerebros adultos sanos, que representan la población de la que se extraen la mayoría de los estudios. Si está estudiando otra población, como niños o ancianos, considere usar una plantilla creada con representantes de esa población. (Pregunta: ¿Por qué está borrosa la plantilla?)
Transformaciones afines

Para deformar las imágenes según una plantilla, usaremos una transformación afín . Esta es similar a la transformación de cuerpo rígido descrita anteriormente en Corrección de movimiento, pero añade dos transformaciones más: zoom y corte . Mientras que las traslaciones y rotaciones son fáciles de realizar con un objeto cotidiano como un bolígrafo, los zoom y cortes son más inusuales: los zoom reducen o amplían la imagen, mientras que los cortes toman las esquinas diagonalmente opuestas de la imagen y las estiran. La animación a continuación resume estos cuatro tipos de transformaciones lineales .
../../../_images/04_03_AffineTransformations1.gif

Nota

Al igual que con las transformaciones de cuerpo rígido, los zoom y los cortes tienen tres grados de libertad: puede hacer zoom o cortar una imagen a lo largo del eje x, y o z. En total, entonces, las transformaciones afines tienen doce grados de libertad. Estas también se llaman transformaciones lineales porque una transformación aplicada en una dirección a lo largo de un eje está acompañada por una transformación de igual magnitud en la dirección opuesta. Una traslación de un milímetro a la izquierda, por ejemplo, implica que la imagen se ha movido un milímetro desde la derecha. Del mismo modo, si una imagen se amplía un milímetro a lo largo del eje z, se amplía un milímetro en ambas direcciones a lo largo de ese eje. Las transformaciones sin estas restricciones se llaman transformaciones no lineales . Por ejemplo, una transformación no lineal puede ampliar la imagen en una dirección mientras la encoge en la otra dirección, como cuando se aprieta una esponja. Estos tipos de transformaciones se tratarán más adelante.
Registro y Normalización

Recuerde que nuestro conjunto de datos incluye imágenes anatómicas y funcionales. Nuestro objetivo es adaptar las imágenes funcionales a la plantilla para realizar un análisis grupal de todos los sujetos. Si bien parece razonable adaptar las imágenes funcionales directamente a la plantilla, en la práctica esto no funciona bien: las imágenes tienen baja resolución y, por lo tanto, es menos probable que coincidan con los detalles anatómicos de la plantilla. La imagen anatómica es una mejor opción.

Aunque esto parezca no ayudarnos a alcanzar nuestro objetivo, de hecho, deformar la imagen anatómica puede ayudar a estandarizar las imágenes funcionales. Recuerde que las exploraciones anatómicas y funcionales suelen adquirirse en la misma sesión, y que la cabeza del sujeto se mueve poco o nada entre las exploraciones. Si ya hemos normalizado nuestra imagen anatómica a una plantilla y registrado las transformaciones realizadas, podemos aplicar las mismas transformaciones a las imágenes funcionales, siempre que comiencen en el mismo lugar que la imagen anatómica.

Esta alineación entre las imágenes funcionales y anatómicas se denomina registro . La mayoría de los algoritmos de registro utilizan los siguientes pasos:

    Suponga que las imágenes funcionales y anatómicas están prácticamente en la misma ubicación. De no ser así, alinee los contornos de las imágenes.

    Aproveche que las imágenes anatómicas y funcionales tienen diferentes ponderaciones de contraste; es decir, las áreas oscuras en la imagen anatómica (como el líquido cefalorraquídeo) aparecerán brillantes en la imagen funcional, y viceversa. Esto se denomina información mutua . El algoritmo de registro mueve las imágenes para probar diferentes superposiciones de las imágenes anatómicas y funcionales, haciendo coincidir los vóxeles brillantes de una imagen con los oscuros de otra, y los oscuros con los brillantes, hasta encontrar una coincidencia irreprochable. Este procedimiento también se conoce como función de coste .

    Una vez que se encuentra la mejor coincidencia, se aplican a las imágenes funcionales las mismas transformaciones que se utilizaron para deformar la imagen anatómica según la plantilla.

../../../_images/04_03_Registro_Normalización_Demo1.gif
Co-registro con SPM

Para co-registrar las imágenes funcionales y anatómicas, regrese a la interfaz gráfica de usuario de SPM y haga clic en . Se abrirá una ventana de edición por lotes con solo dos campos para completar: una imagen de referencia y una imagen de origen .Coregister (Estimate & Reslice)

La imagen de referencia es la que permanece fija; la imagen de origen, por otro lado, se mueve hasta encontrar el mejor ajuste entre ambas, utilizando las funciones de coste descritas anteriormente. Para la mayoría de los experimentos, conviene utilizar una representación de los datos funcionales como imagen de referencia y los datos anatómicos como imagen de origen, ya que generalmente se busca minimizar las modificaciones en los datos funcionales.

Haga doble clic en la imagen de referencia y seleccione el archivo meansub-08_task-flanker_run-1_bold.nii. Para la imagen de origen, navegue al anatdirectorio y seleccione el archivo sub-08_T1w.nii. Luego, haga clic en el botón verde "Ir". Este paso solo debería tomar unos instantes.

Al finalizar, se generará otra ventana con los resultados del corregistro, con la imagen funcional media a la izquierda y la imagen anatómica a la derecha. Haga clic y arrastre la cruceta en cualquiera de las imágenes para comprobar su correcta alineación. Además de la coincidencia de los contornos de los cerebros, también debe comprobar la alineación de las estructuras internas, como los ventrículos. Recuerde que las intensidades se invertirán: las zonas más oscuras de la imagen anatómica (como los ventrículos) aparecerán más brillantes en la imagen funcional.

Nota

Abra la imagen anatómica rediseñada con el botón "Mostrar imagen" (es decir, cargue la imagen rsub-08_T1w.nii). ¿Qué observa en la imagen en comparación con la imagen anatómica original? (Sugerencia: Compare los valores en los campos "Dimensiones" y "Tamaño de Vox").
../../../_images/03_Coregistration_Check.png
Ceremonias

    Al igual que con el paso de Realineación , tenemos la opción de hacer que el paso de corregistro sea más rápido pero de menor calidad, o más lento pero de mayor calidad. Use el campo "Interpolación" para examinar las diferencias entre las diferentes opciones disponibles y configúrelo como "Vecino más cercano". Cambie el prefijo del nombre de archivo a "NN" y ejecute el corregistro. ¿Qué observa en el resultado? ¿Cómo se compara con la interpolación predeterminada de "4th Degree B-Spline"? A continuación, compruebe cómo cambia el resultado al usar la opción "7th Degree B-Spline". Tome capturas de pantalla de los resultados de NN, 4th Degree B-Spline y 7th Degree B-Spline, y etiquételas claramente.

    Intente intercambiar las imágenes de referencia y fuente; es decir, convierta la imagen anatómica en la de referencia y la imagen funcional en la fuente. (Recuerde cambiar el prefijo del nombre de archivo por uno que le resulte comprensible para mantener los resultados organizados). ¿Cómo han cambiado las dimensiones y la resolución de los datos funcionales? Teniendo en cuenta que tenemos un total de 292 volúmenes funcionales en comparación con un volumen anatómico, y sabiendo que un conjunto de datos de mayor resolución ocupa más espacio en el ordenador, ¿qué razones se podrían dar para mantener la imagen anatómica como fuente y los datos funcionales como referencia?

Próximos pasos

Ahora que hemos corregistrado las imágenes, estamos listos para normalizar todos nuestros datos a un espacio estandarizado. Sin embargo, antes de hacerlo, necesitamos segmentar la imagen anatómica para alinear con mayor precisión los diferentes tipos de tejido al normalizarla.


