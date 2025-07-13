

.. _FEAT_GUI.rst

Capítulo 2: La GUI de FEAT y la carga de datos funcionales
^^^^^^^^^^^

El resto de los pasos de preprocesamiento (corrección de movimiento mediante normalización) se realizarán en la interfaz gráfica de FEAT. El botón FEAT se encuentra en el centro del menú de la interfaz gráfica de FSL; al hacer clic en él, se abrirá una ventana con varias pestañas.

.. figura:: FEAT_GUI.png

  Al hacer clic en el botón de análisis FEAT FMRI (A), se abre la interfaz gráfica de usuario de FEAT. Por ahora, nos centraremos en las pestañas «Datos», «Preestadísticas» y «Registro», que preprocesan los datos. En el menú desplegable superior derecho (B), seleccione «Preprocesamiento». Esto desactivará las pestañas «Estadísticas» y «Postestadísticas», permitiéndonos centrarnos únicamente en el preprocesamiento. Haga clic en el botón «Seleccionar datos 4D» (C) para cargar los datos de imágenes (en este ejemplo, «sub-08_task-flanker_run-1_bold.nii.gz», que se encuentra en el directorio «func»). Se abrirá una nueva ventana (D), con un icono de carpeta que permite seleccionar una ejecución de imágenes funcionales (E).

Al cargar una imagen funcional, FSL lee la información del **encabezado** de dicha imagen. Imagine la imagen como una matriz tridimensional de números, donde los números más altos se representan como más brillantes que los más bajos. Este contraste nos permite distinguir diferentes estructuras dentro de la imagen. El encabezado, por otro lado, contiene información que no se ve directamente en la imagen, pero que es necesaria para visualizarla; por ejemplo, la orientación. El encabezado de datos tetradimensionales (es decir, conjuntos de datos individuales que contienen varios volúmenes) también contiene números que indican la :ref:`TR" y número de volúmenes.

Después de cargar los datos de entrada, estos campos se ingresarán automáticamente en los campos correspondientes de la GUI de FEAT, como se muestra en el siguiente video:

.. figura:: FEAT_GUI_Demonstration.gif

  Asegúrese de verificar que el TR y el número de volúmenes coincidan con los adquiridos en el escáner. Si tiene alguna pregunta sobre los parámetros utilizados, consulte a su técnico de escaneo.

Las dos pestañas siguientes, Preestadísticas y Registro, se analizarán en los siguientes capítulos. Para continuar con el tutorial sobre los pasos de preprocesamiento, haga clic en el botón Siguiente.

   

