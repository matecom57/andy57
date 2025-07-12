

.. _fMRI_03_MirandoLosDatos:

.. |iconoDePelícula| imagen:: iconoDePelícula.png

================
Tutorial de fMRI n.º 3: Análisis de los datos
================


Descripción general
---------

Ahora que ha descargado el conjunto de datos, veamos cómo se ve. Si el conjunto de datos se ha descargado en su directorio de Descargas, vaya al Escritorio y escriba lo siguiente:

::

    mv ~/Descargas/ds000102_0001/ Flanker
    
Esto cambiará el nombre de la carpeta a «Flanker» y la colocará en su escritorio.


.. figura:: Move_Flanker_Folder.png

    Después de descargar el conjunto de datos de Flanker, escriba el comando anterior para moverlo a su escritorio.
    
    
Como viste en la página de descarga de datos anteriorEl conjunto de datos tiene una estructura estandarizada: cada carpeta de sujeto contiene un directorio anatómico y un directorio funcional denominados «anat» y «func», que a su vez contienen las imágenes anatómicas y funcionales, respectivamente. (El directorio «func» también contiene las **horas de inicio**, o las marcas de tiempo de cuándo el sujeto se sometió a una prueba congruente o incongruente). Este formato se conoce como «BIDS». 
    `__, o estructura de datos de imágenes cerebrales, que facilita la organización y la búsqueda de sus datos.


.. figura:: Flanker_DataStructure.png

    Ejemplo del formato BIDS. Tenga en cuenta que el directorio ``func`` contiene datos funcionales (en este caso, dos ejecuciones de datos funcionales) y los archivos "events.tsv" correspondientes, que contienen **onsets**, o marcas de tiempo que indican qué condición se produjo y a qué hora. Puede abrirlos como archivo de texto o como hoja de cálculo.

--------

Inspección de la imagen anatómica
----------
    
Al descargar datos de imágenes, revise las imágenes anatómicas y funcionales para detectar cualquier problema (picos en el escáner, orientación incorrecta, contraste deficiente, etc.). Aprender a identificar estos problemas llevará tiempo, pero con la práctica será más rápido y fácil.

Echemos un vistazo a la imagen anatómica en la carpeta "anat" para "sub-08". Navegue a la carpeta sub-08 y escriba

::

    fsleyes anat/sub-08_T1w.nii.gz
    
Esto abrirá la imagen anatómica en "fsleyes", el visor de imágenes de FSL.


.. figura:: anat_firstLook.png

    La imagen anatómica mostrada en fsleyes. El contraste entre la sustancia gris y la blanca parece bajo, pero esto se debe a que los vasos sanguíneos del cuello (indicados por flechas naranjas) son mucho más brillantes que el resto del cerebro.
    
.. figura:: anat_changeContrast.png

    Esto se puede solucionar modificando los valores en el cuadro de contraste. En este caso, el Máximo se ha reducido a 800, limitando la señal más brillante a ese valor. Esto facilita la visualización del contraste entre los tejidos.
    
    
    
Inspeccione la imagen haciendo clic y arrastrando el ratón. Puede cambiar de panel de visualización haciendo clic en la ventana correspondiente. Tenga en cuenta que las demás ventanas se actualizan en tiempo real al mover el ratón. Esto se debe a que los datos de resonancia magnética se recopilan como una imagen tridimensional, y al desplazarse por una de las dimensiones, también se modificarán las demás ventanas.

.. nota::

    Quizás haya notado que a este sujeto parece faltarle el rostro. Esto se debe a que los datos de OpenNeuro.org han sido **desidentificados**: No solo se ha eliminado del encabezado información como el nombre y la fecha del escaneo, sino que también se han borrado los rostros. Esto se hace para garantizar el anonimato del sujeto.
    

A medida que continúa inspeccionando la imagen, aquí hay dos cosas que puede tener en cuenta:

1. Líneas que parecen ondas en un estanque. Estas ondas pueden deberse a que el sujeto se mueve demasiado durante el escaneo y, si son lo suficientemente grandes, pueden provocar fallos en los pasos de preprocesamiento, como la extracción cerebral o la normalización.

.. ¿También incluye imágenes de la charla de QC?

2. Diferencias anormales de intensidad en la sustancia gris o blanca. Estas pueden indicar patologías como aneurismas o cavernomas, y deben reportarse a su radiólogo de inmediato; asegúrese de familiarizarse con los protocolos de su laboratorio para reportar artefactos.

----------

Inspección de las imágenes funcionales
----------
    
Cuando termine de ver la imagen anatómica, haga clic en "Superposición -> Eliminar todo" en el menú superior de la pantalla. Luego, haga clic en "Archivo -> Agregar desde archivo", navegue al directorio "func" de "sub-08" y seleccione la imagen que termina en "run-1_bold.nii.gz". Esta imagen también se asemeja a un cerebro, pero no está tan claramente definida como la imagen anatómica. Esto se debe a que la **resolución** es menor. Es habitual que un estudio recopile una imagen ponderada en T1 de alta resolución (es decir, anatómica) e imágenes funcionales de menor resolución, en parte porque recopilamos las imágenes funcionales con mayor rapidez.

.. figura:: functional_firstLook.png


Muchos de los controles de calidad de la imagen funcional son los mismos que los de la imagen anatómica: Preste atención a las manchas extremadamente brillantes o extremadamente oscuras en la sustancia gris o blanca, así como a las distorsiones de la imagen, como estiramientos o deformaciones anormales. Un lugar donde es común observar una ligera distorsión es en la región orbitofrontal del cerebro, justo por encima de los globos oculares. Hay maneras de reducir esta distorsión, pero por ahora la ignoraremos.

.. Consulte el glosario de series temporales

Otra comprobación de calidad consiste en asegurar que no haya movimiento excesivo. Las imágenes funcionales suelen recopilarse como series temporales; es decir, se concatenan varios volúmenes en un único conjunto de datos. Puede hojear rápidamente todos los volúmenes como si fueran páginas de un libro haciendo clic en el icono del carrete de película en fsleyes. Observe cualquier movimiento repentino o brusco en cualquiera de los paneles de visualización. Durante el preprocesamiento, cuantificaremos la cantidad de movimiento para decidir si se conservan o se descartan los datos de ese sujeto.

--------

Video
--------

Sigue aqui
    `__ para una demostración de la comprobación de calidad de los datos de fMRI. Al terminar, haga clic en el botón Siguiente para obtener información sobre el preprocesamiento de los datos.

    
   

