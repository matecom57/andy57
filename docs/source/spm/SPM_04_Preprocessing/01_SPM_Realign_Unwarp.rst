

.. _01_SPM_Realinear_Desdeformar:

============================================
Capítulo 1: Realinear y corregir la distorsión de los datos
============================================

---------------

El primer paso del preprocesamiento es realinear las imágenes funcionales. Si consideramos una serie temporal como una baraja de cartas, con cada volumen como una carta independiente, la realineación colocará todas las cartas en la misma orientación y hará que sus lados se alineen, de forma similar a lo que ocurre después de barajar una baraja.

Al hacer clic en el botón "Realinear (Estimar y Recortar)", se abre una ventana con las opciones para realinear y recortar los datos. La sección "Estimar" se refiere a la estimación del grado de desalineación de cada volumen con respecto a un **volumen de referencia**, y "Recortar" indica que estas estimaciones se utilizarán para ajustar cada volumen a su nivel de referencia. El volumen de referencia se define en el campo "Número de pasadas", que permite especificar si los volúmenes se alinearán con la media de todos los volúmenes o con el primero. Para este tutorial, deje este valor predeterminado y no modifique los demás.

.. figure:: 01_Realign_Menu.png

  Este menú aparecerá después de hacer clic en el botón "Realinear: Estimar y rebanar".

.. nota::

  En este paso de preprocesamiento y en los siguientes, dejaremos la mayoría de los valores predeterminados tal como están. Estos valores se han calculado para obtener los mejores resultados para una amplia gama de campos de visión de imagen, tamaños de vóxel, etc. No obstante, puede resultarle útil cambiar los valores predeterminados del prefijo de archivo, por ejemplo, a uno que le resulte más comprensible. Si decide cambiar alguna de las demás opciones, al hacer clic en ellas se abrirá un archivo de ayuda que se muestra en el cuadro de información en la parte inferior de la pantalla del editor de lotes.
  
  
Cargando las imágenes
******************

En este experimento, se realizaron dos ejecuciones de datos por sujeto (SPM denomina cada ejecución una **sesión**). Si hace clic en el campo "Datos", verá una opción para agregar más sesiones. Haga clic en "Nueva: Sesión" para agregar otra. Verá una "<-X" a la derecha de cada campo de Sesión, lo que indica que debe completarse antes de ejecutar el programa.

Haga doble clic en la primera sesión para abrir la ventana de selección de imágenes. Vaya al directorio ``func`` y seleccione el archivo ``sub-08_task-flanker_run-1_bold.nii,1``. El ``,1`` al final del nombre del archivo indica que solo se puede seleccionar el primer **fotograma** o volumen. Para seleccionar todos los volúmenes de esa sesión, necesitaremos **expandir** el número de fotogramas disponibles. En el campo ``Fotogramas`` (debajo del campo ``Filtro``), escriba ``1:146`` y presione Intro.

.. nota::

  Si desconoce la cantidad de fotogramas del conjunto de datos actual, puede establecer el límite superior en un número arbitrario, por ejemplo, "1:10000". La lista de archivos se llenará con la cantidad de fotogramas disponibles, lo que garantizará que no se pierda ninguno.


Sin embargo, notará que se han seleccionado todos los fotogramas de la ejecución 1 y la ejecución 2, aunque solo queremos los fotogramas de la ejecución 1. Podría simplemente hacer clic y arrastrar desde el fotograma 1 hasta el 146 de la ejecución 1, pero se arriesga a incluir otros fotogramas por error. Por otro lado, para restringir la selección de archivos a solo los fotogramas que nos interesan, podemos usar el campo "Filtro". Este campo usa **expresiones regulares**, un tipo de código abreviado para indicar qué caracteres incluir en una cadena. En este caso, a la izquierda de los caracteres ``.*`` que ya están en el campo, escriba ``ejecución 1`` y presione Enter. Esto actualizará la pantalla para mostrar solo los fotogramas que incluyen la cadena ``ejecución 1``. Haga clic y arrastre para seleccionar todas las imágenes, o haga clic derecho en la ventana de selección y haga clic en "Seleccionar todo".


.. figure:: 01_SelectFrames.png

  Pantalla de selección de figuras. Si siguió las instrucciones anteriores, la ventana debería verse así. Tenga en cuenta que al introducir la cadena ``1:146`` en el campo ``Fotogramas``, se expandirá automáticamente a ``[1 2 3 4 5 ... 146]``.
  
Al terminar, haga clic en "Listo". Repita el mismo procedimiento para la segunda sesión, usando el campo "Filtro" para restringir la búsqueda a los fotogramas que contengan la cadena "run-2".

.. figure:: 01_FrameSelect_Run2.png

Ahora que ha completado todos los campos marcados con una "<-X", el botón "Reproducir" en la esquina superior izquierda de la pantalla ha cambiado de gris a verde. Haga clic en el botón para comenzar el preprocesamiento de Realineación.

.. figure:: 01_Realign_Demo.gif


.. nota::

  Las **expresiones regulares** permiten crear filtros muy específicos. Por ejemplo, si escribe la cadena ``run-1.*`` en el campo Filtro, la ventana de archivos mostrará solo los archivos que contengan la cadena "run-1" en su nombre. Si escribe la cadena ``^sub-08_task-flanker_run-1``, se mostrarán los archivos que *comiencen* con la cadena "run-1" (indicada por el símbolo de intercalación ``^``).
  
  
-----------

Ceremonias
*********

1. En el campo Filtro, se puede usar el símbolo de dólar (``$``) para obtener archivos que *terminan* con una cadena específica. Por ejemplo, al escribir ``run-1_bold.*$``, se obtendrán los archivos que terminan con la cadena "run-1_bold". Use el campo Filtro para obtener solo los archivos que terminan con ``run-2_bold``. Después de ejecutar la realineación, use el campo Filtro para obtener los archivos que comienzan con ``rsub-08``. Use el campo Fotogramas para seleccionar los fotogramas del 10 al 20. Haga una captura de pantalla de lo que ingresó en el campo Fotogramas y de los archivos filtrados resultantes.

2. Vuelva a ejecutar el paso de realineación solo en las imágenes de la ejecución 1, cambiando el valor del campo Calidad de 0,9 a 0,5. Al seleccionar el campo Calidad, lea el texto de ayuda en la parte inferior de la ventana. ¿Cómo cree que este cambio afectará la calidad de su realineación? Para mantener estos archivos separados del resto de la salida, cambie el prefijo del nombre de archivo a ``qual_05``. Revise la salida en la ventana "Comprobar registro" cargando una imagen representativa de los archivos rsub-08_task-flanker_run-1 y una imagen de los archivos qual_05 que acaba de crear. ¿Observa alguna diferencia entre ellos? ¿Por qué cree que hay o no diferencia?

3. Repita el paso de realineación cambiando el número de pases de "Registrar como medio" a "Registrar como primero". Consulte el archivo de ayuda y determine las ventajas y desventajas. ¿Cuál preferiría usar como predeterminado para su análisis y por qué?

4. Lea los archivos de ayuda de cada opción del módulo "Realinear: Estimar y Recortar". Imagine dos escenarios: 1) Que prioriza la velocidad de finalización de la realineación en lugar de la calidad; y 2) Que prioriza la calidad sobre la velocidad. ¿Qué opciones debería cambiar en los escenarios 1 y 2? Indique qué opciones modificó, junto con una captura de pantalla de una imagen de muestra de los volúmenes realineados. (Pista: No es necesario modificar todas las opciones. El suavizado, por ejemplo, puede permanecer igual).


Video
*****

Para ver una introducción en video sobre el preprocesamiento y cómo realizar la realineación, haga clic aquí`__.

Próximos pasos
*********

Este tutorial ha cubierto los conceptos básicos del uso de los diferentes menús de la interfaz gráfica de usuario de SPM, incluyendo cómo cambiar opciones y seleccionar fotogramas. Utilizaremos estos mismos métodos para el resto de los pasos de preprocesamiento, continuando con la **corrección de la sincronización de cortes**.

   

