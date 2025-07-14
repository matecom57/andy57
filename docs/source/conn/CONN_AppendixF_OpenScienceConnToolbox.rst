

.. _CONN_ApéndiceF_Caja de herramientas OpenScienceConn:

=============================================
Apéndice F: Ciencia abierta y la caja de herramientas CONN
=============================================

-------

Descripción general
********

La última versión de la caja de herramientas CONN, 24.27, le permite descargar cualquiera de los conjuntos de datos alojados por el «**Proyecto 1000 Conectomas Funcionales**`__. Hay 33 conjuntos de datos en total, desde Cambridge hasta Taipéi, y la mayoría también contiene datos demográficos. El tamaño de las muestras varía, desde unos pocos hasta doscientos.

Puede descargar y analizar uno de estos conjuntos de datos abriendo la caja de herramientas CONN y seleccionando «Proyecto -> Nuevo (descargar) -> de la base de datos pública FCP/INDI». Se le pedirá que introduzca un nombre para el proyecto; en este caso, lo llamaremos CONN_fCONN_Demo. A continuación, puede seleccionar el conjunto de datos que desee; elijamos el más pequeño, con solo 8 sujetos: el conjunto de datos «Taipei_b».

El siguiente mensaje le preguntará si desea simplemente descargar los datos o descargarlos y procesarlos. Esto incluye todo, desde el preprocesamiento hasta la eliminación de ruido y la creación de mapas de correlación, y tiene la ventaja de encargarse de todo mientras usted hace otras cosas. La desventaja es que utiliza valores predeterminados que podrían no serle útiles y solo genera mapas de correlación para las ROI de la red, no para las ROI del atlas (aunque puede cambiar esto más adelante). Por ahora, seleccionemos la opción "Descargar y procesar" y esperemos aproximadamente una hora mientras se analizan los datos.

Una vez finalizado, verá que todas las pestañas están habilitadas, ya que se han completado el preprocesamiento y los análisis. Las revisaremos rápidamente, aunque le recomendamos que se tome el tiempo de revisar la calidad de los datos, como se explicó en los capítulos anteriores.`.

Tenga en cuenta que solo se analizan las ROI de la red en la pestaña de primer nivel; puede agregar aquí las demás ROI del atlas si lo desea. También puede ejecutar análisis a nivel de grupo para cualquier región disponible. Tenga en cuenta también que este conjunto de datos no contiene ninguna otra información demográfica, como edad o sexo, por lo que no podremos controlarla.

Análisis de datos en el clúster de supercomputación
********************************************

Veamos ahora cómo analizar estos conjuntos de datos en el clúster de supercomputación. En la Universidad de Michigan, utilizo el clúster Great Lakes, que cuenta con una interfaz gráfica de usuario web llamada OnDemand. Aquí puedo hacer clic en "Mis sesiones interactivas" y seleccionar una nueva instancia de Matlab. Muchos de mis valores predeterminados son estándar, y mantendré esta sesión activa durante 96 horas, utilizando solo 16 gigabytes de memoria. Tras hacer clic en "Iniciar", la sesión tarda unos instantes en cargarse; luego hago clic en "Iniciar Matlab" y espero a que se abra Matlab.

Ya he instalado SPM12 y la caja de herramientas CONN, y después de agregarlos a mi ruta, escribo ``conn`` para abrir una nueva instancia de la caja de herramientas CONN. Como antes, creo un nuevo proyecto descargando uno de los conjuntos de datos fCONN; llamemos a este proyecto ``AnnArbor_CONN``, ya que analizaré datos de uno de los sitios de Ann Arbor; seleccionemos la primera opción, AnnArbor_a. Esta vez, sin embargo, elijamos simplemente descargar los datos en lugar de procesarlos. Una vez descargados, vamos a aprovechar los numerosos núcleos, o computadoras individuales, que están contenidas dentro del clúster. Haga clic en ``Herramientas -> Opciones de HCP -> Configuración``. En ``Perfiles``, seleccione ``Clúster de computadoras Slurm`` del menú desplegable, donde slurm hace referencia a la sintaxis por lotes utilizada para enviar trabajos y marque la casilla junto a ``Perfil predeterminado`` para que se use automáticamente para todos los proyectos futuros. La mayoría de los valores predeterminados son correctos; lo único que cambiaremos es la configuración de envío adicional. En el campo junto a "in-line:", agregue "--mem=16gb". Esto garantiza que tengamos suficiente memoria para ejecutar el análisis actual; y "-t 12:00:00" asigna 12 horas de tiempo de procesamiento para el trabajo. Probablemente sea más de lo necesario, pero conviene ir sobre seguro.

.. figure:: ApéndiceF_SlurmSettings.png

Ahora, haga clic en "Probar perfil" para comprobar si se puede enviar un trabajo a este sistema. Verá una ventana del administrador de trabajos que registra el progreso del trabajo enviado. Si hace clic en la casilla junto a "Opciones avanzadas", podrá ver más detalles sobre lo que está sucediendo en el trabajo en este momento. En este ejemplo, tenemos un trabajo enviado a un nodo, con un identificador único. Si hace clic en "Ver registros", se mostrará exactamente qué código se está ejecutando; en este caso, simplemente se está probando si los trabajos se pueden enviar en paralelo. Haga clic en el botón "Actualizar", ya sea en la ventana de detalles del registro o en la ventana del administrador de trabajos, para ver si se ha producido algún progreso.

.. figure:: ApéndiceF_SeeLogs.png

Después de unos instantes, debería ver que la barra de pruebas cambia a verde y que indica "finalizado". Esto significa que se ejecutó correctamente sin errores. Salga de la ventana, haga clic en "Opciones" y desmarque las casillas "Vóxel a Vóxel" y "Circuitos dinámicos"; esto es solo para ahorrar tiempo. Haga clic en "Preprocesamiento" y seleccione la primera opción, la canalización de preprocesamiento predeterminada. Haga clic en el menú desplegable "Procesamiento local" y cámbielo a "Procesamiento distribuido (ejecutar en el clúster de Slurm)". Luego, haga clic en "Iniciar".

.. figure:: ApéndiceF_ProcesamientoDistribuido.png

Verá un nuevo mensaje que le preguntará cuántos trabajos en paralelo desea ejecutar. Hemos descargado 23 temas y, si lo desea, podemos usar 23 núcleos o uno para cada trabajo, como si se usara un ordenador independiente para procesar cada trabajo individualmente. Tras hacer clic en "Aceptar", se le harán las preguntas habituales sobre el preprocesamiento, como la corrección de la sincronización de cortes y el suavizado; por ahora, omitiré la corrección de la sincronización de cortes y mantendré el resto de los valores predeterminados.

Después de seleccionar todas las opciones, aparecerá otra ventana del administrador de trabajos al cabo de unos instantes. Haga clic en "Opciones avanzadas" y observe que, en este caso, se están ejecutando 23 trabajos simultáneamente. Al hacer clic en "Ver registros", se mostrará el progreso de cada uno individualmente. Puede alternar entre diferentes trabajos haciendo clic en el menú desplegable "node.0001" y seleccionando otro nodo. La principal ventaja de la paralelización es que el procesamiento se realiza en paralelo en lugar de en serie. Si preprocesar un solo sujeto toma treinta minutos, analizar todos los sujetos que tenga en cola tomará aproximadamente treinta minutos. El ahorro de tiempo puede ser enorme y directamente proporcional al número de trabajos que esté ejecutando. Por ahora, dejaremos que el preprocesamiento se ejecute en segundo plano y lo reanudaremos cuando finalice en aproximadamente media hora. Si parece que se detiene en algún punto cuando se desprende de los archivos de registro individuales que el preprocesamiento ha finalizado, siga haciendo clic en el botón «Actualizar» en el administrador de trabajos hasta que finalicen y se importen al proyecto.

.. figure:: ApéndiceF_TrabajosEnviados.png

Tal como hicimos en tutoriales anteriores, haz clic en el botón "Listo" en la pestaña Configuración. Esta vez, selecciona "Procesamiento distribuido", introduce "23" núcleos y haz clic en "Listo". Esto tardará entre diez y quince minutos, y puedes supervisar el progreso como hicimos antes.

Haremos lo mismo para la eliminación de ruido y el análisis de primer nivel, seleccionando siempre el procesamiento distribuido y utilizando el máximo número de núcleos posible. El proceso completo debería tardar menos de una hora.

Una vez preprocesados y analizados todos los datos, puede consultar el resultado que desee en la pestaña de segundo nivel. Por ejemplo, podríamos tomar un contraste de Hombres > Mujeres para la región MPFC, incluyendo la edad como covariable. Usted decide cómo analizar los datos, y también puede repetir estos análisis mediante análisis vóxel a vóxel o circuitos dinámicos. En resumen, importar estas bases de datos de acceso abierto es una excelente manera de aprender más sobre la variedad de muestras que se recopilan y cómo analizarlas en la caja de herramientas CONN.

   

