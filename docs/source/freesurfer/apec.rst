Apéndice C: Anotación de imágenes anatómicas con Freeview
======================================================

---------------

Descripción general
********

Freeview, además de permitirle ver imágenes y editarlas para la reconstrucción total, también le permite **anotarlas**. Por ejemplo, si desea dibujar sobre una imagen anatómica ponderada en T1 para localizar una región específica del cerebro (por ejemplo, el putamen), puede hacerlo desde la interfaz de Freeview. Al seleccionar los vóxeles que forman parte de una región específica del cerebro, los rellenamos con un número determinado (por ejemplo, el uno) y dejamos el resto como ceros. Esto se denomina **máscara**, también conocida como **Región de Interés (ROI)**.


Anotación de una región de interés (ROI)
*************************************

Primero, abra Freeview haciendo doble clic en el icono en su directorio de FreeSurfer o abriendo una terminal y escribiendo "freeview". Cuando se abra, haga clic en "Archivo -> Cargar volumen" y seleccione la imagen anatómica que desea anotar. Al cargar, debería ver algo como esto:

.. figura:: ApéndiceC_FreeviewLayout.png

Para crear nuestra región de interés, haga clic en «Archivo -> Nuevo volumen». Se le pedirá que escriba una etiqueta para la ROI; en este caso, estamos anotando el putamen derecho, así que lo llamaremos «Putamen derecho». Asegúrese de que el menú desplegable que aparece debajo sea la imagen T1 que está anotando; esto garantizará que la ROI tenga la misma resolución y dimensiones que la imagen sobre la que está dibujando, también llamada **Imagen de plantilla**. Haga clic en Aceptar.

Ahora aparecerá una pequeña ventana flotante llamada "Edición de vóxeles", que permanecerá abierta mientras se anote la ROI. El tamaño del pincel se refiere al radio del pincel, en vóxeles, que para la mayoría de las imágenes anatómicas equivale a milímetros. Para regiones más pequeñas y bandas de corteza más delgadas, probablemente debería usar un tamaño de pincel menor. En nuestro ejemplo, cambiaremos el tamaño del pincel a "3". Tenga en cuenta también que en esta ventana hay otras opciones de dibujo, como "Polilínea", "Cable vivo" y "Relleno". Las abordaremos más adelante; por ahora, deje el valor predeterminado "Mano alzada".

.. figura:: ApéndiceC_VoxelEdit.png

.. nota::

Los íconos en la fila superior de la GUI de Freeview indican qué modo de visualización o dibujo está activo ahora; en este momento debería ver resaltado el ícono con un cerebro en blanco y un lápiz.


Dibujando la Región
&&&&&&&&&&&&&&&&&&

Una vez seleccionada la herramienta de dibujo, puede hacer clic izquierdo en los vóxeles en cualquiera de los paneles de visualización para comenzar a anotarlos. Puede que prefiera un panel de visualización a otro; por ejemplo, si solo desea ver el panel axial, haga clic en el icono de la vista axial en la parte superior de la ventana de Freeview y luego en el cuadrado blanco, que mostrará solo esa vista ortogonal. También puede cambiar el color y la opacidad de su anotación mediante las opciones del panel izquierdo de la interfaz gráfica de Freeview:

.. figura:: ApéndiceC_AxialView.png

Nota: Puedes acercar o alejar la imagen con el desplazamiento del ratón. También puedes moverte entre secciones adyacentes pulsando las flechas arriba y abajo del teclado.

Ahora, haz clic izquierdo y arrastra para dibujar tu anotación en los vóxeles que crees que pertenecen al Putamen. Continúa con cada corte adyacente hasta que puedas anotar toda la región.

.. figura:: ApéndiceC_Anotación.png

Cuando termine de dibujar su ROI, puede guardarlo haciendo clic en «Archivo -> Guardar volumen como». Esto lo guardará automáticamente como un archivo «.mgz», que posteriormente podremos convertir al formato NIFTI con el comando «mri_convert».

Puede anotar varias ROI simultáneamente. Por ejemplo, si selecciona "Archivo -> Nuevo volumen" y nombra la nueva ROI "Putamen izquierdo", asegúrese de que esté resaltada en el panel izquierdo de Freeview. Luego, puede elegir un color diferente y anotarla como desee. La ROI resaltada se guardará en el disco al seleccionar "Archivo -> Guardar volumen como".

.. figura:: ApéndiceC_TwoROIs.png

.. nota::

  Si comete un error durante la anotación, puede presionar "Comando + Z" para deshacer el último trazo. Al presionar "Mayús + Comando + Z", rehacerá el último trazo. Mantener presionada la tecla Mayús y hacer clic izquierdo eliminará los vóxeles anotados de la ROI resaltada en el panel de selección.

Salvando los ROI como NIFTI
************************

Algunos investigadores pueden optar por crear una **Etiqueta** en lugar de un volumen. Las etiquetas tienen la ventaja de poder dibujarse tanto en vóxeles como en vértices, y FreeSurfer genera automáticamente una carpeta llamada ``label`` que contiene estos archivos. Dicho esto, los archivos de etiquetas solo pueden ser leídos por FreeSurfer, pero también puede usar o ver las ROI en otro software. Para que sean lo más fáciles de transportar entre grupos posible, puede convertir el archivo de etiqueta a un archivo NIFTI usando ``mri_label2vol``. Por ejemplo, esta línea de código, ejecutada desde el directorio que contiene los archivos T1.mgz y RightPutamen.label, convertirá RightPutamen.label en RightPutamen.nii.gz:

::

  mri_label2vol --label RightPutamen.label --temp T1.mgz --regheader T1.mgz --tkr-template T1.mgz --o RightPutamen.nii.gz

Cálculo del coeficiente de dados
********************************

Imagina que eres un anatomista cualificado que quiere anotar manualmente las regiones cerebrales y comparar cómo coinciden tus anotaciones con las generadas automáticamente por FreeSurfer. La técnica más común es calcular el **Coeficiente Dice**, una medida de similitud entre conjuntos. En teoría, los conjuntos pueden ser cualquier cosa: letras, números, etc. Es especialmente adecuado para comparar segmentaciones, ya que se puede calcular la superposición entre ellas. Dadas las segmentaciones A y B, el Coeficiente Dice se calcula como:

.. figura:: ApéndiceC_DiceCoefficient_Equation.png

Donde **D** es el coeficiente de Dice, **A** es el patrón de vóxeles de una de las segmentaciones y **B** es el patrón de vóxeles de la otra segmentación. Otra forma de verlo es comparar la máscara de Putamen que acabamos de crear con el Putamen generado por FreeSurfer:


::

  mri_label2vol --seg aparc+aseg.mgz --temp T1.mgz --o aparc-in-rawavg.mgz --regheader aparc+aseg.mgz

Donde ``T1.mgz`` se refiere a la imagen anatómica T1 original que proporcionó, y ``aparc+aseg.mgz`` es el resultado de segmentación de FreeSurfer. Puede calcular la superposición con:

::

  segmentación mri_seg_overlap.mgz aparc-in-rawavg.mgz

Lo que le da a Dice puntuaciones como las siguientes:

.. figura:: ApéndiceC_DiceScores.png

En este caso, sólo anoté a mano algunas de las regiones; las que no fueron anotadas tienen una puntuación Dice de "0".


Video
*****

Para ver una descripción general en video sobre cómo anotar cerebros en Freeview, haga clic aquí`__.

   

