Tutorial de FreeSurfer n.º 6: Freeview
================================

---------------

Visualización de sus datos
*****************

Cada paquete de software de neuroimagen cuenta con un **visor de datos**, o una aplicación que permite consultar los datos. AFNI, SPM y FSL cuentan con visores de datos que básicamente hacen lo mismo: el usuario carga datos de imágenes, generalmente imágenes anatómicas o funcionales, y puede visualizarlos en tres dimensiones. La mayoría de los visores permiten cargar archivos NIFTI que contienen cualquier tipo de datos de imágenes.

FreeSurfer cuenta con su propio visor, **Freeview**, que se puede iniciar desde la Terminal escribiendo ``freeview`` y pulsando Intro. Puede cargar imágenes NIFTI al igual que los demás paquetes, y además, puede cargar formatos específicos de FreeSurfer, como datos con extensiones ``.mgz`` e ``.inflated``. La imagen se puede visualizar en tres dimensiones en el Panel de Visualización, o se puede cambiar el diseño para que solo se muestre una dimensión.

.. figura:: 06_Freeview_Example.png


El panel de control
*********

La esquina superior izquierda de Freeview contiene el **Panel de Control**, que muestra los volúmenes cargados actualmente en la memoria. La casilla junto a cada imagen se puede marcar o desmarcar para hacerla visible o invisible, respectivamente. Al igual que en los demás visores, la imagen superior es la **superposición**: cubre todas las demás imágenes. Las flechas arriba y abajo permiten colocar una imagen en la parte superior de la pila o bajarla para que deje de ser la superposición. El control deslizante de "Opacidad" permite mantener una imagen como superposición, pero cambiar su transparencia para que se pueda ver la imagen inmediatamente inferior.

La **Barra de Herramientas** se encuentra debajo del Panel de Control y contiene opciones para cambiar la opacidad, el contraste y el mapa de color de las imágenes. Al cargar una imagen como aseg.mgz, por ejemplo, se usa una paleta de colores en escala de grises por defecto. Sin embargo, un mapa de color más informativo es **FreeSurferColorLUT** (LUT = Tabla de Consulta), que codifica por color cada segmento de la imagen según una tabla predefinida.

Muchas de las imágenes en FreeSurfer están codificadas así. Tomará tiempo determinar cuáles lo están, pero una heurística útil es asumir una tabla de consulta para cualquier imagen segmentada (como aseg.mgz) o parcelada (como uno de los atlas).

Volúmenes y superficies de carga
*********

Freeview permite cargar volúmenes y superficies simultáneamente. Para cargar una superficie, haga clic en «Archivo -> Cargar superficie» y seleccione una imagen en el directorio «surf», como «lh.pial». Esto superpondrá una representación 3D de la superficie en el cuadro tridimensional de la ventana Vista y trazará su contorno en los cuadros ortogonales (es decir, las vistas sagital, axial y coronal). El color de la superficie en las vistas ortogonales se puede cambiar seleccionando un nuevo «Color de borde».

.. figura:: 06_Volúmenes_Superficies_Freeview.png

Opciones de Freeview desde la línea de comandos
*********

Freeview ofrece varias opciones de línea de comandos que puede usar para ahorrar tiempo. Por ejemplo, si desea crear el mismo diseño de la figura anterior (es decir, cargar el archivo orig.mgz, el archivo aseg.mgz con la tabla de consulta de colores y el archivo lh.pial con un borde amarillo), puede escribir lo siguiente desde el directorio principal que contiene los directorios ``mri`` y ``surf`` (por ejemplo, navegue al directorio ``sub-101_ses_BL_T1w``):

::

  freeview -v mri/orig.mgz mri/aseg.mgz:colormap=LUT -f surf/lh.pial:edgecolor=amarillo
  
La opción ``-v`` indica que los siguientes archivos son volúmenes, y la opción ``-f`` indica que el siguiente archivo es una superficie. Los dos puntos indican una opción para el archivo al que están adjuntos; por ejemplo, ``aseg.mgz:colormap=LUT`` significa asignar un mapa de colores de la tabla de consulta al archivo aseg.mgz. Asimismo, la opción ``edgecolor=yellow`` significa establecer el color del borde del archivo lh.pial en amarillo. Puede encontrar otras opciones para Freeview escribiendo ``freeview -h`` desde la línea de comandos; también puede encontrar un buen resumen de otras opciones y atajos de línea de comandos en la ``demo de Freeview` de Inés Pereira.`__.

.. nota::

  Si usa Conda y encuentra un error con la cadena "Error de segmentación", intente desactivar su entorno Conda actual escribiendo "conda deactivate". Esto debería resolver el problema en la mayoría de los casos.

--------


Video
*********


Para ver una descripción general en video de la estructura de directorio creada por recon-all y cómo usar freeview con la salida, haga clic aquí`__.

   

