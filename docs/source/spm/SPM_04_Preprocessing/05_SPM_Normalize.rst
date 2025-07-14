

.. _05_SPM_Normalizar:

========================
Capítulo 5: Normalización
========================

---------------

Realizar la normalización en SPM
*******************************

Tras segmentar la imagen anatómica, podemos usar esas segmentaciones para **normalizar** la imagen. Desde la interfaz gráfica de usuario de SPM, haga clic en «Normalizar (Escribir)», haga clic en el campo «Datos» del Editor por lotes y cree un nuevo sujeto. Seleccione el campo de deformación que creó en el directorio «anat» durante la segmentación (el archivo debe llamarse «y_rsub-08_T1w.nii») y, en «Imágenes para escribir», seleccione todas las imágenes realineadas y con corrección de tiempo de corte. (Puede hacerlo de forma más eficiente escribiendo «^ar.*» en el campo «Filtro» e introduciendo «1:146» en el campo «Fotogramas»).

En la sección "Opciones de escritura", puede cambiar la resolución de vóxel de las imágenes deformadas. El valor predeterminado de 2x2x2 creará imágenes de mayor resolución, pero los archivos ocuparán más espacio en su computadora. Si desea crear archivos más pequeños con menor resolución, cámbielo a "3 3 3".

.. nota::

  También puede seleccionar la imagen anatómica corregistrada como imagen para normalizar, lo cual puede ser útil si desea visualizar los resultados de cada sujeto en su propia anatomía. Para este tutorial, solo visualizaremos los resultados en un cerebro modelo, por lo que no es necesario normalizar la imagen anatómica.


Comprobación de la salida
*******************

Una vez normalizadas las imágenes funcionales, verifique la salida para asegurarse de que no haya errores. En la interfaz gráfica de usuario de SPM, haga clic en "Check Reg" y seleccione uno de los volúmenes funcionales que tenga una "w" precedida (lo que indica que se ha deformado, es decir, normalizado). Para la segunda imagen, vaya al directorio "spm12/canonical" y seleccione cualquiera de las imágenes "T1": avg152T1.nii, avg305T1.nii o single_subj_T1.nii. Al igual que con :ref:`Coregistration <03_SPM_Coregistration>`, verifique que los contornos de los cerebros y las estructuras internas estén bien alineados.

.. nota::

  La plantilla ``single_subj_T1.nii`` tendrá la resolución espacial más nítida; es decir, podrá ver cada circunvolución y surco individualmente. Sin embargo, visualizar los resultados en esta plantilla puede ser ligeramente engañoso, ya que la anatomía de cada sujeto se ha distorsionado y difuminado; la activación que parece estar en una ubicación específica en la plantilla ``single_subj_T1`` podría no ser tan específica como parece. Por este motivo, se recomienda visualizar la activación en una de las plantillas promediadas o en una imagen promedio que consista en la media de las imágenes anatómicas normalizadas del sujeto. Analizaremos esto con más detalle cuando abordemos el modelado estadístico en el siguiente capítulo.
  
.. figura:: 04_05_CheckNormalization.gif

-----------------

Ceremonias
*********

1. Si bien se recomienda la versión más reciente de la normalización de SPM, también puede usar una versión anterior de normalización, que no requiere la entrada del paso de Segmentación. Puede encontrarla en la interfaz gráfica de SPM haciendo clic en el botón "Lote" y, en la parte superior de la ventana, seleccionando "SPM -> Herramientas -> Normalización anterior: Estimar y escribir". Haga clic en el botón "Datos", cree un nuevo Sujeto y seleccione la imagen anatómica recortada como Imagen de origen y los 292 volúmenes de sus datos funcionales corregistrados como Imágenes para escribir (es decir, las imágenes que comienzan con el prefijo "r"; puede seleccionarlas en la ventana de selección de archivos con el filtro "^rsub"). Para la Imagen de plantilla, seleccione "T1.nii". Muestre una captura de pantalla del resultado de esta normalización y comente cualquier diferencia notable entre esta normalización y la que utiliza segmentación.

2. Cambie el tamaño de vóxel de [2 2 2] a [3 3 3] y el prefijo del nombre de archivo de ``w`` a ``w_3_3_3``. Compare la resolución espacial de las dos salidas. ¿Qué resolución le parece mejor? ¿Cuáles son las desventajas de usar una resolución muy pequeña, como [1 1 1]?

3. Al igual que con el corregistro, puede seleccionar un nivel de interpolación diferente. El valor predeterminado es "B-Spline de 4.º grado", con opciones para grados de interpolación más altos (como B-Spline de 7.º grado) o más bajos; el nivel más bajo es "Vecino más cercano", que utiliza el valor del vóxel más cercano para el remuestreo (véase esta animación).`__ para una ilustración; quizás deba desplazarse hacia abajo en la página). ¿Cuándo sería conveniente un mayor grado de interpolación y cuándo preferiría usar la interpolación por vecino más cercano? Pruebe ambas opciones de interpolación y compare los resultados.

   

