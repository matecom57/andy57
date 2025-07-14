

.. _SPM_07_ConfigurandoElOrigen:

===================================
Tutorial de SPM n.° 7: Establecer el origen
===================================

----------

Descripción general
********

Después de que :ref:`escribimos nuestro análisisParece que solo necesitamos ejecutar el script para el resto de los sujetos. Antes de continuar, conviene comprobar si el análisis programado funcionó tan bien como el análisis manual para el sub-08. Si hay algún error en el script, se propagará a todos los sujetos; es recomendable ejecutar el script para uno o dos sujetos y comprobar si hay algún problema.

Si examina el resultado de cada paso de preprocesamiento cargando las imágenes en el visor de la interfaz gráfica de usuario de SPM, observará que los pasos iniciales de preprocesamiento, como la realineación y la corrección de la temporización de corte, parecen haberse ejecutado sin errores. Sin embargo, al observar el resultado del corregistro, se observa una anomalía: aunque los datos funcionales parecen normales, la imagen anatómica realineada parece tener las orientaciones invertidas. Al observar el resultado de etapas posteriores, como la normalización o el análisis de primer nivel, este error también se ha propagado a los datos funcionales. Por lo tanto, cualquier resultado que generemos a partir de este análisis carecerá de sentido.

.. figura:: 07_CoregistrationError_Anatomical.png

  Ejemplo de un fallo de corregistro. La gran distancia entre los orígenes de las exploraciones anatómicas y funcionales provoca una coincidencia inexacta entre las imágenes; la discrepancia es tan extrema que el eje de orientación inferior-superior de la imagen anatómica se invierte.

.. figura:: 07_NormalizationError_Functional.png

  El error anterior se propaga a las imágenes funcionales. Dado que la imagen anatómica tiene una orientación incorrecta, la normalización entre la imagen anatómica y la plantilla también generará una discrepancia. Estos parámetros de deformación erróneos se aplican a los datos funcionales normalizados que se muestran aquí.
  
Para ver por qué se produce este error, haga clic en el botón "Comprobar registro" en la interfaz gráfica de usuario de SPM y seleccione la imagen anatómica sin procesar y una de las imágenes funcionales. Los centros de las imágenes están muy alejados, lo que provoca los errores mencionados.

.. figura:: 07_CheckRegAnatFunc.png

Establecer el origen
******************

El problema no reside en los datos en sí, ni en un error del script. Se trata, en cambio, de un problema con la alineación inicial de la imagen anatómica, que provoca el fallo de los pasos posteriores de preprocesamiento. Si ha leído las otras guías, quizá recuerde del tutorial AFNI <07_AFNI_Checking_Preprocessing> que, a veces, una imagen anatómica requiere un pequeño ajuste para una mejor alineación inicial con la plantilla a la que se está normalizando. Si bien AFNI y FSL cuentan con métodos para realizar estos ajustes automáticamente, SPM requiere que definamos manualmente el origen (es decir, los valores 0, 0, 0 para las dimensiones x, y y z). En concreto, debemos fijar el origen en la comisura anterior, un haz de fibras de sustancia blanca que conecta los lóbulos anteriores del cerebro. Las plantillas MNI que utilizamos tienen la comisura anterior en su origen, y establecer el origen de las imágenes anatómicas también en la comisura anterior mejorará las posibilidades de que nuestra normalización sea exitosa.

Para ello, haga clic en el botón "Mostrar" y cargue la imagen anatómica sin procesar de la sub-01. (Es posible que deba usar el comando "gunzip" de Matlab para descomprimir la imagen original comprimida antes de poder seleccionarla en la interfaz gráfica de usuario). Tenga en cuenta que si hace clic en el botón "Origen", el origen está lejos de la comisura anterior. Nuestra tarea es corregir estas diferencias de coordenadas para que el origen se establezca en esa estructura.

.. figura:: 07_Orígenes_Anatómicos_Antes.png

  Al hacer clic en el botón de origen, se observa que este se encuentra lejos del centro de la imagen. Transformaremos la imagen para que el origen se encuentre en la comisura anterior.
  
Ahora, haga clic y arrastre la cruceta hasta que se sitúe sobre la comisura anterior. Esta delgada banda de fibras de sustancia blanca se encuentra en la base del fórnix, una banda arqueada de sustancia blanca que se extiende hacia abajo desde el cuerpo calloso. La comisura anterior se observa con mayor facilidad en la vista sagital; una vez que haya colocado la cruceta cerca de la comisura anterior, también debería ver una delgada banda de sustancia blanca en las vistas axial y coronal. (En la vista coronal, imagine que los ventrículos son ojos; la comisura anterior se ve entonces como un bigote blanco).

.. figura:: 07_FindingTheAC.png

Observe los números en el campo ``mm:``; estos indican la distancia del origen a la cruz en los ejes derecho/izquierdo, anteroposterior e inferior/superior. Usaremos los campos a continuación (``derecha {mm}``, ``adelante {mm}`` y ``arriba {mm}``) para desplazar manualmente el origen a la comisura anterior. Introduzca el opuesto de cada número en el campo ``mm:`` con su campo correspondiente a continuación.

Por ejemplo, si hizo clic en el botón "Origen" y se devolvieron los números "-84.0, 18.7, -15.1" en el campo "mm:", deberá ingresar los siguientes números opuestos en los campos derecha, adelante y arriba:

::

  84.0
  -18.7
  15.1
  
.. figura:: 07_SettingTheOrigin.png

  Estableciendo el origen en la comisura anterior. Una vez que haya ingresado los números en los campos derecho, delantero y superior, presione "Intro". Para asegurarse de que el nuevo origen esté en la comisura anterior, presione el botón "Origen".
  
.. nota::

  Un método más sencillo para establecer el origen es apuntar la mira a la comisura anterior y simplemente hacer clic en el botón "Establecer origen" en la parte inferior de la pantalla. El objetivo de hacerlo de la otra manera era presentar al lector las funciones de la interfaz gráfica de usuario (GUI) de visualización que podría usar más adelante al ajustar manualmente una imagen. Para establecer el origen de futuras imágenes, se recomienda usar el método más sencillo: hacer clic en el botón "Establecer origen".
  
Ahora haremos clic en el botón "Reorientar" para establecer permanentemente este nuevo origen de la imagen anatómica y de las imágenes funcionales. Al hacer clic en el botón "Reorientar", se le pedirá que seleccione las imágenes que desea reorientar, con la imagen anatómica ya seleccionada. Haga clic en "Listo" y guarde la matriz de reorientación cuando se le solicite.

Ahora verifique de nuevo el registro inicial entre las imágenes anatómicas y funcionales. Los centros de las imágenes, aunque no están perfectamente alineados, ahora están en una posición inicial mucho mejor. Esto aumenta las probabilidades de que el corregistro y, por extensión, la normalización y el modelado de primer nivel, tengan éxito.

.. figura:: 07_CheckUpdatedRegAnatFunc.png


¿Debe restablecerse el origen para cada sujeto?
********************************************

Si intentó analizar a todos sus sujetos con el script mencionado en el capítulo anterior, habrá observado que el preprocesamiento fue exitoso para la mayoría de los sujetos y falló para aproximadamente una cuarta parte. Esto plantea la pregunta de si el origen debería restablecerse a la comisura anterior de cada sujeto. El enfoque conservador sería hacerlo para cada sujeto; sin embargo, debería verificar el resultado del preprocesamiento para asegurarse de que no haya errores.

Video
*****

Para ver una demostración en video de cómo configurar el origen en SPM12, haga clic aquí
    `__.

Próximos pasos
*********

Una vez que haya restablecido el origen de cada sujeto, vuelva a ejecutar el script de preprocesamiento. Tenga en cuenta que si el script ya se ejecutó para algunos sujetos (como sub-01, sub-02 y sub-08), en la etapa de estimación del modelo se le preguntará si desea sobrescribir la salida estadística existente. Deberá hacerlo manualmente o eliminar los directorios de primer nivel existentes. La otra salida de preprocesamiento se sobrescribirá.

Una vez analizados todos los sujetos individuales, podrá realizar un análisis a nivel de grupo. Para obtener una descripción general del método y cómo hacerlo en SPM, haga clic en el botón "Siguiente".

    
   

